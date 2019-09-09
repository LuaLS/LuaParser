local emmy = require 'parser.emmy'

local tonumber    = tonumber
local stringChar  = string.char
local utf8Char    = utf8.char
local tableUnpack = table.unpack
local mathType    = math.type
local pairs       = pairs

_ENV = nil

local State
local Asts
local pushError

-- goto 单独处理
local RESERVED = {
    ['and']      = true,
    ['break']    = true,
    ['do']       = true,
    ['else']     = true,
    ['elseif']   = true,
    ['end']      = true,
    ['false']    = true,
    ['for']      = true,
    ['function'] = true,
    ['if']       = true,
    ['in']       = true,
    ['local']    = true,
    ['nil']      = true,
    ['not']      = true,
    ['or']       = true,
    ['repeat']   = true,
    ['return']   = true,
    ['then']     = true,
    ['true']     = true,
    ['until']    = true,
    ['while']    = true,
}

local VersionOp = {
    ['&']  = {'Lua 5.3', 'Lua 5.4'},
    ['~']  = {'Lua 5.3', 'Lua 5.4'},
    ['|']  = {'Lua 5.3', 'Lua 5.4'},
    ['<<'] = {'Lua 5.3', 'Lua 5.4'},
    ['>>'] = {'Lua 5.3', 'Lua 5.4'},
    ['//'] = {'Lua 5.3', 'Lua 5.4'},
}

local function checkOpVersion(op)
    local opAst = Asts[op]
    local versions = VersionOp[opAst.type]
    if not versions then
        return
    end
    for i = 1, #versions do
        if versions[i] == State.version then
            return
        end
    end
    pushError {
        type    = 'UNSUPPORT_SYMBOL',
        start   = opAst.start,
        finish  = opAst.finish,
        version = versions,
        info    = {
            version = State.version,
        }
    }
end

local Exp

local function expSplit(list, start, finish, level)
    if start == finish then
        return list[start]
    end
    local info = Exp[level]
    if not info then
        return
    end
    local func = info[1]
    return func(list, start, finish, level)
end

local function binaryForward(list, start, finish, level)
    local info = Exp[level]
    for i = finish-1, start+1, -1 do
        local op = list[i]
        local opType = Asts[op].type
        if info[opType] then
            local e1 = expSplit(list, start, i-1, level)
            if not e1 then
                goto CONTINUE
            end
            local e2 = expSplit(list, i+1, finish, level+1)
            if not e2 then
                goto CONTINUE
            end
            checkOpVersion(op)
            Asts[#Asts+1] = {
                type   = 'binary',
                op     = op,
                start  = Asts[e1].start,
                finish = Asts[e2].finish,
                [1]    = e1,
                [2]    = e2,
            }
            return #Asts
        end
        ::CONTINUE::
    end
    return expSplit(list, start, finish, level+1)
end

local function binaryBackward(list, start, finish, level)
    local info = Exp[level]
    for i = start+1, finish-1 do
        local op = list[i]
        local opType = Asts[op].type
        if info[opType] then
            local e1 = expSplit(list, start, i-1, level+1)
            if not e1 then
                goto CONTINUE
            end
            local e2 = expSplit(list, i+1, finish, level)
            if not e2 then
                goto CONTINUE
            end
            checkOpVersion(op)
            Asts[#Asts+1] = {
                type   = 'binary',
                op     = op,
                start  = Asts[e1].start,
                finish = Asts[e2].finish,
                [1]    = e1,
                [2]    = e2,
            }
            return #Asts
        end
        ::CONTINUE::
    end
    return expSplit(list, start, finish, level+1)
end

local function unary(list, start, finish, level)
    local info = Exp[level]
    local op = list[start]
    local opType = Asts[op].type
    if info[opType] then
        local e1 = expSplit(list, start+1, finish, level)
        if e1 then
            checkOpVersion(op)
            Asts[#Asts+1] = {
                type   = 'unary',
                op     = op,
                start  = Asts[op].start,
                finish = Asts[e1].finish,
                [1]    = e1,
            }
            return #Asts
        end
    end
    return expSplit(list, start, finish, level+1)
end

local function checkMissEnd(start)
    if not State.MissEndErr then
        return
    end
    local err = State.MissEndErr
    State.MissEndErr = nil
    local _, finish = State.lua:find('[%w_]+', start)
    if not finish then
        return
    end
    err.info.related = { start, finish }
    pushError {
        type   = 'MISS_END',
        start  = start,
        finish = finish,
    }
end

local function getSelect(vararg, index)
    Asts[#Asts+1] = {
        type   = 'select',
        vararg = vararg,
        index  = index,
    }
    return #Asts
end

local function getValue(values, i)
    if not values then
        return nil, nil
    end
    local value = values[i]
    if not value then
        local last = values[#values]
        if not last then
            return nil, nil
        end
        local lastAst = Asts[last]
        if lastAst.type == 'call' or lastAst.type == 'varargs' then
            return getSelect(last, i - #values + 1)
        end
        return nil, nil
    end
    local valueAst = Asts[value]
    if valueAst.type == 'call' or valueAst.type == 'varargs' then
        value = getSelect(value, 1)
    end
    return value, valueAst
end

local function createLocal(key, value, attrs)
    if not key then
        return nil
    end
    local keyAst = Asts[key]
    Asts[#Asts+1] = {
        type   = 'local',
        start  = keyAst.start,
        finish = keyAst.finish,
        loc    = key,
        value  = value,
        attrs  = attrs
    }
    return #Asts
end

local function createCall(args, start, finish)
    args.type    = 'callargs'
    args.start   = start
    args.finish  = finish
    Asts[#Asts+1] = args
    Asts[#Asts+1] = {
        type   = 'call',
        start  = start,
        finish = finish,
        args   = #Asts,
    }
    return #Asts
end

local function packList(start, list, finish)
    local lastFinish = start
    local wantName = true
    local count = 0
    for i = 1, #list do
        local ast = Asts[list[i]]
        if ast.type == ',' then
            if wantName or i == #list then
                pushError {
                    type   = 'UNEXPECT_SYMBOL',
                    start  = ast.start,
                    finish = ast.finish,
                    info = {
                        symbol = ',',
                    }
                }
            end
            wantName = true
        else
            if not wantName then
                pushError {
                    type   = 'MISS_SYMBOL',
                    start  = lastFinish,
                    finish = ast.start - 1,
                    info = {
                        symbol = ',',
                    }
                }
            end
            wantName = false
            count = count + 1
            list[count] = list[i]
        end
        lastFinish = ast.finish + 1
    end
    for i = count + 1, #list do
        list[i] = nil
    end
    return list
end

Exp = {
    {
        ['or'] = true,
        binaryForward,
    },
    {
        ['and'] = true,
        binaryForward,
    },
    {
        ['<='] = true,
        ['>='] = true,
        ['<']  = true,
        ['>']  = true,
        ['~='] = true,
        ['=='] = true,
        binaryForward,
    },
    {
        ['|'] = true,
        binaryForward,
    },
    {
        ['~'] = true,
        binaryForward,
    },
    {
        ['&'] = true,
        binaryForward,
    },
    {
        ['<<'] = true,
        ['>>'] = true,
        binaryForward,
    },
    {
        ['..'] = true,
        binaryBackward,
    },
    {
        ['+'] = true,
        ['-'] = true,
        binaryForward,
    },
    {
        ['*']  = true,
        ['//'] = true,
        ['/']  = true,
        ['%']  = true,
        binaryForward,
    },
    {
        ['^'] = true,
        binaryBackward,
    },
    {
        ['not'] = true,
        ['#']   = true,
        ['~']   = true,
        ['-']   = true,
        unary,
    },
}

local Defs = {
    Nil = function (pos)
        Asts[#Asts+1] = {
            type   = 'nil',
            start  = pos,
            finish = pos + 2,
        }
        return #Asts
    end,
    True = function (pos)
        Asts[#Asts+1] = {
            type   = 'boolean',
            start  = pos,
            finish = pos + 3,
            [1]    = true,
        }
        return #Asts
    end,
    False = function (pos)
        Asts[#Asts+1] = {
            type   = 'boolean',
            start  = pos,
            finish = pos + 4,
            [1]    = false,
        }
        return #Asts
    end,
    LongComment = function (beforeEq, afterEq, str, missPos)
        if missPos then
            local endSymbol = ']' .. ('='):rep(afterEq-beforeEq) .. ']'
            local s, _, w = str:find('(%][%=]*%])[%c%s]*$')
            if s then
                pushError {
                    type   = 'ERR_LCOMMENT_END',
                    start  = missPos - #str + s - 1,
                    finish = missPos - #str + s + #w - 2,
                    info   = {
                        symbol = endSymbol,
                    },
                    fix    = {
                        title = 'FIX_LCOMMENT_END',
                        {
                            start  = missPos - #str + s - 1,
                            finish = missPos - #str + s + #w - 2,
                            text   = endSymbol,
                        }
                    },
                }
            end
            pushError {
                type   = 'MISS_SYMBOL',
                start  = missPos,
                finish = missPos,
                info   = {
                    symbol = endSymbol,
                },
                fix    = {
                    title = 'ADD_LCOMMENT_END',
                    {
                        start  = missPos,
                        finish = missPos,
                        text   = endSymbol,
                    }
                },
            }
        end
    end,
    CLongComment = function (start1, finish1, start2, finish2)
        pushError {
            type   = 'ERR_C_LONG_COMMENT',
            start  = start1,
            finish = finish2 - 1,
            fix    = {
                title = 'FIX_C_LONG_COMMENT',
                {
                    start  = start1,
                    finish = finish1 - 1,
                    text   = '--[[',
                },
                {
                    start  = start2,
                    finish = finish2 - 1,
                    text   =  '--]]'
                },
            }
        }
    end,
    CCommentPrefix = function (start, finish)
        pushError {
            type   = 'ERR_COMMENT_PREFIX',
            start  = start,
            finish = finish - 1,
            fix    = {
                title = 'FIX_COMMENT_PREFIX',
                {
                    start  = start,
                    finish = finish - 1,
                    text   = '--',
                },
            }
        }
    end,
    String = function (start, quote, str, finish)
        Asts[#Asts+1] = {
            type   = 'string',
            start  = start,
            finish = finish - 1,
            [1]    = str,
            [2]    = quote,
        }
        return #Asts
    end,
    LongString = function (beforeEq, afterEq, str, missPos)
        if missPos then
            local endSymbol = ']' .. ('='):rep(afterEq-beforeEq) .. ']'
            local s, _, w = str:find('(%][%=]*%])[%c%s]*$')
            if s then
                pushError {
                    type   = 'ERR_LSTRING_END',
                    start  = missPos - #str + s - 1,
                    finish = missPos - #str + s + #w - 2,
                    info   = {
                        symbol = endSymbol,
                    },
                    fix    = {
                        title = 'FIX_LSTRING_END',
                        {
                            start  = missPos - #str + s - 1,
                            finish = missPos - #str + s + #w - 2,
                            text   = endSymbol,
                        }
                    },
                }
            end
            pushError {
                type   = 'MISS_SYMBOL',
                start  = missPos,
                finish = missPos,
                info   = {
                    symbol = endSymbol,
                },
                fix    = {
                    title = 'ADD_LSTRING_END',
                    {
                        start  = missPos,
                        finish = missPos,
                        text   = endSymbol,
                    }
                },
            }
        end
        return '[' .. ('='):rep(afterEq-beforeEq) .. '[', str
    end,
    Char10 = function (char)
        char = tonumber(char)
        if not char or char < 0 or char > 255 then
            return ''
        end
        return stringChar(char)
    end,
    Char16 = function (pos, char)
        if State.version == 'Lua 5.1' then
            pushError {
                type = 'ERR_ESC',
                start = pos-1,
                finish = pos,
                version = {'Lua 5.2', 'Lua 5.3', 'Lua 5.4', 'LuaJIT'},
                info = {
                    version = State.version,
                }
            }
            return char
        end
        return stringChar(tonumber(char, 16))
    end,
    CharUtf8 = function (pos, char)
        if  State.version ~= 'Lua 5.3'
        and State.version ~= 'Lua 5.4'
        and State.version ~= 'LuaJIT'
        then
            pushError {
                type = 'ERR_ESC',
                start = pos-3,
                finish = pos-2,
                version = {'Lua 5.3', 'Lua 5.4', 'LuaJIT'},
                info = {
                    version = State.version,
                }
            }
            return char
        end
        if #char == 0 then
            pushError {
                type = 'UTF8_SMALL',
                start = pos-3,
                finish = pos,
            }
            return ''
        end
        local v = tonumber(char, 16)
        if not v then
            for i = 1, #char do
                if not tonumber(char:sub(i, i), 16) then
                    pushError {
                        type = 'MUST_X16',
                        start = pos + i - 1,
                        finish = pos + i - 1,
                    }
                end
            end
            return ''
        end
        if State.version == 'Lua 5.4' then
            if v < 0 or v > 0x7FFFFFFF then
                pushError {
                    type = 'UTF8_MAX',
                    start = pos-3,
                    finish = pos+#char,
                    info = {
                        min = '00000000',
                        max = '7FFFFFFF',
                    }
                }
            end
        else
            if v < 0 or v > 0x10FFFF then
                pushError {
                    type = 'UTF8_MAX',
                    start = pos-3,
                    finish = pos+#char,
                    version = v <= 0x7FFFFFFF and 'Lua 5.4' or nil,
                    info = {
                        min = '000000',
                        max = '10FFFF',
                    }
                }
            end
        end
        if v >= 0 and v <= 0x10FFFF then
            return utf8Char(v)
        end
        return ''
    end,
    Number = function (start, number, finish)
        local n = tonumber(number)
        if n then
            Asts[#Asts+1] = {
                type   = 'number',
                start  = start,
                finish = finish - 1,
                [1]    = n,
            }
            State.LastNumber = #Asts
            return State.LastNumber
        else
            pushError {
                type   = 'MALFORMED_NUMBER',
                start  = start,
                finish = finish - 1,
            }
            Asts[#Asts+1] = {
                type   = 'number',
                start  = start,
                finish = finish - 1,
                [1]    = 0,
            }
            State.LastNumber = #Asts
            return State.LastNumber
        end
    end,
    FFINumber = function (start, symbol)
        local lastNumber = Asts[State.LastNumber]
        if mathType(lastNumber[1]) == 'float' then
            pushError {
                type = 'UNKNOWN_SYMBOL',
                start = start,
                finish = start + #symbol - 1,
                info = {
                    symbol = symbol,
                }
            }
            lastNumber[1] = 0
            return
        end
        if State.version ~= 'LuaJIT' then
            pushError {
                type = 'UNSUPPORT_SYMBOL',
                start = start,
                finish = start + #symbol - 1,
                version = 'LuaJIT',
                info = {
                    version = State.version,
                }
            }
            lastNumber[1] = 0
        end
    end,
    ImaginaryNumber = function (start, symbol)
        local lastNumber = Asts[State.LastNumber]
        if State.version ~= 'LuaJIT' then
            pushError {
                type = 'UNSUPPORT_SYMBOL',
                start = start,
                finish = start + #symbol - 1,
                version = 'LuaJIT',
                info = {
                    version = State.version,
                }
            }
        end
        lastNumber[1] = 0
    end,
    Name = function (start, str, finish)
        local isKeyWord
        if RESERVED[str] then
            isKeyWord = true
        elseif str == 'goto' then
            if State.version ~= 'Lua 5.1' and State.version ~= 'LuaJIT' then
                isKeyWord = true
            end
        end
        if isKeyWord then
            pushError {
                type = 'KEYWORD',
                start = start,
                finish = finish - 1,
            }
        end
        Asts[#Asts+1] = {
            type   = 'name',
            start  = start,
            finish = finish - 1,
            [1]    = str,
        }
        return #Asts
    end,
    GetField = function (dot, field)
        Asts[#Asts+1] = {
            type   = 'getfield',
            field  = field,
            dot    = dot,
            start  = Asts[dot].start,
            finish = Asts[field or dot].finish,
        }
        return #Asts
    end,
    GetIndex = function (start, index, finish)
        Asts[#Asts+1] = {
            type   = 'getindex',
            start  = start,
            finish = finish - 1,
            index  = index,
        }
        return #Asts
    end,
    GetMethod = function (colon, method)
        Asts[#Asts+1] = {
            type   = 'getmethod',
            method = method,
            colon  = colon,
            start  = Asts[colon].start,
            finish = Asts[method or colon].finish,
        }
        return #Asts
    end,
    Single = function (unit)
        local unitAst = Asts[unit]
        Asts[#Asts+1] = {
            type   = 'getname',
            start  = unitAst.start,
            finish = unitAst.finish,
            name   = unit,
        }
        return #Asts
    end,
    Simple = function (units)
        local last = units[1]
        for i = 2, #units do
            local current  = Asts[units[i]]
            current.parent = last
            current.start  = Asts[last].start
            last = units[i]
        end
        return last
    end,
    SimpleCall = function (call)
        local callAst = Asts[call]
        if callAst.type ~= 'call' and callAst.type ~= 'getmethod' then
            pushError {
                type   = 'EXP_IN_ACTION',
                start  = callAst.start,
                finish = callAst.finish,
            }
        end
        return call
    end,
    BinaryOp = function (start, op)
        Asts[#Asts+1] = {
            type   = op,
            start  = start,
            finish = start + #op - 1,
        }
        return #Asts
    end,
    UnaryOp = function (start, op)
        Asts[#Asts+1] = {
            type   = op,
            start  = start,
            finish = start + #op - 1,
        }
        return #Asts
    end,
    Exp = function (first, ...)
        if not ... then
            return first
        end
        local list = {first, ...}
        return expSplit(list, 1, #list, 1)
    end,
    Paren = function (start, exp, finish)
        local expAst = Asts[exp]
        if expAst and expAst.type == 'paren' then
            expAst.start  = start
            expAst.finish = finish - 1
            return expAst
        end
        Asts[#Asts+1] = {
            type   = 'paren',
            start  = start,
            finish = finish - 1,
            exp    = exp
        }
        return #Asts
    end,
    VarArgs = function (dots)
        Asts[dots].type = 'varargs'
        return dots
    end,
    PackLoopArgs = function (start, list, finish)
        local list = packList(start, list, finish)
        if #list == 0 then
            pushError {
                type   = 'MISS_LOOP_MIN',
                start  = finish,
                finish = finish,
            }
        elseif #list == 1 then
            pushError {
                type   = 'MISS_LOOP_MAX',
                start  = finish,
                finish = finish,
            }
        end
        return list
    end,
    PackInNameList = function (start, list, finish)
        local list = packList(start, list, finish)
        if #list == 0 then
            pushError {
                type   = 'MISS_NAME',
                start  = start,
                finish = finish,
            }
        end
        return list
    end,
    PackInExpList = function (start, list, finish)
        local list = packList(start, list, finish)
        if #list == 0 then
            pushError {
                type   = 'MISS_EXP',
                start  = start,
                finish = finish,
            }
        end
        return list
    end,
    PackExpList = function (start, list, finish)
        local list = packList(start, list, finish)
        return list
    end,
    PackNameList = function (start, list, finish)
        local list = packList(start, list, finish)
        return list
    end,
    Call = function (start, args, finish)
        return createCall(args, start, finish-1)
    end,
    COMMA = function (start)
        Asts[#Asts+1] = {
            type   = ',',
            start  = start,
            finish = start,
        }
        return #Asts
    end,
    SEMICOLON = function (start)
        Asts[#Asts+1] = {
            type   = ';',
            start  = start,
            finish = start,
        }
        return #Asts
    end,
    DOTS = function (start)
        Asts[#Asts+1] = {
            type   = '...',
            start  = start,
            finish = start + 2,
        }
        return #Asts
    end,
    COLON = function (start)
        Asts[#Asts+1] = {
            type   = ':',
            start  = start,
            finish = start,
        }
        return #Asts
    end,
    DOT = function (start)
        Asts[#Asts+1] = {
            type   = '.',
            start  = start,
            finish = start,
        }
        return #Asts
    end,
    Function = function (start, args, actions, finish)
        actions.type   = 'function'
        actions.start  = start
        actions.finish = finish - 1
        actions.args   = args
        checkMissEnd(start)
        Asts[#Asts+1] = actions
        local id = #Asts
        local funcList = State.ref['function']
        for i = 1, #actions do
            local action = actions[i]
            funcList[action] = id
        end
        return #Asts
    end,
    NamedFunction = function (start, name, args, actions, finish)
        actions.type   = 'function'
        actions.start  = start
        actions.finish = finish - 1
        actions.args   = args
        checkMissEnd(start)
        Asts[#Asts+1] = (actions)
        local func = #Asts
        local funcList = State.ref['function']
        for i = 1, #actions do
            local action = actions[i]
            funcList[action] = func
        end
        if not name then
            return
        end
        local nameAst = Asts[name]
        if nameAst.type == 'getname' then
            nameAst.type = 'setname'
            nameAst.value = func
            return name
        elseif nameAst.type == 'getfield' then
            nameAst.type = 'setfield'
            nameAst.value = func
            return name
        elseif nameAst.type == 'getmethod' then
            nameAst.type = 'setmethod'
            nameAst.value = func
            return name
        end
    end,
    LocalFunction = function (start, name, args, actions, finish)
        actions.type   = 'function'
        actions.start  = start
        actions.finish = finish - 1
        actions.args   = args
        checkMissEnd(start)
        Asts[#Asts+1] = actions
        local func = #Asts
        local funcList = State.ref['function']
        for i = 1, #actions do
            local action = actions[i]
            funcList[action] = func
        end

        if not name then
            return
        end

        local nameAst = Asts[name]
        if nameAst.type ~= 'getname' then
            pushError {
                type = 'UNEXPECT_LFUNC_NAME',
                start = nameAst.start,
                finish = nameAst.finish,
            }
            return
        end

        nameAst.type = 'setname'
        nameAst.value = func

        return createLocal(nameAst.name), name
    end,
    Table = function (start, tbl, finish)
        tbl.type   = 'table'
        tbl.start  = start
        tbl.finish = finish - 1
        local wantField = true
        local lastStart = start + 1
        local fieldCount = 0
        for i = 1, #tbl do
            local field = tbl[i]
            local fieldAst = Asts[field]
            if fieldAst.type == ',' or fieldAst.type == ';' then
                if wantField then
                    pushError {
                        type = 'MISS_EXP',
                        start = lastStart,
                        finish = fieldAst.start - 1,
                    }
                end
                wantField = true
                lastStart = fieldAst.finish + 1
            else
                if not wantField then
                    pushError {
                        type = 'MISS_SEP_IN_TABLE',
                        start = lastStart,
                        finish = fieldAst.start - 1,
                    }
                end
                wantField = false
                lastStart = fieldAst.finish + 1
                fieldCount = fieldCount + 1
                tbl[fieldCount] = field
            end
        end
        for i = fieldCount + 1, #tbl do
            tbl[i] = nil
        end
        Asts[#Asts+1] = tbl
        return #Asts
    end,
    NewField = function (start, field, value, finish)
        Asts[#Asts+1] = {
            type   = 'tablefield',
            start  = start,
            finish = finish-1,
            field  = field,
            value  = value,
        }
        return #Asts
    end,
    Index = function (start, index, finish)
        Asts[#Asts+1] = {
            type   = 'index',
            start  = start,
            finish = finish - 1,
            index  = index,
        }
        return #Asts
    end,
    NewIndex = function (start, index, value, finish)
        Asts[#Asts+1] = {
            type   = 'tableindex',
            start  = start,
            finish = finish-1,
            index  = index,
            value  = value,
        }
        return #Asts
    end,
    FuncArgs = function (start, args, finish)
        args.type   = 'funcargs'
        args.start  = start
        args.finish = finish - 1
        local lastStart = start + 1
        local wantName = true
        local argCount = 0
        for i = 1, #args do
            local arg = args[i]
            local argAst = Asts[arg]
            if argAst.type == ',' then
                if wantName then
                    pushError {
                        type = 'MISS_NAME',
                        start = lastStart,
                        finish = argAst.start-1,
                    }
                end
                wantName = true
            else
                if not wantName then
                    pushError {
                        type = 'MISS_SYMBOL',
                        start = lastStart-1,
                        finish = argAst.start-1,
                        info = {
                            symbol = ',',
                        }
                    }
                end
                wantName = false
                argCount = argCount + 1
                args[argCount] = arg

                if argAst.type == '...' then
                    if i < #args then
                        local a = args[i+1]
                        local b = args[#args]
                        pushError {
                            type   = 'ARGS_AFTER_DOTS',
                            start  = Asts[a].start,
                            finish = Asts[b].finish,
                        }
                    end
                    break
                end
            end
            lastStart = argAst.finish + 1
        end
        for i = argCount + 1, #args do
            args[i] = nil
        end
        if wantName and argCount > 0 then
            pushError {
                type   = 'MISS_NAME',
                start  = lastStart,
                finish = finish - 1,
            }
        end
        Asts[#Asts+1] = args
        return #Asts
    end,
    Set = function (start, keys, values, finish)
        for i = 1, #keys do
            local key = keys[i]
            local keyAst = Asts[key]
            if keyAst.type == 'getname' then
                keyAst.type = 'setname'
                keyAst.value = getValue(values, i)
            elseif keyAst.type == 'getfield' then
                keyAst.type = 'setfield'
                keyAst.value = getValue(values, i)
            end
        end
        return tableUnpack(keys)
    end,
    LocalAttr = function (attrs)
        for i = 1, #attrs do
            local attr = attrs[i]
            local attrAst = Asts[attr]
            attrAst.type = 'localattr'
            if State.version ~= 'Lua 5.4' then
                pushError {
                    type    = 'UNSUPPORT_SYMBOL',
                    start   = attrAst.start,
                    finish  = attrAst.finish,
                    version = 'Lua 5.4',
                    info    = {
                        version = State.version,
                    }
                }
            elseif attrAst[1] ~= 'const' and attrAst[1] ~= 'close' then
                pushError {
                    type   = 'UNKNOWN_TAG',
                    start  = attrAst.start,
                    finish = attrAst.finish,
                    info   = {
                        tag = attrAst[1],
                    }
                }
            elseif i > 1 then
                pushError {
                    type   = 'MULTI_TAG',
                    start  = attrAst.start,
                    finish = attrAst.finish,
                    info   = {
                        tag = attrAst[1],
                    }
                }
            end
        end
        return attrs
    end,
    LocalName = function (name, attrs)
        if not name then
            return name
        end
        Asts[name].attrs = attrs
        return name
    end,
    Local = function (start, keys, values, finish)
        for i = 1, #keys do
            local key = keys[i]
            local keyAst = Asts[key]
            local attrs = keyAst.attrs
            keyAst.attrs = nil
            local value = getValue(values, i)
            createLocal(key, value, attrs)
        end
        return tableUnpack(keys)
    end,
    Do = function (start, actions, finish)
        actions.type = 'do'
        actions.start  = start
        actions.finish = finish - 1
        checkMissEnd(start)
        Asts[#Asts+1] = actions
        return #Asts
    end,
    Break = function (start, finish)
        Asts[#Asts+1] = {
            type   = 'break',
            start  = start,
            finish = finish,
        }
        return #Asts
    end,
    Return = function (start, exps, finish)
        exps.type   = 'return'
        exps.start  = start
        exps.finish = finish - 1
        Asts[#Asts+1] = exps
        local id = #Asts
        local rtnList = State.ref['return']
        for i = 1, #exps do
            local exp = exps[i]
            rtnList[exp] = id
        end
        return #Asts
    end,
    Label = function (start, name, finish)
        if State.version == 'Lua 5.1' then
            pushError {
                type   = 'UNSUPPORT_SYMBOL',
                start  = start,
                finish = finish - 1,
                version = {'Lua 5.2', 'Lua 5.3', 'Lua 5.4', 'LuaJIT'},
                info = {
                    version = State.version,
                }
            }
            return
        end
        if not name then
            return nil
        end
        local nameAst = Asts[name]
        nameAst.type = 'label'
        return name
    end,
    GoTo = function (start, name, finish)
        if State.version == 'Lua 5.1' then
            pushError {
                type    = 'UNSUPPORT_SYMBOL',
                start   = start,
                finish  = finish - 1,
                version = {'Lua 5.2', 'Lua 5.3', 'Lua 5.4', 'LuaJIT'},
                info = {
                    version = State.version,
                }
            }
            return
        end
        if not name then
            return nil
        end
        local nameAst = Asts[name]
        nameAst.type = 'goto'
        return name
    end,
    IfBlock = function (start, exp, actions, finish)
        actions.type   = 'ifblock'
        actions.start  = start
        actions.finish = finish - 1
        actions.filter = exp
        Asts[#Asts+1] = actions
        return #Asts
    end,
    ElseIfBlock = function (start, exp, actions, finish)
        actions.type   = 'elseifblock'
        actions.start  = start
        actions.finish = finish - 1
        actions.filter = exp
        Asts[#Asts+1] = actions
        return #Asts
    end,
    ElseBlock = function (start, actions, finish)
        actions.type   = 'elseblock'
        actions.start  = start
        actions.finish = finish - 1
        Asts[#Asts+1] = actions
        return #Asts
    end,
    If = function (start, blocks, finish)
        blocks.type   = 'if'
        blocks.start  = start
        blocks.finish = finish - 1
        local hasElse
        for i = 1, #blocks do
            local block = blocks[i]
            local blockAst = Asts[block]
            if i == 1 and blockAst.type ~= 'ifblock' then
                pushError {
                    type = 'MISS_SYMBOL',
                    start = blockAst.start,
                    finish = blockAst.start,
                    info = {
                        symbol = 'if',
                    }
                }
            end
            if hasElse then
                pushError {
                    type   = 'BLOCK_AFTER_ELSE',
                    start  = blockAst.start,
                    finish = blockAst.finish,
                }
            end
            if blockAst.type == 'elseblock' then
                hasElse = true
            end
        end
        checkMissEnd(start)
        Asts[#Asts+1] = blocks
        return #Asts
    end,
    Loop = function (start, arg, steps, actions, finish)
        local loc = createLocal(arg, steps[1])
        actions.type   = 'loop'
        actions.start  = start
        actions.finish = finish - 1
        actions.loc    = loc
        actions.max    = steps[2]
        actions.step   = steps[3]
        checkMissEnd(start)
        Asts[#Asts+1] = actions
        return #Asts
    end,
    In = function (start, locs, exp, actions, finish)
        local func = exp[#exp]
        exp[#exp] = nil
        local call
        if #exp == 0 then
            call = createCall(exp, 0, 0)
        else
            call = createCall(exp, Asts[exp[1]].start, Asts[exp[#exp]].finish)
        end
        Asts[call].parent = func
        actions.type   = 'in'
        actions.start  = start
        actions.finish = finish - 1
        actions.locs = {}
        local values = {call}
        for i = 1, #locs do
            local loc = locs[i]
            actions.locs[i] = createLocal(loc, getValue(values, i), nil)
        end
        checkMissEnd(start)
        Asts[#Asts+1] = actions
        return #Asts
    end,
    While = function (start, filter, actions, finish)
        actions.type   = 'while'
        actions.start  = start
        actions.finish = finish - 1
        actions.filter = filter
        checkMissEnd(start)
        Asts[#Asts+1] = actions
        return #Asts
    end,
    Repeat = function (start, actions, filter, finish)
        actions.type   = 'repeat'
        actions.start  = start
        actions.finish = finish
        actions.filter = filter
        Asts[#Asts+1] = actions
        return #Asts
    end,
    Lua = function (actions)
        actions.type = 'main'
        Asts[#Asts+1] = actions
        local id = #Asts
        local funcList = State.ref['function']
        for i = 1, #actions do
            local action = actions[i]
            funcList[action] = id
        end
        return id
    end,

    -- 捕获错误
    UnknownSymbol = function (start, symbol)
        pushError {
            type = 'UNKNOWN_SYMBOL',
            start = start,
            finish = start + #symbol - 1,
            info = {
                symbol = symbol,
            }
        }
        return
    end,
    UnknownAction = function (start, symbol)
        pushError {
            type = 'UNKNOWN_SYMBOL',
            start = start,
            finish = start + #symbol - 1,
            info = {
                symbol = symbol,
            }
        }
    end,
    DirtyName = function (pos)
        pushError {
            type = 'MISS_NAME',
            start = pos,
            finish = pos,
        }
        return nil
    end,
    DirtyExp = function (pos)
        pushError {
            type = 'MISS_EXP',
            start = pos,
            finish = pos,
        }
        return nil
    end,
    MissExp = function (pos)
        pushError {
            type = 'MISS_EXP',
            start = pos,
            finish = pos,
        }
    end,
    MissExponent = function (start, finish)
        pushError {
            type = 'MISS_EXPONENT',
            start = start,
            finish = finish - 1,
        }
    end,
    MissQuote1 = function (pos)
        pushError {
            type = 'MISS_SYMBOL',
            start = pos,
            finish = pos,
            info = {
                symbol = '"'
            }
        }
    end,
    MissQuote2 = function (pos)
        pushError {
            type = 'MISS_SYMBOL',
            start = pos,
            finish = pos,
            info = {
                symbol = "'"
            }
        }
    end,
    MissEscX = function (pos)
        pushError {
            type = 'MISS_ESC_X',
            start = pos-2,
            finish = pos+1,
        }
    end,
    MissTL = function (pos)
        pushError {
            type = 'MISS_SYMBOL',
            start = pos,
            finish = pos,
            info = {
                symbol = '{',
            }
        }
    end,
    MissTR = function (pos)
        pushError {
            type = 'MISS_SYMBOL',
            start = pos,
            finish = pos,
            info = {
                symbol = '}',
            }
        }
    end,
    MissBR = function (pos)
        pushError {
            type = 'MISS_SYMBOL',
            start = pos,
            finish = pos,
            info = {
                symbol = ']',
            }
        }
    end,
    MissPL = function (pos)
        pushError {
            type = 'MISS_SYMBOL',
            start = pos,
            finish = pos,
            info = {
                symbol = '(',
            }
        }
    end,
    MissPR = function (pos)
        pushError {
            type = 'MISS_SYMBOL',
            start = pos,
            finish = pos,
            info = {
                symbol = ')',
            }
        }
    end,
    ErrEsc = function (pos)
        pushError {
            type = 'ERR_ESC',
            start = pos-1,
            finish = pos,
        }
    end,
    MustX16 = function (pos, str)
        pushError {
            type = 'MUST_X16',
            start = pos,
            finish = pos + #str - 1,
        }
    end,
    MissAssign = function (pos)
        pushError {
            type = 'MISS_SYMBOL',
            start = pos,
            finish = pos,
            info = {
                symbol = '=',
            }
        }
    end,
    MissTableSep = function (pos)
        pushError {
            type = 'MISS_SYMBOL',
            start = pos,
            finish = pos,
            info = {
                symbol = ','
            }
        }
    end,
    MissField = function (pos)
        pushError {
            type = 'MISS_FIELD',
            start = pos,
            finish = pos,
        }
    end,
    MissMethod = function (pos)
        pushError {
            type = 'MISS_METHOD',
            start = pos,
            finish = pos,
        }
    end,
    MissLabel = function (pos)
        pushError {
            type = 'MISS_SYMBOL',
            start = pos,
            finish = pos,
            info = {
                symbol = '::',
            }
        }
    end,
    MissEnd = function (pos)
        State.MissEndErr = pushError {
            type = 'MISS_SYMBOL',
            start = pos,
            finish = pos,
            info = {
                symbol = 'end',
            }
        }
    end,
    MissDo = function (pos)
        pushError {
            type = 'MISS_SYMBOL',
            start = pos,
            finish = pos,
            info = {
                symbol = 'do',
            }
        }
    end,
    MissComma = function (pos)
        pushError {
            type = 'MISS_SYMBOL',
            start = pos,
            finish = pos,
            info = {
                symbol = ',',
            }
        }
    end,
    MissIn = function (pos)
        pushError {
            type = 'MISS_SYMBOL',
            start = pos,
            finish = pos,
            info = {
                symbol = 'in',
            }
        }
    end,
    MissUntil = function (pos)
        pushError {
            type = 'MISS_SYMBOL',
            start = pos,
            finish = pos,
            info = {
                symbol = 'until',
            }
        }
    end,
    MissThen = function (pos)
        pushError {
            type = 'MISS_SYMBOL',
            start = pos,
            finish = pos,
            info = {
                symbol = 'then',
            }
        }
    end,
    MissName = function (pos)
        pushError {
            type = 'MISS_NAME',
            start = pos,
            finish = pos,
        }
    end,
    ExpInAction = function (start, exp, finish)
        pushError {
            type = 'EXP_IN_ACTION',
            start = start,
            finish = finish - 1,
        }
        return exp
    end,
    MissIf = function (start, block)
        pushError {
            type = 'MISS_SYMBOL',
            start = start,
            finish = start,
            info = {
                symbol = 'if',
            }
        }
        return block
    end,
    MissGT = function (start)
        pushError {
            type = 'MISS_SYMBOL',
            start = start,
            finish = start,
            info = {
                symbol = '>'
            }
        }
    end,
    ErrAssign = function (start, finish)
        pushError {
            type = 'ERR_ASSIGN_AS_EQ',
            start = start,
            finish = finish - 1,
            fix = {
                title = 'FIX_ASSIGN_AS_EQ',
                {
                    start   = start,
                    finish  = finish - 1,
                    text    = '=',
                }
            }
        }
    end,
    ErrEQ = function (start, finish)
        pushError {
            type   = 'ERR_EQ_AS_ASSIGN',
            start  = start,
            finish = finish - 1,
            fix = {
                title = 'FIX_EQ_AS_ASSIGN',
                {
                    start  = start,
                    finish = finish - 1,
                    text   = '==',
                }
            }
        }
        return '=='
    end,
    ErrUEQ = function (start, finish)
        pushError {
            type   = 'ERR_UEQ',
            start  = start,
            finish = finish - 1,
            fix = {
                title = 'FIX_UEQ',
                {
                    start  = start,
                    finish = finish - 1,
                    text   = '~=',
                }
            }
        }
        return '=='
    end,
    ErrThen = function (start, finish)
        pushError {
            type = 'ERR_THEN_AS_DO',
            start = start,
            finish = finish - 1,
            fix = {
                title = 'FIX_THEN_AS_DO',
                {
                    start   = start,
                    finish  = finish - 1,
                    text    = 'then',
                }
            }
        }
    end,
    ErrDo = function (start, finish)
        pushError {
            type = 'ERR_DO_AS_THEN',
            start = start,
            finish = finish - 1,
            fix = {
                title = 'FIX_DO_AS_THEN',
                {
                    start   = start,
                    finish  = finish - 1,
                    text    = 'do',
                }
            }
        }
    end,
}

--for k, v in pairs(emmy.ast) do
--    Defs[k] = v
--end

local function initRefs()
    State.ref['function'] = {}
    State.ref['return']   = {}
end

local function init(state)
    State     = state
    pushError = state.pushError
    Asts      = state.ast
    emmy.init(State)
    initRefs()
end

return {
    defs = Defs,
    init = init,
}

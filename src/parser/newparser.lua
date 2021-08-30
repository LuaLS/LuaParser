local sbyte     = string.byte
local sfind     = string.find
local smatch    = string.match
local sgsub     = string.gsub
local ssub      = string.sub
local schar     = string.char
local uchar     = utf8.char
local tconcat   = table.concat
local tinsert   = table.insert
local tointeger = math.tointeger
local mtype     = math.type
local tonumber  = tonumber

---@alias parser.position integer

---@param str string
---@return table<integer, boolean>
local function stringToCharMap(str)
    local map = {}
    local pos = 1
    while pos <= #str do
        local byte = sbyte(str, pos, pos)
        map[schar(byte)] = true
        pos = pos + 1
        if  ssub(str, pos, pos) == '-'
        and pos < #str then
            pos = pos + 1
            local byte2 = sbyte(str, pos, pos)
            assert(byte < byte2)
            for b = byte + 1, byte2 do
                map[schar(b)] = true
            end
            pos = pos + 1
        end
    end
    return map
end

local CharMapNL      = stringToCharMap '\r\n'
local CharMapNumber  = stringToCharMap '0-9'
local CharMapN16     = stringToCharMap 'xX'
local CharMapN2      = stringToCharMap 'bB'
local CharMapE10     = stringToCharMap 'eE'
local CharMapE16     = stringToCharMap 'pP'
local CharMapSign    = stringToCharMap '+-'
local CharMapSB      = stringToCharMap 'ao|~&=<>.*/%^+-'
local CharMapSU      = stringToCharMap 'n#~-'
local CharMapSimple  = stringToCharMap '.:([\'"{'
local CharMapStrSH   = stringToCharMap '\'"'
local CharMapStrLH   = stringToCharMap '['
local CharMapTSep    = stringToCharMap ',;'

local EscMap = {
    ['a'] = '\a',
    ['b'] = '\b',
    ['f'] = '\f',
    ['n'] = '\n',
    ['r'] = '\r',
    ['t'] = '\t',
    ['v'] = '\v',
}

local LineMulti = 10000

-- goto 单独处理
local KeyWord = {
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

local UnarySymbol = {
    ['not'] = true,
    ['#']   = true,
    ['~']   = true,
    ['-']   = true,
}

local BinarySymbol = {
    ['or']  = 1,
    ['and'] = 2,
    ['<=']  = 3,
    ['>=']  = 3,
    ['<']   = 3,
    ['>']   = 3,
    ['~=']  = 3,
    ['==']  = 3,
    ['|']   = 4,
    ['~']   = 5,
    ['&']   = 6,
    ['<<']  = 7,
    ['>>']  = 7,
    ['..']  = 8,
    ['+']   = 9,
    ['-']   = 9,
    ['*']   = 10,
    ['//']  = 10,
    ['/']   = 10,
    ['%']   = 10,
    ['^']   = 11,
}

local SymbolForward = {
    [01]  = true,
    [02]  = true,
    [03]  = true,
    [04]  = true,
    [05]  = true,
    [06]  = true,
    [07]  = true,
    [08]  = false,
    [09]  = true,
    [10]  = true,
    [11]  = false,
}

local State, Lua, LuaOffset, Line, LineOffset, Chunk

local parseExp

local function pushError(err)
    local errs = State.errs
    if err.finish < err.start then
        err.finish = err.start
    end
    local last = errs[#errs]
    if last then
        if last.start <= err.start and last.finish >= err.finish then
            return
        end
    end
    err.level = err.level or 'error'
    errs[#errs+1] = err
    return err
end

local CachedChar, CachedCharOffset
local function getChar(offset)
    if not offset then
        offset = LuaOffset
    end
    if CachedCharOffset ~= offset then
        CachedCharOffset = offset
        CachedChar = ssub(Lua, offset, offset)
    end
    return CachedChar
end

---@param offset integer
---@param leftOrRight '"left"'|'"right"'
local function getPosition(offset, leftOrRight)
    if leftOrRight == 'left' then
        return LineMulti * Line + offset - LineOffset
    else
        return LineMulti * Line + offset - LineOffset + 1
    end
end

local function missSymbol(offset, symbol)
    local pos = getPosition(offset, 'right')
    pushError {
        type   = 'MISS_SYMBOL',
        start  = pos,
        finish = pos,
        info = {
            symbol = symbol,
        }
    }
end

local function missExp(offset)
    local pos = getPosition(offset, 'right')
    pushError {
        type   = 'MISS_EXP',
        start  = pos,
        finish = pos,
    }
end

---@return string          word
---@return parser.position startPosition
---@return parser.position finishPosition
---@return integer         newOffset
local function peekWord()
    local start, finish, word = sfind(Lua
        , '^([%a_\x80-\xff][%w_\x80-\xff]*)'
        , LuaOffset
    )
    if not finish then
        return nil
    end
    local startPos  = getPosition(start , 'left')
    local finishPos = getPosition(finish, 'right')
    return word, startPos, finishPos, finish + 1
end

local function skipNL()
    local b = getChar()
    if not CharMapNL[b] then
        return false
    end
    LuaOffset = LuaOffset + 1
    -- \r\n ?
    if b == '\r' then
        local nb = getChar()
        if nb == '\n' then
            LuaOffset = LuaOffset + 1
        end
    end
    Line       = Line + 1
    LineOffset = LuaOffset
    return true
end

local function skipSpace()
    ::AGAIN::
    if skipNL() then
        goto AGAIN
    end
    local offset = sfind(Lua, '[^ \t]', LuaOffset)
    if not offset then
        return
    end
    if offset > LuaOffset then
        LuaOffset = offset
        goto AGAIN
    end
end

local function createLocal(obj, effect, value, attrs)
    if not obj then
        return nil
    end
    obj.type   = 'local'
    obj.effect = effect or obj.finish
    obj.value  = value
    obj.attrs  = attrs
    if value then
        obj.range = value.finish
    end
    local chunk = Chunk[#Chunk]
    local locals = chunk.locals
    if not locals then
        locals = {}
        chunk.locals = {}
        locals[#locals+1] = obj
    end
    return obj
end

local function pushChunk(chunk)
    Chunk[#Chunk+1] = chunk
end

local function popChunk()
    Chunk[#Chunk] = nil
end

local function parseNil()
    local word, start, finish, newOffset = peekWord()
    if word ~= 'nil' then
        return nil
    end
    LuaOffset = newOffset
    return {
        type   = 'nil',
        start  = start,
        finish = finish,
    }
end

local function parseBoolean()
    local word, start, finish, newOffset = peekWord()
    if  word ~= 'true'
    and word ~= 'false' then
        return nil
    end
    LuaOffset = newOffset
    return {
        type   = 'boolean',
        start  = start,
        finish = finish,
        [1]    = word == 'true' and true or false,
    }
end

local stringPool = {}

local function parseStringUnicode()
    if getChar() ~= '{' then
        missSymbol(LuaOffset)
        return nil
    end
    local leftPos  = getPosition(LuaOffset, 'right')
    local x16 = smatch(Lua, '^[%da-fA-F]*', LuaOffset + 1)
    local rightPos = getPosition(LuaOffset + #x16, 'right')
    LuaOffset = LuaOffset + #x16 + 1
    if getChar() == '}' then
        LuaOffset = LuaOffset + 1
    else
        missSymbol(LuaOffset, '}')
    end
    if  State.version ~= 'Lua 5.3'
    and State.version ~= 'Lua 5.4'
    and State.version ~= 'LuaJIT'
    then
        pushError {
            type    = 'ERR_ESC',
            start   = leftPos - 1,
            finish  = getPosition(LuaOffset, 'right'),
            version = {'Lua 5.3', 'Lua 5.4', 'LuaJIT'},
            info = {
                version = State.version,
            }
        }
        return nil
    end
    local byte = tonumber(x16, 16)
    if not byte then
        for i = 1, #x16 do
            if not tonumber(ssub(x16, i, i), 16) then
                pushError {
                    type   = 'MUST_X16',
                    start  = leftPos + i - 1,
                    finish = leftPos + i,
                }
            end
        end
        return nil
    end
    if State.version == 'Lua 5.4' then
        if byte < 0 or byte > 0x7FFFFFFF then
            pushError {
                type   = 'UTF8_MAX',
                start  = leftPos,
                finish = rightPos,
                info   = {
                    min = '00000000',
                    max = '7FFFFFFF',
                }
            }
            return nil
        end
    else
        if byte < 0 or byte > 0x10FFFF then
            pushError {
                type    = 'UTF8_MAX',
                start   = leftPos,
                finish  = rightPos,
                version = byte <= 0x7FFFFFFF and 'Lua 5.4' or nil,
                info = {
                    min = '000000',
                    max = '10FFFF',
                }
            }
        end
    end
    if byte >= 0 and byte <= 0x10FFFF then
        return uchar(byte)
    end
    return nil
end

local function parseShotString()
    local mark = getChar()
    local start = LuaOffset
    local pattern
    if mark == '"' then
        pattern = '(["\r\n\\])'
    else
        pattern = "(['\r\n\\])"
    end
    LuaOffset = LuaOffset + 1
    local offset, _, char = sfind(Lua, pattern, LuaOffset)
    -- simple string
    if char == mark then
        LuaOffset = offset + 1
        return {
            type   = 'string',
            start  = getPosition(start , 'left'),
            finish = getPosition(offset, 'right'),
            [1]    = ssub(Lua, start + 1, offset - 1),
            [2]    = mark,
        }
    end
    local startPos = getPosition(start , 'left')
    local stringResult
    local stringIndex = 1
    while true do
        stringPool[stringIndex] = ssub(Lua, LuaOffset, offset - 1)
        stringIndex = stringIndex + 1
        if     char == '\\' then
            local nextChar = getChar(offset + 1)
            if EscMap[nextChar] then
                LuaOffset = offset + 2
                stringPool[stringIndex] = EscMap[nextChar]
                stringIndex = stringIndex + 1
            elseif nextChar == mark then
                LuaOffset = offset + 2
                stringPool[stringIndex] = nextChar
                stringIndex = stringIndex + 1
            elseif nextChar == 'z' then
                LuaOffset = offset + 2
                skipSpace()
            elseif CharMapNumber[nextChar] then
                local numbers = smatch(Lua, '%d+', offset + 1)
                if #numbers > 3 then
                    numbers = ssub(numbers, 1, 3)
                end
                LuaOffset = offset + #numbers + 1
                local byte = tointeger(numbers)
                if byte <= 255 then
                    stringPool[stringIndex] = schar(byte)
                    stringIndex = stringIndex + 1
                else
                    -- TODO pushError
                end
            elseif nextChar == 'x' then
                local x16 = ssub(Lua, offset + 2, offset + 3)
                local byte = tonumber(x16, 16)
                if byte then
                    stringPool[stringIndex] = schar(byte)
                    stringIndex = stringIndex + 1
                    LuaOffset = LuaOffset + 4
                else
                    -- TODO pushError
                    LuaOffset = LuaOffset + 2
                end
            elseif nextChar == 'u' then
                LuaOffset = offset + 2
                local str = parseStringUnicode()
                if str then
                    stringPool[stringIndex] = str
                    stringIndex = stringIndex + 1
                end
            else
                LuaOffset = offset + 2
            end
        elseif char == mark then
            stringResult = tconcat(stringPool, '', 1, stringIndex - 1)
            LuaOffset = offset + 1
            break
        end
        offset, _, char = sfind(Lua, pattern, LuaOffset)
        if not char then
            stringPool[stringIndex] = ssub(Lua, LuaOffset)
            stringResult = tconcat(stringPool, '', 1, stringIndex)
            LuaOffset = offset + 1
            break
        end
    end
    return {
        type   = 'string',
        start  = startPos,
        finish = getPosition(LuaOffset - 1, 'right'),
        [1]    = stringResult,
        [2]    = mark,
    }
end

local function parseLongString()
    local start, finish, mark = sfind(Lua, '(%[%=*%[)', LuaOffset)
    if not mark then
        return nil
    end
    local startPos = getPosition(start, 'left')
    LuaOffset = finish + 1
    skipNL()
    local finishMark = sgsub(mark, '%[', ']')
    local stringResult
    local stringIndex = 1
    while true do
        local offset, _, char = sfind(Lua, '([\r\n%]])', LuaOffset)
        if not char then
            stringPool[stringIndex] = ssub(Lua, LuaOffset)
            stringResult = tconcat(stringPool, '', 1, stringIndex)
            LuaOffset = #Lua + 1
            break
        end
        stringPool[stringIndex] = ssub(Lua, LuaOffset, offset - 1)
        stringIndex = stringIndex + 1
        if char == '\r'
        or char == '\n' then
            LuaOffset = offset
            skipNL()
            stringPool[stringIndex] = '\n'
            stringIndex = stringIndex + 1
        else
            local markFinishOffset = offset + #finishMark - 1
            if ssub(Lua, offset, markFinishOffset) == finishMark then
                stringResult = tconcat(stringPool, '', 1, stringIndex - 1)
                LuaOffset = markFinishOffset + 1
                break
            else
                stringPool[stringIndex] = ']'
                stringIndex = stringIndex + 1
                LuaOffset   = offset + 1
            end
        end
    end
    return {
        type   = 'string',
        start  = startPos,
        finish = getPosition(LuaOffset - 1, 'right'),
        [1]    = stringResult,
        [2]    = mark,
    }
end

local function parseString()
    local b = getChar()
    if CharMapStrSH[b] then
        return parseShotString()
    end
    if CharMapStrLH[b] then
        return parseLongString()
    end
    return nil
end

local function parseNumber10(offset)
    local integerPart = smatch(Lua, '^%d*', offset)
    LuaOffset = offset + #integerPart
    -- float part
    if getChar(LuaOffset) == '.' then
        local floatPart = smatch(Lua, '^%d*', LuaOffset + 1)
        LuaOffset = LuaOffset + #floatPart + 1
    end
    -- exp part
    local echar = getChar(LuaOffset)
    if CharMapE10[echar] then
        LuaOffset = LuaOffset + 1
        local nextChar = getChar(LuaOffset)
        if CharMapSign[nextChar] then
            LuaOffset = LuaOffset + 1
        end
        local exp = smatch(Lua, '^%d*', LuaOffset)
        LuaOffset = LuaOffset + #exp
    end
    return tonumber(ssub(Lua, offset, LuaOffset - 1))
end

local function parseNumber16(offset)
    local integerPart = smatch(Lua, '^[%da-fA-F]*', offset)
    LuaOffset = offset + #integerPart
    -- float part
    if getChar(LuaOffset) == '.' then
        local floatPart = smatch(Lua, '^[%da-fA-F]*', LuaOffset + 1)
        LuaOffset = LuaOffset + #floatPart + 1
    end
    -- exp part
    local echar = getChar(LuaOffset)
    if CharMapE16[echar] then
        LuaOffset = LuaOffset + 1
        local nextChar = getChar(LuaOffset)
        if CharMapSign[nextChar] then
            LuaOffset = LuaOffset + 1
        end
        local exp = smatch(Lua, '^%d*', LuaOffset)
        LuaOffset = LuaOffset + #exp
    end
    return tonumber(ssub(Lua, offset - 2, LuaOffset - 1))
end

local function parseNumber2(offset)
    local bins = smatch(Lua, '[01]*', offset)
    LuaOffset = offset + #bins
    return tonumber(bins, 2)
end

local function parseNumber()
    local offset = LuaOffset
    local startPos = getPosition(offset, 'left')
    local neg
    if getChar(offset) == '-' then
        neg = true
        offset = offset + 1
    end
    local number
    local firstChar = getChar(offset)
    if     firstChar == '.' then
    elseif firstChar == '0' then
        local nextChar = getChar(offset + 1)
        if CharMapN16[nextChar] then
            number = parseNumber16(offset + 2)
        elseif CharMapN2[nextChar] then
            number = parseNumber2(offset + 2)
        else
            number = parseNumber10(offset)
        end
    elseif CharMapNumber[firstChar] then
        number = parseNumber10(offset)
    else
        return nil
    end
    if not number then
        number = 0
    end
    if neg then
        number = - number
    end
    return {
        type   = mtype(number) == 'integer' and 'integer' or 'number',
        start  = startPos,
        finish = getPosition(LuaOffset - 1, 'right'),
        [1]    = number,
    }
end

local function parseName()
    local word, startPos, finishPos, newOffset = peekWord()
    if not word then
        return nil
    end
    LuaOffset = newOffset
    return {
        type   = 'name',
        start  = startPos,
        finish = finishPos,
        [1]    = word,
    }
end

local function parseExpList()
    local list
    local lastSepPos = LuaOffset
    while true do
        skipSpace()
        local char = getChar()
        if not char then
            break
        end
        if char == ',' then
            local sepPos = getPosition(LuaOffset, 'right')
            if lastSepPos then
                pushError {
                    type   = 'UNEXPECT_SYMBOL',
                    start  = getPosition(LuaOffset, 'left'),
                    finish = sepPos,
                    info = {
                        symbol = ',',
                    }
                }
            end
            lastSepPos = sepPos
            LuaOffset = LuaOffset + 1
            goto CONTINUE
        else
            if not lastSepPos then
                break
            end
            local exp = parseExp()
            if not exp then
                break
            end
            lastSepPos = nil
            if not list then
                list = {
                    start  = exp.start,
                }
            end
            list[#list+1] = exp
            list.finish   = exp.finish
            exp.parent    = list
        end
        ::CONTINUE::
    end
    if not list then
        return nil
    end
    if lastSepPos then
        pushError {
            type   = 'MISS_EXP',
            start  = lastSepPos,
            finish = lastSepPos,
        }
    end
    return list
end

local function parseTable()
    if getChar() ~= '{' then
        return nil
    end
    local tbl = {
        type   = 'table',
        start  = getPosition(LuaOffset, 'left'),
    }
    LuaOffset = LuaOffset + 1
    local index = 0
    while true do
        skipSpace()
        local nextChar = getChar()
        if nextChar == '}' then
            LuaOffset = LuaOffset + 1
            break
        end
        if CharMapTSep[nextChar] then
            LuaOffset = LuaOffset + 1
            goto CONTINUE
        end
        local exp = parseExp()
        if exp then
            index = index + 1
            if exp.type == 'varargs' then
                tbl[index] = exp
                exp.parent = tbl
                goto CONTINUE
            end
            if exp.type == 'getlocal'
            or exp.type == 'getglobal' then
                skipSpace()
                if getChar() == '=' then
                    local eqRight = getPosition(LuaOffset, 'right')
                    LuaOffset = LuaOffset + 1
                    skipSpace()
                    local fvalue = parseExp()
                    local tfield = {
                        type   = 'tablefield',
                        start  = exp.start,
                        finish = fvalue and fvalue.finish or eqRight,
                        parent = tbl,
                        field  = exp,
                        value  = fvalue,
                    }
                    exp.type   = 'field'
                    exp.parent = tfield
                    if fvalue then
                        fvalue.parent = tfield
                    end
                    tbl[index] = tfield
                    goto CONTINUE
                end
            end
            local texp = {
                type   = 'tableexp',
                start  = exp.start,
                finish = exp.finish,
                tindex = index,
                parent = tbl,
                value  = exp,
            }
            exp.parent = texp
            tbl[index] = texp
        else
            missSymbol(LuaOffset, '}')
            break
        end
        ::CONTINUE::
    end
    tbl.finish = getPosition(LuaOffset - 1, 'right')
    return tbl
end

local function parseSimple(node)
    while true do
        skipSpace()
        local nextChar = getChar()
        if not CharMapSimple[nextChar] then
            break
        end
        if nextChar == '.' then
            local dot = {
                type   = nextChar,
                start  = getPosition(LuaOffset, 'left'),
                finish = getPosition(LuaOffset, 'right'),
            }
            LuaOffset = LuaOffset + 1
            skipSpace()
            local field = parseName()
            local getfield = {
                type   = 'getfield',
                start  = node.start,
                finish = getPosition(LuaOffset - 1, 'right'),
                node   = node,
                dot    = dot,
                field  = field
            }
            if field then
                field.parent = node
                field.type   = 'field'
            end
            node.next = getfield
            node = getfield
        elseif nextChar == ':' then
            local colon = {
                type   = nextChar,
                start  = getPosition(LuaOffset, 'left'),
                finish = getPosition(LuaOffset, 'right'),
            }
            LuaOffset = LuaOffset + 1
            skipSpace()
            local method = parseName()
            local getmethod = {
                type   = 'getmethod',
                start  = node.start,
                finish = getPosition(LuaOffset - 1, 'right'),
                node   = node,
                colon   = colon,
                method = method
            }
            if method then
                method.parent = node
                method.type   = 'method'
            end
            node.next = getmethod
            node = getmethod
        elseif nextChar == '(' then
            local startPos = getPosition(LuaOffset, 'left')
            local call = {
                type   = 'call',
                start  = node.start,
                node   = node,
            }
            LuaOffset = LuaOffset + 1
            local args = parseExpList()
            if getChar(LuaOffset) == ')' then
                LuaOffset = LuaOffset + 1
            else
                missSymbol(LuaOffset, ')')
            end
            if args then
                args.type   = 'callargs'
                args.start  = startPos
                args.finish = getPosition(LuaOffset - 1, 'right')
                args.parent = call
                call.args   = args
            end
            call.finish = getPosition(LuaOffset - 1, 'right')
            if node.type == 'getmethod' then
                -- dummy param `self`
                if not call.args then
                    call.args = {
                        type   = 'callargs',
                        start  = call.start,
                        finish = call.finish,
                        parent = call,
                    }
                end
                local newNode = {}
                for k, v in pairs(call.node.node) do
                    newNode[k] = v
                end
                newNode.mirror = call.node.node
                newNode.dummy  = true
                newNode.parent = call.args
                call.node.node.mirror = newNode
                tinsert(call.args, 1, newNode)
            end
            node = call
        elseif nextChar == '{' then
            local str = parseTable()
            local call = {
                type   = 'call',
                start  = node.start,
                finish = str.finish,
                node   = node,
            }
            local args = {
                type   = 'callargs',
                start  = str.start,
                finish = str.finish,
                parent = call,
                [1]    = str,
            }
            call.args  = args
            str.parent = args
            return call
        elseif CharMapStrSH[nextChar] then
            local str = parseShotString()
            local call = {
                type   = 'call',
                start  = node.start,
                finish = str.finish,
                node   = node,
            }
            local args = {
                type   = 'callargs',
                start  = str.start,
                finish = str.finish,
                parent = call,
                [1]    = str,
            }
            call.args  = args
            str.parent = args
            return call
        elseif CharMapStrLH[nextChar] then
            local str = parseLongString()
            if str then
                local call = {
                    type   = 'call',
                    start  = node.start,
                    finish = str.finish,
                    node   = node,
                }
                local args = {
                    type   = 'callargs',
                    start  = str.start,
                    finish = str.finish,
                    parent = call,
                    [1]    = str,
                }
                call.args  = args
                str.parent = args
                return call
            else
                local bstart = getPosition(LuaOffset, 'left')
                LuaOffset = LuaOffset + 1
                skipSpace()
                local index = parseExp()
                local getindex = {
                    type   = 'getindex',
                    start  = node.start,
                    bstart = bstart,
                    finish = getPosition(LuaOffset - 1, 'right'),
                    node   = node,
                    index  = index
                }
                if index then
                    index.parent = node
                end
                node.next = getindex
                node = getindex
                skipSpace()
                if getChar() == ']' then
                    getindex.finish = getPosition(LuaOffset, 'right')
                    LuaOffset = LuaOffset + 1
                else
                    missSymbol(LuaOffset, ']')
                end
            end
        end
    end
    return node
end

local function parseVarargs()
    if ssub(Lua, LuaOffset, LuaOffset + 2) == '...' then
        local varargs = {
            type   = 'varargs',
            start  = getPosition(LuaOffset, 'left'),
            finish = getPosition(LuaOffset + 2, 'right'),
        }
        LuaOffset = LuaOffset + 3
        return varargs
    end
    return nil
end

local function parseParen()
    local firstChar = getChar()
    if firstChar ~= '(' then
        return
    end
    local pl = LuaOffset
    local paren = {
        type   = 'paren',
        start  = getPosition(pl, 'left'),
        finish = getPosition(pl, 'right')
    }
    LuaOffset = LuaOffset + 1
    skipSpace()
    local exp = parseExp()
    if exp then
        paren.exp    = exp
        paren.finish = exp.finish
        exp.parent   = paren
    else
        missExp(pl)
    end
    skipSpace()
    if getChar() == ')' then
        paren.finish = getPosition(LuaOffset, 'right')
        LuaOffset = LuaOffset + 1
    else
        missSymbol(LuaOffset, ')')
    end
    return paren
end

local function parseFunction()
    local word, funcLeft, funcRight, newOffset = peekWord()
    if word ~= 'function' then
        return nil
    end
    local func = {
        type    = 'function',
        start   = funcLeft,
        finish  = funcRight,
        keyword = {
            [1] = funcLeft,
            [2] = funcRight,
        },
    }
    pushChunk(func)
    LuaOffset = newOffset
    skipSpace()
    local name
    if getChar() ~= '(' then
        name = parseExp()
        if not name then
            return func
        end
        func.name   = name
        func.finish = name.finish
        skipSpace()
        if getChar() ~= '(' then
            missSymbol(name.finish, ')')
            return func
        end
    end
    local parenLeft = getPosition(LuaOffset, 'left')
    LuaOffset = LuaOffset + 1
    skipSpace()
    local args = parseExpList()
    if args then
        args.type   = 'funcargs'
        args.start  = parenLeft
        args.parent = func
        func.args   = args
        func.finish = args.finish
        for i = 1, #args do
            local arg = args[i]
            if arg.type == 'varargs' then
                arg.type = '...'
            elseif arg.type == 'getglobal'
            or     arg.type == 'getlocal' then
                createLocal(arg)
            end
        end
    end
    skipSpace()
    if getChar() == ')' then
        local parenRight = getPosition(LuaOffset, 'right')
        func.finish = parenRight
        if args then
            args.finish = parenRight
        end
        LuaOffset = LuaOffset + 1
        skipSpace()
    else
        missSymbol(func.finish, ')')
    end
    -- TODO: actions
    local endWord, endLeft, endRight, endOffset = peekWord()
    if not endWord then
        missSymbol(LuaOffset, 'end')
        popChunk()
        return func
    end
    if endWord == 'end' then
        func.keyword[3] = endLeft
        func.keyword[4] = endRight
        func.finish     = endRight
        popChunk()
        return func
    end
end

local function parseExpUnit()
    local paren = parseParen()
    if paren then
        return parseSimple(paren)
    end

    local varargs = parseVarargs()
    if varargs then
        return varargs
    end

    local table = parseTable()
    if table then
        return table
    end

    local string = parseString()
    if string then
        return string
    end

    local number = parseNumber()
    if number then
        return number
    end

    local word = peekWord()
    if word then
        if word == 'nil' then
            return parseNil()
        end
        if word == 'true'
        or word == 'false' then
            return parseBoolean()
        end
        if word == 'function' then
            return parseFunction()
        end
        local node = parseName()
        node.type = 'getglobal'
        return parseSimple(node)
    end

    return nil
end

local function parseUnaryOP()
    local char = getChar()
    if not CharMapSU[char] then
        return nil
    end
    if char == '-' then
        local nextChar = getChar(LuaOffset + 1)
        if nextChar == '.' or CharMapNumber[nextChar] then
            return nil
        end
    end
    if UnarySymbol[char] then
        local op = {
            type   = char,
            start  = getPosition(LuaOffset, 'left'),
            finish = getPosition(LuaOffset, 'right'),
        }
        LuaOffset = LuaOffset + 1
        return op
    end
    local word, start, finish, newOffset = peekWord()
    if UnarySymbol[word] then
        local op = {
            type   = word,
            start  = start,
            finish = finish,
        }
        LuaOffset = newOffset
        return op
    end
    return nil
end

---@param level integer # op level must greater than this level
local function parseBinaryOP(level)
    local char = getChar()
    if not CharMapSB[char] then
        return nil
    end
    local symbol, len
    if BinarySymbol[char] then
        symbol = char
        len    = #char
    else
        local char2 = ssub(Lua, LuaOffset, LuaOffset + 1)
        if BinarySymbol[char2] then
            symbol = char2
            len    = #char2
        else
            local word = peekWord()
            if BinarySymbol[word] then
                symbol = word
                len    = #word
            else
                return nil
            end
        end
    end
    local myLevel = BinarySymbol[symbol]
    if level and myLevel < level then
        return nil
    end
    local op = {
        type   = symbol,
        start  = getPosition(LuaOffset, 'left'),
        finish = getPosition(LuaOffset + len - 1, 'right'),
    }
    LuaOffset = LuaOffset + len
    return op, myLevel
end

function parseExp(level)
    local exp
    local uop = parseUnaryOP()
    if uop then
        skipSpace()
        local child = parseExp(1000)
        exp = {
            type   = 'unary',
            op     = uop,
            start  = uop.start,
            finish = child and child.finish or uop.finish,
            [1]    = child,
        }
        if child then
            child.parent = exp
        end
    else
        exp = parseExpUnit()
        if not exp then
            return nil
        end
    end

    if level and level >= 1000 then
        return exp
    end

    while true do
        skipSpace()
        local bop, opLevel = parseBinaryOP(level)
        if not bop then
            break
        end

        skipSpace()
        local isForward = SymbolForward[opLevel]
        local child = parseExp(isForward and (opLevel + 0.5) or opLevel)
        local bin = {
            type   = 'binary',
            start  = exp.start,
            finish = child and child.finish or bop.finish,
            op     = bop,
            [1]    = exp,
            [2]    = child
        }
        exp.parent = bin
        if child then
            child.parent = bin
        end
        exp = bin
    end

    return exp
end

local function initState(lua, version, options)
    Lua        = lua
    LuaOffset  = 1
    Line       = 0
    LineOffset = 1
    Chunk      = {}
    CachedByteOffset = nil
    CachedCharOffset = nil
    State = {
        version = version,
        lua     = lua,
        ast     = {},
        errs    = {},
        diags   = {},
        comms   = {},
        options = options or {},
    }
    if version == 'Lua 5.1' or version == 'LuaJIT' then
        State.ENVMode = '@fenv'
    else
        State.ENVMode = '_ENV'
    end
end

return function (lua, mode, version, options)
    initState(lua, version, options)
    skipSpace()
    if     mode == 'Lua' then
    elseif mode == 'Nil' then
        State.ast = parseNil()
    elseif mode == 'Boolean' then
        State.ast = parseBoolean()
    elseif mode == 'String' then
        State.ast = parseString()
    elseif mode == 'Number' then
        State.ast = parseNumber()
    elseif mode == 'Exp' then
        State.ast = parseExp()
    end
    return State
end

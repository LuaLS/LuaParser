local tokens     = require 'parser.tokens'

local sbyte      = string.byte
local sfind      = string.find
local smatch     = string.match
local sgsub      = string.gsub
local ssub       = string.sub
local schar      = string.char
local uchar      = utf8.char
local tconcat    = table.concat
local tinsert    = table.insert
local tointeger  = math.tointeger
local mtype      = math.type
local tonumber   = tonumber
local maxinteger = math.maxinteger
local assert     = assert
local next       = next

_ENV = nil

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

local CharMapNumber  = stringToCharMap '0-9'
local CharMapN16     = stringToCharMap 'xX'
local CharMapN2      = stringToCharMap 'bB'
local CharMapE10     = stringToCharMap 'eE'
local CharMapE16     = stringToCharMap 'pP'
local CharMapSign    = stringToCharMap '+-'
local CharMapSB      = stringToCharMap 'ao|~&=<>.*/%^+-'
local CharMapSU      = stringToCharMap 'n#~!-'
local CharMapSimple  = stringToCharMap '.:([\'"{'
local CharMapStrSH   = stringToCharMap '\'"'
local CharMapStrLH   = stringToCharMap '['
local CharMapTSep    = stringToCharMap ',;'
local CharMapWord    = stringToCharMap '_a-zA-Z\x80-\xff'

local EscMap = {
    ['a']  = '\a',
    ['b']  = '\b',
    ['f']  = '\f',
    ['n']  = '\n',
    ['r']  = '\r',
    ['t']  = '\t',
    ['v']  = '\v',
    ['\\'] = '\\',
    ['\''] = '\'',
    ['\"'] = '\"',
}

local NLMap = {
    ['\n']   = true,
    ['\r']   = true,
    ['\r\n'] = true,
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

local Specials = {
    ['_G']           = true,
    ['rawset']       = true,
    ['rawget']       = true,
    ['setmetatable'] = true,
    ['require']      = true,
    ['dofile']       = true,
    ['loadfile']     = true,
    ['pcall']        = true,
    ['xpcall']       = true,
    ['pairs']        = true,
    ['ipairs']       = true,
}

local UnarySymbol = {
    ['not'] = 11,
    ['#']   = 11,
    ['~']   = 11,
    ['-']   = 11,
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
    ['^']   = 12,
}

local BinaryAlias = {
    ['&&'] = 'and',
    ['||'] = 'or',
    ['!='] = '~=',
}

local BinaryActionAlias = {
    ['='] = '==',
}

local UnaryAlias = {
    ['!'] = 'not',
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
    [11]  = true,
    [12]  = false,
}

local GetToSetMap = {
    ['getglobal'] = 'setglobal',
    ['getlocal']  = 'setlocal',
    ['getfield']  = 'setfield',
    ['getindex']  = 'setindex',
    ['getmethod'] = 'setmethod',
}

local ChunkFinishMap = {
    ['end']    = true,
    ['else']   = true,
    ['elseif'] = true,
    ['in']     = true,
    ['do']     = true,
    ['then']   = true,
    ['until']  = true,
    [';']      = true,
    [']']      = true,
    [')']      = true,
    ['}']      = true,
}

local State, Lua, Line, LineOffset, Chunk, Tokens, Index, LastTokenFinish

local parseExp, parseAction

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

local function addSpecial(name, obj)
    local root = State.ast
    if not root.specials then
        root.specials = {}
    end
    if not root.specials[name] then
        root.specials[name] = {}
    end
    root.specials[name][#root.specials[name]+1] = obj
    obj.special = name
end

---@param offset integer
---@param leftOrRight '"left"'|'"right"'
local function getPosition(offset, leftOrRight)
    if not offset or offset > #Lua then
        return LineMulti * Line + #Lua - LineOffset + 1
    end
    if leftOrRight == 'left' then
        return LineMulti * Line + offset - LineOffset
    else
        return LineMulti * Line + offset - LineOffset + 1
    end
end

---@return string          word
---@return parser.position startPosition
---@return parser.position finishPosition
---@return integer         newOffset
local function peekWord()
    local word = Tokens[Index + 1]
    if not word then
        return nil
    end
    if not CharMapWord[ssub(word, 1, 1)] then
        return nil
    end
    local startPos  = getPosition(Tokens[Index] , 'left')
    local finishPos = getPosition(Tokens[Index] + #word - 1, 'right')
    return word, startPos, finishPos
end

local function lastRightPosition()
    if Index < 2 then
        return 0
    end
    local token = Tokens[Index - 1]
    if NLMap[token] then
        return LastTokenFinish
    elseif token then
        return getPosition(Tokens[Index - 2] + #token - 1, 'right')
    else
        return getPosition(#Lua, 'right')
    end
end

local function missSymbol(symbol, start, finish)
    pushError {
        type   = 'MISS_SYMBOL',
        start  = start or lastRightPosition(),
        finish = finish or start or lastRightPosition(),
        info = {
            symbol = symbol,
        }
    }
end

local function missExp()
    pushError {
        type   = 'MISS_EXP',
        start  = lastRightPosition(),
        finish = lastRightPosition(),
    }
end

local function missName(pos)
    pushError {
        type   = 'MISS_NAME',
        start  = pos or lastRightPosition(),
        finish = pos or lastRightPosition(),
    }
end

local function missEnd(relatedStart, relatedFinish)
    pushError {
        type   = 'MISS_SYMBOL',
        start  = lastRightPosition(),
        finish = lastRightPosition(),
        info = {
            symbol  = 'end',
            related = {
                {
                    start  = relatedStart,
                    finish = relatedFinish,
                }
            }
        }
    }
    pushError {
        type   = 'MISS_END',
        start  = relatedStart,
        finish = relatedFinish,
    }
end

local function unknownSymbol(start, finish, word)
    local token = word or Tokens[Index + 1]
    if not token then
        return false
    end
    pushError {
        type   = 'UNKNOWN_SYMBOL',
        start  = start  or getPosition(Tokens[Index], 'left'),
        finish = finish or getPosition(Tokens[Index] + #token - 1, 'right'),
        info   = {
            symbol = token,
        }
    }
    return true
end

local function skipUnknownSymbol(stopSymbol)
    if unknownSymbol() then
        Index = Index + 2
        return true
    end
    return false
end

local function skipNL()
    local token = Tokens[Index + 1]
    if NLMap[token] then
        if Index >= 2 and not NLMap[Tokens[Index - 1]] then
            LastTokenFinish = getPosition(Tokens[Index - 2] + #Tokens[Index - 1] - 1, 'right')
        end
        Line       = Line + 1
        LineOffset = Tokens[Index] + #token
        Index = Index + 2
        return true
    end
    return false
end

local function fastForwardToken(offset)
    while true do
        local myOffset = Tokens[Index]
        if not myOffset
        or myOffset >= offset then
            break
        end
        Index = Index + 2
    end
end

local function resolveLongString(finishMark)
    skipNL()
    local miss
    local start        = Tokens[Index]
    local finishOffset = sfind(Lua, finishMark, start, true)
    if not finishOffset then
        finishOffset = #Lua + 1
        miss = true
    end
    local stringResult = ssub(Lua, start, finishOffset - 1)
    local lastLN = stringResult:find '[\r\n][^\r\n]*$'
    if lastLN then
        local result, count = stringResult
            : gsub('\r\n', '\n')
            : gsub('[\r\n]', '\n')
        Line       = Line + count
        LineOffset = lastLN + start
        stringResult = result
    end
    fastForwardToken(finishOffset + #finishMark)
    if miss then
        local pos = getPosition(finishOffset - 1, 'right')
        pushError {
            type   = 'MISS_SYMBOL',
            start  = pos,
            finish = pos,
            info   = {
                symbol = finishMark,
            },
            fix    = {
                title = 'ADD_LSTRING_END',
                {
                    start  = pos,
                    finish = pos,
                    text   = finishMark,
                }
            },
        }
    end
    return stringResult, getPosition(finishOffset + #finishMark - 1, 'right')
end

local function parseLongString()
    local start, finish, mark = sfind(Lua, '^(%[%=*%[)', Tokens[Index])
    if not mark then
        return nil
    end
    fastForwardToken(finish + 1)
    local startPos     = getPosition(start, 'left')
    local finishMark   = sgsub(mark, '%[', ']')
    local stringResult, finishOffset = resolveLongString(finishMark)
    return {
        type   = 'string',
        start  = startPos,
        finish = getPosition(finishOffset, 'right'),
        [1]    = stringResult,
        [2]    = mark,
    }
end

local function pushCommentHeadError(left)
    if State.options.nonstandardSymbol and State.options.nonstandardSymbol['//'] then
        return
    end
    pushError {
        type   = 'ERR_COMMENT_PREFIX',
        start  = left,
        finish = left + 2,
        fix    = {
            title = 'FIX_COMMENT_PREFIX',
            {
                start  = left,
                finish = left + 2,
                text   = '--',
            },
        }
    }
end

local function pushLongCommentError(left, right)
    if State.options.nonstandardSymbol and State.options.nonstandardSymbol['/**/'] then
        return
    end
    pushError {
        type   = 'ERR_C_LONG_COMMENT',
        start  = left,
        finish = right,
        fix    = {
            title = 'FIX_C_LONG_COMMENT',
            {
                start  = left,
                finish = left + 2,
                text   = '--[[',
            },
            {
                start  = right - 2,
                finish = right,
                text   =  '--]]'
            },
        }
    }
end

local function skipComment(isAction)
    local token = Tokens[Index + 1]
    if token == '--'
    or (token == '//' and isAction) then
        local left = getPosition(Tokens[Index], 'left')
        if token == '//' then
            pushCommentHeadError(left)
        end
        Index = Index + 2
        local longComment = parseLongString()
        if longComment then
            return true
        end
        while true do
            local nl = Tokens[Index + 1]
            if not nl or NLMap[nl] then
                break
            end
            Index = Index + 2
        end
        return true
    end
    if token == '/*' then
        local left = getPosition(Tokens[Index], 'left')
        Index = Index + 2
        local result, right = resolveLongString '*/'
        pushLongCommentError(left, right)
        return true
    end
    return false
end

local function skipSpace(isAction)
    repeat until not skipNL()
            and  not skipComment(isAction)
end

local function expectAssign()
    local token = Tokens[Index + 1]
    if token == '=' then
        Index = Index + 2
        return true
    end
    if token == '==' then
        local left  = getPosition(Tokens[Index], 'left')
        local right = getPosition(Tokens[Index] + #token - 1, 'right')
        pushError {
            type   = 'ERR_ASSIGN_AS_EQ',
            start  = left,
            finish = right,
            fix    = {
                title = 'FIX_ASSIGN_AS_EQ',
                {
                    start  = left,
                    finish = right,
                    text   = '=',
                }
            }
        }
        Index = Index + 2
        return true
    end
    return false
end

local function parseLocalAttrs()
    local attrs
    while true do
        skipSpace()
        local token = Tokens[Index + 1]
        if token ~= '<' then
            break
        end
        if not attrs then
            attrs = {}
        end
        local attr = {
            type   = 'localattr',
            start  = getPosition(Tokens[Index], 'left'),
            finish = getPosition(Tokens[Index], 'right'),
        }
        attrs[#attrs+1] = attr
        Index = Index + 2
        skipSpace()
        local word, wstart, wfinish = peekWord()
        if word then
            attr[1] = word
            attr.finish = wfinish
            Index = Index + 2
        else
            missName()
        end
        attr.finish = lastRightPosition()
        skipSpace()
        if Tokens[Index + 1] == '>' then
            attr.finish = getPosition(Tokens[Index], 'right')
            Index = Index + 2
        else
            missSymbol '>'
        end
        if State.version ~= 'Lua 5.4' then
            pushError {
                type    = 'UNSUPPORT_SYMBOL',
                start   = attr.start,
                finish  = attr.finish,
                version = 'Lua 5.4',
                info    = {
                    version = State.version
                }
            }
        end
    end
    return attrs
end

local function createLocal(obj, attrs)
    if not obj then
        return nil
    end
    obj.type   = 'local'
    obj.effect = obj.finish

    if attrs then
        obj.attrs = attrs
        for i = 1, #attrs do
            local attr = attrs[i]
            attr.parent = obj
        end
    end

    local chunk = Chunk[#Chunk]
    if chunk then
        local locals = chunk.locals
        if not locals then
            locals = {}
            chunk.locals = locals
        end
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
    if Tokens[Index + 1] ~= 'nil' then
        return nil
    end
    local offset = Tokens[Index]
    Index = Index + 2
    return {
        type   = 'nil',
        start  = getPosition(offset, 'left'),
        finish = getPosition(offset + 2, 'right'),
    }
end

local function parseBoolean()
    local word = Tokens[Index+1]
    if  word ~= 'true'
    and word ~= 'false' then
        return nil
    end
    local start  = getPosition(Tokens[Index], 'left')
    local finish = getPosition(Tokens[Index] + #word - 1, 'right')
    Index = Index + 2
    return {
        type   = 'boolean',
        start  = start,
        finish = finish,
        [1]    = word == 'true' and true or false,
    }
end

local function parseStringUnicode()
    local offset = Tokens[Index] + 1
    if ssub(Lua, offset, offset) ~= '{' then
        local pos  = getPosition(offset, 'left')
        missSymbol('{', pos)
        return nil, offset
    end
    local leftPos  = getPosition(offset, 'left')
    local x16      = smatch(Lua, '^%w*', offset + 1)
    local rightPos = getPosition(offset + #x16, 'right')
    offset = offset + #x16 + 1
    if ssub(Lua, offset, offset) == '}' then
        offset   = offset + 1
        rightPos = rightPos + 1
    else
        missSymbol('}', rightPos)
    end
    offset = offset + 1
    if #x16 == 0 then
        pushError {
            type   = 'UTF8_SMALL',
            start  = leftPos,
            finish = rightPos,
        }
        return '', offset
    end
    if  State.version ~= 'Lua 5.3'
    and State.version ~= 'Lua 5.4'
    and State.version ~= 'LuaJIT'
    then
        pushError {
            type    = 'ERR_ESC',
            start   = leftPos - 2,
            finish  = rightPos,
            version = {'Lua 5.3', 'Lua 5.4', 'LuaJIT'},
            info = {
                version = State.version,
            }
        }
        return nil, offset
    end
    local byte = tonumber(x16, 16)
    if not byte then
        for i = 1, #x16 do
            if not tonumber(ssub(x16, i, i), 16) then
                pushError {
                    type   = 'MUST_X16',
                    start  = leftPos + i,
                    finish = leftPos + i + 1,
                }
            end
        end
        return nil, offset
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
            return nil, offset
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
        return uchar(byte), offset
    end
    return '', offset
end

local stringPool = {}
local function parseShortString()
    local mark        = Tokens[Index+1]
    local startOffset = Tokens[Index]
    local startPos    = getPosition(startOffset, 'left')
    Index             = Index + 2
    -- empty string
    if Tokens[Index+1] == mark then
        local finishPos = getPosition(Tokens[Index], 'right')
        Index = Index + 2
        return {
            type   = 'string',
            start  = startPos,
            finish = finishPos,
            [1]    = '',
            [2]    = mark,
        }
    end
    local stringIndex = 0
    local currentOffset = startOffset + 1
    while true do
        local token = Tokens[Index + 1]
        if token == mark then
            stringIndex = stringIndex + 1
            stringPool[stringIndex] = ssub(Lua, currentOffset, Tokens[Index] - 1)
            Index = Index + 2
            break
        end
        if not token
        or NLMap[token] then
            missSymbol(mark)
            break
        end
        if token == '\\' then
            stringIndex = stringIndex + 1
            stringPool[stringIndex] = ssub(Lua, currentOffset, Tokens[Index] - 1)
            currentOffset = Tokens[Index]
            Index = Index + 2
            -- has space?
            if Tokens[Index] - currentOffset > 1 then
                pushError {
                    type   = 'ERR_ESC',
                    start  = getPosition(currentOffset, 'left'),
                    finish = getPosition(currentOffset + 1, 'right'),
                }
                goto CONTINUE
            end
            local nextToken = ssub(Tokens[Index + 1], 1, 1)
            if EscMap[nextToken] then
                stringIndex = stringIndex + 1
                stringPool[stringIndex] = EscMap[nextToken]
                currentOffset = Tokens[Index] + #nextToken
                Index = Index + 2
                goto CONTINUE
            end
            if nextToken == mark then
                stringIndex = stringIndex + 1
                stringPool[stringIndex] = mark
                currentOffset = Tokens[Index] + #nextToken
                Index = Index + 2
                goto CONTINUE
            end
            if nextToken == 'z' then
                Index = Index + 2
                repeat until not skipNL()
                currentOffset = Tokens[Index]
                goto CONTINUE
            end
            if CharMapNumber[nextToken] then
                local numbers = smatch(Tokens[Index + 1], '^%d+')
                if #numbers > 3 then
                    numbers = ssub(numbers, 1, 3)
                end
                currentOffset = Tokens[Index] + #numbers
                fastForwardToken(currentOffset)
                local byte = tointeger(numbers)
                if byte <= 255 then
                    stringIndex = stringIndex + 1
                    stringPool[stringIndex] = schar(byte)
                else
                    -- TODO pushError
                end
                goto CONTINUE
            end
            if nextToken == 'x' then
                local left = getPosition(Tokens[Index] - 1, 'left')
                local x16  = ssub(Tokens[Index + 1], 2, 3)
                local byte = tonumber(x16, 16)
                if byte then
                    currentOffset = Tokens[Index] + 3
                    stringIndex = stringIndex + 1
                    stringPool[stringIndex] = schar(byte)
                else
                    currentOffset = Tokens[Index] + 1
                    pushError {
                        type   = 'MISS_ESC_X',
                        start  = getPosition(currentOffset, 'left'),
                        finish = getPosition(currentOffset + 1, 'right'),
                    }
                end
                if State.version == 'Lua 5.1' then
                    pushError {
                        type    = 'ERR_ESC',
                        start   = left,
                        finish  = left + 4,
                        version = {'Lua 5.2', 'Lua 5.3', 'Lua 5.4', 'LuaJIT'},
                        info = {
                            version = State.version,
                        }
                    }
                end
                Index = Index + 2
                goto CONTINUE
            end
            if nextToken == 'u' then
                local str, newOffset = parseStringUnicode()
                if str then
                    stringIndex = stringIndex + 1
                    stringPool[stringIndex] = str
                end
                currentOffset = newOffset
                fastForwardToken(currentOffset - 1)
                goto CONTINUE
            end
            if NLMap[nextToken] then
                stringPool[stringIndex] = '\n'
                currentOffset = Tokens[Index] + #nextToken
                Index = Index + 2
                goto CONTINUE
            end
            pushError {
                type   = 'ERR_ESC',
                start  = getPosition(currentOffset, 'left'),
                finish = getPosition(currentOffset + 1, 'right'),
            }
        end
        Index = Index + 2
        ::CONTINUE::
    end
    local stringResult = tconcat(stringPool, '', 1, stringIndex)
    return {
        type   = 'string',
        start  = startPos,
        finish = lastRightPosition(),
        [1]    = stringResult,
        [2]    = mark,
    }
end

local function parseString()
    local c = Tokens[Index + 1]
    if CharMapStrSH[c] then
        return parseShortString()
    end
    if CharMapStrLH[c] then
        return parseLongString()
    end
    return nil
end

local function parseNumber10(start)
    local integerPart = smatch(Lua, '^%d*', start)
    local offset = start + #integerPart
    -- float part
    if ssub(Lua, offset, offset) == '.' then
        local floatPart = smatch(Lua, '^%d*', offset + 1)
        offset = offset + #floatPart + 1
    end
    -- exp part
    local echar = ssub(Lua, offset, offset)
    if CharMapE10[echar] then
        offset = offset + 1
        local nextChar = ssub(Lua, offset, offset)
        if CharMapSign[nextChar] then
            offset = offset + 1
        end
        local exp = smatch(Lua, '^%d*', offset)
        offset = offset + #exp
        if #exp == 0 then
            pushError {
                type   = 'MISS_EXPONENT',
                start  = getPosition(offset - 1, 'right'),
                finish = getPosition(offset - 1, 'right'),
            }
        end
    end
    return tonumber(ssub(Lua, start, offset - 1)), offset
end

local function parseNumber16(start)
    local integerPart = smatch(Lua, '^[%da-fA-F]*', start)
    local offset = start + #integerPart
    -- float part
    if ssub(Lua, offset, offset) == '.' then
        local floatPart = smatch(Lua, '^[%da-fA-F]*', offset + 1)
        offset = offset + #floatPart + 1
        if #integerPart == 0 and #floatPart == 0 then
            pushError {
                type   = 'MUST_X16',
                start  = getPosition(offset - 1, 'right'),
                finish = getPosition(offset - 1, 'right'),
            }
        end
    else
        if #integerPart == 0 then
            pushError {
                type   = 'MUST_X16',
                start  = getPosition(offset - 1, 'right'),
                finish = getPosition(offset - 1, 'right'),
            }
            return 0, offset
        end
    end
    -- exp part
    local echar = ssub(Lua, offset, offset)
    if CharMapE16[echar] then
        offset = offset + 1
        local nextChar = ssub(Lua, offset, offset)
        if CharMapSign[nextChar] then
            offset = offset + 1
        end
        local exp = smatch(Lua, '^%d*', offset)
        offset = offset + #exp
    end
    local n = tonumber(ssub(Lua, start - 2, offset - 1))
    return n, offset
end

local function parseNumber2(start)
    local bins = smatch(Lua, '^[01]*', start)
    local offset = start + #bins
    return tonumber(bins, 2), offset
end

local function dropNumberTail(offset)
    local _, finish, word = sfind(Lua, '^([%.%w_\x80-\xff]+)', offset)
    if not finish then
        return offset
    end
    pushError {
        type   = 'MALFORMED_NUMBER',
        start  = getPosition(offset, 'left'),
        finish = getPosition(finish, 'right'),
    }
    return finish + 1
end

local function parseNumber()
    local offset = Tokens[Index]
    if not offset then
        return nil
    end
    local startPos = getPosition(offset, 'left')
    local neg
    if ssub(Lua, offset, offset) == '-' then
        neg = true
        offset = offset + 1
    end
    local number
    local firstChar = ssub(Lua, offset, offset)
    if     firstChar == '.' then
        number, offset = parseNumber10(offset)
    elseif firstChar == '0' then
        local nextChar = ssub(Lua, offset + 1, offset + 1)
        if CharMapN16[nextChar] then
            number, offset = parseNumber16(offset + 2)
        elseif CharMapN2[nextChar] then
            number, offset = parseNumber2(offset + 2)
        else
            number, offset = parseNumber10(offset)
        end
    elseif CharMapNumber[firstChar] then
        number, offset = parseNumber10(offset)
    else
        return nil
    end
    if not number then
        number = 0
    end
    if neg then
        number = - number
    end
    local result = {
        type   = mtype(number) == 'integer' and 'integer' or 'number',
        start  = startPos,
        finish = getPosition(offset - 1, 'right'),
        [1]    = number,
    }
    offset = dropNumberTail(offset)
    fastForwardToken(offset)
    return result
end

local function parseName()
    local word = peekWord()
    if not word then
        return nil
    end
    if ChunkFinishMap[word] then
        return nil
    end
    local startPos  = getPosition(Tokens[Index], 'left')
    local finishPos = getPosition(Tokens[Index] + #word - 1, 'right')
    Index = Index + 2
    if not State.options.unicodeName and word:find '[\x80-\xff]' then
        pushError {
            type   = 'UNICODE_NAME',
            start  = startPos,
            finish = finishPos,
        }
    end
    local isKeyWord
    if KeyWord[word] then
        isKeyWord = true
    elseif word == 'goto' then
        isKeyWord = State.version ~= 'Lua 5.1'
    end
    if isKeyWord then
        pushError {
            type   = 'KEYWORD',
            start  = startPos,
            finish = finishPos,
        }
    end
    return {
        type   = 'name',
        start  = startPos,
        finish = finishPos,
        [1]    = word,
    }
end

local function parseNameOrList()
    local first = parseName()
    if not first then
        return nil
    end
    skipSpace()
    local list
    while true do
        if Tokens[Index + 1] ~= ',' then
            break
        end
        Index = Index + 2
        skipSpace()
        local name = parseName()
        if not name then
            missName()
            break
        end
        if not list then
            list = {
                type   = 'list',
                start  = first.start,
                finish = first.finish,
                [1]    = first
            }
        end
        list[#list+1] = name
        list.finish = name.finish
    end
    return list or first
end

local function dropTail()
    local token = Tokens[Index + 1]
    if  token ~= '?'
    and token ~= ':' then
        return
    end
    local pl, pt, pp = 0, 0, 0
    while true do
        local token = Tokens[Index + 1]
        if not token then
            break
        end
        if NLMap[token] then
            break
        end
        if token == ',' then
            if pl > 0
            or pt > 0
            or pp > 0 then
                goto CONTINUE
            else
                break
            end
        end
        if token == '<' then
            pl = pl + 1
            goto CONTINUE
        end
        if token == '{' then
            pt = pt + 1
            goto CONTINUE
        end
        if token == '(' then
            pp = pp + 1
            goto CONTINUE
        end
        if token == '>' then
            if pl <= 0 then
                break
            end
            pl = pl - 1
            goto CONTINUE
        end
        if token == '}' then
            if pt <= 0 then
                break
            end
            pt = pt - 1
            goto CONTINUE
        end
        if token == ')' then
            if pp <= 0 then
                break
            end
            pp = pp - 1
            goto CONTINUE
        end
        ::CONTINUE::
        Index = Index + 2
    end
end

local function parseExpList()
    local list
    local wantSep = false
    while true do
        skipSpace()
        local token = Tokens[Index + 1]
        if not token then
            break
        end
        if ChunkFinishMap[token] then
            break
        end
        if token == ',' then
            local sepPos = getPosition(Tokens[Index], 'right')
            if not wantSep then
                pushError {
                    type   = 'UNEXPECT_SYMBOL',
                    start  = getPosition(Tokens[Index], 'left'),
                    finish = sepPos,
                    info = {
                        symbol = ',',
                    }
                }
            end
            wantSep = false
            Index = Index + 2
            goto CONTINUE
        else
            local exp = parseExp()
            if not exp then
                break
            end
            dropTail()
            if wantSep then
                missSymbol(',', list[#list].finish, exp.start)
            end
            wantSep = true
            if not list then
                list = {
                    type   = 'list',
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
    if not wantSep then
        missExp()
    end
    return list
end

local function parseIndex()
    local bstart = getPosition(Tokens[Index], 'left')
    Index = Index + 2
    skipSpace()
    local exp = parseExp()
    local index = {
        type   = 'index',
        start  = bstart,
        finish = exp and exp.finish or (bstart + 1),
        index  = exp
    }
    if exp then
        exp.parent = index
    else
        missExp()
    end
    skipSpace()
    if Tokens[Index + 1] == ']' then
        index.finish = getPosition(Tokens[Index], 'right')
        Index = Index + 2
    else
        missSymbol ']'
    end
    return index
end

local function parseTable()
    local tbl = {
        type   = 'table',
        start  = getPosition(Tokens[Index], 'left'),
        finish = getPosition(Tokens[Index], 'right'),
    }
    Index = Index + 2
    local index = 0
    local wantSep = false
    while true do
        skipSpace()
        local token = Tokens[Index + 1]
        if token == '}' then
            Index = Index + 2
            break
        end
        if CharMapTSep[token] then
            if not wantSep then
                missExp()
            end
            wantSep = false
            Index = Index + 2
            goto CONTINUE
        end
        local lastRight = lastRightPosition()
        if token == '[' then
            if wantSep then
                pushError {
                    type   = 'MISS_SEP_IN_TABLE',
                    start  = lastRight,
                    finish = getPosition(Tokens[Index], 'left'),
                }
            end
            wantSep = true
            index = index + 1
            local tindex = parseIndex()
            skipSpace()
            if expectAssign() then
                skipSpace()
                local ivalue = parseExp()
                tindex.type   = 'tableindex'
                tindex.parent = tbl
                if ivalue then
                    ivalue.parent = tindex
                    tindex.finish = ivalue.finish
                    tindex.value  = ivalue
                else
                    missExp()
                end
                tbl[index] = tindex
            else
                missSymbol '='
            end
            goto CONTINUE
        end

        local exp = parseExp(true)
        if exp then
            if wantSep then
                pushError {
                    type   = 'MISS_SEP_IN_TABLE',
                    start  = lastRight,
                    finish = exp.start,
                }
            end
            wantSep = true
            index = index + 1
            if exp.type == 'varargs' then
                tbl[index] = exp
                exp.parent = tbl
                goto CONTINUE
            end
            if exp.type == 'getlocal'
            or exp.type == 'getglobal' then
                skipSpace()
                if expectAssign() then
                    local eqRight = lastRightPosition()
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
                    else
                        missExp()
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
            goto CONTINUE
        end
        missSymbol '}'
        break
        ::CONTINUE::
    end
    tbl.finish = getPosition(Tokens[Index - 2], 'right')
    return tbl
end

local function parseSimple(node, enableCall)
    local lastMethod
    while true do
        if lastMethod and node.node == lastMethod then
            if node.type ~= 'call' then
                missSymbol('(', node.node.finish, node.node.finish)
            end
            lastMethod = nil
        end
        skipSpace()
        local token = Tokens[Index + 1]
        if token == '.' then
            local dot = {
                type   = token,
                start  = getPosition(Tokens[Index], 'left'),
                finish = getPosition(Tokens[Index], 'right'),
            }
            Index = Index + 2
            skipSpace()
            local field = parseName()
            local getfield = {
                type   = 'getfield',
                start  = node.start,
                finish = lastRightPosition(),
                node   = node,
                dot    = dot,
                field  = field
            }
            if field then
                field.parent = node
                field.type   = 'field'
            else
                pushError {
                    type   = 'MISS_FIELD',
                    start  = lastRightPosition(),
                    finish = lastRightPosition(),
                }
            end
            node.next = getfield
            node = getfield
        elseif token == ':' then
            local colon = {
                type   = token,
                start  = getPosition(Tokens[Index], 'left'),
                finish = getPosition(Tokens[Index], 'right'),
            }
            Index = Index + 2
            skipSpace()
            local method = parseName()
            local getmethod = {
                type   = 'getmethod',
                start  = node.start,
                finish = lastRightPosition(),
                node   = node,
                colon  = colon,
                method = method
            }
            if method then
                method.parent = node
                method.type   = 'method'
            else
                pushError {
                    type   = 'MISS_METHOD',
                    start  = lastRightPosition(),
                    finish = lastRightPosition(),
                }
            end
            node.next  = getmethod
            node       = getmethod
            if lastMethod then
                missSymbol('(', node.node.finish, node.node.finish)
            end
            lastMethod = getmethod
        elseif token == '(' then
            if not enableCall then
                break
            end
            local startPos = getPosition(Tokens[Index], 'left')
            local call = {
                type   = 'call',
                start  = node.start,
                node   = node,
            }
            Index = Index + 2
            local args = parseExpList()
            if Tokens[Index + 1] == ')' then
                call.finish = getPosition(Tokens[Index], 'right')
                Index = Index + 2
            else
                missSymbol ')'
            end
            if args then
                args.type   = 'callargs'
                args.start  = startPos
                args.finish = call.finish
                args.parent = call
                call.args   = args
            end
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
                for k, v in next, call.node.node do
                    newNode[k] = v
                end
                newNode.mirror = call.node.node
                newNode.dummy  = true
                newNode.parent = call.args
                call.node.node.mirror = newNode
                tinsert(call.args, 1, newNode)
            end
            node = call
        elseif token == '{' then
            if not enableCall then
                break
            end
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
        elseif CharMapStrSH[token] then
            if not enableCall then
                break
            end
            local str = parseShortString()
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
        elseif CharMapStrLH[token] then
            local str = parseLongString()
            if str then
                if not enableCall then
                    break
                end
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
                local index = parseIndex()
                index.type   = 'getindex'
                index.bstart = index.start
                index.start  = node.start
                index.node   = node
                node.next    = index
                node = index
            end
        else
            break
        end
    end
    if  node.type == 'call'
    and node.node == lastMethod then
        lastMethod = nil
    end
    if node == lastMethod then
        if not enableCall then
            lastMethod = nil
        end
    end
    if lastMethod then
        missSymbol('(', lastMethod.finish)
    end
    return node
end

local function parseVarargs()
    local varargs = {
        type   = 'varargs',
        start  = getPosition(Tokens[Index], 'left'),
        finish = getPosition(Tokens[Index] + 2, 'right'),
    }
    Index = Index + 2
    return varargs
end

local function parseParen()
    local pl = Tokens[Index]
    local paren = {
        type   = 'paren',
        start  = getPosition(pl, 'left'),
        finish = getPosition(pl, 'right')
    }
    Index = Index + 2
    skipSpace()
    local exp = parseExp()
    if exp then
        paren.exp    = exp
        paren.finish = exp.finish
        exp.parent   = paren
    else
        missExp()
    end
    skipSpace()
    if Tokens[Index + 1] == ')' then
        paren.finish = getPosition(Tokens[Index], 'right')
        Index = Index + 2
    else
        missSymbol ')'
    end
    return paren
end

local function getLocal(name, pos)
    for i = #Chunk, 1, -1 do
        local chunk  = Chunk[i]
        local locals = chunk.locals
        if locals then
            local res
            for n = 1, #locals do
                local loc = locals[n]
                if loc.effect > pos then
                    break
                end
                if loc[1] == name then
                    if not res or res.effect < loc.effect then
                        res = loc
                    end
                end
            end
            if res then
                return res
            end
        end
    end
end

local function resolveName(node)
    if not node then
        return nil
    end
    local loc  = getLocal(node[1], node.start)
    if loc then
        node.type = 'getlocal'
        node.node = loc
        if not loc.ref then
            loc.ref = {}
        end
        loc.ref[#loc.ref+1] = node
    else
        node.type = 'getglobal'
        local env = getLocal(State.ENVMode, node.start)
        if env then
            node.node = env
            if not env.ref then
                env.ref = {}
            end
            env.ref[#env.ref+1] = node
        end
    end
    local name = node[1]
    if Specials[name] then
        addSpecial(name, node)
    else
        local ospeicals = State.options.special
        if ospeicals and ospeicals[name] then
            addSpecial(name, node)
        end
    end
    return node
end

local function isChunkFinishToken(token)
    local currentChunk = Chunk[#Chunk]
    if not currentChunk then
        return false
    end
    local tp = currentChunk.type
    if tp == 'main' then
        return false
    end
    if tp == 'for'
    or tp == 'in'
    or tp == 'loop' then
        return token == 'do'
            or token == 'end'
    end
    if tp == 'if'
    or tp == 'ifblock'
    or tp == 'elseifblock'
    or tp == 'elseblock' then
        return token == 'then'
            or token == 'end'
            or token == 'else'
            or token == 'elseif'
    end
    return true
end

local function parseActions()
    while true do
        skipSpace(true)
        local token = Tokens[Index + 1]
        if token == ';' then
            Index = Index + 2
            goto CONTINUE
        end
        if  ChunkFinishMap[token]
        and isChunkFinishToken(token) then
            return
        end
        local _, failed = parseAction()
        if failed then
            break
        end
        ::CONTINUE::
    end
end

local function parseParams(params)
    local lastSep
    local hasDots
    while true do
        skipSpace()
        local token = Tokens[Index + 1]
        if not token or token == ')' then
            if lastSep then
                missName()
            end
            break
        end
        if token == ',' then
            if lastSep or lastSep == nil then
                missName()
            else
                lastSep = true
            end
            Index = Index + 2
            goto CONTINUE
        end
        if token == '...' then
            if lastSep == false then
                missSymbol ','
            end
            lastSep = false
            if not params then
                params = {}
            end
            params[#params+1] = {
                type   = '...',
                start  = getPosition(Tokens[Index], 'left'),
                finish = getPosition(Tokens[Index] + 2, 'right'),
                parent = params,
            }
            if hasDots then
                pushError {
                    type   = 'ARGS_AFTER_DOTS',
                    start  = getPosition(Tokens[Index], 'left'),
                    finish = getPosition(Tokens[Index] + 2, 'right'),
                }
            end
            hasDots = true
            Index = Index + 2
            goto CONTINUE
        end
        if CharMapWord[ssub(token, 1, 1)] then
            if lastSep == false then
                missSymbol ','
            end
            lastSep = false
            if not params then
                params = {}
            end
            params[#params+1] = createLocal {
                start  = getPosition(Tokens[Index], 'left'),
                finish = getPosition(Tokens[Index] + #token - 1, 'right'),
                parent = params,
                [1]    = token,
            }
            if hasDots then
                pushError {
                    type   = 'ARGS_AFTER_DOTS',
                    start  = getPosition(Tokens[Index], 'left'),
                    finish = getPosition(Tokens[Index] + #token - 1, 'right'),
                }
            end
            Index = Index + 2
            goto CONTINUE
        end
        skipUnknownSymbol '%,%)%.'
        ::CONTINUE::
    end
    return params
end

local function parseFunction(isLocal, isAction)
    local funcLeft  = getPosition(Tokens[Index], 'left')
    local funcRight = getPosition(Tokens[Index] + 7, 'right')
    local func = {
        type    = 'function',
        start   = funcLeft,
        finish  = funcRight,
        keyword = {
            [1] = funcLeft,
            [2] = funcRight,
        },
    }
    Index = Index + 2
    skipSpace()
    local hasLeftParen = Tokens[Index + 1] == '('
    if not hasLeftParen then
        local name = parseName()
        if name then
            local simple = parseSimple(name, false)
            if isLocal then
                if simple == name then
                    createLocal(name)
                else
                    resolveName(name)
                    pushError {
                        type   = 'UNEXPECT_LFUNC_NAME',
                        start  = simple.start,
                        finish = simple.finish,
                    }
                end
            else
                resolveName(name)
            end
            func.name   = simple
            func.finish = simple.finish
            if not isAction then
                pushError {
                    type   = 'UNEXPECT_EFUNC_NAME',
                    start  = simple.start,
                    finish = simple.finish,
                }
            end
            skipSpace()
            hasLeftParen = Tokens[Index + 1] == '('
        end
    end
    pushChunk(func)
    local params
    if func.name and func.name.type == 'getmethod' then
        if func.name.type == 'getmethod' then
            params = {}
            params[1] = createLocal {
                start  = funcRight,
                finish = funcRight,
                method = func.name,
                parent = params,
                tag    = 'self',
                dummy  = true,
                [1]    = 'self',
            }
        end
    end
    if hasLeftParen then
        local parenLeft = getPosition(Tokens[Index], 'left')
        Index = Index + 2
        params = parseParams(params)
        if params then
            params.type   = 'funcargs'
            params.start  = parenLeft
            params.finish = lastRightPosition()
            params.parent = func
            func.args     = params
            func.finish   = params.finish
        end
        skipSpace()
        if Tokens[Index + 1] == ')' then
            local parenRight = getPosition(Tokens[Index], 'right')
            func.finish = parenRight
            if params then
                params.finish = parenRight
            end
            Index = Index + 2
            skipSpace()
        else
            if params then
                params.finish = func.finish
            end
            missSymbol ')'
        end
    else
        missSymbol '('
    end
    parseActions()
    if Tokens[Index + 1] == 'end' then
        local endLeft   = getPosition(Tokens[Index], 'left')
        local endRight  = getPosition(Tokens[Index] + 2, 'right')
        func.keyword[3] = endLeft
        func.keyword[4] = endRight
        func.finish     = endRight
        Index = Index + 2
    else
        missEnd(funcLeft, funcRight)
    end
    popChunk()
    return func
end

local function parseExpUnit()
    local token = Tokens[Index + 1]
    if token == '(' then
        local paren = parseParen()
        return parseSimple(paren, true)
    end

    if token == '...' then
        local varargs = parseVarargs()
        return varargs
    end

    if token == '{' then
        local table = parseTable()
        return table
    end

    if CharMapStrSH[token] then
        local string = parseShortString()
        return string
    end

    if CharMapStrLH[token] then
        local string = parseLongString()
        return string
    end

    local number = parseNumber()
    if number then
        return number
    end

    if ChunkFinishMap[token] then
        return nil
    end

    if token == 'nil' then
        return parseNil()
    end

    if token == 'true'
    or token == 'false' then
        return parseBoolean()
    end

    if token == 'function' then
        return parseFunction()
    end

    local node = parseName()
    if node then
        return parseSimple(resolveName(node), true)
    end

    return nil
end

local function parseUnaryOP(level)
    local token  = Tokens[Index + 1]
    local symbol = UnarySymbol[token] and token or UnaryAlias[token]
    if not symbol then
        return nil
    end
    local myLevel = UnarySymbol[symbol]
    if level and myLevel < level then
        return nil
    end
    local op = {
        type   = symbol,
        start  = getPosition(Tokens[Index], 'left'),
        finish = getPosition(Tokens[Index] + #symbol - 1, 'right'),
    }
    Index = Index + 2
    return op, myLevel
end

---@param level integer # op level must greater than this level
local function parseBinaryOP(asAction, level)
    local token  = Tokens[Index + 1]
    local symbol = (BinarySymbol[token] and token)
                or BinaryAlias[token]
                or (not asAction and BinaryActionAlias[token])
    if not symbol then
        return nil
    end
    local myLevel = BinarySymbol[symbol]
    if level and myLevel < level then
        return nil
    end
    local op = {
        type   = symbol,
        start  = getPosition(Tokens[Index], 'left'),
        finish = getPosition(Tokens[Index] + #token - 1, 'right'),
    }
    if not asAction then
        if token == '=' then
            pushError {
                type   = 'ERR_EQ_AS_ASSIGN',
                start  = op.start,
                finish = op.finish,
                fix    = {
                    title = 'FIX_EQ_AS_ASSIGN',
                    {
                        start  = op.start,
                        finish = op.finish,
                        text   = '==',
                    }
                }
            }
        end
    end
    if BinaryAlias[token] then
        if State.options.nonstandardSymbol and State.options.nonstandardSymbol[token] then
        else
            pushError {
                type   = 'ERR_NONSTANDARD_SYMBOL',
                start  = op.start,
                finish = op.finish,
                info   = {
                    symbol = symbol,
                },
                fix    = {
                    title  = 'FIX_NONSTANDARD_SYMBOL',
                    symbol = symbol,
                    {
                        start  = op.start,
                        finish = op.finish,
                        text   = symbol,
                    },
                }
            }
        end
    end
    if token == '//'
    or token == '<<'
    or token == '>>' then
        if  State.version ~= 'Lua 5.3'
        and State.version ~= 'Lua 5.4' then
            pushError {
                type    = 'UNSUPPORT_SYMBOL',
                version = {'Lua 5.3', 'Lua 5.4'},
                start   = op.start,
                finish  = op.finish,
                info    = {
                    version = State.version,
                }
            }
        end
    end
    Index = Index + 2
    return op, myLevel
end

function parseExp(asAction, level)
    local exp
    local uop, uopLevel = parseUnaryOP(level)
    if uop then
        skipSpace()
        local child = parseExp(asAction, uopLevel)
        exp = {
            type   = 'unary',
            op     = uop,
            start  = uop.start,
            finish = child and child.finish or uop.finish,
            [1]    = child,
        }
        if child then
            child.parent = exp
        else
            missExp()
        end
    else
        exp = parseExpUnit()
        if not exp then
            return nil
        end
    end

    while true do
        skipSpace()
        local bop, bopLevel = parseBinaryOP(asAction, level)
        if not bop then
            break
        end

        ::AGAIN::
        skipSpace()
        local isForward = SymbolForward[bopLevel]
        local child = parseExp(asAction, isForward and (bopLevel + 0.5) or bopLevel)
        if not child then
            if skipUnknownSymbol() then
                goto AGAIN
            else
                missExp()
            end
        end
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

local function skipSeps()
    while true do
        skipSpace()
        if Tokens[Index + 1] == ',' then
            missExp()
            Index = Index + 2
        else
            break
        end
    end
end

---@return parser.guide.object   first
---@return parser.guide.object   second
---@return parser.guide.object[] rest
local function parseSetValues()
    skipSpace()
    local first = parseExp()
    if not first then
        return nil
    end
    skipSpace()
    if Tokens[Index + 1] ~= ',' then
        return first
    end
    Index = Index + 2
    skipSeps()
    local second = parseExp()
    if not second then
        missExp()
        return first
    end
    skipSpace()
    if Tokens[Index + 1] ~= ',' then
        return first, second
    end
    Index = Index + 2
    skipSeps()
    local third = parseExp()
    if not third then
        missExp()
        return first, second
    end

    local rest = { third }
    while true do
        skipSpace()
        if Tokens[Index + 1] ~= ',' then
            return first, second, rest
        end
        Index = Index + 2
        skipSeps()
        local exp = parseExp()
        if not exp then
            missExp()
            return first, second, rest
        end
        rest[#rest+1] = exp
    end
end

local function pushActionIntoCurrentChunk(action)
    local chunk = Chunk[#Chunk]
    if chunk then
        chunk[#chunk+1] = action
        action.parent   = chunk
        chunk.finish    = action.finish
    end
end

---@return parser.guide.object   second
---@return parser.guide.object[] rest
local function parseVarTails(parser, isLocal)
    if Tokens[Index + 1] ~= ',' then
        return
    end
    Index = Index + 2
    skipSpace()
    local second = parser(true)
    if not second then
        missName()
        return
    end
    if isLocal then
        createLocal(second, parseLocalAttrs())
        second.effect = maxinteger
    end
    skipSpace()
    if Tokens[Index + 1] ~= ',' then
        return second
    end
    Index = Index + 2
    skipSeps()
    local third = parser(true)
    if not third then
        missName()
        return second
    end
    if isLocal then
        createLocal(third, parseLocalAttrs())
        third.effect = maxinteger
    end
    local rest = { third }
    while true do
        skipSpace()
        if Tokens[Index + 1] ~= ',' then
            return second, rest
        end
        Index = Index + 2
        skipSeps()
        local name = parser(true)
        if not name then
            missName()
            return second, rest
        end
        if isLocal then
            createLocal(name, parseLocalAttrs())
            name.effect = maxinteger
        end
        rest[#rest+1] = name
    end
end

local function bindValue(n, v, index, lastValue, isLocal, isSet)
    if isLocal then
        n.effect = lastRightPosition()
    elseif isSet then
        n.type = GetToSetMap[n.type] or n.type
    end
    if not v and lastValue then
        if lastValue.type == 'call'
        or lastValue.type == 'varargs' then
            v = lastValue
            if not v.extParent then
                v.extParent = {}
            end
        end
    end
    if v then
        if v.type == 'call'
        or v.type == 'varargs' then
            local select = {
                type   = 'select',
                sindex = index,
                start  = v.start,
                finish = v.finish,
                vararg = v
            }
            if v.parent then
                v.extParent[#v.extParent+1] = select
            else
                v.parent = select
            end
            v = select
        end
        n.value  = v
        n.range  = v.finish
        v.parent = n
        if isLocal then
            n.effect = lastRightPosition()
        end
    end
end

local function parseMultiVars(n1, parser, isLocal)
    local n2, nrest = parseVarTails(parser, isLocal)
    skipSpace()
    local v1, v2, vrest
    local isSet
    if expectAssign() then
        v1, v2, vrest = parseSetValues()
        isSet = true
        if not v1 then
            missExp()
        end
    end
    bindValue(n1, v1, 1, nil, isLocal, isSet)
    local lastValue = v1
    if n2 then
        bindValue(n2, v2, 2, lastValue, isLocal, isSet)
        lastValue = v2 or lastValue
        pushActionIntoCurrentChunk(n2)
    end
    if nrest then
        for i = 1, #nrest do
            local n = nrest[i]
            local v = vrest and vrest[i]
            bindValue(n, v, i + 2, lastValue, isLocal, isSet)
            lastValue = v or lastValue
            pushActionIntoCurrentChunk(n)
        end
    end

    if v2 and not n2 then
        v2.redundant = true
        pushActionIntoCurrentChunk(v2)
    end
    if vrest then
        for i = 1, #vrest do
            local v = vrest[i]
            if not nrest or not nrest[i] then
                v.redundant = true
                pushActionIntoCurrentChunk(v)
            end
        end
    end

    return n1, isSet
end

local function compileExpAsAction(exp)
    pushActionIntoCurrentChunk(exp)
    if GetToSetMap[exp.type] then
        skipSpace()
        local action, isSet = parseMultiVars(exp, parseExp)
        if isSet
        or action.type == 'getmethod' then
            return action
        end
    end

    if exp.type == 'call' then
        return exp
    end

    if exp.type == 'binary' then
        if GetToSetMap[exp[1].type] then
            local op = exp.op
            if op.type == '==' then
                pushError {
                    type   = 'ERR_ASSIGN_AS_EQ',
                    start  = op.start,
                    finish = op.finish,
                    fix    = {
                        title = 'FIX_ASSIGN_AS_EQ',
                        {
                            start  = op.start,
                            finish = op.finish,
                            text   = '=',
                        }
                    }
                }
                return
            end
        end
    end

    pushError {
        type   = 'EXP_IN_ACTION',
        start  = exp.start,
        finish = exp.finish,
    }
end

local function parseLocal()
    Index = Index + 2
    skipSpace()
    local word = peekWord()
    if not word then
        missName()
        return nil
    end

    if word == 'function' then
        local func = parseFunction(true, true)
        local name = func.name
        if name then
            func.name    = nil
            name.value  = func
            name.vstart = func.start
            name.range  = func.finish
            func.parent  = name
            pushActionIntoCurrentChunk(name)
            return name
        else
            missName(func.keyword[2])
            pushActionIntoCurrentChunk(func)
            return func
        end
    end

    local name = parseName()
    if not name then
        missName()
        return nil
    end
    local loc = createLocal(name, parseLocalAttrs())
    loc.effect = maxinteger
    pushActionIntoCurrentChunk(loc)
    skipSpace()
    parseMultiVars(loc, parseName, true)
    loc.effect = lastRightPosition()

    return loc
end

local function parseDo()
    local doLeft  = getPosition(Tokens[Index], 'left')
    local doRight = getPosition(Tokens[Index] + 1, 'right')
    local obj = {
        type   = 'do',
        start  = doLeft,
        finish = doRight,
        keyword = {
            [1] = doLeft,
            [2] = doRight,
        },
    }
    Index = Index + 2
    pushChunk(obj)
    parseActions()
    if Tokens[Index + 1] == 'end' then
        obj.finish     = getPosition(Tokens[Index] + 2, 'right')
        obj.keyword[3] = getPosition(Tokens[Index], 'left')
        obj.keyword[4] = getPosition(Tokens[Index] + 2, 'right')
        Index = Index + 2
    else
        missEnd(doLeft, doRight)
    end
    popChunk()

    pushActionIntoCurrentChunk(obj)

    return obj
end

local function parseReturn()
    local returnLeft  = getPosition(Tokens[Index], 'left')
    local returnRight = getPosition(Tokens[Index] + 5, 'right')
    Index = Index + 2
    skipSpace()
    local rtn = parseExpList()
    if rtn then
        rtn.type  = 'return'
        rtn.start = returnLeft
    else
        rtn = {
            type   = 'return',
            start  = returnLeft,
            finish = returnRight,
        }
    end
    pushActionIntoCurrentChunk(rtn)
    for i = #Chunk, 1, -1 do
        local func = Chunk[i]
        if func.type == 'function'
        or func.type == 'main' then
            if not func.returns then
                func.returns = {}
            end
            func.returns[#func.returns+1] = rtn
            break
        end
    end

    return rtn
end

local function parseLabel()
    local left = getPosition(Tokens[Index], 'left')
    Index = Index + 2
    skipSpace()
    local label = parseName()
    skipSpace()

    if not label then
        missName()
    end

    if Tokens[Index + 1] == '::' then
        Index = Index + 2
    else
        if label then
            missSymbol '::'
        end
    end

    if not label then
        return nil
    end

    label.type = 'label'
    pushActionIntoCurrentChunk(label)
    if State.version == 'Lua 5.1' then
        pushError {
            type   = 'UNSUPPORT_SYMBOL',
            start  = left,
            finish = lastRightPosition(),
            version = {'Lua 5.2', 'Lua 5.3', 'Lua 5.4', 'LuaJIT'},
            info = {
                version = State.version,
            }
        }
        return
    end
    return label
end

local function parseGoTo()
    Index = Index + 2
    skipSpace()

    local action = parseName()
    if not action then
        missName()
        return nil
    end

    action.type = 'goto'

    pushActionIntoCurrentChunk(action)
    return action
end

local function parseIfBlock()
    local ifLeft  = getPosition(Tokens[Index], 'left')
    local ifRight = getPosition(Tokens[Index] + 1, 'right')
    Index = Index + 2
    local ifblock = {
        type    = 'ifblock',
        start   = ifLeft,
        finish  = ifRight,
        keyword = {
            [1] = ifLeft,
            [2] = ifRight,
        }
    }
    skipSpace()
    local filter = parseExp()
    if filter then
        ifblock.filter = filter
        ifblock.finish = filter.finish
        filter.parent = ifblock
    else
        missExp()
    end
    skipSpace()
    local thenToken = Tokens[Index + 1]
    if thenToken == 'then'
    or thenToken == 'do' then
        ifblock.finish     = getPosition(Tokens[Index] + #thenToken - 1, 'right')
        ifblock.keyword[3] = getPosition(Tokens[Index], 'left')
        ifblock.keyword[4] = ifblock.finish
        if thenToken == 'do' then
            pushError {
                type   = 'ERR_THEN_AS_DO',
                start  = ifblock.keyword[3],
                finish = ifblock.keyword[4],
                fix = {
                    title = 'FIX_THEN_AS_DO',
                    {
                        start  = ifblock.keyword[3],
                        finish = ifblock.keyword[4],
                        text   = 'then',
                    }
                }
            }
        end
        Index = Index + 2
    else
        missSymbol 'then'
    end
    pushChunk(ifblock)
    parseActions()
    popChunk()
    return ifblock
end

local function parseElseIfBlock()
    local ifLeft  = getPosition(Tokens[Index], 'left')
    local ifRight = getPosition(Tokens[Index] + 5, 'right')
    local elseifblock = {
        type    = 'elseifblock',
        start   = ifLeft,
        finish  = ifRight,
        keyword = {
            [1] = ifLeft,
            [2] = ifRight,
        }
    }
    Index = Index + 2
    skipSpace()
    local filter = parseExp()
    if filter then
        elseifblock.filter = filter
        elseifblock.finish = filter.finish
        filter.parent = elseifblock
    else
        missExp()
    end
    skipSpace()
    local thenToken = Tokens[Index + 1]
    if thenToken == 'then'
    or thenToken == 'do' then
        elseifblock.finish     = getPosition(Tokens[Index] + #thenToken - 1, 'right')
        elseifblock.keyword[3] = getPosition(Tokens[Index], 'left')
        elseifblock.keyword[4] = elseifblock.finish
        if thenToken == 'do' then
            pushError {
                type   = 'ERR_THEN_AS_DO',
                start  = elseifblock.keyword[3],
                finish = elseifblock.keyword[4],
                fix = {
                    title = 'FIX_THEN_AS_DO',
                    {
                        start  = elseifblock.keyword[3],
                        finish = elseifblock.keyword[4],
                        text   = 'then',
                    }
                }
            }
        end
        Index = Index + 2
    else
        missSymbol 'then'
    end
    pushChunk(elseifblock)
    parseActions()
    popChunk()
    return elseifblock
end

local function parseElseBlock()
    local ifLeft  = getPosition(Tokens[Index], 'left')
    local ifRight = getPosition(Tokens[Index] + 3, 'right')
    local elseblock = {
        type    = 'elseblock',
        start   = ifLeft,
        finish  = ifRight,
        keyword = {
            [1] = ifLeft,
            [2] = ifRight,
        }
    }
    Index = Index + 2
    skipSpace()
    pushChunk(elseblock)
    parseActions()
    popChunk()
    return elseblock
end

local function parseIf()
    local token = Tokens[Index + 1]
    local left  = getPosition(Tokens[Index], 'left')
    local action  = {
        type   = 'if',
        start  = left,
        finish = getPosition(Tokens[Index] + #token - 1, 'right'),
    }
    if token ~= 'if' then
        missSymbol('if', left, left)
    end
    local hasElse
    while true do
        local word = Tokens[Index + 1]
        local child
        if     word == 'if' then
            child = parseIfBlock()
        elseif word == 'elseif' then
            child = parseElseIfBlock()
        elseif word == 'else' then
            child = parseElseBlock()
        end
        if not child then
            break
        end
        if hasElse then
            pushError {
                type   = 'BLOCK_AFTER_ELSE',
                start  = child.start,
                finish = child.finish,
            }
        end
        if word == 'else' then
            hasElse = true
        end
        action[#action+1] = child
        child.parent = action
        action.finish = child.finish
        skipSpace()
    end

    if Tokens[Index + 1] == 'end' then
        action.finish = getPosition(Tokens[Index] + 2, 'right')
        Index = Index + 2
    else
        missEnd(action[1].keyword[1], action[1].keyword[2])
    end

    pushActionIntoCurrentChunk(action)
    return action
end

local function parseFor()
    local action = {
        type    = 'for',
        start   = getPosition(Tokens[Index], 'left'),
        finish  = getPosition(Tokens[Index] + 2, 'right'),
        keyword = {},
    }
    action.keyword[1] = action.start
    action.keyword[2] = action.finish
    Index = Index + 2
    pushChunk(action)
    skipSpace()
    local nameOrList = parseNameOrList()
    if not nameOrList then
        missName()
    end
    skipSpace()
    -- for i =
    if expectAssign() then
        action.type = 'loop'

        skipSpace()
        local expList = parseExpList()
        local name
        if nameOrList then
            if nameOrList.type == 'name' then
                name = nameOrList
            else
                name = nameOrList[1]
            end
        end
        if name then
            local loc = createLocal(name)
            loc.parent    = action
            action.finish = name.finish
            action.loc    = loc
        end
        if expList then
            local value = expList[1]
            if value then
                value.parent  = action
                action.init   = value
                action.finish = expList[#expList].finish
            end
            local max = expList[2]
            if max then
                max.parent    = action
                action.max    = max
                action.finish = max.finish
            else
                pushError {
                    type   = 'MISS_LOOP_MAX',
                    start  = lastRightPosition(),
                    finish = lastRightPosition(),
                }
            end
            local step = expList[3]
            if step then
                step.parent   = action
                action.step   = step
                action.finish = step.finish
            end
        else
            pushError {
                type   = 'MISS_LOOP_MIN',
                start  = lastRightPosition(),
                finish = lastRightPosition(),
            }
        end

        if action.loc then
            action.loc.effect = action.finish
        end
    elseif Tokens[Index + 1] == 'in' then
        action.type = 'in'
        local inLeft  = getPosition(Tokens[Index], 'left')
        local inRight = getPosition(Tokens[Index] + 1, 'right')
        Index = Index + 2
        skipSpace()

        local exps = parseExpList()

        action.finish = inRight
        action.keyword[3] = inLeft
        action.keyword[4] = inRight

        local list
        if nameOrList and nameOrList.type == 'name' then
            list = {
                type   = 'list',
                start  = nameOrList.start,
                finish = nameOrList.finish,
                [1]    = nameOrList,
            }
        else
            list = nameOrList
        end

        if exps then
            local lastExp = exps[#exps]
            if lastExp then
                action.finish = lastExp.finish
            end

            action.exps = exps
            for i = 1, #exps do
                local exp = exps[i]
                exp.parent = action
            end
        else
            missExp()
        end

        if list then
            local lastName  = list[#list]
            list.range  = lastName and lastName.range or inRight
            action.keys = list
            for i = 1, #list do
                local loc = createLocal(list[i])
                loc.parent = action
                loc.effect = action.finish
            end
        end
    else
        missSymbol 'in'
    end

    skipSpace()
    local doToken = Tokens[Index + 1]
    if doToken == 'do'
    or doToken == 'then' then
        local left  = getPosition(Tokens[Index], 'left')
        local right = getPosition(Tokens[Index] + #doToken - 1, 'right')
        action.finish                     = left
        action.keyword[#action.keyword+1] = left
        action.keyword[#action.keyword+1] = right
        if doToken == 'then' then
            pushError {
                type   = 'ERR_DO_AS_THEN',
                start  = left,
                finish = right,
                fix = {
                    title = 'FIX_DO_AS_THEN',
                    {
                        start  = left,
                        finish = right,
                        text    = 'do',
                    }
                }
            }
        end
        Index = Index + 2
    else
        missSymbol 'do'
    end

    skipSpace()
    parseActions()

    skipSpace()
    if Tokens[Index + 1] == 'end' then
        action.finish                     = getPosition(Tokens[Index] + 2, 'right')
        action.keyword[#action.keyword+1] = getPosition(Tokens[Index], 'left')
        action.keyword[#action.keyword+1] = action.finish
        Index = Index + 2
    else
        missEnd(action.keyword[1], action.keyword[2])
    end

    popChunk()

    pushActionIntoCurrentChunk(action)

    return action
end

local function parseWhile()
    local action = {
        type    = 'while',
        start   = getPosition(Tokens[Index], 'left'),
        finish  = getPosition(Tokens[Index] + 4, 'right'),
        keyword = {},
    }
    action.keyword[1] = action.start
    action.keyword[2] = action.finish
    Index = Index + 2

    skipSpace()
    local filter = parseExp()
    if filter then
        action.filter = filter
        action.finish = filter.finish
        filter.parent = action
    else
        missExp()
    end

    skipSpace()
    local doToken = Tokens[Index + 1]
    if doToken == 'do'
    or doToken == 'then' then
        local left  = getPosition(Tokens[Index], 'left')
        local right = getPosition(Tokens[Index] + #doToken - 1, 'right')
        action.finish                     = left
        action.keyword[#action.keyword+1] = left
        action.keyword[#action.keyword+1] = right
        if doToken == 'then' then
            pushError {
                type   = 'ERR_DO_AS_THEN',
                start  = left,
                finish = right,
                fix = {
                    title = 'FIX_DO_AS_THEN',
                    {
                        start  = left,
                        finish = right,
                        text    = 'do',
                    }
                }
            }
        end
        Index = Index + 2
    else
        missSymbol 'do'
    end

    pushChunk(action)
    skipSpace()
    parseActions()
    popChunk()

    skipSpace()
    if Tokens[Index + 1] == 'end' then
        action.finish                     = getPosition(Tokens[Index] + 2, 'right')
        action.keyword[#action.keyword+1] = getPosition(Tokens[Index], 'left')
        action.keyword[#action.keyword+1] = action.finish
        Index = Index + 2
    else
        missEnd(action.keyword[1], action.keyword[2])
    end

    pushActionIntoCurrentChunk(action)

    return action
end

local function parseRepeat()
    local action = {
        type    = 'repeat',
        start   = getPosition(Tokens[Index], 'left'),
        finish  = getPosition(Tokens[Index] + 5, 'right'),
        keyword = {},
    }
    action.keyword[1] = action.start
    action.keyword[2] = action.finish
    Index = Index + 2

    pushChunk(action)
    skipSpace()
    parseActions()

    skipSpace()
    if Tokens[Index + 1] == 'until' then
        action.finish                     = getPosition(Tokens[Index] + 4, 'right')
        action.keyword[#action.keyword+1] = getPosition(Tokens[Index], 'left')
        action.keyword[#action.keyword+1] = action.finish
        Index = Index + 2

        skipSpace()
        local filter = parseExp()
        if filter then
            action.filter = filter
            action.finish = filter.finish
            filter.parent = action
        else
            missExp()
        end

    else
        missSymbol 'until'
    end

    popChunk()

    pushActionIntoCurrentChunk(action)

    return action
end

local function parseBreak()
    local returnLeft  = getPosition(Tokens[Index], 'left')
    local returnRight = getPosition(Tokens[Index] + 4, 'right')
    Index = Index + 2
    skipSpace()
    local action = {
        type   = 'break',
        start  = returnLeft,
        finish = returnRight,
    }

    local chunk = Chunk[#Chunk]
    if chunk then
        if not chunk.breaks then
            chunk.breaks = {}
        end
        chunk.breaks[#chunk.breaks+1] = action
    end

    pushActionIntoCurrentChunk(action)
    return action
end

function parseAction()
    local token = Tokens[Index + 1]

    if token == '::' then
        return parseLabel()
    end

    if token == 'local' then
        return parseLocal()
    end

    if token == 'if'
    or token == 'elseif'
    or token == 'else' then
        return parseIf()
    end

    if token == 'for' then
        return parseFor()
    end

    if token == 'do' then
        return parseDo()
    end

    if token == 'return' then
        return parseReturn()
    end

    if token == 'break' then
        return parseBreak()
    end

    if token == 'while' then
        return parseWhile()
    end

    if token == 'repeat' then
        return parseRepeat()
    end

    if token == 'goto' then
        return parseGoTo()
    end

    if token == 'function' then
        local exp = parseFunction(false, true)
        local name = exp.name
        if name then
            exp.name    = nil
            name.type   = GetToSetMap[name.type]
            name.value  = exp
            name.vstart = exp.start
            name.range  = exp.finish
            exp.parent  = name
            pushActionIntoCurrentChunk(name)
            return name
        else
            pushActionIntoCurrentChunk(exp)
            missName(exp.keyword[2])
            return exp
        end
    end

    local exp = parseExp(true)
    if exp then
        local action = compileExpAsAction(exp)
        if action then
            return action
        end
    end
    return nil, true
end

local function skipFirstComment()
    if Tokens[Index + 1] ~= '#' then
        return
    end
    while true do
        Index = Index + 2
        local token = Tokens[Index + 1]
        if not token then
            break
        end
        if NLMap[token] then
            skipNL()
            break
        end
    end
end

local function parseLua()
    local main = {
        type   = 'main',
        start  = 0,
        finish = 0,
    }
    pushChunk(main)
    createLocal{
        type   = 'local',
        start  = 0,
        finish = 0,
        effect = 0,
        tag    = '_ENV',
        special= '_G',
        [1]    = State.ENVMode,
    }
    skipFirstComment()
    while true do
        parseActions()
        if Index <= #Tokens then
            unknownSymbol()
            Index = Index + 2
        else
            break
        end
    end
    popChunk()
    main.finish = getPosition(#Lua, 'right')

    return main
end

local function initState(lua, version, options)
    Lua                 = lua
    Line                = 0
    LineOffset          = 1
    LastTokenFinish     = 0
    Chunk               = {}
    Tokens              = tokens(lua)
    Index               = 1
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
        State.ast = parseLua()
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
    elseif mode == 'Action' then
        State.ast = parseAction()
    end

    return State
end

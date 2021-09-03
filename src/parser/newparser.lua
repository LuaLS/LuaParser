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
local CharMapSU      = stringToCharMap 'n#~!-'
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
    ['!']   = 11,
}

local BinarySymbol = {
    ['or']  = 1,
    ['||']  = 1,
    ['and'] = 2,
    ['&&']  = 2,
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
}

local State, Lua, Line, LineOffset, Chunk, Tokens, Index

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

local CachedChar, CachedCharOffset
local function peekChar(offset)
    if not offset then
        offset = LuaOffset
    end
    if CachedCharOffset ~= offset then
        CachedCharOffset = offset
        CachedChar = ssub(Lua, offset, offset)
        if CachedChar == '' then
            CachedChar = nil
        end
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

local function missSymbol(symbol, pos)
    pushError {
        type   = 'MISS_SYMBOL',
        start  = pos or NonSpacePosition,
        finish = pos or NonSpacePosition,
        info = {
            symbol = symbol,
        }
    }
end

local function missExp()
    pushError {
        type   = 'MISS_EXP',
        start  = NonSpacePosition,
        finish = NonSpacePosition,
    }
end

local function missName(pos)
    pushError {
        type   = 'MISS_NAME',
        start  = pos or NonSpacePosition,
        finish = pos or NonSpacePosition,
    }
end

local function unknownSymbol(start, finish, symbol)
    pushError {
        type   = 'UNKNOWN_SYMBOL',
        start  = start,
        finish = finish,
        info   = {
            symbol = symbol,
        }
    }
end

local function skipUnknownSymbol(stopSymbol)
    local symbol, sstart, sfinish, newOffset = peekWord()
    if not newOffset then
        local pattern = '^([^ \t\r\n' .. (stopSymbol or '') .. ']*)'
        sstart, newOffset, symbol = sfind(Lua, pattern, LuaOffset)
        sstart  = getPosition(sstart, 'left')
        sfinish = getPosition(newOffset, 'right')
        newOffset = newOffset + 1
    end
    LuaOffset = newOffset
    unknownSymbol(sstart, sfinish, symbol)
end

local function skipNL()
    local token = Tokens[Index + 1]
    if token == '\r'
    or token == '\n'
    or token == '\r\n' then
        Line       = Line + 1
        LineOffset = Tokens[Index] + #token
        Index = Index + 2
        return true
    end
    return false
end

local function fastwardToken(offset)
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
    fastwardToken(finishOffset + #finishMark)
    if miss then
        local estart, _, efinish = smatch(Lua, '()(%]%=*%])()[%c%s]*$')
        if estart then
            local left  = getPosition(estart, 'left')
            local right = getPosition(efinish - 1, 'right')
            pushError {
                type   = 'ERR_LSTRING_END',
                start  = left,
                finish = right,
                info   = {
                    symbol = finishMark,
                },
                fix    = {
                    title = 'FIX_LSTRING_END',
                    {
                        start  = estart,
                        finish = efinish,
                        text   = finishMark,
                    }
                },
            }
        else
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
    end
    return stringResult, finishOffset + #finishMark - 1
end

local function parseLongString()
    local start, finish, mark = sfind(Lua, '^(%[%=*%[)', Tokens[Index])
    if not mark then
        return nil
    end
    fastwardToken(finish + 1)
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

local function skipComment()
    local head = ssub(Lua, LuaOffset, LuaOffset + 1)
    if head == '--'
    or head == '//' then
        LuaOffset = LuaOffset + 2
        local longComment = parseLongString()
        if longComment then
            return true
        end
        local offset = sfind(Lua, '[\r\n]', LuaOffset)
        if offset then
            LuaOffset = offset
        else
            LuaOffset = #Lua + 1
        end
        return true
    end
    if head == '/*' then
        LuaOffset = LuaOffset + 2
        resolveLongString '*/'
    end
    return false
end

local function skipSpace()
    if LuaOffset == lastSkipSpaceOffset then
        return
    end
    NonSpacePosition = getPosition(LuaOffset - 1, 'right')
    ::AGAIN::
    if skipNL() then
        goto AGAIN
    end
    if skipComment() then
        goto AGAIN
    end
    local offset = sfind(Lua, '[^ \t]', LuaOffset)
    if not offset then
        lastSkipSpaceOffset = LuaOffset
        return
    end
    if offset > LuaOffset then
        LuaOffset = offset
        goto AGAIN
    end
    lastSkipSpaceOffset = LuaOffset
end

local function expectAssign()
    if peekChar() ~= '=' then
        return false
    end
    LuaOffset = LuaOffset + 1
    if peekChar() == '=' then
        -- TODO
        LuaOffset = LuaOffset + 1
    end
    return true
end

local function parseLocalAttrs()
    local attrs
    while true do
        skipSpace()
        local char = peekChar()
        if char ~= '<' then
            break
        end
        if not attrs then
            attrs = {}
        end
        local attr = {
            type   = 'localattr',
            start  = getPosition(LuaOffset, 'left'),
            finish = getPosition(LuaOffset, 'right'),
        }
        attrs[#attrs+1] = attr
        LuaOffset = LuaOffset + 1
        skipSpace()
        local word, wstart, wfinish, woffset = peekWord()
        if word then
            attr[1] = word
            LuaOffset = woffset
            attr.finish = wfinish
        else
            missName()
        end
        attr.finish = getPosition(LuaOffset, 'right')
        skipSpace()
        if peekChar() == '>' then
            attr.finish = getPosition(LuaOffset, 'right')
            LuaOffset = LuaOffset + 1
        else
            missSymbol '>'
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
    if peekChar() ~= '{' then
        local pos  = getPosition(LuaOffset, 'left')
        missSymbol('{', pos)
        return nil
    end
    local leftPos  = getPosition(LuaOffset - 1, 'right')
    local x16 = smatch(Lua, '^%w*', LuaOffset + 1)
    local rightPos = getPosition(LuaOffset + #x16, 'right')
    LuaOffset = LuaOffset + #x16 + 1
    if peekChar() == '}' then
        LuaOffset = LuaOffset + 1
        rightPos  = rightPos + 1
    else
        missSymbol('}', rightPos)
    end
    if #x16 == 0 then
        pushError {
            type   = 'UTF8_SMALL',
            start  = leftPos,
            finish = rightPos,
        }
        return ''
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
                    start  = leftPos + i,
                    finish = leftPos + i + 1,
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
    return ''
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
    local finishPos
    local currentOffset = startOffset + 1
    while true do
        local token = Tokens[Index + 1]
        if token == mark then
            finishPos   = getPosition(Tokens[Index], 'right')
            stringIndex = stringIndex + 1
            stringPool[stringIndex] = ssub(Lua, currentOffset, Tokens[Index] - 1)
            break
        end
        if token == '\\' then
            stringIndex = stringIndex + 1
            stringPool[stringIndex] = ssub(Lua, currentOffset, Tokens[Index] - 1)
            currentOffset = Tokens[Index]
            -- has space?
            Index = Index + 2
            if Tokens[Index] - currentOffset > 1 then
                goto CONTINUE
            end
            local nextChar = ssub(Tokens[Index + 1], 1, 1)
            if EscMap[nextChar] then
                stringIndex = stringIndex + 1
                stringPool[stringIndex] = EscMap[nextChar]
                currentOffset = Tokens[Index] + #nextChar
                Index = Index + 2
                goto CONTINUE
            end
            if nextChar == mark then
                stringIndex = stringIndex + 1
                stringPool[stringIndex] = mark
                currentOffset = Tokens[Index] + #nextChar
                Index = Index + 2
                goto CONTINUE
            end
            if nextChar == 'z' then
                Index = Index + 2
                repeat until not skipNL()
                currentOffset = Tokens[Index]
                goto CONTINUE
            end
            if CharMapNumber[nextChar] then
                local numbers = smatch(Tokens[Index + 1], '^%d+')
                if #numbers > 3 then
                    numbers = ssub(numbers, 1, 3)
                end
                currentOffset = Tokens[Index] + #numbers
                fastwardToken(currentOffset)
                local byte = tointeger(numbers)
                if byte <= 255 then
                    stringIndex = stringIndex + 1
                    stringPool[stringIndex] = schar(byte)
                else
                    -- TODO pushError
                end
                goto CONTINUE
            end
        end
        --[[
        if     char == '\\' then
            local nextChar = peekChar(offset + 1)
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
                local numbers = smatch(Lua, '^%d+', offset + 1)
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
                    pushError {
                        type   = 'MISS_ESC_X',
                        start  = getPosition(LuaOffset, 'left'),
                        finish = getPosition(LuaOffset + 1, 'right'),
                    }
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
        if not char
        or CharMapNL[char] then
            stringPool[stringIndex] = ssub(Lua, LuaOffset)
            stringResult = tconcat(stringPool, '', 1, stringIndex)
            LuaOffset = offset + 1
            missSymbol(mark, getPosition(offset - 1, 'right'))
            break
        end
        ]]
        Index = Index + 2
        ::CONTINUE::
    end
    local stringResult = tconcat(stringPool, '', 1, stringIndex)
    return {
        type   = 'string',
        start  = startPos,
        finish = finishPos,
        [1]    = stringResult,
        [2]    = mark,
    }
end

local function parseString()
    local c = Tokens[Index+1]
    if CharMapStrSH[c] then
        return parseShortString()
    end
    if CharMapStrLH[c] then
        return parseLongString()
    end
    return nil
end

local function parseNumber10(offset)
    local integerPart = smatch(Lua, '^%d*', offset)
    LuaOffset = offset + #integerPart
    -- float part
    if peekChar(LuaOffset) == '.' then
        local floatPart = smatch(Lua, '^%d*', LuaOffset + 1)
        LuaOffset = LuaOffset + #floatPart + 1
    end
    -- exp part
    local echar = peekChar(LuaOffset)
    if CharMapE10[echar] then
        LuaOffset = LuaOffset + 1
        local nextChar = peekChar(LuaOffset)
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
    if peekChar(LuaOffset) == '.' then
        local floatPart = smatch(Lua, '^[%da-fA-F]*', LuaOffset + 1)
        LuaOffset = LuaOffset + #floatPart + 1
    end
    -- exp part
    local echar = peekChar(LuaOffset)
    if CharMapE16[echar] then
        LuaOffset = LuaOffset + 1
        local nextChar = peekChar(LuaOffset)
        if CharMapSign[nextChar] then
            LuaOffset = LuaOffset + 1
        end
        local exp = smatch(Lua, '^%d*', LuaOffset)
        LuaOffset = LuaOffset + #exp
    end
    return tonumber(ssub(Lua, offset - 2, LuaOffset - 1))
end

local function parseNumber2(offset)
    local bins = smatch(Lua, '^[01]*', offset)
    LuaOffset = offset + #bins
    return tonumber(bins, 2)
end

local function dropNumberTail()
    local _, finish, word = sfind(Lua, '^([%.%w_\x80-\xff]+)', LuaOffset)
    if not finish then
        return
    end
    unknownSymbol(
        getPosition(LuaOffset, 'left'),
        getPosition(LuaOffset, 'right'),
        word
    )
    LuaOffset = finish + 1
end

local function parseNumber()
    local offset = LuaOffset
    local startPos = getPosition(offset, 'left')
    local neg
    if peekChar(offset) == '-' then
        neg = true
        offset = offset + 1
    end
    local number
    local firstChar = peekChar(offset)
    if     firstChar == '.' then
        number = parseNumber10(offset)
    elseif firstChar == '0' then
        local nextChar = peekChar(offset + 1)
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
    local result = {
        type   = mtype(number) == 'integer' and 'integer' or 'number',
        start  = startPos,
        finish = getPosition(LuaOffset - 1, 'right'),
        [1]    = number,
    }
    dropNumberTail()
    return result
end

local function parseName()
    local word, startPos, finishPos, newOffset = peekWord()
    if not word then
        return nil
    end
    LuaOffset = newOffset
    if not State.options.unicodeName and word:find '[\x80-\xff]' then
        pushError {
            type   = 'UNICODE_NAME',
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
        local sep = peekChar()
        if sep ~= ',' then
            break
        end
        LuaOffset = LuaOffset + 1
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
    local pl, pt, pp = 0, 0, 0
    while true do
        local char, offset = smatch(Lua, '([\r\n%,%<%>%{%}%(%)])()', LuaOffset)
        if not char then
            return
        end
        if char == '\r'
        or char == '\n' then
            LuaOffset = offset - 1
            return
        end
        if char == ',' then
            if pl > 0
            or pt > 0
            or pp > 0 then
                LuaOffset = offset
                goto CONTINUE
            else
                LuaOffset = offset - 1
                break
            end
        end
        if char == '<' then
            pl = pl + 1
            LuaOffset = offset
            goto CONTINUE
        end
        if char == '{' then
            pt = pt + 1
            LuaOffset = offset
            goto CONTINUE
        end
        if char == '(' then
            pp = pp + 1
            LuaOffset = offset
            goto CONTINUE
        end
        if char == '>' then
            if pl <= 0 then
                break
            end
            pl = pl - 1
            LuaOffset = offset
            goto CONTINUE
        end
        if char == '}' then
            if pt <= 0 then
                break
            end
            pt = pt - 1
            LuaOffset = offset
            goto CONTINUE
        end
        if char == ')' then
            if pp <= 0 then
                break
            end
            pp = pp - 1
            LuaOffset = offset
            goto CONTINUE
        end
        ::CONTINUE::
    end
end

local function parseExpList(stop)
    local list
    local lastSepPos = LuaOffset
    while true do
        skipSpace()
        local char = peekChar()
        if not char then
            break
        end
        if char == stop then
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
            if stop then
                dropTail()
            end
            lastSepPos = nil
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
    if lastSepPos then
        pushError {
            type   = 'MISS_EXP',
            start  = lastSepPos,
            finish = lastSepPos,
        }
    end
    return list
end

local function parseIndex()
    if peekChar() ~= '[' then
        return nil
    end
    local bstart = getPosition(LuaOffset, 'left')
    LuaOffset = LuaOffset + 1
    skipSpace()
    local exp = parseExp()
    local index = {
        type   = 'index',
        start  = bstart,
        finish = getPosition(LuaOffset - 1, 'right'),
        index  = exp
    }
    if exp then
        exp.parent = index
    end
    skipSpace()
    if peekChar() == ']' then
        index.finish = getPosition(LuaOffset, 'right')
        LuaOffset = LuaOffset + 1
    else
        missSymbol ']'
    end
    return index
end

local function parseTable()
    if peekChar() ~= '{' then
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
        local nextChar = peekChar()
        if nextChar == '}' then
            LuaOffset = LuaOffset + 1
            break
        end
        if CharMapTSep[nextChar] then
            LuaOffset = LuaOffset + 1
            goto CONTINUE
        end
        if nextChar == '[' then
            index = index + 1
            local tindex = parseIndex()
            skipSpace()
            if expectAssign() then
                LuaOffset = LuaOffset + 1
                skipSpace()
                local ivalue = parseExp()
                tindex.type   = 'tableindex'
                tindex.parent = tbl
                if ivalue then
                    ivalue.parent = tindex
                    tindex.finish = ivalue.finish
                    tindex.value  = ivalue
                end
                tbl[index] = tindex
            else
                missSymbol ']'
            end
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
                if expectAssign() then
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
            goto CONTINUE
        end
        missSymbol '}'
        break
        ::CONTINUE::
    end
    tbl.finish = getPosition(LuaOffset - 1, 'right')
    return tbl
end

local function parseSimple(node, enableCall)
    while true do
        skipSpace()
        local nextChar = peekChar()
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
            if not enableCall then
                break
            end
            local startPos = getPosition(LuaOffset, 'left')
            local call = {
                type   = 'call',
                start  = node.start,
                node   = node,
            }
            LuaOffset = LuaOffset + 1
            local args = parseExpList(')')
            if peekChar(LuaOffset) == ')' then
                LuaOffset = LuaOffset + 1
            else
                missSymbol ')'
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
        elseif CharMapStrSH[nextChar] then
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
        elseif CharMapStrLH[nextChar] then
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
    local firstChar = peekChar()
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
        missExp()
    end
    skipSpace()
    if peekChar() == ')' then
        paren.finish = getPosition(LuaOffset, 'right')
        LuaOffset = LuaOffset + 1
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

local function parseActions()
    while true do
        skipSpace()
        if peekChar() == ';' then
            LuaOffset = LuaOffset + 1
            goto CONTINUE
        end
        local word, wstart, wfinish, woffset = peekWord()
        if  ChunkFinishMap[word] then
            return word, wstart, wfinish, woffset
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
    while true do
        skipSpace()
        local char = peekChar()
        if not char or char == ')' then
            if lastSep then
                missName()
            end
            break
        end
        if char == ',' then
            if lastSep then
                missName()
            else
                lastSep = true
            end
            LuaOffset = LuaOffset + 1
            goto CONTINUE
        end
        if char == '.' then
            if ssub(Lua, LuaOffset, LuaOffset + 2) == '...' then
                if lastSep == false then
                    missSymbol ','
                end
                lastSep = false
                if not params then
                    params = {}
                end
                params[#params+1] = {
                    type   = '...',
                    start  = getPosition(LuaOffset, 'left'),
                    finish = getPosition(LuaOffset + 2, 'right'),
                    parent = params,
                }
                LuaOffset = LuaOffset + 3
                goto CONTINUE
            else
                skipUnknownSymbol '%,%)%.'
                goto CONTINUE
            end
        end
        local word, wstart, wfinish, woffset = peekWord()
        if word then
            if lastSep == false then
                missSymbol ','
            end
            lastSep = false
            if not params then
                params = {}
            end
            params[#params+1] = createLocal {
                start  = wstart,
                finish = wfinish,
                parent = params,
                [1]    = word,
            }
            LuaOffset = woffset
            goto CONTINUE
        else
            skipUnknownSymbol '%,%)%.'
            goto CONTINUE
        end
        ::CONTINUE::
    end
    return params
end

local function parseFunction(isLocal)
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
    LuaOffset = newOffset
    skipSpace()
    local name
    if peekChar() ~= '(' then
        name = parseName()
        if not name then
            return func
        end
        if isLocal then
            createLocal(name)
        else
            name = parseSimple(resolveName(name), false)
        end
        func.name   = name
        func.finish = name.finish
        skipSpace()
        if peekChar() ~= '(' then
            missSymbol ')'
            return func
        end
    end
    local parenLeft = getPosition(LuaOffset, 'left')
    LuaOffset = LuaOffset + 1
    pushChunk(func)
    local params
    if func.name and func.name.type == 'getmethod' then
        if name.type == 'getmethod' then
            params = {}
            params[1] = createLocal {
                start  = funcRight,
                finish = funcRight,
                method = name,
                parent = params,
                tag    = 'self',
                dummy  = true,
                [1]    = 'self',
            }
        end
    end
    params = parseParams(params)
    if params then
        params.type   = 'funcargs'
        params.start  = parenLeft
        params.parent = func
        func.args     = params
        func.finish   = params.finish
    end
    skipSpace()
    if peekChar() == ')' then
        local parenRight = getPosition(LuaOffset, 'right')
        func.finish = parenRight
        if params then
            params.finish = parenRight
        end
        LuaOffset = LuaOffset + 1
        skipSpace()
    else
        func.finish = NonSpacePosition
        if params then
            params.finish = NonSpacePosition
        end
        missSymbol ')'
    end
    parseActions()
    local endWord, endLeft, endRight, endOffset = peekWord()
    if endWord == 'end' then
        func.keyword[3] = endLeft
        func.keyword[4] = endRight
        func.finish     = endRight
        LuaOffset       = endOffset
    else
        missSymbol 'end'
    end
    popChunk()
    return func
end

local function parseExpUnit()
    local paren = parseParen()
    if paren then
        return parseSimple(paren, true)
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
        if ChunkFinishMap[word] then
            return nil
        end
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
        return parseSimple(resolveName(node), true)
    end

    return nil
end

local function getUnaryOP(char)
    if UnarySymbol[char] then
        return UnaryAlias[char] or char
    end
    local word = peekWord()
    if UnarySymbol[word] then
        return word
    end
    return nil
end

local function parseUnaryOP(level)
    local char = peekChar()
    if not CharMapSU[char] then
        return nil
    end
    local symbol = getUnaryOP(char)
    if not symbol then
        return nil
    end
    local myLevel = UnarySymbol[symbol]
    if level and myLevel < level then
        return nil
    end
    local op = {
        type   = symbol,
        start  = getPosition(LuaOffset, 'left'),
        finish = getPosition(LuaOffset + #symbol - 1, 'right'),
    }
    LuaOffset = LuaOffset + #symbol
    return op, myLevel
end

local function getBinaryOP(char)
    local char2 = ssub(Lua, LuaOffset, LuaOffset + 1)
    if BinarySymbol[char2] then
        return BinaryAlias[char2] or char2
    end
    if BinarySymbol[char] then
        return char
    end
    local word = peekWord()
    if BinarySymbol[word] then
        return word
    end
    return nil
end

---@param level integer # op level must greater than this level
local function parseBinaryOP(level)
    local char = peekChar()
    if not CharMapSB[char] then
        return nil
    end
    local symbol = getBinaryOP(char)
    if not symbol then
        return nil
    end
    local myLevel = BinarySymbol[symbol]
    if level and myLevel < level then
        return nil
    end
    local op = {
        type   = symbol,
        start  = getPosition(LuaOffset, 'left'),
        finish = getPosition(LuaOffset + #symbol - 1, 'right'),
    }
    LuaOffset = LuaOffset + #symbol
    return op, myLevel
end

function parseExp(level)
    local exp
    local uop, uopLevel = parseUnaryOP(level)
    if uop then
        skipSpace()
        local child = parseExp(uopLevel)
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

    while true do
        skipSpace()
        local bop, bopLevel = parseBinaryOP(level)
        if not bop then
            break
        end

        ::AGAIN::
        skipSpace()
        local isForward = SymbolForward[bopLevel]
        local child = parseExp(isForward and (bopLevel + 0.5) or bopLevel)
        if not child then
            skipUnknownSymbol()
            goto AGAIN
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
        if peekChar() == ',' then
            missExp()
            LuaOffset = LuaOffset + 1
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
    if peekChar() ~= ',' then
        return first
    end
    LuaOffset = LuaOffset + 1
    skipSeps()
    local second = parseExp()
    if not second then
        missExp()
        return first
    end
    skipSpace()
    if peekChar() ~= ',' then
        return first, second
    end
    LuaOffset = LuaOffset + 1
    skipSeps()
    local third = parseExp()
    if not third then
        missExp()
        return first, second
    end

    local rest = { third }
    while true do
        skipSpace()
        if peekChar() ~= ',' then
            return first, second, rest
        end
        LuaOffset = LuaOffset + 1
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
local function parseSetTails(parser, isLocal)
    if peekChar() ~= ',' then
        return
    end
    LuaOffset = LuaOffset + 1
    skipSpace()
    local second = parser()
    if not second then
        missName()
        return
    end
    if isLocal then
        createLocal(second, parseLocalAttrs())
        second.effect = maxinteger
    end
    skipSpace()
    if peekChar() ~= ',' then
        return second
    end
    LuaOffset = LuaOffset + 1
    skipSeps()
    local third = parser()
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
        if peekChar() ~= ',' then
            return second, rest
        end
        LuaOffset = LuaOffset + 1
        skipSeps()
        local name = parser()
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
        n.effect = getPosition(LuaOffset, 'left')
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
            n.effect = NonSpacePosition
        end
    end
end

local function parseSet(n1, parser, isLocal)
    local n2, nrest     = parseSetTails(parser, isLocal)
    skipSpace()
    local v1, v2, vrest
    local isSet
    if expectAssign() then
        v1, v2, vrest = parseSetValues()
        isSet = true
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

    return n1
end

local function compileExpAsAction(exp)

    if GetToSetMap[exp.type] then
        skipSpace()
        pushActionIntoCurrentChunk(exp)
        local action = parseSet(exp, parseExp)
        if action then
            return action
        end
    end

    if exp.type == 'call' then
        pushActionIntoCurrentChunk(exp)
        return exp
    end

    if exp.type == 'function' then
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

    pushActionIntoCurrentChunk(exp)
end

local function parseLocal()
    LuaOffset = LuaOffset + 5
    skipSpace()
    local word = peekWord()
    if not word then
        missName()
        return nil
    end

    if word == 'function' then
        local func = parseFunction(true)
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
    parseSet(loc, parseName, true)
    loc.effect = getPosition(LuaOffset, 'left')

    return loc
end

local function parseDo()
    local doLeft  = getPosition(LuaOffset, 'left')
    local doRight = getPosition(LuaOffset + 1, 'right')
    local obj = {
        type   = 'do',
        start  = doLeft,
        finish = doRight,
        keyword = {
            [1] = doLeft,
            [2] = doRight,
        },
    }
    LuaOffset = LuaOffset + 2
    pushChunk(obj)
    local word, wstart, wfinish, woffset = parseActions()
    if word == 'end' then
        obj.finish     = wfinish
        obj.keyword[3] = wstart
        obj.keyword[4] = wfinish
        LuaOffset = woffset
    end
    popChunk()

    pushActionIntoCurrentChunk(obj)

    return obj
end

local function parseReturn()
    local returnLeft  = getPosition(LuaOffset, 'left')
    local returnRight = getPosition(LuaOffset + 5, 'right')
    LuaOffset = LuaOffset + 6
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
    if ssub(Lua, LuaOffset, LuaOffset + 1) ~= '::' then
        skipUnknownSymbol()
        return nil
    end
    LuaOffset = LuaOffset + 2
    skipSpace()
    local label = parseName()
    skipSpace()

    if ssub(Lua, LuaOffset, LuaOffset + 1) == '::' then
        LuaOffset = LuaOffset + 2
    else
        missSymbol '::'
    end

    if not label then
        return nil
    end

    label.type = 'label'
    pushActionIntoCurrentChunk(label)
    return label
end

local function parseGoTo()
    LuaOffset = LuaOffset + 4
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
    local ifLeft  = getPosition(LuaOffset, 'left')
    local ifRight = getPosition(LuaOffset + 1, 'right')
    local ifblock = {
        type    = 'ifblock',
        start   = ifLeft,
        finish  = ifRight,
        keyword = {
            [1] = ifLeft,
            [2] = ifRight,
        }
    }
    LuaOffset = LuaOffset + 2
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
    local endWord, endLeft, endRight, newOffset = peekWord()
    if endWord == 'then' then
        LuaOffset = newOffset
        ifblock.finish     = endRight
        ifblock.keyword[3] = endLeft
        ifblock.keyword[4] = endRight
    else
        missSymbol 'then'
    end
    pushChunk(ifblock)
    parseActions()
    popChunk()
    return ifblock
end

local function parseElseIfBlock()
    local ifLeft  = getPosition(LuaOffset, 'left')
    local ifRight = getPosition(LuaOffset + 5, 'right')
    local elseifblock = {
        type    = 'elseifblock',
        start   = ifLeft,
        finish  = ifRight,
        keyword = {
            [1] = ifLeft,
            [2] = ifRight,
        }
    }
    LuaOffset = LuaOffset + 6
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
    local endWord, endLeft, endRight, newOffset = peekWord()
    if endWord == 'then' then
        LuaOffset = newOffset
        elseifblock.finish     = endRight
        elseifblock.keyword[3] = endLeft
        elseifblock.keyword[4] = endRight
    else
        missSymbol 'then'
    end
    pushChunk(elseifblock)
    parseActions()
    popChunk()
    return elseifblock
end

local function parseElseBlock()
    local ifLeft  = getPosition(LuaOffset, 'left')
    local ifRight = getPosition(LuaOffset + 3, 'right')
    local elseblock = {
        type    = 'elseblock',
        start   = ifLeft,
        finish  = ifRight,
        keyword = {
            [1] = ifLeft,
            [2] = ifRight,
        }
    }
    LuaOffset = LuaOffset + 4
    skipSpace()
    pushChunk(elseblock)
    parseActions()
    popChunk()
    return elseblock
end

local function parseIf()
    local firstword = peekWord()
    local action  = {
        type   = 'if',
        start  = getPosition(LuaOffset, 'left'),
        finish = getPosition(LuaOffset + #firstword - 1, 'right'),
    }
    while true do
        local word = peekWord()
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
        action[#action+1] = child
        child.parent = action
        action.finish = child.finish
        skipSpace()
    end

    local word, wleft, wright, newOffset = peekWord()
    if word == 'end' then
        action.finish = wright
        LuaOffset = newOffset
    else
        missSymbol 'end'
    end

    pushActionIntoCurrentChunk(action)
    return action
end

local function parseFor()
    local action = {
        type    = 'for',
        start   = getPosition(LuaOffset, 'left'),
        finish  = getPosition(LuaOffset + 2, 'right'),
        keyword = {},
    }
    action.keyword[1] = action.start
    action.keyword[2] = action.finish
    LuaOffset = LuaOffset + 3
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
        if nameOrList and nameOrList.type == 'name' then
            name = nameOrList
        else
            name = nameOrList[1]
            -- TODO
        end
        if name then
            local loc = createLocal(name)
            loc.parent    = action
            action.finish = name.finish
            action.loc    = loc
        end
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
            -- TODO
        end
        local step = expList[3]
        if step then
            step.parent   = action
            action.step   = step
            action.finish = step.finish
        end

        if action.loc then
            action.loc.effect = action.finish
        end
    elseif peekWord() == 'in' then
        action.type = 'in'
        local inLeft  = getPosition(LuaOffset, 'left')
        local inRight = getPosition(LuaOffset + 1, 'right')
        LuaOffset = LuaOffset + 2
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

        local lastName  = list[#list]

        list.range  = lastName and lastName.range or inRight

        local lastExp = exps[#exps]
        if lastExp then
            action.finish = lastExp.finish
        end

        action.keys = list
        for i = 1, #list do
            local loc = createLocal(list[i])
            loc.parent = action
            loc.effect = action.finish
        end

        action.exps = exps
        for i = 1, #exps do
            local exp = exps[i]
            exp.parent = action
        end
    end

    skipSpace()
    local word, wleft, wright, newOffset = peekWord()
    if word == 'do' then
        action.finish     = wright
        action.keyword[#action.keyword+1] = wleft
        action.keyword[#action.keyword+1] = wright
        LuaOffset         = newOffset
    else
        missSymbol 'do'
    end

    skipSpace()
    parseActions()

    skipSpace()
    word, wleft, wright, newOffset = peekWord()
    if word == 'end' then
        action.keyword[#action.keyword+1] = wleft
        action.keyword[#action.keyword+1] = wright
        action.finish     = wright
        LuaOffset         = newOffset
    else
        missSymbol 'end'
    end

    popChunk()

    pushActionIntoCurrentChunk(action)

    return action
end

local function parseWhile()
    local action = {
        type    = 'while',
        start   = getPosition(LuaOffset, 'left'),
        finish  = getPosition(LuaOffset + 4, 'right'),
        keyword = {},
    }
    action.keyword[1] = action.start
    action.keyword[2] = action.finish
    LuaOffset = LuaOffset + 5

    skipSpace()
    local filter = parseExp()
    if filter then
        action.filter = filter
        action.finish = filter.finish
        filter.parent = action
    end

    skipSpace()
    local word, wleft, wright, newOffset = peekWord()
    if word == 'do' then
        action.finish     = wright
        action.keyword[#action.keyword+1] = wleft
        action.keyword[#action.keyword+1] = wright
        LuaOffset         = newOffset
    else
        missSymbol 'do'
    end

    pushChunk(action)
    skipSpace()
    parseActions()
    popChunk()

    skipSpace()
    word, wleft, wright, newOffset = peekWord()
    if word == 'end' then
        action.keyword[#action.keyword+1] = wleft
        action.keyword[#action.keyword+1] = wright
        action.finish     = wright
        LuaOffset         = newOffset
    else
        missSymbol 'end'
    end

    pushActionIntoCurrentChunk(action)

    return action
end

local function parseRepeat()
    local action = {
        type    = 'repeat',
        start   = getPosition(LuaOffset, 'left'),
        finish  = getPosition(LuaOffset + 5, 'right'),
        keyword = {},
    }
    action.keyword[1] = action.start
    action.keyword[2] = action.finish
    LuaOffset = LuaOffset + 6

    pushChunk(action)
    skipSpace()
    parseActions()

    skipSpace()
    local word, wleft, wright, newOffset = peekWord()
    if word == 'until' then
        action.keyword[#action.keyword+1] = wleft
        action.keyword[#action.keyword+1] = wright
        action.finish     = wright
        LuaOffset         = newOffset

        skipSpace()
        local filter = parseExp()
        if filter then
            action.filter = filter
            action.finish = filter.finish
            filter.parent = action
        end

    else
        missSymbol 'until'
    end

    popChunk()

    pushActionIntoCurrentChunk(action)

    return action
end

local function parseBreak()
    local returnLeft  = getPosition(LuaOffset, 'left')
    local returnRight = getPosition(LuaOffset + 4, 'right')
    LuaOffset = LuaOffset + 5
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
    local char = peekChar()

    if char == ':' then
        return parseLabel()
    end

    local word = peekWord()
    if word == 'local' then
        return parseLocal()
    end

    if word == 'if'
    or word == 'elseif'
    or word == 'else' then
        return parseIf()
    end

    if word == 'for' then
        return parseFor()
    end

    if word == 'do' then
        return parseDo()
    end

    if word == 'return' then
        return parseReturn()
    end

    if word == 'break' then
        return parseBreak()
    end

    if word == 'while' then
        return parseWhile()
    end

    if word == 'repeat' then
        return parseRepeat()
    end

    if word == 'goto' then
        return parseGoTo()
    end

    local exp = parseExp()
    if exp then
        local action = compileExpAsAction(exp)
        if action then
            return action
        end
    end
    return nil, true
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
    parseActions()
    popChunk()
    main.finish = getPosition(#Lua, 'right')

    return main
end

local function initState(lua, version, options)
    Lua                 = lua
    Line                = 0
    LineOffset          = 1
    Chunk               = {}
    Tokens              = tokens(lua)
    Index               = 1
    CachedCharOffset    = nil
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

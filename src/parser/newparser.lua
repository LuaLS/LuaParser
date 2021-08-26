local sbyte     = string.byte
local sfind     = string.find
local smatch    = string.match
local sgsub     = string.gsub
local ssub      = string.sub
local schar     = string.char
local uchar     = utf8.char
local tconcat   = table.concat
local tointeger = math.tointeger
local mtype     = math.type
local tonumber  = tonumber

---@alias parser.position integer

---@param str string
---@return table<integer, boolean>
local function stringToByteMap(str)
    local map = {}
    local pos = 1
    while pos <= #str do
        local byte = sbyte(str, pos, pos)
        map[byte] = true
        pos = pos + 1
        if  ssub(str, pos, pos) == '-'
        and pos < #str then
            pos = pos + 1
            local byte2 = sbyte(str, pos, pos)
            assert(byte < byte2)
            for b = byte + 1, byte2 do
                map[b] = true
            end
            pos = pos + 1
        end
    end
    return map
end

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

local ByteMapSP      = stringToByteMap ' \t'
local ByteMapNL      = stringToByteMap '\r\n'
local ByteMapWordH   = stringToByteMap 'a-zA-Z\x80-\xff_'
local ByteMapWordT   = stringToByteMap 'a-zA-Z0-9\x80-\xff_'
local ByteMapStrSH   = stringToByteMap '\'"'
local ByteMapStrLH   = stringToByteMap '['
local ByteMapX16     = stringToByteMap '0-9a-fA-F'
local ByteBLR        = sbyte '\r'
local ByteBLN        = sbyte '\n'

local CharMapNumber  = stringToCharMap '0-9'
local CharMapN16     = stringToCharMap 'xX'
local CharMapN2      = stringToCharMap 'bB'
local CharMapE10     = stringToCharMap 'eE'
local CharMapE16     = stringToCharMap 'pP'
local CharMapSign    = stringToCharMap '+-'
local CharMapSymbol  = stringToCharMap 'nao|~&=<>.*/%#^!+-'
local CharMapSimple  = stringToCharMap '.:(['

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

local State, Lua, LuaOffset, Line, LineOffset

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

local CachedByte, CachedByteOffset
local function getByte(offset)
    if not offset then
        offset = LuaOffset
    end
    if CachedByteOffset ~= offset then
        CachedByteOffset = offset
        CachedByte = sbyte(Lua, offset, offset)
    end
    return CachedByte
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

local function missTL(offset)
    local pos = getPosition(offset, 'right')
    pushError {
        type   = 'MISS_SYMBOL',
        start  = pos,
        finish = pos,
        info = {
            symbol = '{',
        }
    }
end

local function missTR(offset)
    local pos = getPosition(offset, 'right')
    pushError {
        type   = 'MISS_SYMBOL',
        start  = pos,
        finish = pos,
        info = {
            symbol = '}',
        }
    }
end

local function missPL(offset)
    local pos = getPosition(offset, 'right')
    pushError {
        type   = 'MISS_SYMBOL',
        start  = pos,
        finish = pos,
        info = {
            symbol = '(',
        }
    }
end

local function missPR(offset)
    local pos = getPosition(offset, 'right')
    pushError {
        type   = 'MISS_SYMBOL',
        start  = pos,
        finish = pos,
        info = {
            symbol = ')',
        }
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
    local b = getByte()
    if not ByteMapNL[b] then
        return false
    end
    LuaOffset = LuaOffset + 1
    -- \r\n ?
    if b == ByteBLR then
        local nb = getByte()
        if nb == ByteBLN then
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
        missTL(LuaOffset)
        return nil
    end
    local leftPos  = getPosition(LuaOffset, 'right')
    local x16 = smatch(Lua, '^[%da-fA-F]*', LuaOffset + 1)
    local rightPos = getPosition(LuaOffset + #x16, 'right')
    LuaOffset = LuaOffset + #x16 + 1
    if getChar() == '}' then
        LuaOffset = LuaOffset + 1
    else
        missTR(LuaOffset)
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
    local b = getByte()
    if ByteMapStrSH[b] then
        return parseShotString()
    end
    if ByteMapStrLH[b] then
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

local function parseWord()
    local word, startPos, finishPos, newOffset = peekWord()
    if not word then
        return nil
    end
    if word == 'nil' then
        return parseNil()
    end
    if word == 'true'
    or word == 'false' then
        return parseBoolean()
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
    local lastSepPos
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

local function parseSimple(node)
    while true do
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
            local field = parseWord()
            local getfield = {
                type   = 'getfield',
                start  = node.start,
                finish = getPosition(LuaOffset - 1, 'right'),
                node   = node,
                dot    = dot,
                field  = field
            }
            node.parent = getfield
            if field then
                field.parent = node
            end
            node = getfield
        elseif nextChar == ':' then
        elseif nextChar == '(' then
            local startPos = getPosition(LuaOffset, 'left')
            local call = {
                type   = 'call',
                start  = node.start,
                node   = node,
            }
            LuaOffset = LuaOffset + 1
            skipSpace()
            local args = parseExpList()
            if getChar(LuaOffset) == ')' then
                LuaOffset = LuaOffset + 1
            else
                missPR()
            end
            if args then
                args.type   = 'callargs'
                args.start  = startPos
                args.finish = getPosition(LuaOffset - 1, 'right')
                args.parent = call
                call.args   = args
            end
            call.finish = getPosition(LuaOffset - 1, 'right')
            node = call
        end
        skipSpace()
    end
    return node
end

local function parseExpUnit()
    local number = parseNumber()
    if number then
        return number
    end

    local word = parseWord()
    if word then
        skipSpace()
        if word.type == 'name' then
            word.type = 'getglobal'
            return parseSimple(word)
        end
        return word
    end

    return nil
end

local function resolveExpUnit(expUnit)
    local tp = expUnit.type
    return expUnit
end

local function resolveExpGetUnit(expList, index)
    local expUnit = expList[index]
    local tp = expUnit.type
    if UnarySymbol[tp] then
        local right, newIndex = resolveExpGetUnit(expList, index + 1)
        if not right then
            -- TODO
            return expUnit, index + 1
        end
        expUnit[1] = right
        return expUnit, newIndex + 1
    end
    if BinarySymbol[tp] then
        -- TODO
        return expUnit, index + 1
    end

    local nextUnit = expList[index + 1]

end

---@param expList parser.guide.object[]
local function resolveExp(expList, index)
    local left
    while true do
        local exp, newIndex = resolveExpGetUnit(expList, index)
    end
    return left
end

function parseExp()
    local firstExpUnit = parseExpUnit()
    if not firstExpUnit then
        return nil
    end

    local secondExpUnit = parseExpUnit()
    if not secondExpUnit then
        return resolveExpUnit(firstExpUnit)
    end

    local expList = {firstExpUnit, secondExpUnit}
    while true do
        local expUnit = parseExpUnit()
        if expUnit then
            expList[#expList+1] = expUnit
        else
            break
        end
    end

    return resolveExp(expList, 1)
end

local function initState(lua, version, options)
    Lua        = lua
    LuaOffset  = 1
    Line       = 0
    LineOffset = 1
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

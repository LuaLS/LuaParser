local sbyte   = string.byte
local sfind   = string.find
local smatch  = string.match
local sgsub   = string.gsub
local ssub    = string.sub
local tconcat = table.concat

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
        if ssub(str, pos, pos) == '-' then
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

local ByteMapSP      = stringToByteMap ' \t'
local ByteMapNL      = stringToByteMap '\r\n'
local ByteMapWordH   = stringToByteMap 'a-zA-Z\x80-\xff_'
local ByteMapWordT   = stringToByteMap 'a-zA-Z0-9\x80-\xff_'
local ByteMapStrSH   = stringToByteMap '\'"'
local ByteMapStrLH   = stringToByteMap '['
local ByteBLR        = sbyte '\r'
local ByteBLN        = sbyte '\n'

local EscMap = {
    ['a'] = '\a',
    ['b'] = '\b',
    ['f'] = '\f',
    ['n'] = '\n',
    ['r'] = '\r',
    ['t'] = '\t',
    ['v'] = '\v',
}

local LineMulti      = 10000

local State, Lua, LuaOffset, Line, LineOffset

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

local function parseNil(parent)
    skipSpace()
    local word, start, finish, newOffset = peekWord()
    if word ~= 'nil' then
        return nil
    end
    LuaOffset = newOffset
    return {
        type   = 'nil',
        start  = start,
        finish = finish,
        parent = parent,
    }
end

local function parseBoolean(parent)
    skipSpace()
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
        parent = parent,
        [1]    = word == 'true' and true or false,
    }
end

local stringPool = {}
local function parseShotString(parent)
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
            parent = parent,
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
        if char == '\\' then
            local nextChar = getChar(offset + 1)
            LuaOffset = offset + 2
            local escChar = EscMap[nextChar]
            if escChar then
                stringPool[stringIndex] = escChar
                stringIndex = stringIndex + 1
            elseif nextChar == mark then
                stringPool[stringIndex] = nextChar
                stringIndex = stringIndex + 1
            elseif nextChar == 'z' then
                skipSpace()
            end
            goto CONTINUE
        end
        if char == mark then
            stringResult = tconcat(stringPool, '', 1, stringIndex - 1)
            LuaOffset = offset + 1
            break
        end
        ::CONTINUE::
        offset, _, char = sfind(Lua, pattern, LuaOffset)
        if not char then
            stringPool[stringIndex] = ssub(Lua, LuaOffset)
            stringResult = tconcat(stringPool, '', 1, stringIndex)
            offset    = #Lua
            LuaOffset = offset + 1
            break
        end
    end
    return {
        type   = 'string',
        start  = startPos,
        finish = getPosition(offset, 'right'),
        parent = parent,
        [1]    = stringResult,
        [2]    = mark,
    }
end

local function parseLongString(parent)
    local start, finish, mark = sfind(Lua, '%[%=*%[', LuaOffset)
    if not mark then
        return nil
    end
    local startPos = getPosition(start, 'left')
    LuaOffset = finish + 1
    skipNL()
    local stringResult
    local finishMark = sgsub(mark, '%[', '%]')
    local finishOffset, markFinishOffset = sfind(Lua, finishMark, LuaOffset, true)
    if finishOffset then
        stringResult = ssub(Lua, LuaOffset, finishOffset - 1)
        LuaOffset = markFinishOffset + 1
    else
        stringResult = ssub(Lua, LuaOffset)
        markFinishOffset = #Lua
        LuaOffset        = markFinishOffset + 1
    end
    return {
        type   = 'string',
        start  = startPos,
        finish = getPosition(markFinishOffset, 'right'),
        parent = parent,
        [1]    = stringResult,
        [2]    = mark,
    }
end

local function parseString(parent)
    skipSpace()
    local b = getByte()
    if ByteMapStrSH[b] then
        return parseShotString(parent)
    end
    if ByteMapStrLH[b] then
        return parseLongString(parent)
    end
    return nil
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
    if     mode == 'Lua' then
    elseif mode == 'Nil' then
        State.ast = parseNil()
    elseif mode == 'Boolean' then
        State.ast = parseBoolean()
    elseif mode == 'String' then
        State.ast = parseString()
    end
    return State
end

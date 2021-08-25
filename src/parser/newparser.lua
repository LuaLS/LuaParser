local sbyte = string.byte
local sfind = string.find
local ssub  = string.sub

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
local ByteBLR        = sbyte '\r'
local ByteBLN        = sbyte '\n'

local LineMulti      = 10000

local State, Lua, LuaOffset, Line, LineOffset

local CachedByte, CachedOffset
local function getByte(offset)
    if not offset then
        offset = LuaOffset
    end
    if CachedOffset ~= offset then
        CachedOffset = offset
        CachedByte = sbyte(Lua, offset, offset)
    end
    return CachedByte
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

local function getWholeWord(word)
    local startOffset = LuaOffset
    local nextOffset  = LuaOffset + #word
    if ssub(Lua, startOffset, nextOffset - 1) ~= word then
        return nil
    end
    local b = getByte(nextOffset)
    if ByteMapWordT[b] then
        return nil
    end
    LuaOffset = nextOffset
    return getPosition(startOffset, 'left')
         , getPosition(nextOffset, 'left')
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
    local start, finish = getWholeWord 'nil'
    if not start then
        return nil
    end
    return {
        type   = 'nil',
        start  = start,
        finish = finish,
        parent = parent,
    }
end

local function initState(lua, version, options)
    Lua        = lua
    LuaOffset  = 1
    Line       = 0
    LineOffset = 1
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
    end
    return State
end

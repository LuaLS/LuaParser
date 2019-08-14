local fs = require 'bee.filesystem'

local table_sort = table.sort
local string_rep = string.rep
local type = type
local pairs = pairs
local ipairs = ipairs
local math_type = math.type
local next = next
local rawset = rawset
local move = table.move
local setmetatable = setmetatable
local tableSort = table.sort
local mathType = math.type

local function formatNumber(n)
    local str = ('%.10f'):format(n)
    str = str:gsub('%.?0*$', '')
    return str
end

local TAB = setmetatable({}, { __index = function (self, n)
    self[n] = string_rep('\t', n)
    return self[n]
end})

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
    ['goto']     = true,
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

function table.dump(tbl)
    if type(tbl) ~= 'table' then
        return ('%q'):format(tbl)
    end
    local lines = {}
    local mark = {}
    lines[#lines+1] = '{'
    local function unpack(tbl, tab)
        if tab > 10 and mark[tbl] then
            lines[#lines+1] = TAB[tab+1] .. '"<Loop>"'
            return
        end
        mark[tbl] = true
        local keys = {}
        local keymap = {}
        local integerFormat = '[%d]'
        local notInterger = false
        local keyLen = 0
        if #tbl >= 10 then
            local width = math.log(#tbl, 10)
            integerFormat = ('[%%0%dd]'):format(math.ceil(width))
        end
        for key in pairs(tbl) do
            if type(key) == 'string' then
                if not key:match('^[%a_][%w_]*$')
                or #key >= 32
                or RESERVED[key]
                then
                    keymap[key] = ('[%q]'):format(key)
                else
                    keymap[key] = key
                end
                notInterger = true
            elseif mathType(key) == 'integer' then
                keymap[key] = integerFormat:format(key)
            else
                keymap[key] = ('["<%s>"]'):format(key)
                notInterger = true
            end
            keys[#keys+1] = key
            if #keymap[key] > keyLen then
                keyLen = #keymap[key]
            end
        end
        local mt = getmetatable(tbl)
        if not mt or not mt.__pairs then
            if notInterger then
                tableSort(keys, function (a, b)
                    return keymap[a] > keymap[b]
                end)
            else
                tableSort(keys, function (a, b)
                    return keymap[a] < keymap[b]
                end)
            end
        end
        for _, key in ipairs(keys) do
            local value = tbl[key]
            local tp = type(value)
            local keyStr = keymap[key]
            if #keyStr < keyLen then
                keyStr = keyStr .. (' '):rep(keyLen - #keyStr)
            end
            if tp == 'table' then
                lines[#lines+1] = ('%s%s = {'):format(TAB[tab+1], keyStr)
                unpack(value, tab+1)
                lines[#lines+1] = ('%s},'):format(TAB[tab+1])
            elseif tp == 'string' or tp == 'boolean' then
                lines[#lines+1] = ('%s%s = %q,'):format(TAB[tab+1], keyStr, value)
            elseif tp == 'number' then
                lines[#lines+1] = ('%s%s = %s,'):format(TAB[tab+1], keyStr, formatNumber(value))
            elseif tp == 'nil' then
            else
                lines[#lines+1] = ('%s%s = %s,'):format(TAB[tab+1], keyStr, tostring(value))
            end
        end
    end
    unpack(tbl, 0)
    lines[#lines+1] = '}'
    return table.concat(lines, '\r\n')
end

local function sort_table(tbl)
    if not tbl then
        tbl = {}
    end
    local mt = {}
    local keys = {}
    local mark = {}
    local n = 0
    for key in next, tbl do
        n=n+1;keys[n] = key
        mark[key] = true
    end
    table_sort(keys)
    function mt:__newindex(key, value)
        rawset(self, key, value)
        n=n+1;keys[n] = key
        mark[key] = true
        if type(value) == 'table' then
            sort_table(value)
        end
    end
    function mt:__pairs()
        local list = {}
        local m = 0
        for key in next, self do
            if not mark[key] then
                m=m+1;list[m] = key
            end
        end
        if m > 0 then
            move(keys, 1, n, m+1)
            table_sort(list)
            for i = 1, m do
                local key = list[i]
                keys[i] = key
                mark[key] = true
            end
            n = n + m
        end
        local i = 0
        return function ()
            i = i + 1
            local key = keys[i]
            return key, self[key]
        end
    end

    return setmetatable(tbl, mt)
end

function table.container(tbl)
    return sort_table(tbl)
end

function table.equal(a, b)
    local tp1, tp2 = type(a), type(b)
    if tp1 ~= tp2 then
        return false
    end
    if tp1 == 'table' then
        local mark = {}
        for k in pairs(a) do
            if not table.equal(a[k], b[k]) then
                return false
            end
            mark[k] = true
        end
        for k in pairs(b) do
            if not mark[k] then
                return false
            end
        end
        return true
    end
    return a == b
end

function table.deepCopy(a)
    local t = {}
    for k, v in pairs(a) do
        if type(v) == 'table' then
            t[k] = table.deepCopy(v)
        else
            t[k] = v
        end
    end
    return t
end

function io.load(file_path)
    local f, e = io.open(file_path:string(), 'rb')
    if not f then
        return nil, e
    end
    if f:read(3) ~= '\xEF\xBB\xBF' then
        f:seek("set")
    end
    local buf = f:read 'a'
    f:close()
    return buf
end

function io.save(file_path, content)
    local f, e = io.open(file_path:string(), "wb")

    if f then
        f:write(content)
        f:close()
        return true
    else
        return false, e
    end
end

function io.scan(path)
    local result = {path}
    local i = 0
    return function ()
        i = i + 1
        local current = result[i]
        if not current then
            return nil
        end
        if fs.is_directory(current) then
            for path in current:list_directory() do
                result[#result+1] = path
            end
        end
        return current
    end
end

local guide = require 'parser.guide'
local parser = require 'parser'

rawset(_G, 'TEST', true)

local function founded(targets, results)
    if #targets ~= #results then
        return false
    end
    for _, target in ipairs(targets) do
        for _, result in ipairs(results) do
            if target[1] == result[1] and target[2] == result[2] then
                goto NEXT
            end
        end
        do return false end
        ::NEXT::
    end
    return true
end

local accept = {
    ['local']       = true,
    ['setlocal']    = true,
    ['getlocal']    = true,
    ['label']       = true,
    ['goto']        = true,
    ['field']       = true,
    ['method']      = true,
    ['setindex']    = true,
    ['getindex']    = true,
    ['tableindex']  = true,
    ['setglobal']   = true,
    ['getglobal']   = true,
    ['function']    = true,
}

local function find_source(str, pos)
    local len = 999
    local result
    local ast = parser:compile(str)
    guide.eachSourceContain(ast.ast, pos, function (source)
        if source.finish - source.start < len and accept[source.type] then
            result = source
            len = source.finish - source.start
        end
    end)
    assert(result)
    return result
end

function TEST(script)
    return function (target)
        local start  = script:find('<?', 1, true)
        local finish = script:find('?>', 1, true)
        local pos = (start + finish) // 2 + 1
        local new_script = script:gsub('<[!?]', '  '):gsub('[!?]>', '  ')
        local source = find_source(new_script, pos)

        local results = guide.requestFields(source)
        if results then
            local names = {}
            for i, result in ipairs(results) do
                names[i] = guide.getName(result)
            end
            assert(founded(target, names))
        else
            assert(#target == 0)
        end
    end
end

TEST [[
local <?t?> = {
    a = 1,
    b = 2,
    c = 3,
}
]]
{'a', 'b', 'c'}

TEST [[
local <?t?> = setmetatable({
    a = 1,
    b = 2,
    c = 3,
})
]]
{'a', 'b', 'c'}

TEST [[
local mt = {
    a = 1,
    b = 2,
    c = 3,
}
local <?t?> = setmetatable({}, {__index = mt})
]]
{'a', 'b', 'c'}

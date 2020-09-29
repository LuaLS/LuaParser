local guide = require 'parser.guide'
local parser = require 'parser'

rawset(_G, 'TEST', true)

local function catch_target(script)
    local list = {}
    local cur = 1
    while true do
        local start, finish  = script:find('<!.-!>', cur)
        if not start then
            break
        end
        list[#list+1] = { start + 2, finish - 2 }
        cur = finish + 1
    end
    return list
end

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
    local target = catch_target(script)
    local start  = script:find('<?', 1, true)
    local finish = script:find('?>', 1, true)
    local pos = (start + finish) // 2 + 1
    local new_script = script:gsub('<[!?]', '  '):gsub('[!?]>', '  ')
    local source = find_source(new_script, pos)

    local results = guide.requestDefinition(source)
    if results then
        local positions = {}
        for i, result in ipairs(results) do
            positions[i] = { result.start, result.finish }
        end
        assert(founded(target, positions))
    else
        assert(#target == 0)
    end
end

require 'guide.definition.local'
require 'guide.definition.set'
require 'guide.definition.arg'
require 'guide.definition.function'
require 'guide.definition.table'
require 'guide.definition.method'
require 'guide.definition.label'
require 'guide.definition.call'
require 'guide.definition.bug'
require 'guide.definition.special'

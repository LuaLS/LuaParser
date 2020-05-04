local guide = require 'parser.guide'
local parser = require 'parser'

rawset(_G, 'TEST', true)

local function catch_target(script)
    local list = {}
    local cur = 1
    while true do
        local start, finish  = script:find('<[?!].-[!?]>', cur)
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

local function find_source(str, pos)
    local len = 999
    local result
    local ast = parser:compile(str)
    guide.eachSourceContain(ast.ast, pos, function (source)
        if source.finish - source.start < len then
            result = source
            len = source.finish - source.start
        end
    end)
    return result
end

function TEST(script)
    local target = catch_target(script)
    local start  = script:find('<?', 1, true)
    local finish = script:find('?>', 1, true)
    local pos = (start + finish) // 2 + 1
    local new_script = script:gsub('<[!?]', '  '):gsub('[!?]>', '  ')
    local source = find_source(new_script, pos)

    local results = guide.getStepRef(source)
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

TEST [[
local <!x!> = 1
print(<?x?>)
]]

TEST [[
local <!x!> = 1
<!x!> = 2
print(<?x?>)
<!x!> = 3
]]

TEST [[
::<!TAG!>::
goto <?TAG?>
]]

TEST [[
<!x!> = 1
print(<?x?>)
]]

TEST [[
<!x!> = 1
print(<?x?>)
]]

TEST [[
p = 1
print(<?_ENV?>)
]]

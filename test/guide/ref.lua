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

    local results = guide.getRef(guide.frame(), source)
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
local <?a?> = 1
<!a!> = <!a!>
]]

TEST [[
<?a?> = 1
<!a!> = <!a!>
]]

TEST [[
local t
t.<?a?> = 1
t.<!a!> = t.<!a!>
]]

TEST [[
t.<?a?> = 1
t.<!a!> = t.<!a!>
]]

TEST [[
:: <!LABEL!> ::
goto <?LABEL?>
if true then
    goto <!LABEL!>
end
]]

TEST [[
:: <?LABEL?> ::
goto <!LABEL!>
if true then
    goto <!LABEL!>
end
]]

TEST [[
local a = 1
local <?a?> = 1
<!a!> = <!a!>
]]

TEST [[
local t = {
    <!a!> = 1
}
print(t.<?a?>)
]]

do return end
TEST [[
local t = {
    <?a?> = 1
}
print(t.<!a!>)
]]

TEST [[
local t = {
    [<?'a'?>] = 1
}
print(t.<!a!>)
]]

--TEST [[
--local <!mt!> = {}
--function <!mt!>:a()
--    <?self?>:remove()
--end
--]]

TEST [[
local function f()
    return <~function~> ()
    end
end

local <!f2!> = f()
]]

TEST [[
local function f()
    return nil, <~function~> ()
    end
end

local _, <!f2!> = f()
]]

TEST [[
table.<!dump!>()
function table.<?dump?>()
end
]]

TEST [[
local mt = {}
local <?obj?> = setmetatable({}, mt)
]]

TEST [[
local mt = {}
mt.x = 1
local obj = setmetatable({}, mt)
print(obj.<?x?>)
]]

TEST [[
local x
local function f()
    return x
end
local <?y?> = f()
]]

TEST [[
local <?x?>
local function f()
    return <!x!>
end
local y = f()
]]

TEST [[
local x
local function f()
    return function ()
        return x
    end
end
local <?y?> = f()()
]]

TEST [[
local <?x?>
local function f()
    return function ()
        return <!x!>
    end
end
local y = f()()
]]

TEST [[
local mt = {}
mt.__index = mt

function mt:add(a, b)
end

local function init()
    return setmetatable({}, mt)
end

local <!t!> = init()
<?t?>:add()
]]

TEST [[
local mt = {}
mt.__index = mt

function mt:add(a, b)
end

local function init()
    return setmetatable({}, mt)
end

local t = init()
t:<?add?>()
]]

TEST [[
local t = {}
t.<?x?> = 1
t[a.b.x] = 1
]]

--TEST [[
--local t = {}
--t.x = 1
--t[a.b.<?x?>] = 1
--]]

TEST [[
local t
local f = t.<?f?>

f()

return {
    f = f,
}
]]

TEST [[
self = {
    results = {
        <?labels?> = {},
    }
}
self[self.results.<!labels!>] = lbl
]]

TEST [[
a.b.<?c?> = 1
print(a.b.<!c!>)
]]

--TEST [[
-----@class <!Class!>
-----@type <?Class?>
-----@type <!Class!>
--]]
--
--TEST [[
-----@class <?Class?>
-----@type <!Class!>
-----@type <!Class!>
--]]

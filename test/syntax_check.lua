local parser = require 'parser'

local EXISTS = {}

local function eq(a, b)
    if a == EXISTS and b ~= nil then
        return true
    end
    local tp1, tp2 = type(a), type(b)
    if tp1 ~= tp2 then
        return false
    end
    if tp1 == 'table' then
        local mark = {}
        for k in pairs(a) do
            if not eq(a[k], b[k]) then
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

local function catchTarget(script, sep)
    local list = {}
    local cur = 1
    local cut = 0
    while true do
        local start, finish  = script:find(('<%%%s.-%%%s>'):format(sep, sep), cur)
        if not start then
            break
        end
        list[#list+1] = { start - cut, math.max(start - cut, finish - 4 - cut) }
        cur = finish + 1
        cut = cut + 4
    end
    local new_script = script:gsub(('<%%%s(.-)%%%s>'):format(sep, sep), '%1')
    return new_script, list
end

local Version

local function TEST(script)
    return function (expect)
        local newScript, list = catchTarget(script, '!')
        local ast, errs = parser:compile(newScript, 'lua', Version)
        assert(ast)
        assert(errs)
        local first = errs[1]
        local target = list[1]
        if not expect then
            assert(#errs == 0)
            return
        end
        if expect.multi then
            assert(#errs > 1)
            first = errs[expect.multi]
        else
            assert(#errs == 1)
        end
        assert(first)
        assert(first.type == expect.type)
        assert(first.start == target[1])
        assert(first.finish == target[2])
        assert(eq(first.version, expect.version))
        assert(eq(first.info, expect.info))
    end
end

TEST[[
function f()
    return <!...!>
end
]]
{
    type = 'UNEXPECT_DOTS',
}

TEST[[
function f(...)
    return function ()
        return <!...!>
    end
end
]]
{
    type = 'UNEXPECT_DOTS',
}

TEST[[
function f(...)
    return ...
end
]]
(nil)

TEST[[
for i = 1, 10 do
    break
end
]]
(nil)

TEST[[
for k, v in pairs(t) do
    break
end
]]
(nil)

TEST[[
while true do
    break
end
]]
(nil)

TEST[[
repeat
    break
until true
]]
(nil)

TEST[[
<!break!>
]]
{
    type = 'BREAK_OUTSIDE',
}

TEST[[
function f (x)
    if 1 then <!break!> end
end
]]
{
    type = 'BREAK_OUTSIDE',
}

TEST[[
while 1 do
end
<!break!>
]]
{
    type = 'BREAK_OUTSIDE',
}

TEST[[
while 1 do
    local function f()
        <!break!>
    end
end
]]
{
    type = 'BREAK_OUTSIDE',
}

TEST[[
:: label :: <!return
goto!> label
]]
{
    type = 'ACTION_AFTER_RETURN',
    multi = 3,
}

TEST[[
::label::
goto label
]]
(nil)

TEST[[
goto label
::label::
]]
(nil)

TEST[[
do
    goto label
end
::label::
]]
(nil)

TEST[[
::label::
do
    goto label
end
]]
(nil)

TEST[[
goto label
local x = 1
x = 2
::label::
]]
(nil)

TEST[[
local x = 1
goto label
x = 2
::label::
print(x)
]]
(nil)

TEST[[
local x = 1
::label::
print(x)
local x
goto label
]]
(nil)

TEST[[
goto <!label!>
]]
{
    type = 'NO_VISIBLE_LABEL',
    info = {
        label = 'label',
    }
}

TEST[[
::other_label::
do do do goto <!label!> end end end
]]
{
    type = 'NO_VISIBLE_LABEL',
    info = {
        label = 'label',
    }
}

TEST[[
goto <!label!>
do
    ::label::
end
]]
{
    type = 'NO_VISIBLE_LABEL',
    info = {
        label = 'label',
    }
}

TEST[[
goto <!label!>
local x = 1
::label::
x = 2
]]
{
    type = 'JUMP_LOCAL_SCOPE',
    info = {
        loc = 'x',
    },
    relative = {
        {
            start = 26,
            finish = 30,
        },
        {
            start = 18,
            finish = 18,
        },
    }
}

TEST[[
goto <!label!>
local x = 1
::label::
return x
]]
{
    type = 'JUMP_LOCAL_SCOPE',
    info = {
        loc = 'x',
    },
    relative = {
        {
            start = 26,
            finish = 30,
        },
        {
            start = 18,
            finish = 18,
        },
    }
}

do return end

TEST[[
::<!label!>::
::label::
do
    ::label::
end
]]
{
    type = 'REDEFINED_LABEL',
    relative = {
        {
            start = 3,
            finish = 7,
        },
        {
            start = 13,
            finish = 17,
        },
        {
            start = 30,
            finish = 34,
        },
    }
}

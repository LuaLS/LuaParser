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

local function TEST(script)
    return function (expect)
        local newScript, list = catchTarget(script, '!')
        local ast, errs = parser:ast(newScript)
        assert(ast)
        assert(errs)
        local first = errs[1]
        local target = list[1]
        assert(#errs == 1)
        assert(first)
        assert(first.type == expect.type)
        assert(first.start == target[1])
        assert(first.finish == target[2])
        assert(eq(first.info, expect.info))
    end
end

TEST[[
local<! !>
]]
{
    type = 'MISS_NAME',
}

TEST[[
<!？？？!>
]]
{
    type = 'UNKNOWN_SYMBOL',
    info = {
        symbol = '？？？',
    }
}

TEST[[
n = 1<!a!>
]]
{
    type = 'UNKNOWN_SYMBOL',
    info = {
        symbol = 'a',
    }
}

TEST[[
s = 'a<!!>
]]
{
    type = 'MISS_SYMBOL',
    info = {
        symbol = "'",
    }
}

TEST[[
s = "a<!!>
]]
{
    type = 'MISS_SYMBOL',
    info = {
        symbol = '"',
    }
}

TEST[======[
s = [[a<!!>]======]
{
    type = 'MISS_SYMBOL',
    info = {
        symbol = ']]',
    }
}

TEST[======[
s = [===[a<!!>]======]
{
    type = 'MISS_SYMBOL',
    info = {
        symbol = ']===]',
    }
}

TEST[[
s = '<!\xzz!>zzz'
]]
{
    type = 'MISS_ESC_X',
}

TEST[[
s = '\u<!!>'
]]
{
    type = 'MISS_SYMBOL',
    info = {
        symbol = '{'
    }
}

TEST[[
s = '<!\u{}!>'
]]
{
    type = 'UTF8_SMALL',
}

TEST[[
s = '<!\u{111111111}!>'
]]
{
    type = 'UTF8_MAX',
    info = {
        min = '000000',
        max = '10ffff',
    }
}

TEST[[
s = '<!\u{ffffff}!>'
]]
{
    type = 'UTF8_MAX',
    info = {
        min = '000000',
        max = '10ffff',
    }
}

TEST[[
s = '\u{aaa<!'!>
]]
{
    type = 'MISS_SYMBOL',
    info = {
        symbol = '}',
    }
}

TEST[[
s = '\u{abc<!z!>}'
]]
{
    type = 'MUST_X16',
}

TEST[[
s = '<!\c!>'
]]
{
    type = 'ERR_ESC',
}

TEST[[
n = 0x<!!>
]]
{
    type = 'MUST_X16'
}

TEST[[
n = 0x<!zzzz!>
]]
{
    type = 'MUST_X16'
}


TEST[[
n = 0x.<!zzzz!>
]]
{
    type = 'MUST_X16'
}

TEST[[
t = {<!!>
]]
{
    type = 'MISS_SYMBOL',
    info = {
        symbol = '}',
    }
}

TEST[[
t = {1<!!>
]]
{
    type = 'MISS_SYMBOL',
    info = {
        symbol = '}',
    }
}

TEST[[
t = {1,<!!>
]]
{
    type = 'MISS_SYMBOL',
    info = {
        symbol = '}',
    }
}

TEST[[
t = {name =<!!>}
]]
{
    type = 'MISS_EXP',
}

TEST[[
t = {['name'] =<!!>}
]]
{
    type = 'MISS_EXP',
}

TEST[[
t = {['name']<!!>}
]]
{
    type = 'MISS_SYMBOL',
    info = {
        symbol = '=',
    }
}

TEST[[
t = {['name'<! !>= 1}
]]
{
    type = 'MISS_SYMBOL',
    info = {
        symbol = ']',
    }
}

TEST[[
t = {[<!!>]=1}
]]
{
    type = 'MISS_EXP',
}

TEST[[
t = {<!!>,}
]]
{
    type = 'MISS_EXP',
}

TEST[[
t = {1<! !>2}
]]
{
    type = 'MISS_SYMBOL',
    info = {
        symbol = ',',
    }
}

TEST[[
f(<!!>
]]
{
    type = 'MISS_SYMBOL',
    info = {
        symbol = ')',
    },
}

TEST[[
f(<!!>,1)
]]
{
    type = 'MISS_EXP',
}

TEST[[
f(1,<!!>)
]]
{
    type = 'MISS_EXP',
}

TEST[[
f(1<! !>1)
]]
{
    type = 'MISS_SYMBOL',
    info = {
        symbol = ',',
    },
}

TEST[[
(<!!>).x()
]]
{
    type = 'MISS_EXP',
}

TEST[[
(x<!!> = 1
]]
{
    type = 'MISS_SYMBOL',
    info = {
        symbol = ')',
    }
}

TEST[[
x.<!!>()
]]
{
    type = 'MISS_FIELD',
}

TEST[[
x:<!!>()
]]
{
    type = 'MISS_METHOD',
}

TEST[[
x[<!!>] = 1
]]
{
    type = 'MISS_EXP',
}

TEST[[
x[1<!!> = 1
]]
{
    type = 'MISS_SYMBOL',
    info = {
        symbol = ']',
    }
}

TEST[[
x:m<!!>
]]
{
    type = 'MISS_SYMBOL',
    info = {
        symbol = '(',
    }
}

TEST[[
x = 1 and<!!>
]]
{
    type = 'MISS_EXP',
}

TEST[[
x = #<!!>
]]
{
    type = 'MISS_EXP',
}

TEST[[
local x = 1,<!!>
]]
{
    type = 'MISS_EXP',
}

TEST[[
local x,<!!> = 1, 2
]]
{
    type = 'MISS_NAME',
}

TEST[[
::<!!>
]]
{
    type = 'MISS_NAME',
}

TEST[[
::LABEL<!!>
]]
{
    type = 'MISS_SYMBOL',
    info = {
        symbol = '::',
    }
}

TEST[[
goto<!!>
]]
{
    type = 'MISS_NAME',
}

TEST[[
return 1,<!!>
]]
{
    type = 'MISS_EXP',
}

TEST[[
local function<!!>() end
]]
{
    type = 'MISS_NAME',
}

TEST[[
function<!!>() end
]]
{
    type = 'MISS_NAME',
}

TEST[[
function f(<!!>
]]
{
    type = 'MISS_SYMBOL',
    info = {
        symbol = ')',
    }
}

TEST[[
function f<!!> end
]]
{
    type = 'MISS_SYMBOL',
    info = {
        symbol = '(',
    }
}

TEST[[
f = function (<!!>
]]
{
    type = 'MISS_SYMBOL',
    info = {
        symbol = ')',
    }
}

TEST[[
f = function<!!> end
]]
{
    type = 'MISS_SYMBOL',
    info = {
        symbol = '(',
    }
}

TEST[[
f = function<!!> f() end
]]
{
    type = 'MISS_SYMBOL',
    info = {
        symbol = '(',
    }
}

TEST[[
function f()<!!>
]]
{
    type = 'MISS_SYMBOL',
    info = {
        symbol = 'end',
    }
}

TEST[[
function f:<!!>() end
]]
{
    type = 'MISS_METHOD',
}

TEST[[
function f:x<!.!>y() end
]]
{
    type = 'MISS_SYMBOL',
    info = {
        symbol = '(',
    }
}

TEST[[
function f(a,<!!>) end
]]
{
    type = 'MISS_NAME',
}

TEST[[
function f(<!!>,a) end
]]
{
    type = 'MISS_NAME',
}

TEST[[
function f(...<!, a!>) end
]]
{
    type = 'ARGS_AFTER_DOTS',
}

TEST[[
local x = <!!>]]
{
    type = 'MISS_EXP',
}

TEST[[
x = <!!>]]
{
    type = 'MISS_EXP',
}

TEST[[
for<!!> in next do
end
]]
{
    type = 'MISS_NAME',
}

TEST[[
for k, v<!!> next do
end
]]
{
    type = 'MISS_SYMBOL',
    info = {
        symbol = 'in',
    }
}

TEST[[
for k, v in <!!>do
end
]]
{
    type = 'MISS_EXP',
}

TEST[[
for k, v in next<!!>
end
]]
{
    type = 'MISS_SYMBOL',
    info = {
        symbol = 'do',
    }
}

TEST[[
for k, v in next do<!!>
]]
{
    type = 'MISS_SYMBOL',
    info = {
        symbol = 'end',
    }
}

TEST[[
for i =<!!>, 2 do
end
]]
{
    type = 'MISS_EXP',
}

TEST[[
for<!!> = 1, 2 do
end
]]
{
    type = 'MISS_NAME',
}

TEST[[
for i = 1<!!> do
end
]]
{
    type = 'MISS_SYMBOL',
    info = {
        symbol = ',',
    }
}

TEST[[
for i = 1,<!!> do
end
]]
{
    type = 'MISS_EXP',
}

TEST[[
for i = 1, 2,<!!> do
end
]]
{
    type = 'MISS_EXP',
}

TEST[[
for i = 1, 2<!!> 3 do
end
]]
{
    type = 'MISS_SYMBOL',
    info = {
        symbol = ',',
    }
}

TEST[[
for i = 1, 2<!!>
end
]]
{
    type = 'MISS_SYMBOL',
    info = {
        symbol = 'do',
    }
}

TEST[[
for i = 1, 2 do<!!>
]]
{
    type = 'MISS_SYMBOL',
    info = {
        symbol = 'end',
    }
}

TEST[[
while<!!> do
end
]]
{
    type = 'MISS_EXP',
}

TEST[[
while true<!!>
end
]]
{
    type = 'MISS_SYMBOL',
    info = {
        symbol = 'do',
    }
}

TEST[[
while true do<!!>
]]
{
    type = 'MISS_SYMBOL',
    info = {
        symbol = 'end',
    }
}

TEST[[
repeat
until<!!>
]]
{
    type = 'MISS_EXP',
}

TEST[[
repeat<!!>
]]
{
    type = 'MISS_SYMBOL',
    info = {
        symbol = 'until',
    }
}

TEST[[
if<!!> then
end
]]
{
    type = 'MISS_EXP',
}

TEST[[
if true<!!>
end
]]
{
    type = 'MISS_SYMBOL',
    info = {
        symbol = 'then',
    }
}

TEST[[
if true then<!!>
]]
{
    type = 'MISS_SYMBOL',
    info = {
        symbol = 'end',
    }
}

TEST[[
if true then
else<!!>
]]
{
    type = 'MISS_SYMBOL',
    info = {
        symbol = 'end',
    }
}

TEST[[
if true then
elseif<!!>
end
]]
{
    type = 'MISS_EXP',
}

TEST[[
if true then
elseif true<!!>
end
]]
{
    type = 'MISS_SYMBOL',
    info = {
        symbol = 'then',
    }
}

TEST[[
<!1 == 2!>
]]
{
    type = 'EXP_IN_ACTION',
}

-- 以下测试来自 https://github.com/andremm/lua-parser/blob/master/test.lua
TEST[[
f = 9<!e!>
]]
{
    type = 'MISS_EXPONENT'
}
TEST[[
f = 5.<!e!>
]]
{
    type = 'MISS_EXPONENT'
}
TEST[[
f = .9<!e-!>
]]
{
    type = 'MISS_EXPONENT'
}
TEST[[
f = 5.9<!e+!>
]]
{
    type = 'MISS_EXPONENT'
}

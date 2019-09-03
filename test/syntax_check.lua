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
        local ast, errs = parser:parse(newScript, 'lua', Version)
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

Version = 'Lua 5.3'

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

TEST[======[
s = [===[a<!]=]!>]======]
{
    multi = 1,
    type = 'ERR_LSTRING_END',
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
        max = '10FFFF',
    }
}

TEST[[
s = '<!\u{ffffff}!>'
]]
{
    type = 'UTF8_MAX',
    version = 'Lua 5.4',
    info = {
        min = '000000',
        max = '10FFFF',
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
    type = 'MUST_X16',
    multi = 1,
}

TEST[[
n = 0x<!zzzz!>
]]
{
    type = 'MUST_X16',
    multi = 1,
}


TEST[[
n = 0x.<!zzzz!>
]]
{
    type = 'MUST_X16',
    multi = 1,
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
    type = 'MISS_SEP_IN_TABLE',
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
print(x<!!>
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
y = x[1<!!>
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
    multi = 1,
    type = 'MISS_SYMBOL',
    info = {
        symbol = 'end',
        related = {1, 8},
    }
}

TEST[[
<!function!> f()
]]
{
    multi = 2,
    type = 'MISS_END',
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
    multi = 1,
    type = 'MISS_SYMBOL',
    info = {
        symbol = 'end',
        related = {1, 3},
    }
}

TEST[[
<!for!> k, v in next do
]]
{
    multi = 2,
    type = 'MISS_END',
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
    multi = 1,
    type = 'MISS_SYMBOL',
    info = {
        symbol = 'end',
        related = {1, 3},
    }
}

TEST[[
<!for!> i = 1, 2 do
]]
{
    multi = 2,
    type = 'MISS_END',
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
    multi = 1,
    type = 'MISS_SYMBOL',
    info = {
        symbol = 'end',
        related = {1, 5},
    }
}

TEST[[
<!while!> true do
]]
{
    multi = 2,
    type = 'MISS_END',
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
    multi = 1,
    type = 'MISS_SYMBOL',
    info = {
        symbol = 'end',
        related = {1, 2},
    }
}

TEST[[
<!if!> true then
]]
{
    multi = 2,
    type = 'MISS_END',
}

TEST[[
if true then
else<!!>
]]
{
    multi = 1,
    type = 'MISS_SYMBOL',
    info = {
        symbol = 'end',
        related = {1, 2},
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

TEST[[
<!a!>
]]
{
    type = 'EXP_IN_ACTION',
}

TEST[[
<!a.b!>
]]
{
    type = 'EXP_IN_ACTION',
}

TEST[[
<!a.b[1]!>
]]
{
    type = 'EXP_IN_ACTION',
}

TEST[[
<!!>else
end
]]
{
    type = 'MISS_SYMBOL',
    info = {
        symbol = 'if',
    }
}

TEST[[
<!!>elseif true then
end
]]
{
    type = 'MISS_SYMBOL',
    info = {
        symbol = 'if',
    }
}

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
<!//!>xxxx
]]
{
    type = 'ERR_COMMENT_PREFIX',
    fix  = EXISTS,
}

TEST[[
<!/*
adadasd
*/!>
]]
{
    type = 'ERR_C_LONG_COMMENT',
    fix  = EXISTS,
}

TEST[[
a <!==!> b
]]
{
    type = 'ERR_ASSIGN_AS_EQ',
    fix  = EXISTS,
}

TEST[[
_VERSION <!==!> 1
]]
{
    type = 'ERR_ASSIGN_AS_EQ',
    fix  = EXISTS,
}

TEST[[
return a <!=!> b
]]
{
    type = 'ERR_EQ_AS_ASSIGN',
    fix  = EXISTS,
}

TEST[[
return a <!!=!> b
]]
{
    type = 'ERR_UEQ',
    fix  = EXISTS,
}

TEST[[
if a <!do!> end
]]
{
    type = 'ERR_THEN_AS_DO',
    fix  = EXISTS,
}

TEST[[
while true <!then!> end
]]
{
    type = 'ERR_DO_AS_THEN',
    fix  = EXISTS,
}

TEST[[
return {
    _VERSION = '',
}
]]
(nil)

TEST[[
return {
    _VERSION == '',
}
]]
(nil)

-- 以下测试来自 https://github.com/andremm/lua-parser/blob/master/test.lua
TEST[[
f = 9<!e!>
]]
{
    type = 'MISS_EXPONENT',
    multi = 1,
}

TEST[[
f = 5.<!e!>
]]
{
    type = 'MISS_EXPONENT',
    multi = 1,
}

TEST[[
f = .9<!e-!>
]]
{
    type = 'MISS_EXPONENT',
    multi = 1,
}

TEST[[
f = 5.9<!e+!>
]]
{
    type = 'MISS_EXPONENT',
    multi = 1,
}

TEST[[
hex = 0x<!G!>
]]
{
    type = 'MUST_X16',
    multi = 1,
}

TEST[=============[
--[==[
testing long string3 begin
]==]

ls3 = [===[
testing
unfinised
long string
]==]

--[==[
[[ testing long string3 end ]]
]==]
<!!>]=============]
{
    multi = 2,
    type = 'MISS_SYMBOL',
    info = {
        symbol = ']===]',
    }
}

TEST[[
-- short string test begin

ss6 = "testing unfinished string<!!>

-- short string test end
]]
{
    type = 'MISS_SYMBOL',
    info = {
        symbol = '"'
    }
}

TEST[[
-- short string test begin

ss7 = 'testing \\<!!>
unfinished \\
string'

-- short string test end
]]
{
    type = 'MISS_SYMBOL',
    info = {
        symbol = "'",
    },
    multi = 1,
}

TEST[[
--[[ testing
unfinished
comment
<!!>]]
{
    type = 'MISS_SYMBOL',
    info = {
        symbol = ']]',
    }
}

TEST[[
--[=[xxx<!]==]!>
]]
{
    multi = 1,
    type = 'ERR_LCOMMENT_END',
    info = {
        symbol = ']=]',
    },
    fix  = EXISTS,
}

TEST[[
a = function (a,b,<!!>) end
]]
{
    type = 'MISS_NAME',
}

TEST[[
a = function (...<!,a!>) end
]]
{
    type = 'ARGS_AFTER_DOTS',
}

TEST[[
local a = function (<!!>1) end
]]
{
    type = 'MISS_SYMBOL',
    info = {
        symbol = ')',
    },
    multi = 1,
}

TEST[[
local test = function ( a , b , c , ... )<!!>
]]
{
    multi = 1,
    type = 'MISS_SYMBOL',
    info = {
        symbol = 'end',
        related = {14, 21},
    }
}

TEST[[
local test = <!function!> ( a , b , c , ... )
]]
{
    multi = 2,
    type = 'MISS_END',
}

TEST[[
a = 3 /<!!> / 2
]]
{
    type = 'MISS_EXP',
}

TEST[[
b = 1 &<!!>& 1
]]
{
    type = 'MISS_EXP',
}

TEST[[
b = 1 <<!!>> 0
]]
{
    type = 'MISS_EXP',
}

TEST[[
b = 1 <<!!> < 0
]]
{
    type = 'MISS_EXP',
}

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
concat2 = 2^<!3..1!>
]]
{
    type = 'MALFORMED_NUMBER',
}

TEST[[
for k<!!>;v in pairs(t) do end
]]
{
    type = 'MISS_SYMBOL',
    info = {
        symbol = 'in',
    },
    multi = 1,
}

TEST[[
for k,v in pairs(t:any<!!>) do end
]]
{
    type = 'MISS_SYMBOL',
    info = {
        symbol = '(',
    },
}

TEST[[
for i=1,10,<!!> do end
]]
{
    type = 'MISS_EXP',
}

TEST[[
for i=1,n:number<!!> do end
]]
{
    type = 'MISS_SYMBOL',
    info = {
        symbol = '(',
    },
}

TEST[[
function func(a,b,c,<!!>) end
]]
{
    type = 'MISS_NAME',
}

TEST[[
function func(...<!,a!>) end
]]
{
    type = 'ARGS_AFTER_DOTS'
}

TEST[[
function a.b:c<!!>:d () end
]]
{
    type = 'MISS_SYMBOL',
    info = {
        symbol = '(',
    }
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
if a then<!!>
]]
{
    multi = 1,
    type = 'MISS_SYMBOL',
    info = {
        symbol = 'end',
        related = {1, 2},
    }
}

TEST[[
<!if!> a then
]]
{
    multi = 2,
    type = 'MISS_END',
}

TEST[[
if a then else<!!>
]]
{
    multi = 1,
    type = 'MISS_SYMBOL',
    info = {
        symbol = 'end',
        related = {1, 2},
    }
}

TEST[[
<!if!> a then else
]]
{
    multi = 2,
    type = 'MISS_END',
}

TEST[[
if a then
    return a
elseif b then
    return b
elseif<!!>
    
end
]]
{
    type = 'MISS_EXP',
}

TEST[[
if a:any<!!> then else end
]]
{
    type = 'MISS_SYMBOL',
    info = {
        symbol = '(',
    }
}

TEST[[
:: blah ::
:: <!not!> ::
]]
{
    type = 'KEYWORD',
}

--TEST[[
--::label::
--::other_label::
--::<!label!>::
--]]
--{
--    type = 'REDEFINE_LABEL',
--    info = {
--        label = 'label',
--        related = {3, 7},
--    }
--}

TEST[[
local function <!a.b!>()
end
]]
{
    type = 'UNEXPECT_LFUNC_NAME'
}

Version = 'Lua 5.1'
TEST[[
<!::xx::!>
]]
{
    type = 'UNSUPPORT_SYMBOL',
    version = {'Lua 5.2', 'Lua 5.3', 'Lua 5.4', 'LuaJIT'},
    info = {
        version = 'Lua 5.1',
    }
}

TEST[[
local goto = 1
]]
(nil)

TEST[[
local x = '<!\u!>{1000}'
]]
{
    type = 'ERR_ESC',
    version = {'Lua 5.3', 'Lua 5.4', 'LuaJIT'},
    info = {
        version ='Lua 5.1',
    }
}

TEST[[
local x = '<!\x!>ff'
]]
{
    type = 'ERR_ESC',
    version = {'Lua 5.2', 'Lua 5.3', 'Lua 5.4', 'LuaJIT'},
    info = {
        version = 'Lua 5.1',
    }
}

TEST[[
while true do
    <!break!>
    x = 1
end
]]
{
    type = 'ACTION_AFTER_BREAK',
}

Version = 'Lua 5.2'
TEST[[
local x = 1 <!//!> 2
]]
{
    type = 'UNSUPPORT_SYMBOL',
    version = {'Lua 5.3', 'Lua 5.4'},
    info = {
        version = 'Lua 5.2',
    }
}

TEST[[
local x = 1 <!<<!> 2
]]
{
    type = 'UNSUPPORT_SYMBOL',
    version = {'Lua 5.3', 'Lua 5.4'},
    info = {
        version = 'Lua 5.2',
    }
}

TEST[[
local x = '<!\u!>{1000}'
]]
{
    type = 'ERR_ESC',
    version = {'Lua 5.3', 'Lua 5.4', 'LuaJIT'},
    info = {
        version = 'Lua 5.2',
    }
}

TEST[[
while true do
    break
    x = 1
end
]]
(nil)

Version = 'Lua 5.3'

TEST[[
local x <<!close!>> = 1
]]
{
    type = 'UNSUPPORT_SYMBOL',
    version = 'Lua 5.4',
    info = {
        version = 'Lua 5.3',
    }
}


Version = 'Lua 5.4'

TEST[[
local x <<!close!>> = 1
]]
(nil)

TEST[[
s = '<!\u{1FFFFF}!>'
]]
(nil)


TEST[[
s = '<!\u{111111111}!>'
]]
{
    type = 'UTF8_MAX',
    info = {
        min = '00000000',
        max = '7FFFFFFF',
    }
}

TEST[[
x = 42<!LL!>
]]
{
    type = 'UNSUPPORT_SYMBOL',
    version = 'LuaJIT',
    info = {
        version = 'Lua 5.4',
    }
}

TEST[[
x = 12.5<!i!>
]]
{
    type = 'UNSUPPORT_SYMBOL',
    version = 'LuaJIT',
    info = {
        version = 'Lua 5.4',
    }
}

TEST[[
x = 1.23<!LL!>
]]
{
    type = 'UNKNOWN_SYMBOL',
    info = {
        symbol = 'LL'
    }
}

Version = 'LuaJIT'

TEST[[
x = 42LL
x = 42ULl
x = 0x2aLL
x = 0x2All
x = 12.5i
x = 1I
]]
(nil)

TEST[[
x = 1.23<!LL!>
]]
{
    type = 'UNKNOWN_SYMBOL',
    info = {
        symbol = 'LL'
    }
}

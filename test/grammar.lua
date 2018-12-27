local parser = require 'parser'

local function check_str(str, name, mode)
    local gram, err = parser.grammar(str, mode)
    if err then
        local spc = ''
        for i = 1, err.pos - 1 do
            if err.code:sub(i, i) == '\t' then
                spc = spc .. '\t'
            else
                spc = spc .. ' '
            end
        end
        local text = ('%s\r\n%s^'):format(err.code, spc)
        local msg = ([[
%s

[%s] 第 %d 行：
===========================
%s
===========================
]]):format(err.err, name, err.line, text)

        error(([[
%s

[%s]测试失败:
%s
%s
%s
]]):format(
    msg,
    name,
    ('='):rep(30),
    str,
    ('='):rep(30)
))
    end
end

local function check(mode)
    return function (list)
        for i, str in ipairs(list) do
            check_str(str, mode .. '-' .. i, mode)
        end
    end
end

check 'Comment'
{
'--',
'--123',
'--123123',
[===[--[[123]]===],
[===[--[=[123]=]===],
[===[--[=[123]==]]=]===],
[===[--[[123
123
123]]]===],
}

check 'Sp'
{
'',
' ',
'  ',
'\t',
'--',
'--123',
' \t',
[===[--[[123
123
123]]]===],
}

check 'Nil'
{
'nil',
}

check 'Boolean'
{
'true',
'false',
}

check 'String'
{
[['']],
[[""]],
[['123']],
[['123\'']],
[['123\\']],
[['123\
']],
[['123\z
    345']],
[===[[[123]]]===],
[===[[[123
345]]]===],

[['alo\n123"']],
[["alo\n123\""]],
[['\97lo\10\04923"']],
[=[[[alo
123"]]]=],
[=[[==[alo
123"]==]]=],

[['\xff']],
[['\x1A']],

[['\492']],
[['\0']],
[['\049']],
[['\0492']],

[['\u{3b1}']],
[['\u{3B2}']],
[['\u{0}']],
[['\u{ffffff}']],
}

check 'Number'
{
'3',
'345',
'0xff',
'0xBEBADA',
'3.0',
'3.1416',
'314.16e-2',
'0.31416E1',
'34e1',
'0x0.1E',
'0xA23p-4',
'0X1.921FB54442D18P+1',
}

check 'Name'
{
'_',
'And',
'AND',
'_VERSION',
'_1',
}

check 'Exp'
{
'nil',
'true',
'false',
'"123"',
'123',
'a.b.c',
'func()',
'a.b.c()',
'1 or 2',
'1 and 2',
'1 < 2',
'1 > 2',
'1 <= 2',
'1 >= 2',
'1 ~= 2',
'1 == 2',
'1 | 2',
'1 ~ 2',
'1 & 2',
'1 << 2',
'1 >> 2',
'1 .. 2',
'1 + 2',
'1 - 2',
'1 * 2',
'1 / 2',
'1 // 2',
'1 % 2',
'not 1',
'- 1',
'~ 1',
'1 ^ 2',
'1 ^ -2',
'...',
'1 + 2 + 3',
'1 + 2 * 3',
'- 1 + 2 * 3',

'(1)',
'(1 + 2)',

'func()',
'func(1)',
'func(1, 2)',
'func(...)',
'func(1, ...)',

'table.concat',
'table[1]',
'x.y.z',
'get_point().x',
'obj:remove()',
'(...)[1]',

'function () end',
'function (...) end',
'function (a) end',
'function (a, b) end',
'function (a, ...) end',

'{}',
'{...}',
'{1, 2, 3}',
'{x = 1, y = 2}',
'{["x"] = 1, ["y"] = 2}',
'{[x] = 1, [y] = 2}',
'{{}}',
'{ a = { b = { c = {} } } }',
'{{}, {}, {{}, {}}}',
'{1, 2, 3,}',
}

check 'Action'
{
';',

'x = 1',
'x, y, z = 1, 2, 3',
'local x = 1',
'local x, y, z = 1, 2, 3',
'x = function () end',
'x.y = function () end',

'func()',
'func(1, 2)',
'func.x()',
'func.x(1, 2)',
'func:x()',
'func:x(1, 2)',
'("%s"):format(1)',

'do x = 1 end',

'break',

'return',
'return 1',
'return 1, 2',

'::CONTINUE::',

'goto CONTINUE',

[[if 1 then
end]],
[[if 1 then
    x = 1
end]],
[[if 1 then
    x = 1
else
    x = 1
end]],
[[if 1 then
    x = 1
elseif 1 then
    x = 1
end]],
[[if 1 then
    x = 1
elseif 1 then
    x = 1
else
    x = 1
end]],
[[
if 1 then
elseif 1 then
elseif 1 then
elseif 1 then
end]],

[[for i = 1, 10 do
    x = 1
end]],
[[for i = 1, 10, 1 do
    x = 1
end]],
[[for k, v in pairs(t) do
    x = 1
end]],
[[for k, v in next, t, nil do
    x = 1
end]],

[[while 1 do
    x = 1
end]],

[[repeat
    x = 1
until 1]],

'local a',
'local a, b, c',
'local function test() end',
'function test() end',
'function a.b:c() end',

'local *toclose _ = 1'
}

check 'Lua'
{
'',
[[
]],
[[return function ()
end]]
}

-- Dirty
check 'Lua'
{
'f',
'f(',
'f(a,',
'f(,1)',
'f(1,)',
'f(,)',
'function (,)',
'function (,a)',
'function (a,)',
[[
t = {
    a =
}
]],
[[
t = {
    a = 1
    b = 2
}
]],
'for',
'for i',
'for i = a',
'for i = a, b',
'for i = a, b do',
'for i,',
'for i, v in',
'for i, v in a',
'for i, v in a do',
't = {',
't = {a',
't = {a =',
't = {a = 1,',
's = "',
's = "123',
[[
if true then
elseif
end
]],
't[',
't[]',
't[#',
't[#]',
}

require 'filesystem'
local grammar = require 'parser.grammar'

local function check_str(str, name, mode)
    local gram, err = grammar(str, mode)
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
            if mode ~= 'Nl' then
                str = str:gsub('[\r\n]+$', '')
            end
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
';',
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
'func()',
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

'function () end',
'function (...) end',
'function (1) end',
'function (1, 2) end',
'function (1, ...) end',

'{}',
'{...}',
'{1, 2, 3}',
'{x = 1, y = 2}',
'{["x"] = 1, ["y"] = 2}',
'{[x] = 1, [y] = 2}',
'{{}}',
'{ a = { b = { c = {} } } }',
'{{}, {}, {{}, {}}}',
}

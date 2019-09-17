CHECK'x = 1'
{
    [1] = {
        type   = "setname",
        start  = 1,
        finish = 1,
        value  = 2,
        [1]    = "x",
    },
    [2] = {
        type   = "number",
        start  = 5,
        finish = 5,
        parent = 1,
        [1]    = 1,
    },
}
CHECK'local x'
{
    [1] = {
        type   = "local",
        start  = 7,
        finish = 7,
        [1]    = "x",
    },
}
CHECK'local x = 1'
{
    [1] = {
        value  = 2,
        type   = "local",
        start  = 7,
        finish = 7,
        [1]    = "x",
    },
    [2] = {
        type   = "number",
        start  = 11,
        finish = 11,
        parent = 1,
        [1]    = 1,
    },
}
CHECK'local x <close> <const> = 1'
{
    [1] = {
        type   = "local",
        start  = 7,
        finish = 7,
        value  = 4,
        attrs  = {
            [1] = 2,
            [2] = 3,
        },
        [1]    = "x",
    },
    [2] = {
        type   = "localattr",
        start  = 10,
        finish = 14,
        parent = 1,
        [1]    = "close",
    },
    [3] = {
        type   = "localattr",
        start  = 18,
        finish = 22,
        parent = 1,
        [1]    = "const",
    },
    [4] = {
        type   = "number",
        start  = 27,
        finish = 27,
        parent = 1,
        [1]    = 1,
    },
}
CHECK'local x < const > = 1'
{
    [1] = {
        type   = "local",
        start  = 7,
        finish = 7,
        value  = 3,
        attrs  = {
            [1] = 2,
        },
        [1]    = "x",
    },
    [2] = {
        type   = "localattr",
        start  = 11,
        finish = 15,
        parent = 1,
        [1]    = "const",
    },
    [3] = {
        type   = "number",
        start  = 21,
        finish = 21,
        parent = 1,
        [1]    = 1,
    },
}
CHECK'x = function () end'
{
    [1] = {
        type   = "setname",
        start  = 1,
        finish = 1,
        value  = 2,
        [1]    = "x",
    },
    [2] = {
        type   = "function",
        start  = 5,
        finish = 19,
        parent = 1,
        args   = 3,
    },
    [3] = {
        type   = "funcargs",
        start  = 14,
        finish = 15,
        parent = 2,
    },
}
CHECK'x.y = function () end'
{
    [1] = {
        type   = "setfield",
        start  = 1,
        finish = 3,
        node   = 2,
        dot    = {
            type   = ".",
            start  = 2,
            finish = 2,
        },
        value  = 3,
    },
    [2] = {
        type   = "getname",
        start  = 1,
        finish = 1,
        parent = 1,
        [1]    = "x",
    },
    [3] = {
        type   = "function",
        start  = 7,
        finish = 21,
        parent = 1,
        args   = 4,
    },
    [4] = {
        type   = "funcargs",
        start  = 16,
        finish = 17,
        parent = 3,
    },
}
CHECK'func.x(1, 2)'
{
    [1] = {
        type   = "call",
        start  = 1,
        finish = 12,
        node   = 2,
        args   = 4,
    },
    [2] = {
        type   = "getfield",
        start  = 1,
        finish = 6,
        parent = 1,
        node   = 3,
        dot    = {
            type   = ".",
            start  = 5,
            finish = 5,
        },
        field  = {
            type   = "field",
            start  = 6,
            finish = 6,
            [1]    = "x",
        },
    },
    [3] = {
        type   = "getname",
        start  = 1,
        finish = 4,
        parent = 2,
        [1]    = "func",
    },
    [4] = {
        type   = "callargs",
        start  = 7,
        finish = 12,
        parent = 1,
        [1]    = 5,
        [2]    = 6,
    },
    [5] = {
        type   = "number",
        start  = 8,
        finish = 8,
        parent = 4,
        [1]    = 1,
    },
    [6] = {
        type   = "number",
        start  = 11,
        finish = 11,
        parent = 4,
        [1]    = 2,
    },
}
CHECK'func:x(1, 2)'
{
    [1] = {
        type   = "call",
        start  = 1,
        finish = 12,
        node   = 2,
        args   = 5,
    },
    [2] = {
        type   = "getmethod",
        start  = 1,
        finish = 6,
        parent = 1,
        node   = 3,
        colon  = {
            type   = ":",
            start  = 5,
            finish = 5,
        },
        method = 4,
    },
    [3] = {
        type   = "getname",
        start  = 1,
        finish = 4,
        parent = 2,
        [1]    = "func",
    },
    [4] = {
        type   = "method",
        start  = 6,
        finish = 6,
        parent = 2,
        [1]    = "x",
    },
    [5] = {
        type   = "callargs",
        start  = 7,
        finish = 12,
        parent = 1,
        [1]    = 6,
        [2]    = 7,
    },
    [6] = {
        type   = "number",
        start  = 8,
        finish = 8,
        parent = 5,
        [1]    = 1,
    },
    [7] = {
        type   = "number",
        start  = 11,
        finish = 11,
        parent = 5,
        [1]    = 2,
    },
}
CHECK'("%s"):format(1)'
{
    [1] = {
        type   = "call",
        start  = 1,
        finish = 16,
        node   = 2,
        args   = 6,
    },
    [2] = {
        type   = "getmethod",
        start  = 1,
        finish = 13,
        parent = 1,
        node   = 3,
        colon  = {
            type   = ":",
            start  = 7,
            finish = 7,
        },
        method = 5,
    },
    [3] = {
        type   = "paren",
        start  = 1,
        finish = 6,
        parent = 2,
        exp    = 4,
    },
    [4] = {
        type   = "string",
        start  = 2,
        finish = 5,
        parent = 3,
        [1]    = "%s",
        [2]    = "\"",
    },
    [5] = {
        type   = "method",
        start  = 8,
        finish = 13,
        parent = 2,
        [1]    = "format",
    },
    [6] = {
        type   = "callargs",
        start  = 14,
        finish = 16,
        parent = 1,
        [1]    = 7,
    },
    [7] = {
        type   = "number",
        start  = 15,
        finish = 15,
        parent = 6,
        [1]    = 1,
    },
}
CHECK'do end'
{
    [1] = {
        type   = "do",
        start  = 1,
        finish = 6,
    },
}
CHECK'do x = 1 end'
{
    [1] = {
        type   = "do",
        start  = 1,
        finish = 12,
        [1]    = 2,
    },
    [2] = {
        type   = "setname",
        start  = 4,
        finish = 4,
        parent = 1,
        value  = 3,
        [1]    = "x",
    },
    [3] = {
        type   = "number",
        start  = 8,
        finish = 8,
        parent = 2,
        [1]    = 1,
    },
}
CHECK'return'
{
    [1] = {
        type   = "return",
        start  = 1,
        finish = 6,
    },
}
CHECK'return 1'
{
    [1] = {
        type   = "return",
        start  = 1,
        finish = 8,
        [1]    = 2,
    },
    [2] = {
        type   = "number",
        start  = 8,
        finish = 8,
        parent = 1,
        [1]    = 1,
    },
}
CHECK'return 1, 2'
{
    [1] = {
        type   = "return",
        start  = 1,
        finish = 11,
        [1]    = 2,
        [2]    = 3,
    },
    [2] = {
        type   = "number",
        start  = 8,
        finish = 8,
        parent = 1,
        [1]    = 1,
    },
    [3] = {
        type   = "number",
        start  = 11,
        finish = 11,
        parent = 1,
        [1]    = 2,
    },
}
CHECK'::CONTINUE::'
{
    [1] = {
        type   = "label",
        start  = 3,
        finish = 10,
        [1]    = "CONTINUE",
    },
}
CHECK'goto CONTINUE'
{
    [1] = {
        type   = 'goto',
        start  = 6,
        finish = 13,
        [1]    = 'CONTINUE',
    }
}
CHECK[[if 1 then
end]]
{
    [1] = {
        type   = "if",
        start  = 1,
        finish = 13,
        [1]    = 2,
    },
    [2] = {
        type   = "ifblock",
        start  = 1,
        finish = 9,
        parent = 1,
        filter = 3,
    },
    [3] = {
        type   = "number",
        start  = 4,
        finish = 4,
        parent = 2,
        [1]    = 1,
    },
}
CHECK[[if 1 then
    return
end]]
{
    [1] = {
        type   = "if",
        start  = 1,
        finish = 24,
        [1]    = 2,
    },
    [2] = {
        type   = "ifblock",
        start  = 1,
        finish = 21,
        parent = 1,
        filter = 3,
        [1]    = 4,
    },
    [3] = {
        type   = "number",
        start  = 4,
        finish = 4,
        parent = 2,
        [1]    = 1,
    },
    [4] = {
        type   = "return",
        start  = 15,
        finish = 21,
        parent = 2,
    },
}
CHECK[[if 1 then
    return
else
    return
end]]
{
    [1] = {
        type   = "if",
        start  = 1,
        finish = 40,
        [1]    = 2,
        [2]    = 5,
    },
    [2] = {
        type   = "ifblock",
        start  = 1,
        finish = 21,
        parent = 1,
        filter = 3,
        [1]    = 4,
    },
    [3] = {
        type   = "number",
        start  = 4,
        finish = 4,
        parent = 2,
        [1]    = 1,
    },
    [4] = {
        type   = "return",
        start  = 15,
        finish = 21,
        parent = 2,
    },
    [5] = {
        type   = "elseblock",
        start  = 22,
        finish = 37,
        parent = 1,
        [1]    = 6,
    },
    [6] = {
        type   = "return",
        start  = 31,
        finish = 37,
        parent = 5,
    },
}
CHECK[[if 1 then
    return
elseif 1 then
    return
end]]
{
    [1] = {
        type   = "if",
        start  = 1,
        finish = 49,
        [1]    = 2,
        [2]    = 5,
    },
    [2] = {
        type   = "ifblock",
        start  = 1,
        finish = 21,
        parent = 1,
        filter = 3,
        [1]    = 4,
    },
    [3] = {
        type   = "number",
        start  = 4,
        finish = 4,
        parent = 2,
        [1]    = 1,
    },
    [4] = {
        type   = "return",
        start  = 15,
        finish = 21,
        parent = 2,
    },
    [5] = {
        type   = "elseifblock",
        start  = 22,
        finish = 46,
        parent = 1,
        filter = 6,
        [1]    = 7,
    },
    [6] = {
        type   = "number",
        start  = 29,
        finish = 29,
        parent = 5,
        [1]    = 1,
    },
    [7] = {
        type   = "return",
        start  = 40,
        finish = 46,
        parent = 5,
    },
}
CHECK[[if 1 then
    return
elseif 1 then
    return
else
    return
end]]
{
    [1] = {
        type   = "if",
        start  = 1,
        finish = 65,
        [1]    = 2,
        [2]    = 5,
        [3]    = 8,
    },
    [2] = {
        type   = "ifblock",
        start  = 1,
        finish = 21,
        parent = 1,
        filter = 3,
        [1]    = 4,
    },
    [3] = {
        type   = "number",
        start  = 4,
        finish = 4,
        parent = 2,
        [1]    = 1,
    },
    [4] = {
        type   = "return",
        start  = 15,
        finish = 21,
        parent = 2,
    },
    [5] = {
        type   = "elseifblock",
        start  = 22,
        finish = 46,
        parent = 1,
        filter = 6,
        [1]    = 7,
    },
    [6] = {
        type   = "number",
        start  = 29,
        finish = 29,
        parent = 5,
        [1]    = 1,
    },
    [7] = {
        type   = "return",
        start  = 40,
        finish = 46,
        parent = 5,
    },
    [8] = {
        type   = "elseblock",
        start  = 47,
        finish = 62,
        parent = 1,
        [1]    = 9,
    },
    [9] = {
        type   = "return",
        start  = 56,
        finish = 62,
        parent = 8,
    },
}
CHECK[[
if 1 then
elseif 1 then
elseif 1 then
elseif 1 then
end]]
{
    [1] = {
        type   = "if",
        start  = 1,
        finish = 55,
        [1]    = 2,
        [2]    = 4,
        [3]    = 6,
        [4]    = 8,
    },
    [2] = {
        type   = "ifblock",
        start  = 1,
        finish = 9,
        parent = 1,
        filter = 3,
    },
    [3] = {
        type   = "number",
        start  = 4,
        finish = 4,
        parent = 2,
        [1]    = 1,
    },
    [4] = {
        type   = "elseifblock",
        start  = 11,
        finish = 23,
        parent = 1,
        filter = 5,
    },
    [5] = {
        type   = "number",
        start  = 18,
        finish = 18,
        parent = 4,
        [1]    = 1,
    },
    [6] = {
        type   = "elseifblock",
        start  = 25,
        finish = 37,
        parent = 1,
        filter = 7,
    },
    [7] = {
        type   = "number",
        start  = 32,
        finish = 32,
        parent = 6,
        [1]    = 1,
    },
    [8] = {
        type   = "elseifblock",
        start  = 39,
        finish = 51,
        parent = 1,
        filter = 9,
    },
    [9] = {
        type   = "number",
        start  = 46,
        finish = 46,
        parent = 8,
        [1]    = 1,
    },
}
CHECK[[
if 1 then
    if 2 then
    end
end]]
{
    [1] = {
        type   = "if",
        start  = 1,
        finish = 35,
        [1]    = 2,
    },
    [2] = {
        type   = "ifblock",
        start  = 1,
        finish = 31,
        parent = 1,
        filter = 3,
        [1]    = 4,
    },
    [3] = {
        type   = "number",
        start  = 4,
        finish = 4,
        parent = 2,
        [1]    = 1,
    },
    [4] = {
        type   = "if",
        start  = 15,
        finish = 31,
        parent = 2,
        [1]    = 5,
    },
    [5] = {
        type   = "ifblock",
        start  = 15,
        finish = 23,
        parent = 4,
        filter = 6,
    },
    [6] = {
        type   = "number",
        start  = 18,
        finish = 18,
        parent = 5,
        [1]    = 2,
    },
}
CHECK[[
if 1 then
elseif 1 then
else
end]]
{
    [1] = {
        type   = "if",
        start  = 1,
        finish = 32,
        [1]    = 2,
        [2]    = 4,
        [3]    = 6,
    },
    [2] = {
        type   = "ifblock",
        start  = 1,
        finish = 9,
        parent = 1,
        filter = 3,
    },
    [3] = {
        type   = "number",
        start  = 4,
        finish = 4,
        parent = 2,
        [1]    = 1,
    },
    [4] = {
        type   = "elseifblock",
        start  = 11,
        finish = 23,
        parent = 1,
        filter = 5,
    },
    [5] = {
        type   = "number",
        start  = 18,
        finish = 18,
        parent = 4,
        [1]    = 1,
    },
    [6] = {
        type   = "elseblock",
        start  = 25,
        finish = 28,
        parent = 1,
    },
}
CHECK[[
for i = 1, 10 do
    return
end]]
{
    [1] = {
        type   = "loop",
        start  = 1,
        finish = 31,
        loc    = 2,
        max    = 4,
        [1]    = 5,
    },
    [2] = {
        type   = "local",
        start  = 5,
        finish = 5,
        parent = 1,
        value  = 3,
        [1]    = "i",
    },
    [3] = {
        type   = "number",
        start  = 9,
        finish = 9,
        parent = 2,
        [1]    = 1,
    },
    [4] = {
        type   = "number",
        start  = 12,
        finish = 13,
        parent = 1,
        [1]    = 10,
    },
    [5] = {
        type   = "return",
        start  = 22,
        finish = 28,
        parent = 1,
    },
}
CHECK[[
for i = 1, 10, 1 do
    return
end]]
{
    [1] = {
        type   = "loop",
        start  = 1,
        finish = 34,
        loc    = 2,
        max    = 4,
        step   = 5,
        [1]    = 6,
    },
    [2] = {
        type   = "local",
        start  = 5,
        finish = 5,
        parent = 1,
        value  = 3,
        [1]    = "i",
    },
    [3] = {
        type   = "number",
        start  = 9,
        finish = 9,
        parent = 2,
        [1]    = 1,
    },
    [4] = {
        type   = "number",
        start  = 12,
        finish = 13,
        parent = 1,
        [1]    = 10,
    },
    [5] = {
        type   = "number",
        start  = 16,
        finish = 16,
        parent = 1,
        [1]    = 1,
    },
    [6] = {
        type   = "return",
        start  = 25,
        finish = 31,
        parent = 1,
    },
}
CHECK[[
for a in a do
    return
end]]
{
    [1] = {
        type   = "in",
        start  = 1,
        finish = 28,
        locs   = {
            [1] = 2,
        },
        [1]    = 6,
    },
    [2] = {
        type   = "local",
        start  = 5,
        finish = 5,
        parent = 1,
        value  = 3,
        [1]    = "a",
    },
    [3] = {
        type   = "select",
        parent = 2,
        vararg = 4,
        index  = 1,
    },
    [4] = {
        type   = "call",
        start  = 0,
        finish = 0,
        parent = 3,
        args   = 5,
    },
    [5] = {
        type   = "callargs",
        start  = 0,
        finish = 0,
        parent = 4,
    },
    [6] = {
        type   = "return",
        start  = 19,
        finish = 25,
        parent = 1,
    },
}
CHECK[[
for a, b, c in a, b, c do
    return
end]]
{
    [01] = {
        type   = "in",
        start  = 1,
        finish = 40,
        locs   = {
            [1] = 2,
            [2] = 8,
            [3] = 10,
        },
        [1]    = 12,
    },
    [02] = {
        type   = "local",
        start  = 5,
        finish = 5,
        parent = 1,
        value  = 3,
        [1]    = "a",
    },
    [03] = {
        type   = "select",
        parent = 2,
        index  = 1,
        vararg = 4,
    },
    [04] = {
        type      = "call",
        start     = 16,
        finish    = 22,
        parent    = 3,
        extParent = {
            [1] = 9,
            [2] = 11,
        },
        args      = 5,
    },
    [05] = {
        type   = "callargs",
        start  = 16,
        finish = 22,
        parent = 4,
        [1]    = 6,
        [2]    = 7,
    },
    [06] = {
        type   = "getname",
        start  = 16,
        finish = 16,
        parent = 5,
        [1]    = "a",
    },
    [07] = {
        type   = "getname",
        start  = 19,
        finish = 19,
        parent = 5,
        [1]    = "b",
    },
    [08] = {
        type   = "local",
        start  = 8,
        finish = 8,
        parent = 1,
        value  = 9,
        [1]    = "b",
    },
    [09] = {
        type   = "select",
        parent = 8,
        index  = 2,
        vararg = 4,
    },
    [10] = {
        type   = "local",
        start  = 11,
        finish = 11,
        parent = 1,
        value  = 11,
        [1]    = "c",
    },
    [11] = {
        type   = "select",
        parent = 10,
        index  = 3,
        vararg = 4,
    },
    [12] = {
        type   = "return",
        start  = 31,
        finish = 37,
        parent = 1,
    },
}
CHECK[[
while true do
    return
end]]
{
    [1] = {
        type   = "while",
        start  = 1,
        finish = 28,
        filter = 2,
        [1]    = 3,
    },
    [2] = {
        type   = "boolean",
        start  = 7,
        finish = 10,
        parent = 1,
        [1]    = true,
    },
    [3] = {
        type   = "return",
        start  = 19,
        finish = 25,
        parent = 1,
    },
}
CHECK[[
repeat
    break
until 1]]
{
    [1] = {
        type   = "repeat",
        start  = 1,
        finish = 25,
        filter = 3,
        [1]    = 2,
    },
    [2] = {
        type   = "break",
        start  = 12,
        finish = 16,
        parent = 1,
    },
    [3] = {
        type   = "number",
        start  = 24,
        finish = 24,
        parent = 1,
        [1]    = 1,
    },
}
CHECK[[
function test()
    return
end]]
{
    [1] = {
        type   = "setname",
        start  = 10,
        finish = 13,
        value  = 2,
        [1]    = "test",
    },
    [2] = {
        type   = "function",
        start  = 1,
        finish = 30,
        parent = 1,
        args   = 3,
        [1]    = 4,
    },
    [3] = {
        type   = "funcargs",
        start  = 14,
        finish = 15,
        parent = 2,
    },
    [4] = {
        type   = "return",
        start  = 21,
        finish = 27,
        parent = 2,
    },
}
CHECK[[
function test(a)
    return
end]]
{
    [1] = {
        type   = "setname",
        start  = 10,
        finish = 13,
        value  = 2,
        [1]    = "test",
    },
    [2] = {
        type   = "function",
        start  = 1,
        finish = 31,
        parent = 1,
        args   = 3,
        [1]    = 4,
    },
    [3] = {
        type   = "funcargs",
        start  = 14,
        finish = 16,
        parent = 2,
    },
    [4] = {
        type   = "return",
        start  = 22,
        finish = 28,
        parent = 2,
    },
}
CHECK[[
function a.b:c(a, b, c)
    return
end]]
{
    [1] = {
        type   = "setmethod",
        start  = 10,
        finish = 14,
        node   = 2,
        colon  = {
            type   = ":",
            start  = 13,
            finish = 13,
        },
        method = 4,
        value  = 5,
    },
    [2] = {
        type   = "getfield",
        start  = 10,
        finish = 12,
        parent = 1,
        node   = 3,
        dot    = {
            type   = ".",
            start  = 11,
            finish = 11,
        },
        field  = {
            type   = "field",
            start  = 12,
            finish = 12,
            [1]    = "b",
        },
    },
    [3] = {
        type   = "getname",
        start  = 10,
        finish = 10,
        parent = 2,
        [1]    = "a",
    },
    [4] = {
        type   = "method",
        start  = 14,
        finish = 14,
        parent = 1,
        [1]    = "c",
    },
    [5] = {
        type   = "function",
        start  = 1,
        finish = 38,
        parent = 1,
        args   = 6,
        [1]    = 7,
    },
    [6] = {
        type   = "funcargs",
        start  = 15,
        finish = 23,
        parent = 5,
    },
    [7] = {
        type   = "return",
        start  = 29,
        finish = 35,
        parent = 5,
    },
}

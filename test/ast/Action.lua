CHECK'x = 1'
{
    [1] = {
        type   = "name",
        start  = 1,
        finish = 1,
        [1]    = "x",
    },
    [2] = {
        type   = "number",
        start  = 5,
        finish = 5,
        [1]    = 1,
    },
    [3] = {
        type   = "set",
        start  = 1,
        finish = 5,
        keys   = {
            [1] = 1,
        },
        values = {
            [1] = 2,
        },
    },
}
CHECK'x, y, z = 1, 2, 3'
{
    [1] = {
        type   = "name",
        start  = 1,
        finish = 1,
        [1]    = "x",
    },
    [2] = {
        type   = "name",
        start  = 4,
        finish = 4,
        [1]    = "y",
    },
    [3] = {
        type   = "name",
        start  = 7,
        finish = 7,
        [1]    = "z",
    },
    [4] = {
        type   = "number",
        start  = 11,
        finish = 11,
        [1]    = 1,
    },
    [5] = {
        type   = "number",
        start  = 14,
        finish = 14,
        [1]    = 2,
    },
    [6] = {
        type   = "number",
        start  = 17,
        finish = 17,
        [1]    = 3,
    },
    [7] = {
        type   = "set",
        start  = 1,
        finish = 17,
        keys   = {
            [1] = 1,
            [2] = 2,
            [3] = 3,
        },
        values = {
            [1] = 4,
            [2] = 5,
            [3] = 6,
        },
    },
}
CHECK'local x'
{
    [1] = {
        type   = "name",
        start  = 7,
        finish = 7,
        [1]    = "x",
    },
    [2] = {
        type   = "local",
        start  = 1,
        finish = 7,
        keys   = {
            [1] = 1,
        },
    },
}
CHECK'local x, y, z'
{
    [1] = {
        type   = "name",
        start  = 7,
        finish = 7,
        [1]    = "x",
    },
    [2] = {
        type   = "name",
        start  = 10,
        finish = 10,
        [1]    = "y",
    },
    [3] = {
        type   = "name",
        start  = 13,
        finish = 13,
        [1]    = "z",
    },
    [4] = {
        type   = "local",
        start  = 1,
        finish = 13,
        keys   = {
            [1] = 1,
            [2] = 2,
            [3] = 3,
        },
    },
}
CHECK'local x = 1'
{
    [1] = {
        type   = "name",
        start  = 7,
        finish = 7,
        [1]    = "x",
    },
    [2] = {
        type   = "number",
        start  = 11,
        finish = 11,
        [1]    = 1,
    },
    [3] = {
        type   = "local",
        start  = 1,
        finish = 11,
        keys   = {
            [1] = 1,
        },
        values = {
            [1] = 2,
        },
    },
}
CHECK'local x, y, z = 1, 2, 3'
{
    [1] = {
        type   = "name",
        start  = 7,
        finish = 7,
        [1]    = "x",
    },
    [2] = {
        type   = "name",
        start  = 10,
        finish = 10,
        [1]    = "y",
    },
    [3] = {
        type   = "name",
        start  = 13,
        finish = 13,
        [1]    = "z",
    },
    [4] = {
        type   = "number",
        start  = 17,
        finish = 17,
        [1]    = 1,
    },
    [5] = {
        type   = "number",
        start  = 20,
        finish = 20,
        [1]    = 2,
    },
    [6] = {
        type   = "number",
        start  = 23,
        finish = 23,
        [1]    = 3,
    },
    [7] = {
        type   = "local",
        start  = 1,
        finish = 23,
        keys   = {
            [1] = 1,
            [2] = 2,
            [3] = 3,
        },
        values = {
            [1] = 4,
            [2] = 5,
            [3] = 6,
        },
    },
}
CHECK'local x <close> <const> = 1'
{
    [1] = {
        type   = "name",
        start  = 7,
        finish = 7,
        [1]    = "x",
        attrs  = {
            [1] = 2,
            [2] = 3,
        },
    },
    [2] = {
        type   = "localattr",
        start  = 10,
        finish = 14,
        [1]    = "close",
    },
    [3] = {
        type   = "localattr",
        start  = 18,
        finish = 22,
        [1]    = "const",
    },
    [4] = {
        type   = "number",
        start  = 27,
        finish = 27,
        [1]    = 1,
    },
    [5] = {
        type   = "local",
        start  = 1,
        finish = 27,
        keys   = {
            [1] = 1,
        },
        values = {
            [1] = 4,
        },
    },
}
CHECK'local x < const > = 1'
{
    [1] = {
        type   = "name",
        start  = 7,
        finish = 7,
        [1]    = "x",
        attrs  = {
            [1] = 2,
        },
    },
    [2] = {
        type   = "localattr",
        start  = 11,
        finish = 15,
        [1]    = "const",
    },
    [3] = {
        type   = "number",
        start  = 21,
        finish = 21,
        [1]    = 1,
    },
    [4] = {
        type   = "local",
        start  = 1,
        finish = 21,
        keys   = {
            [1] = 1,
        },
        values = {
            [1] = 3,
        },
    },
}
CHECK'local x <const>, y <close> = 1'
{
    [1] = {
        type   = "name",
        start  = 7,
        finish = 7,
        [1]    = "x",
        attrs  = {
            [1] = 2,
        },
    },
    [2] = {
        type   = "localattr",
        start  = 10,
        finish = 14,
        [1]    = "const",
    },
    [3] = {
        type   = "name",
        start  = 18,
        finish = 18,
        [1]    = "y",
        attrs  = {
            [1] = 4,
        },
    },
    [4] = {
        type   = "localattr",
        start  = 21,
        finish = 25,
        [1]    = "close",
    },
    [5] = {
        type   = "number",
        start  = 30,
        finish = 30,
        [1]    = 1,
    },
    [6] = {
        type   = "local",
        start  = 1,
        finish = 30,
        keys   = {
            [1] = 1,
            [2] = 3,
        },
        values = {
            [1] = 5,
        },
    },
}
CHECK'x = function () end'
{
    [1] = {
        type   = "name",
        start  = 1,
        finish = 1,
        [1]    = "x",
    },
    [2] = {
        type   = "funcargs",
        start  = 14,
        finish = 15,
    },
    [3] = {
        type   = "function",
        start  = 5,
        finish = 19,
        args   = 2,
    },
    [4] = {
        type   = "set",
        start  = 1,
        finish = 19,
        keys   = {
            [1] = 1,
        },
        values = {
            [1] = 3,
        },
    },
}
CHECK'x.y = function () end'
{
    [1] = {
        type   = "name",
        start  = 1,
        finish = 1,
        [1]    = "x",
    },
    [2] = {
        type   = ".",
        start  = 2,
        finish = 2,
    },
    [3] = {
        type   = "name",
        start  = 3,
        finish = 3,
        [1]    = "y",
    },
    [4] = {
        type   = "getfield",
        start  = 1,
        finish = 3,
        parent = 1,
        field  = 3,
        dot    = 2,
    },
    [5] = {
        type   = "funcargs",
        start  = 16,
        finish = 17,
    },
    [6] = {
        type   = "function",
        start  = 7,
        finish = 21,
        args   = 5,
    },
    [7] = {
        type   = "set",
        start  = 1,
        finish = 21,
        keys   = {
            [1] = 4,
        },
        values = {
            [1] = 6,
        },
    },
}
CHECK'func.x(1, 2)'
{
    [1] = {
        type   = "name",
        start  = 1,
        finish = 4,
        [1]    = "func",
    },
    [2] = {
        type   = ".",
        start  = 5,
        finish = 5,
    },
    [3] = {
        type   = "name",
        start  = 6,
        finish = 6,
        [1]    = "x",
    },
    [4] = {
        type   = "getfield",
        start  = 1,
        finish = 6,
        parent = 1,
        dot    = 2,
        field  = 3,
    },
    [5] = {
        type   = "number",
        start  = 8,
        finish = 8,
        [1]    = 1,
    },
    [6] = {
        type   = ",",
        start  = 9,
        finish = 9,
    },
    [7] = {
        type   = "number",
        start  = 11,
        finish = 11,
        [1]    = 2,
    },
    [8] = {
        type   = "callargs",
        start  = 7,
        finish = 12,
        [1]    = 5,
        [2]    = 7,
    },
    [9] = {
        type   = "call",
        start  = 1,
        finish = 12,
        parent = 4,
        args   = 8,
    },
}
CHECK'func:x(1, 2)'
{
    [1] = {
        type   = "name",
        start  = 1,
        finish = 4,
        [1]    = "func",
    },
    [2] = {
        type   = ":",
        start  = 5,
        finish = 5,
    },
    [3] = {
        type   = "name",
        start  = 6,
        finish = 6,
        [1]    = "x",
    },
    [4] = {
        type   = "getmethod",
        start  = 1,
        finish = 6,
        parent = 1,
        colon  = 2,
        method = 3,
    },
    [5] = {
        type   = "number",
        start  = 8,
        finish = 8,
        [1]    = 1,
    },
    [6] = {
        type   = ",",
        start  = 9,
        finish = 9,
    },
    [7] = {
        type   = "number",
        start  = 11,
        finish = 11,
        [1]    = 2,
    },
    [8] = {
        type   = "callargs",
        start  = 7,
        finish = 12,
        [2]    = 7,
        [1]    = 5,
    },
    [9] = {
        type   = "call",
        start  = 1,
        finish = 12,
        parent = 4,
        args   = 8,
    },
}
CHECK'("%s"):format(1)'
{
    [1] = {
        type   = "string",
        start  = 2,
        finish = 5,
        [2]    = "\"",
        [1]    = "%s",
    },
    [2] = {
        type   = "parentheses",
        start  = 1,
        finish = 6,
        exp    = 1,
    },
    [3] = {
        type   = ":",
        start  = 7,
        finish = 7,
    },
    [4] = {
        type   = "name",
        start  = 8,
        finish = 13,
        [1]    = "format",
    },
    [5] = {
        type   = "getmethod",
        start  = 1,
        finish = 13,
        parent = 2,
        colon  = 3,
        method = 4,
    },
    [6] = {
        type   = "number",
        start  = 15,
        finish = 15,
        [1]    = 1,
    },
    [7] = {
        type   = "callargs",
        start  = 14,
        finish = 16,
        [1]    = 6,
    },
    [8] = {
        type   = "call",
        start  = 1,
        finish = 16,
        parent = 5,
        args   = 7,
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
        type   = "name",
        start  = 4,
        finish = 4,
        [1]    = "x",
    },
    [2] = {
        type   = "number",
        start  = 8,
        finish = 8,
        [1]    = 1,
    },
    [3] = {
        type   = "set",
        start  = 4,
        finish = 8,
        keys   = {
            [1] = 1,
        },
        values = {
            [1] = 2,
        },
    },
    [4] = {
        type   = "do",
        start  = 1,
        finish = 12,
        [1]    = 3,
    },
}
CHECK'return'
{
    [1] = {
        type   = "return",
        start  = 1,
        finish = 6,
        exps   = {
        },
    },
}
CHECK'return 1'
{
    [1] = {
        type   = "number",
        start  = 8,
        finish = 8,
        [1]    = 1,
    },
    [2] = {
        type   = "return",
        start  = 1,
        finish = 8,
        exps   = {
            [1] = 1,
        },
    },
}
CHECK'return 1, 2'
{
    [1] = {
        type   = "number",
        start  = 8,
        finish = 8,
        [1]    = 1,
    },
    [2] = {
        type   = "number",
        start  = 11,
        finish = 11,
        [1]    = 2,
    },
    [3] = {
        type   = "return",
        start  = 1,
        finish = 11,
        exps   = {
            [1] = 1,
            [2] = 2,
        },
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
        type   = "number",
        start  = 4,
        finish = 4,
        [1]    = 1,
    },
    [2] = {
        type   = 'ifblock',
        start  = 1,
        finish = 9,
        filter = 1,
    },
    [3] = {
        type   = "if",
        start  = 1,
        finish = 13,
        [1]    = 2,
    },
}
CHECK[[if 1 then
    return
end]]
{
    [1] = {
        type   = "number",
        start  = 4,
        finish = 4,
        [1]    = 1,
    },
    [2] = {
        type   = "return",
        start  = 15,
        finish = 21,
        exps   = {
        },
    },
    [3] = {
        type   = 'ifblock',
        start  = 1,
        finish = 21,
        filter = 1,
        [1]    = 2,
    },
    [4] = {
        type   = "if",
        start  = 1,
        finish = 24,
        [1]    = 3,
    },
}
CHECK[[if 1 then
    return
else
    return
end]]
{
    [1] = {
        type   = "number",
        start  = 4,
        finish = 4,
        [1]    = 1,
    },
    [2] = {
        type   = "return",
        start  = 15,
        finish = 21,
        exps   = {
        },
    },
    [3] = {
        type   = "ifblock",
        start  = 1,
        finish = 21,
        filter = 1,
        [1]    = 2,
    },
    [4] = {
        type   = "return",
        start  = 31,
        finish = 37,
        exps   = {
        },
    },
    [5] = {
        type   = "elseblock",
        start  = 22,
        finish = 37,
        [1]    = 4,
    },
    [6] = {
        type   = "if",
        start  = 1,
        finish = 40,
        [1]    = 3,
        [2]    = 5,
    },
}
CHECK[[if 1 then
    return
elseif 1 then
    return
end]]
{
    [1] = {
        type   = "number",
        start  = 4,
        finish = 4,
        [1]    = 1,
    },
    [2] = {
        type   = "return",
        start  = 15,
        finish = 21,
        exps   = {
        },
    },
    [3] = {
        type   = "ifblock",
        start  = 1,
        finish = 21,
        filter = 1,
        [1]    = 2,
    },
    [4] = {
        type   = "number",
        start  = 29,
        finish = 29,
        [1]    = 1,
    },
    [5] = {
        type   = "return",
        start  = 40,
        finish = 46,
        exps   = {
        },
    },
    [6] = {
        type   = "elseifblock",
        start  = 22,
        finish = 46,
        filter = 4,
        [1]    = 5,
    },
    [7] = {
        type   = "if",
        start  = 1,
        finish = 49,
        [1]    = 3,
        [2]    = 6,
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
        type   = "number",
        start  = 4,
        finish = 4,
        [1]    = 1,
    },
    [2] = {
        type   = "return",
        start  = 15,
        finish = 21,
        exps   = {
        },
    },
    [3] = {
        type   = "ifblock",
        start  = 1,
        finish = 21,
        filter = 1,
        [1]    = 2,
    },
    [4] = {
        type   = "number",
        start  = 29,
        finish = 29,
        [1]    = 1,
    },
    [5] = {
        type   = "return",
        start  = 40,
        finish = 46,
        exps   = {
        },
    },
    [6] = {
        type   = "elseifblock",
        start  = 22,
        finish = 46,
        filter = 4,
        [1]    = 5,
    },
    [7] = {
        type   = "return",
        start  = 56,
        finish = 62,
        exps   = {
        },
    },
    [8] = {
        type   = "elseblock",
        start  = 47,
        finish = 62,
        [1]    = 7,
    },
    [9] = {
        type   = "if",
        start  = 1,
        finish = 65,
        [1]    = 3,
        [2]    = 6,
        [3]    = 8,
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
        type   = "number",
        start  = 4,
        finish = 4,
        [1]    = 1,
    },
    [2] = {
        type   = "ifblock",
        start  = 1,
        finish = 9,
        filter = 1,
    },
    [3] = {
        type   = "number",
        start  = 18,
        finish = 18,
        [1]    = 1,
    },
    [4] = {
        type   = "elseifblock",
        start  = 10,
        finish = 23,
        filter = 3,
    },
    [5] = {
        type   = "number",
        start  = 32,
        finish = 32,
        [1]    = 1,
    },
    [6] = {
        type   = "elseifblock",
        start  = 24,
        finish = 37,
        filter = 5,
    },
    [7] = {
        type   = "number",
        start  = 46,
        finish = 46,
        [1]    = 1,
    },
    [8] = {
        type   = "elseifblock",
        start  = 38,
        finish = 51,
        filter = 7,
    },
    [9] = {
        type   = "if",
        start  = 1,
        finish = 55,
        [1]    = 2,
        [2]    = 4,
        [3]    = 6,
        [4]    = 8,
    },
}
CHECK[[
if 1 then
    if 2 then
    end
end]]
{
    [1] = {
        type   = "number",
        start  = 4,
        finish = 4,
        [1]    = 1,
    },
    [2] = {
        type   = "number",
        start  = 18,
        finish = 18,
        [1]    = 2,
    },
    [3] = {
        type   = "ifblock",
        start  = 15,
        finish = 23,
        filter = 2,
    },
    [4] = {
        type   = "if",
        start  = 15,
        finish = 31,
        [1]    = 3,
    },
    [5] = {
        type   = "ifblock",
        start  = 1,
        finish = 31,
        filter = 1,
        [1]    = 4,
    },
    [6] = {
        type   = "if",
        start  = 1,
        finish = 35,
        [1]    = 5,
    },
}
CHECK[[
if a then
elseif b then
else
end]]
{
    [1] = {
        type   = "name",
        start  = 4,
        finish = 4,
        [1]    = "a",
    },
    [2] = {
        type   = "ifblock",
        start  = 1,
        finish = 9,
        filter = 1,
    },
    [3] = {
        type   = "name",
        start  = 18,
        finish = 18,
        [1]    = "b",
    },
    [4] = {
        type   = "elseifblock",
        start  = 10,
        finish = 23,
        filter = 3,
    },
    [5] = {
        type   = "elseblock",
        start  = 24,
        finish = 28,
    },
    [6] = {
        type   = "if",
        start  = 1,
        finish = 32,
        [1]    = 2,
        [2]    = 4,
        [3]    = 5,
    },
}
CHECK[[
for i = 1, 10 do
    return
end]]
{
    [1] = {
        type   = "name",
        start  = 5,
        finish = 5,
        [1]    = "i",
    },
    [2] = {
        type   = "number",
        start  = 9,
        finish = 9,
        [1]    = 1,
    },
    [3] = {
        type   = ",",
        start  = 10,
        finish = 10,
    },
    [4] = {
        type   = "number",
        start  = 12,
        finish = 13,
        [1]    = 10,
    },
    [5] = {
        type   = "return",
        start  = 22,
        finish = 28,
        exps   = {
        },
    },
    [6] = {
        type   = "loop",
        start  = 1,
        finish = 31,
        min    = 2,
        max    = 4,
        arg    = 1,
        [1]    = 5,
    },
}
CHECK[[
for i = 1, 10, 1 do
    return
end]]
{
    [1] = {
        type   = "name",
        start  = 5,
        finish = 5,
        [1]    = "i",
    },
    [2] = {
        type   = "number",
        start  = 9,
        finish = 9,
        [1]    = 1,
    },
    [3] = {
        type   = ",",
        start  = 10,
        finish = 10,
    },
    [4] = {
        type   = "number",
        start  = 12,
        finish = 13,
        [1]    = 10,
    },
    [5] = {
        type   = ",",
        start  = 14,
        finish = 14,
    },
    [6] = {
        type   = "number",
        start  = 16,
        finish = 16,
        [1]    = 1,
    },
    [7] = {
        type   = "return",
        start  = 25,
        finish = 31,
        exps   = {
        },
    },
    [8] = {
        type   = "loop",
        start  = 1,
        finish = 34,
        arg    = 1,
        min    = 2,
        max    = 4,
        step   = 6,
        [1]    = 7,
    },
}
do return end
CHECK[[
for a in a do
    return
end]]
{
    type   = 'in',
    start  = 1,
    finish = 28,
    arg    = {
        type   = 'name',
        start  = 5,
        finish = 5,
        [1]    = 'a',
    },
    exp    = {
        type   = 'name',
        start  = 10,
        finish = 10,
        [1]    = 'a',
    },
    [1]    = {
        type   = 'return',
        start  = 19,
        finish = 24,
    }
}
CHECK[[
for a, b, c in a, b, c do
    return
end]]
{
    type   = 'in',
    start  = 1,
    finish = 40,
    arg    = {
        type   = 'list',
        start  = 5,
        finish = 11,
        [1]    = {
            type   = 'name',
            start  = 5,
            finish = 5,
            [1]    = 'a',
        },
        [2]    = {
            type   = 'name',
            start  = 8,
            finish = 8,
            [1]    = 'b',
        },
        [3]    = {
            type   = 'name',
            start  = 11,
            finish = 11,
            [1]    = 'c',
        },
    },
    exp    = {
        type   = 'list',
        start  = 16,
        finish = 22,
        [1]    = {
            type   = 'name',
            start  = 16,
            finish = 16,
            [1]    = 'a',
        },
        [2]    = {
            type   = 'name',
            start  = 19,
            finish = 19,
            [1]    = 'b',
        },
        [3]    = {
            type   = 'name',
            start  = 22,
            finish = 22,
            [1]    = 'c',
        },
    },
    [1]    = {
        type   = 'return',
        start  = 31,
        finish = 36,
    }
}
CHECK[[
while true do
    return
end]]
{
    type   = 'while',
    start  = 1,
    finish = 28,
    filter = {
        type   = 'boolean',
        start  = 7,
        finish = 10,
        [1]    = true,
    },
    [1]    = {
        type   = 'return',
        start  = 19,
        finish = 24,
    }
}
CHECK[[
repeat
    break
until 1]]
{
    type   = 'repeat',
    start  = 1,
    finish = 24,
    filter = {
        type   = 'number',
        start  = 24,
        finish = 24,
        [1]    = 1,
    },
    [1]    = {
        type = 'break',
    }
}
CHECK[[
function test()
    return
end]]
{
    type      = 'function',
    start     = 1,
    finish    = 30,
    argStart  = 14,
    argFinish = 15,
    name      = {
        type   = 'name',
        start  = 10,
        finish = 13,
        [1]    = 'test',
    },
    [1]       = {
        type   = 'return',
        start  = 21,
        finish = 26,
    }
}
CHECK[[
function test(a)
    return
end]]
{
    type      = 'function',
    start     = 1,
    finish    = 31,
    argStart  = 14,
    argFinish = 16,
    name      = {
        type   = 'name',
        start  = 10,
        finish = 13,
        [1]    = 'test',
    },
    arg       = {
        type   = 'name',
        start  = 15,
        finish = 15,
        [1]    = 'a',
    },
    [1]       = {
        type   = 'return',
        start  = 22,
        finish = 27,
    }
}
CHECK[[
function a.b:c(a, b, c)
    return
end]]
{
    type      = 'function',
    start     = 1,
    finish    = 38,
    argStart  = 15,
    argFinish = 23,
    name      = {
        type   = 'simple',
        start  = 10,
        finish = 14,
        [1]  = {
            type   = 'name',
            start  = 10,
            finish = 10,
            [1]    = 'a',
        },
        [2]  = {
            type   = '.',
            start  = 11,
            finish = 11,
        },
        [3]  = {
            type   = 'name',
            start  = 12,
            finish = 12,
            [1]    = 'b',
        },
        [4]  = {
            type   = ':',
            start  = 13,
            finish = 13,
        },
        [5]  = {
            type   = 'name',
            start  = 14,
            finish = 14,
            [1]    = 'c',
        }
    },
    arg       = {
        type   = 'list',
        start  = 16,
        finish = 22,
        [1]  = {
            type   = 'name',
            start  = 16,
            finish = 16,
            [1]    = 'a',
        },
        [2]  = {
            type   = 'name',
            start  = 19,
            finish = 19,
            [1]    = 'b',
        },
        [3]  = {
            type   = 'name',
            start  = 22,
            finish = 22,
            [1]    = 'c',
        },
    },
    [1]       = {
        type   = 'return',
        start  = 29,
        finish = 34,
    }
}
CHECK[[
local function a()
    return
end]]
{
    type      = 'localfunction',
    start     = 1,
    finish    = 33,
    argStart  = 17,
    argFinish = 18,
    name   = {
        type   = 'name',
        start  = 16,
        finish = 16,
        [1]    = 'a',
    },
    [1]    = {
        type   = 'return',
        start  = 24,
        finish = 29,
    }
}
CHECK[[
local function a(b, c)
    return
end]]
{
    type      = 'localfunction',
    start     = 1,
    finish    = 37,
    argStart  = 17,
    argFinish = 22,
    name   = {
        type   = 'name',
        start  = 16,
        finish = 16,
        [1]    = 'a',
    },
    arg    = {
        type   = 'list',
        start  = 18,
        finish = 21,
        [1]  = {
            type   = 'name',
            start  = 18,
            finish = 18,
            [1]    = 'b',
        },
        [2]  = {
            type   = 'name',
            start  = 21,
            finish = 21,
            [1]    = 'c',
        },
    },
    [1]    = {
        type = 'return',
        start  = 28,
        finish = 33,
    }
}

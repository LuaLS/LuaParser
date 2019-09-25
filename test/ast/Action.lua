CHECK'x = 1'
{
    [1] = {
        type   = "setglobal",
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
        effect = 8,
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
        effect = 12,
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
CHECK'local x = x'
{
    [1] = {
        value  = 2,
        type   = "local",
        start  = 7,
        finish = 7,
        effect = 12,
        [1]    = "x",
    },
    [2] = {
        type   = "getglobal",
        start  = 11,
        finish = 11,
        parent = 1,
        [1]    = "x",
    },
}
CHECK'local x <close> <const> = 1'
{
    [1] = {
        type   = "local",
        start  = 7,
        finish = 7,
        effect = 28,
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
        effect = 22,
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
CHECK 'x.y = 1'
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
        field  = {
            type   = "field",
            start  = 3,
            finish = 3,
            [1]    = "y",
        },
        value  = 3,
    },
    [2] = {
        type   = "getglobal",
        start  = 1,
        finish = 1,
        parent = 1,
        [1]    = "x",
    },
    [3] = {
        type   = "number",
        start  = 7,
        finish = 7,
        parent = 1,
        [1]    = 1,
    },
}
CHECK 'x[y] = 1'
{
    [1] = {
        type   = "setindex",
        start  = 1,
        finish = 4,
        node   = 2,
        index  = 3,
        value  = 4,
    },
    [2] = {
        type   = "getglobal",
        start  = 1,
        finish = 1,
        parent = 1,
        [1]    = "x",
    },
    [3] = {
        type   = "getglobal",
        start  = 3,
        finish = 3,
        parent = 1,
        [1]    = "y",
    },
    [4] = {
        type   = "number",
        start  = 8,
        finish = 8,
        parent = 1,
        [1]    = 1,
    },
}
CHECK'x = function () end'
{
    [1] = {
        type   = "setglobal",
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
        field  = {
            type   = "field",
            start  = 3,
            finish = 3,
            [1]    = "y",
        },
        value  = 3,
    },
    [2] = {
        type   = "getglobal",
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
        type   = "getglobal",
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
        type   = "getglobal",
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
        type   = "setglobal",
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
for i = 1, i do
    return
end]]
{
    [1] = {
        locals = {
            [1] = 2,
        },
        type   = "loop",
        start  = 1,
        finish = 30,
        loc    = 2,
        max    = 4,
        [1]    = 5,
    },
    [2] = {
        type   = "local",
        start  = 5,
        finish = 5,
        effect = 16,
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
        type   = "getglobal",
        start  = 12,
        finish = 12,
        parent = 1,
        [1]    = "i",
    },
    [5] = {
        type   = "return",
        start  = 21,
        finish = 27,
        parent = 1,
    },
}
CHECK[[
for i = 1, 10, i do
    return
end]]
{
    [1] = {
        locals = {
            [1] = 2,
        },
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
        effect = 20,
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
        type   = "getglobal",
        start  = 16,
        finish = 16,
        parent = 1,
        [1]    = "i",
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
        locals = {
            [1] = 2,
        },
        type   = "in",
        start  = 1,
        finish = 28,
        keys   = {
            [1] = 2,
        },
        [1]    = 7,
    },
    [2] = {
        type   = "local",
        start  = 5,
        finish = 5,
        effect = 14,
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
        start  = 11,
        finish = 10,
        parent = 3,
        node   = 5,
        args   = 6,
    },
    [5] = {
        type   = "getglobal",
        start  = 10,
        finish = 10,
        parent = 4,
        [1]    = "a",
    },
    [6] = {
        type   = "callargs",
        start  = 11,
        finish = 10,
        parent = 4,
    },
    [7] = {
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
        keys   = {
            [1] = 2,
            [2] = 9,
            [3] = 11,
        },
        locals = {
            [1] = 2,
            [2] = 9,
            [3] = 11,
        },
        [1]    = 13,
    },
    [02] = {
        type   = "local",
        start  = 5,
        finish = 5,
        effect = 26,
        parent = 1,
        value  = 3,
        [1]    = "a",
    },
    [03] = {
        type   = "select",
        parent = 2,
        vararg = 4,
        index  = 1,
    },
    [04] = {
        type      = "call",
        start     = 17,
        finish    = 22,
        parent    = 3,
        extParent = {
            [1] = 10,
            [2] = 12,
        },
        node      = 5,
        args      = 6,
    },
    [05] = {
        type   = "getglobal",
        start  = 16,
        finish = 16,
        parent = 4,
        [1]    = "a",
    },
    [06] = {
        type   = "callargs",
        start  = 17,
        finish = 22,
        parent = 4,
        [1]    = 7,
        [2]    = 8,
    },
    [07] = {
        type   = "getglobal",
        start  = 19,
        finish = 19,
        parent = 6,
        [1]    = "b",
    },
    [08] = {
        type   = "getglobal",
        start  = 22,
        finish = 22,
        parent = 6,
        [1]    = "c",
    },
    [09] = {
        type   = "local",
        start  = 8,
        finish = 8,
        effect = 26,
        parent = 1,
        value  = 10,
        [1]    = "b",
    },
    [10] = {
        type   = "select",
        parent = 9,
        vararg = 4,
        index  = 2,
    },
    [11] = {
        type   = "local",
        start  = 11,
        finish = 11,
        effect = 26,
        parent = 1,
        value  = 12,
        [1]    = "c",
    },
    [12] = {
        type   = "select",
        parent = 11,
        vararg = 4,
        index  = 3,
    },
    [13] = {
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
        type   = "setglobal",
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
        [1]    = 3,
    },
    [3] = {
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
        type   = "setglobal",
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
        locals   = {
            [1] = 4,
        },
        [1]    = 5,
    },
    [3] = {
        type   = "funcargs",
        start  = 14,
        finish = 16,
        parent = 2,
        [1]    = 4,
    },
    [4] = {
        type   = "local",
        start  = 15,
        finish = 15,
        effect = 15,
        parent = 3,
        [1]    = "a",
    },
    [5] = {
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
    [01] = {
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
    [02] = {
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
    [03] = {
        type   = "getglobal",
        start  = 10,
        finish = 10,
        parent = 2,
        [1]    = "a",
    },
    [04] = {
        type   = "method",
        start  = 14,
        finish = 14,
        parent = 1,
        [1]    = "c",
    },
    [05] = {
        type   = "function",
        start  = 1,
        finish = 38,
        parent = 1,
        args   = 7,
        locals = {
            [1] = 6,
            [2] = 8,
            [3] = 9,
            [4] = 10,
        },
        [1]    = 11,
    },
    [06] = {
        type   = "local",
        start  = 0,
        finish = 0,
        effect = 14,
        parent = 5,
        [1]    = "self",
    },
    [07] = {
        type   = "funcargs",
        start  = 15,
        finish = 23,
        parent = 5,
        [1]    = 8,
        [2]    = 9,
        [3]    = 10,
    },
    [08] = {
        type   = "local",
        start  = 16,
        finish = 16,
        effect = 16,
        parent = 7,
        [1]    = "a",
    },
    [09] = {
        type   = "local",
        start  = 19,
        finish = 19,
        effect = 19,
        parent = 7,
        [1]    = "b",
    },
    [10] = {
        type   = "local",
        start  = 22,
        finish = 22,
        effect = 22,
        parent = 7,
        [1]    = "c",
    },
    [11] = {
        type   = "return",
        start  = 29,
        finish = 35,
        parent = 5,
    },
}
CHECK[[
function m:f()
    return self
end]]
{
    [1] = {
        type   = "setmethod",
        start  = 10,
        finish = 12,
        node   = 2,
        colon  = {
            type   = ":",
            start  = 11,
            finish = 11,
        },
        method = 3,
        value  = 4,
    },
    [2] = {
        type   = "getglobal",
        start  = 10,
        finish = 10,
        parent = 1,
        [1]    = "m",
    },
    [3] = {
        type   = "method",
        start  = 12,
        finish = 12,
        parent = 1,
        [1]    = "f",
    },
    [4] = {
        type   = "function",
        start  = 1,
        finish = 34,
        parent = 1,
        locals = {
            [1] = 5,
        },
        [1]    = 6,
    },
    [5] = {
        type   = "local",
        start  = 0,
        finish = 0,
        effect = 12,
        parent = 4,
        ref    = {
            [1] = 7,
        },
        [1]    = "self",
    },
    [6] = {
        type   = "return",
        start  = 20,
        finish = 30,
        parent = 4,
        [1]    = 7,
    },
    [7] = {
        type   = "getlocal",
        start  = 27,
        finish = 30,
        parent = 6,
        loc    = 5,
        [1]    = "self",
    },
}

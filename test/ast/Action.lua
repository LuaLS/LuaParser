CHECK'x = 1'
{
    type   = "setglobal",
    start  = 1,
    finish = 1,
    range  = 5,
    value  = {
        type   = "number",
        start  = 5,
        finish = 5,
        [1]    = 1,
    },
    [1]    = "x",
}
CHECK'local x'
{
    type   = "local",
    start  = 7,
    finish = 7,
    effect = 8,
    [1]    = "x",
}
CHECK'local x = 1'
{
    type   = "local",
    start  = 7,
    finish = 7,
    effect = 12,
    range  = 11,
    value  = {
        type   = "number",
        start  = 11,
        finish = 11,
        [1]    = 1,
    },
    [1]    = "x",
}
CHECK'local x = x'
{
    type   = "local",
    start  = 7,
    finish = 7,
    effect = 12,
    range  = 11,
    value  = {
        type   = "getglobal",
        start  = 11,
        finish = 11,
        parent = "<LOOP>",
        [1]    = "x",
    },
    [1]    = "x",
}
CHECK'local x <close> <const> = 1'
{
    type   = "local",
    start  = 7,
    finish = 7,
    effect = 28,
    range  = 27,
    value  = {
        type   = "number",
        start  = 27,
        finish = 27,
        [1]    = 1,
    },
    attrs  = {
        [1] = {
            type   = "localattr",
            start  = 10,
            finish = 14,
            [1]    = "close",
        },
        [2] = {
            type   = "localattr",
            start  = 18,
            finish = 22,
            [1]    = "const",
        },
    },
    [1]    = "x",
}
CHECK'local x < const > = 1'
{
    type   = "local",
    start  = 7,
    finish = 7,
    effect = 22,
    range  = 21,
    value  = {
        type   = "number",
        start  = 21,
        finish = 21,
        [1]    = 1,
    },
    attrs  = {
        [1] = {
            type   = "localattr",
            start  = 11,
            finish = 15,
            [1]    = "const",
        },
    },
    [1]    = "x",
}
CHECK 'x.y = 1'
{
    type   = "setfield",
    start  = 1,
    finish = 3,
    range  = 7,
    node   = {
        type   = "getglobal",
        start  = 1,
        finish = 1,
        parent = "<LOOP>",
        [1]    = "x",
    },
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
    value  = {
        type   = "number",
        start  = 7,
        finish = 7,
        [1]    = 1,
    },
}
CHECK 'x[y] = 1'
{
    type   = "setindex",
    start  = 1,
    finish = 4,
    range  = 8,
    node   = {
        type   = "getglobal",
        start  = 1,
        finish = 1,
        parent = "<LOOP>",
        [1]    = "x",
    },
    index  = {
        type   = "getglobal",
        start  = 3,
        finish = 3,
        parent = "<LOOP>",
        [1]    = "y",
    },
    value  = {
        type   = "number",
        start  = 8,
        finish = 8,
        [1]    = 1,
    },
}
CHECK'x = function () end'
{
    type   = "setglobal",
    start  = 1,
    finish = 1,
    range  = 19,
    value  = {
        type   = "function",
        start  = 5,
        finish = 19,
        parent = "<LOOP>",
    },
    [1]    = "x",
}
CHECK'x.y = function () end'
{
    type   = "setfield",
    start  = 1,
    finish = 3,
    range  = 21,
    node   = {
        type   = "getglobal",
        start  = 1,
        finish = 1,
        parent = "<LOOP>",
        [1]    = "x",
    },
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
    value  = {
        type   = "function",
        start  = 7,
        finish = 21,
        parent = "<LOOP>",
    },
}
CHECK'func.x(1, 2)'
{
    type   = "call",
    start  = 1,
    finish = 12,
    node   = {
        type   = "getfield",
        start  = 1,
        finish = 6,
        parent = "<LOOP>",
        node   = {
            type   = "getglobal",
            start  = 1,
            finish = 4,
            parent = "<LOOP>",
            [1]    = "func",
        },
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
    args   = {
        type   = "callargs",
        start  = 7,
        finish = 12,
        parent = "<LOOP>",
        [1]    = {
            type   = "number",
            start  = 8,
            finish = 8,
            [1]    = 1,
        },
        [2]    = {
            type   = "number",
            start  = 11,
            finish = 11,
            [1]    = 2,
        },
    },
}
CHECK'func:x(1, 2)'
{
    type   = "call",
    start  = 1,
    finish = 12,
    node   = {
        type   = "getmethod",
        start  = 1,
        finish = 6,
        parent = "<LOOP>",
        node   = {
            type   = "getglobal",
            start  = 1,
            finish = 4,
            parent = "<LOOP>",
            [1]    = "func",
        },
        colon  = {
            type   = ":",
            start  = 5,
            finish = 5,
        },
        method = {
            type   = "method",
            start  = 6,
            finish = 6,
            [1]    = "x",
        },
    },
    args   = {
        type   = "callargs",
        start  = 7,
        finish = 12,
        parent = "<LOOP>",
        [1]    = {
            type   = "number",
            start  = 8,
            finish = 8,
            [1]    = 1,
        },
        [2]    = {
            type   = "number",
            start  = 11,
            finish = 11,
            [1]    = 2,
        },
    },
}
CHECK'("%s"):format(1)'
{
    type   = "call",
    start  = 1,
    finish = 16,
    node   = {
        type   = "getmethod",
        start  = 1,
        finish = 13,
        parent = "<LOOP>",
        node   = {
            type   = "paren",
            start  = 1,
            finish = 6,
            parent = "<LOOP>",
            exp    = {
                type   = "string",
                start  = 2,
                finish = 5,
                [1]    = "%s",
                [2]    = "\"",
            },
        },
        colon  = {
            type   = ":",
            start  = 7,
            finish = 7,
        },
        method = {
            type   = "method",
            start  = 8,
            finish = 13,
            [1]    = "format",
        },
    },
    args   = {
        type   = "callargs",
        start  = 14,
        finish = 16,
        parent = "<LOOP>",
        [1]    = {
            type   = "number",
            start  = 15,
            finish = 15,
            [1]    = 1,
        },
    },
}
CHECK'do end'
{
    type   = "do",
    start  = 1,
    finish = 6,
}
CHECK'do x = 1 end'
{
    type   = "do",
    start  = 1,
    finish = 12,
    [1]    = {
        type   = "setglobal",
        start  = 4,
        finish = 4,
        range  = 8,
        parent = "<LOOP>",
        value  = {
            type   = "number",
            start  = 8,
            finish = 8,
            [1]    = 1,
        },
        [1]    = "x",
    },
}
CHECK'return'
{
    type   = "return",
    start  = 1,
    finish = 6,
}
CHECK'return 1'
{
    type   = "return",
    start  = 1,
    finish = 8,
    [1]    = {
        type   = "number",
        start  = 8,
        finish = 8,
        [1]    = 1,
    },
}
CHECK'return 1, 2'
{
    type   = "return",
    start  = 1,
    finish = 11,
    [1]    = {
        type   = "number",
        start  = 8,
        finish = 8,
        [1]    = 1,
    },
    [2]    = {
        type   = "number",
        start  = 11,
        finish = 11,
        [1]    = 2,
    },
}
CHECK'::CONTINUE::'
{
    type   = "label",
    start  = 3,
    finish = 10,
    [1]    = "CONTINUE",
}
CHECK'goto CONTINUE'
{
    type   = "goto",
    start  = 6,
    finish = 13,
    [1]    = "CONTINUE",
}
CHECK[[if 1 then
end]]
{
    type   = "if",
    start  = 1,
    finish = 13,
    [1]    = {
        type   = "ifblock",
        start  = 1,
        finish = 9,
        parent = "<LOOP>",
        filter = {
            type   = "number",
            start  = 4,
            finish = 4,
            [1]    = 1,
        },
    },
}
CHECK[[if 1 then
    return
end]]
{
    type   = "if",
    start  = 1,
    finish = 24,
    [1]    = {
        type   = "ifblock",
        start  = 1,
        finish = 21,
        parent = "<LOOP>",
        filter = {
            type   = "number",
            start  = 4,
            finish = 4,
            [1]    = 1,
        },
        [1]    = {
            type   = "return",
            start  = 15,
            finish = 21,
            parent = "<LOOP>",
        },
    },
}
CHECK[[if 1 then
    return
else
    return
end]]
{
    type   = "if",
    start  = 1,
    finish = 40,
    [1]    = {
        type   = "ifblock",
        start  = 1,
        finish = 21,
        parent = "<LOOP>",
        filter = {
            type   = "number",
            start  = 4,
            finish = 4,
            [1]    = 1,
        },
        [1]    = {
            type   = "return",
            start  = 15,
            finish = 21,
            parent = "<LOOP>",
        },
    },
    [2]    = {
        type   = "elseblock",
        start  = 22,
        finish = 37,
        parent = "<LOOP>",
        [1]    = {
            type   = "return",
            start  = 31,
            finish = 37,
            parent = "<LOOP>",
        },
    },
}
CHECK[[if 1 then
    return
elseif 1 then
    return
end]]
{
    type   = "if",
    start  = 1,
    finish = 49,
    [1]    = {
        type   = "ifblock",
        start  = 1,
        finish = 21,
        parent = "<LOOP>",
        filter = {
            type   = "number",
            start  = 4,
            finish = 4,
            [1]    = 1,
        },
        [1]    = {
            type   = "return",
            start  = 15,
            finish = 21,
            parent = "<LOOP>",
        },
    },
    [2]    = {
        type   = "elseifblock",
        start  = 22,
        finish = 46,
        parent = "<LOOP>",
        filter = {
            type   = "number",
            start  = 29,
            finish = 29,
            [1]    = 1,
        },
        [1]    = {
            type   = "return",
            start  = 40,
            finish = 46,
            parent = "<LOOP>",
        },
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
    type   = "if",
    start  = 1,
    finish = 65,
    [1]    = {
        type   = "ifblock",
        start  = 1,
        finish = 21,
        parent = "<LOOP>",
        filter = {
            type   = "number",
            start  = 4,
            finish = 4,
            [1]    = 1,
        },
        [1]    = {
            type   = "return",
            start  = 15,
            finish = 21,
            parent = "<LOOP>",
        },
    },
    [2]    = {
        type   = "elseifblock",
        start  = 22,
        finish = 46,
        parent = "<LOOP>",
        filter = {
            type   = "number",
            start  = 29,
            finish = 29,
            [1]    = 1,
        },
        [1]    = {
            type   = "return",
            start  = 40,
            finish = 46,
            parent = "<LOOP>",
        },
    },
    [3]    = {
        type   = "elseblock",
        start  = 47,
        finish = 62,
        parent = "<LOOP>",
        [1]    = {
            type   = "return",
            start  = 56,
            finish = 62,
            parent = "<LOOP>",
        },
    },
}
CHECK[[
if 1 then
elseif 1 then
elseif 1 then
elseif 1 then
end]]
{
    type   = "if",
    start  = 1,
    finish = 55,
    [1]    = {
        type   = "ifblock",
        start  = 1,
        finish = 9,
        parent = "<LOOP>",
        filter = {
            type   = "number",
            start  = 4,
            finish = 4,
            [1]    = 1,
        },
    },
    [2]    = {
        type   = "elseifblock",
        start  = 11,
        finish = 23,
        parent = "<LOOP>",
        filter = {
            type   = "number",
            start  = 18,
            finish = 18,
            [1]    = 1,
        },
    },
    [3]    = {
        type   = "elseifblock",
        start  = 25,
        finish = 37,
        parent = "<LOOP>",
        filter = {
            type   = "number",
            start  = 32,
            finish = 32,
            [1]    = 1,
        },
    },
    [4]    = {
        type   = "elseifblock",
        start  = 39,
        finish = 51,
        parent = "<LOOP>",
        filter = {
            type   = "number",
            start  = 46,
            finish = 46,
            [1]    = 1,
        },
    },
}
CHECK[[
if 1 then
    if 2 then
    end
end]]
{
    type   = "if",
    start  = 1,
    finish = 35,
    [1]    = {
        type   = "ifblock",
        start  = 1,
        finish = 31,
        parent = "<LOOP>",
        filter = {
            type   = "number",
            start  = 4,
            finish = 4,
            [1]    = 1,
        },
        [1]    = {
            type   = "if",
            start  = 15,
            finish = 31,
            parent = "<LOOP>",
            [1]    = {
                type   = "ifblock",
                start  = 15,
                finish = 23,
                parent = "<LOOP>",
                filter = {
                    type   = "number",
                    start  = 18,
                    finish = 18,
                    [1]    = 2,
                },
            },
        },
    },
}
CHECK[[
if 1 then
elseif 1 then
else
end]]
{
    type   = "if",
    start  = 1,
    finish = 32,
    [1]    = {
        type   = "ifblock",
        start  = 1,
        finish = 9,
        parent = "<LOOP>",
        filter = {
            type   = "number",
            start  = 4,
            finish = 4,
            [1]    = 1,
        },
    },
    [2]    = {
        type   = "elseifblock",
        start  = 11,
        finish = 23,
        parent = "<LOOP>",
        filter = {
            type   = "number",
            start  = 18,
            finish = 18,
            [1]    = 1,
        },
    },
    [3]    = {
        type   = "elseblock",
        start  = 25,
        finish = 28,
        parent = "<LOOP>",
    },
}
CHECK[[
for i = 1, i do
    return
end]]
{
    type   = "loop",
    start  = 1,
    finish = 30,
    loc    = {
        type   = "local",
        start  = 5,
        finish = 5,
        effect = 16,
        range  = 9,
        parent = "<LOOP>",
        value  = {
            type   = "number",
            start  = 9,
            finish = 9,
            [1]    = 1,
        },
        [1]    = "i",
    },
    max    = {
        type   = "getglobal",
        start  = 12,
        finish = 12,
        parent = "<LOOP>",
        [1]    = "i",
    },
    locals = {
        [1] = {
            type   = "local",
            start  = 5,
            finish = 5,
            effect = 16,
            range  = 9,
            parent = "<LOOP>",
            value  = {
                type   = "number",
                start  = 9,
                finish = 9,
                [1]    = 1,
            },
            [1]    = "i",
        },
    },
    [1]    = {
        type   = "return",
        start  = 21,
        finish = 27,
        parent = "<LOOP>",
    },
}
CHECK[[
for i = 1, 10, i do
    return
end]]
{
    type   = "loop",
    start  = 1,
    finish = 34,
    loc    = {
        type   = "local",
        start  = 5,
        finish = 5,
        effect = 20,
        range  = 9,
        parent = "<LOOP>",
        value  = {
            type   = "number",
            start  = 9,
            finish = 9,
            [1]    = 1,
        },
        [1]    = "i",
    },
    max    = {
        type   = "number",
        start  = 12,
        finish = 13,
        [1]    = 10,
    },
    step   = {
        type   = "getglobal",
        start  = 16,
        finish = 16,
        parent = "<LOOP>",
        [1]    = "i",
    },
    locals = {
        [1] = {
            type   = "local",
            start  = 5,
            finish = 5,
            effect = 20,
            range  = 9,
            parent = "<LOOP>",
            value  = {
                type   = "number",
                start  = 9,
                finish = 9,
                [1]    = 1,
            },
            [1]    = "i",
        },
    },
    [1]    = {
        type   = "return",
        start  = 25,
        finish = 31,
        parent = "<LOOP>",
    },
}
CHECK[[
for a in a do
    return
end]]
{
    type   = "in",
    start  = 1,
    finish = 28,
    keys   = {
        type   = "list",
        start  = 4,
        finish = 5,
        [1]    = {
            type   = "local",
            start  = 5,
            finish = 5,
            effect = 14,
            range  = 10,
            parent = "<LOOP>",
            value  = {
                type   = "select",
                start  = 11,
                finish = 10,
                parent = "<LOOP>",
                vararg = {
                    type   = "call",
                    start  = 11,
                    finish = 10,
                    parent = "<LOOP>",
                    node   = {
                        type   = "getglobal",
                        start  = 10,
                        finish = 10,
                        parent = "<LOOP>",
                        [1]    = "a",
                    },
                    args   = {
                        type   = "callargs",
                        start  = 11,
                        finish = 10,
                        parent = "<LOOP>",
                    },
                },
                index  = 1,
            },
            [1]    = "a",
        },
    },
    locals = {
        [1] = {
            type   = "local",
            start  = 5,
            finish = 5,
            effect = 14,
            range  = 10,
            parent = "<LOOP>",
            value  = {
                type   = "select",
                start  = 11,
                finish = 10,
                parent = "<LOOP>",
                vararg = {
                    type   = "call",
                    start  = 11,
                    finish = 10,
                    parent = "<LOOP>",
                    node   = {
                        type   = "getglobal",
                        start  = 10,
                        finish = 10,
                        parent = "<LOOP>",
                        [1]    = "a",
                    },
                    args   = {
                        type   = "callargs",
                        start  = 11,
                        finish = 10,
                        parent = "<LOOP>",
                    },
                },
                index  = 1,
            },
            [1]    = "a",
        },
    },
    [1]    = {
        type   = "return",
        start  = 19,
        finish = 25,
        parent = "<LOOP>",
    },
}
CHECK[[
for a, b, c in a, b, c do
    return
end]]
{
    type   = "in",
    start  = 1,
    finish = 40,
    keys   = {
        type   = "list",
        start  = 4,
        finish = 11,
        [1]    = {
            type   = "local",
            start  = 5,
            finish = 5,
            effect = 26,
            range  = 22,
            parent = "<LOOP>",
            value  = {
                type   = "select",
                start  = 17,
                finish = 22,
                parent = "<LOOP>",
                vararg = {
                    type      = "call",
                    start     = 17,
                    finish    = 22,
                    parent    = "<LOOP>",
                    extParent = {
                        [1] = {
                            type   = "select",
                            start  = 17,
                            finish = 22,
                            parent = {
                                type   = "local",
                                start  = 8,
                                finish = 8,
                                effect = 26,
                                range  = 22,
                                parent = "<LOOP>",
                                value  = "<LOOP>",
                                [1]    = "b",
                            },
                            vararg = "<LOOP>",
                            index  = 2,
                        },
                        [2] = {
                            type   = "select",
                            start  = 17,
                            finish = 22,
                            parent = {
                                type   = "local",
                                start  = 11,
                                finish = 11,
                                effect = 26,
                                range  = 22,
                                parent = "<LOOP>",
                                value  = "<LOOP>",
                                [1]    = "c",
                            },
                            vararg = "<LOOP>",
                            index  = 3,
                        },
                    },
                    node      = {
                        type   = "getglobal",
                        start  = 16,
                        finish = 16,
                        parent = "<LOOP>",
                        [1]    = "a",
                    },
                    args      = {
                        type   = "callargs",
                        start  = 17,
                        finish = 22,
                        parent = "<LOOP>",
                        [1]    = {
                            type   = "getglobal",
                            start  = 19,
                            finish = 19,
                            parent = "<LOOP>",
                            [1]    = "b",
                        },
                        [2]    = {
                            type   = "getglobal",
                            start  = 22,
                            finish = 22,
                            parent = "<LOOP>",
                            [1]    = "c",
                        },
                    },
                },
                index  = 1,
            },
            [1]    = "a",
        },
        [2]    = {
            type   = "local",
            start  = 8,
            finish = 8,
            effect = 26,
            range  = 22,
            parent = "<LOOP>",
            value  = {
                type   = "select",
                start  = 17,
                finish = 22,
                parent = "<LOOP>",
                vararg = {
                    type      = "call",
                    start     = 17,
                    finish    = 22,
                    parent    = {
                        type   = "select",
                        start  = 17,
                        finish = 22,
                        parent = {
                            type   = "local",
                            start  = 5,
                            finish = 5,
                            effect = 26,
                            range  = 22,
                            parent = "<LOOP>",
                            value  = "<LOOP>",
                            [1]    = "a",
                        },
                        vararg = "<LOOP>",
                        index  = 1,
                    },
                    extParent = {
                        [1] = "<LOOP>",
                        [2] = {
                            type   = "select",
                            start  = 17,
                            finish = 22,
                            parent = {
                                type   = "local",
                                start  = 11,
                                finish = 11,
                                effect = 26,
                                range  = 22,
                                parent = "<LOOP>",
                                value  = "<LOOP>",
                                [1]    = "c",
                            },
                            vararg = "<LOOP>",
                            index  = 3,
                        },
                    },
                    node      = {
                        type   = "getglobal",
                        start  = 16,
                        finish = 16,
                        parent = "<LOOP>",
                        [1]    = "a",
                    },
                    args      = {
                        type   = "callargs",
                        start  = 17,
                        finish = 22,
                        parent = "<LOOP>",
                        [1]    = {
                            type   = "getglobal",
                            start  = 19,
                            finish = 19,
                            parent = "<LOOP>",
                            [1]    = "b",
                        },
                        [2]    = {
                            type   = "getglobal",
                            start  = 22,
                            finish = 22,
                            parent = "<LOOP>",
                            [1]    = "c",
                        },
                    },
                },
                index  = 2,
            },
            [1]    = "b",
        },
        [3]    = {
            type   = "local",
            start  = 11,
            finish = 11,
            effect = 26,
            range  = 22,
            parent = "<LOOP>",
            value  = {
                type   = "select",
                start  = 17,
                finish = 22,
                parent = "<LOOP>",
                vararg = {
                    type      = "call",
                    start     = 17,
                    finish    = 22,
                    parent    = {
                        type   = "select",
                        start  = 17,
                        finish = 22,
                        parent = {
                            type   = "local",
                            start  = 5,
                            finish = 5,
                            effect = 26,
                            range  = 22,
                            parent = "<LOOP>",
                            value  = "<LOOP>",
                            [1]    = "a",
                        },
                        vararg = "<LOOP>",
                        index  = 1,
                    },
                    extParent = {
                        [1] = {
                            type   = "select",
                            start  = 17,
                            finish = 22,
                            parent = {
                                type   = "local",
                                start  = 8,
                                finish = 8,
                                effect = 26,
                                range  = 22,
                                parent = "<LOOP>",
                                value  = "<LOOP>",
                                [1]    = "b",
                            },
                            vararg = "<LOOP>",
                            index  = 2,
                        },
                        [2] = "<LOOP>",
                    },
                    node      = {
                        type   = "getglobal",
                        start  = 16,
                        finish = 16,
                        parent = "<LOOP>",
                        [1]    = "a",
                    },
                    args      = {
                        type   = "callargs",
                        start  = 17,
                        finish = 22,
                        parent = "<LOOP>",
                        [1]    = {
                            type   = "getglobal",
                            start  = 19,
                            finish = 19,
                            parent = "<LOOP>",
                            [1]    = "b",
                        },
                        [2]    = {
                            type   = "getglobal",
                            start  = 22,
                            finish = 22,
                            parent = "<LOOP>",
                            [1]    = "c",
                        },
                    },
                },
                index  = 3,
            },
            [1]    = "c",
        },
    },
    locals = {
        [1] = {
            type   = "local",
            start  = 5,
            finish = 5,
            effect = 26,
            range  = 22,
            parent = "<LOOP>",
            value  = {
                type   = "select",
                start  = 17,
                finish = 22,
                parent = "<LOOP>",
                vararg = {
                    type      = "call",
                    start     = 17,
                    finish    = 22,
                    parent    = "<LOOP>",
                    extParent = {
                        [1] = {
                            type   = "select",
                            start  = 17,
                            finish = 22,
                            parent = {
                                type   = "local",
                                start  = 8,
                                finish = 8,
                                effect = 26,
                                range  = 22,
                                parent = "<LOOP>",
                                value  = "<LOOP>",
                                [1]    = "b",
                            },
                            vararg = "<LOOP>",
                            index  = 2,
                        },
                        [2] = {
                            type   = "select",
                            start  = 17,
                            finish = 22,
                            parent = {
                                type   = "local",
                                start  = 11,
                                finish = 11,
                                effect = 26,
                                range  = 22,
                                parent = "<LOOP>",
                                value  = "<LOOP>",
                                [1]    = "c",
                            },
                            vararg = "<LOOP>",
                            index  = 3,
                        },
                    },
                    node      = {
                        type   = "getglobal",
                        start  = 16,
                        finish = 16,
                        parent = "<LOOP>",
                        [1]    = "a",
                    },
                    args      = {
                        type   = "callargs",
                        start  = 17,
                        finish = 22,
                        parent = "<LOOP>",
                        [1]    = {
                            type   = "getglobal",
                            start  = 19,
                            finish = 19,
                            parent = "<LOOP>",
                            [1]    = "b",
                        },
                        [2]    = {
                            type   = "getglobal",
                            start  = 22,
                            finish = 22,
                            parent = "<LOOP>",
                            [1]    = "c",
                        },
                    },
                },
                index  = 1,
            },
            [1]    = "a",
        },
        [2] = {
            type   = "local",
            start  = 8,
            finish = 8,
            effect = 26,
            range  = 22,
            parent = "<LOOP>",
            value  = {
                type   = "select",
                start  = 17,
                finish = 22,
                parent = "<LOOP>",
                vararg = {
                    type      = "call",
                    start     = 17,
                    finish    = 22,
                    parent    = {
                        type   = "select",
                        start  = 17,
                        finish = 22,
                        parent = {
                            type   = "local",
                            start  = 5,
                            finish = 5,
                            effect = 26,
                            range  = 22,
                            parent = "<LOOP>",
                            value  = "<LOOP>",
                            [1]    = "a",
                        },
                        vararg = "<LOOP>",
                        index  = 1,
                    },
                    extParent = {
                        [1] = "<LOOP>",
                        [2] = {
                            type   = "select",
                            start  = 17,
                            finish = 22,
                            parent = {
                                type   = "local",
                                start  = 11,
                                finish = 11,
                                effect = 26,
                                range  = 22,
                                parent = "<LOOP>",
                                value  = "<LOOP>",
                                [1]    = "c",
                            },
                            vararg = "<LOOP>",
                            index  = 3,
                        },
                    },
                    node      = {
                        type   = "getglobal",
                        start  = 16,
                        finish = 16,
                        parent = "<LOOP>",
                        [1]    = "a",
                    },
                    args      = {
                        type   = "callargs",
                        start  = 17,
                        finish = 22,
                        parent = "<LOOP>",
                        [1]    = {
                            type   = "getglobal",
                            start  = 19,
                            finish = 19,
                            parent = "<LOOP>",
                            [1]    = "b",
                        },
                        [2]    = {
                            type   = "getglobal",
                            start  = 22,
                            finish = 22,
                            parent = "<LOOP>",
                            [1]    = "c",
                        },
                    },
                },
                index  = 2,
            },
            [1]    = "b",
        },
        [3] = {
            type   = "local",
            start  = 11,
            finish = 11,
            effect = 26,
            range  = 22,
            parent = "<LOOP>",
            value  = {
                type   = "select",
                start  = 17,
                finish = 22,
                parent = "<LOOP>",
                vararg = {
                    type      = "call",
                    start     = 17,
                    finish    = 22,
                    parent    = {
                        type   = "select",
                        start  = 17,
                        finish = 22,
                        parent = {
                            type   = "local",
                            start  = 5,
                            finish = 5,
                            effect = 26,
                            range  = 22,
                            parent = "<LOOP>",
                            value  = "<LOOP>",
                            [1]    = "a",
                        },
                        vararg = "<LOOP>",
                        index  = 1,
                    },
                    extParent = {
                        [1] = {
                            type   = "select",
                            start  = 17,
                            finish = 22,
                            parent = {
                                type   = "local",
                                start  = 8,
                                finish = 8,
                                effect = 26,
                                range  = 22,
                                parent = "<LOOP>",
                                value  = "<LOOP>",
                                [1]    = "b",
                            },
                            vararg = "<LOOP>",
                            index  = 2,
                        },
                        [2] = "<LOOP>",
                    },
                    node      = {
                        type   = "getglobal",
                        start  = 16,
                        finish = 16,
                        parent = "<LOOP>",
                        [1]    = "a",
                    },
                    args      = {
                        type   = "callargs",
                        start  = 17,
                        finish = 22,
                        parent = "<LOOP>",
                        [1]    = {
                            type   = "getglobal",
                            start  = 19,
                            finish = 19,
                            parent = "<LOOP>",
                            [1]    = "b",
                        },
                        [2]    = {
                            type   = "getglobal",
                            start  = 22,
                            finish = 22,
                            parent = "<LOOP>",
                            [1]    = "c",
                        },
                    },
                },
                index  = 3,
            },
            [1]    = "c",
        },
    },
    [1]    = {
        type   = "return",
        start  = 31,
        finish = 37,
        parent = "<LOOP>",
    },
}
CHECK[[
while true do
    return
end]]
{
    type   = "while",
    start  = 1,
    finish = 28,
    filter = {
        type   = "boolean",
        start  = 7,
        finish = 10,
        [1]    = true,
    },
    [1]    = {
        type   = "return",
        start  = 19,
        finish = 25,
        parent = "<LOOP>",
    },
}
CHECK[[
repeat
    break
until 1]]
{
    type   = "repeat",
    start  = 1,
    finish = 25,
    filter = {
        type   = "number",
        start  = 24,
        finish = 24,
        [1]    = 1,
    },
    [1]    = {
        type   = "break",
        start  = 12,
        finish = 16,
        parent = "<LOOP>",
    },
}
CHECK[[
function test()
    return
end]]
{
    type   = "setglobal",
    start  = 10,
    finish = 13,
    value  = {
        type   = "function",
        start  = 1,
        finish = 30,
        parent = "<LOOP>",
        [1]    = {
            type   = "return",
            start  = 21,
            finish = 27,
            parent = "<LOOP>",
        },
    },
    [1]    = "test",
}
CHECK[[
function test(a)
    return
end]]
{
    type   = "setglobal",
    start  = 10,
    finish = 13,
    value  = {
        type   = "function",
        start  = 1,
        finish = 31,
        parent = "<LOOP>",
        args   = {
            type   = "funcargs",
            start  = 14,
            finish = 16,
            parent = "<LOOP>",
            [1]    = {
                type   = "local",
                start  = 15,
                finish = 15,
                effect = 15,
                parent = "<LOOP>",
                [1]    = "a",
            },
        },
        locals = {
            [1] = {
                type   = "local",
                start  = 15,
                finish = 15,
                effect = 15,
                parent = {
                    type   = "funcargs",
                    start  = 14,
                    finish = 16,
                    parent = "<LOOP>",
                    [1]    = "<LOOP>",
                },
                [1]    = "a",
            },
        },
        [1]    = {
            type   = "return",
            start  = 22,
            finish = 28,
            parent = "<LOOP>",
        },
    },
    [1]    = "test",
}
CHECK[[
function a.b:c(a, b, c)
    return
end]]
{
    type   = "setmethod",
    start  = 10,
    finish = 14,
    node   = {
        type   = "getfield",
        start  = 10,
        finish = 12,
        parent = "<LOOP>",
        node   = {
            type   = "getglobal",
            start  = 10,
            finish = 10,
            parent = "<LOOP>",
            [1]    = "a",
        },
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
    colon  = {
        type   = ":",
        start  = 13,
        finish = 13,
    },
    method = {
        type   = "method",
        start  = 14,
        finish = 14,
        [1]    = "c",
    },
    value  = {
        type   = "function",
        start  = 1,
        finish = 38,
        parent = "<LOOP>",
        args   = {
            type   = "funcargs",
            start  = 15,
            finish = 23,
            parent = "<LOOP>",
            [1]    = {
                type   = "local",
                start  = 16,
                finish = 16,
                effect = 16,
                parent = "<LOOP>",
                [1]    = "a",
            },
            [2]    = {
                type   = "local",
                start  = 19,
                finish = 19,
                effect = 19,
                parent = "<LOOP>",
                [1]    = "b",
            },
            [3]    = {
                type   = "local",
                start  = 22,
                finish = 22,
                effect = 22,
                parent = "<LOOP>",
                [1]    = "c",
            },
        },
        locals = {
            [1] = {
                type   = "local",
                start  = 0,
                finish = 0,
                effect = 14,
                parent = "<LOOP>",
                method = "<LOOP>",
                [1]    = "self",
            },
            [2] = {
                type   = "local",
                start  = 16,
                finish = 16,
                effect = 16,
                parent = {
                    type   = "funcargs",
                    start  = 15,
                    finish = 23,
                    parent = "<LOOP>",
                    [1]    = "<LOOP>",
                    [2]    = {
                        type   = "local",
                        start  = 19,
                        finish = 19,
                        effect = 19,
                        parent = "<LOOP>",
                        [1]    = "b",
                    },
                    [3]    = {
                        type   = "local",
                        start  = 22,
                        finish = 22,
                        effect = 22,
                        parent = "<LOOP>",
                        [1]    = "c",
                    },
                },
                [1]    = "a",
            },
            [3] = {
                type   = "local",
                start  = 19,
                finish = 19,
                effect = 19,
                parent = {
                    type   = "funcargs",
                    start  = 15,
                    finish = 23,
                    parent = "<LOOP>",
                    [1]    = {
                        type   = "local",
                        start  = 16,
                        finish = 16,
                        effect = 16,
                        parent = "<LOOP>",
                        [1]    = "a",
                    },
                    [2]    = "<LOOP>",
                    [3]    = {
                        type   = "local",
                        start  = 22,
                        finish = 22,
                        effect = 22,
                        parent = "<LOOP>",
                        [1]    = "c",
                    },
                },
                [1]    = "b",
            },
            [4] = {
                type   = "local",
                start  = 22,
                finish = 22,
                effect = 22,
                parent = {
                    type   = "funcargs",
                    start  = 15,
                    finish = 23,
                    parent = "<LOOP>",
                    [1]    = {
                        type   = "local",
                        start  = 16,
                        finish = 16,
                        effect = 16,
                        parent = "<LOOP>",
                        [1]    = "a",
                    },
                    [2]    = {
                        type   = "local",
                        start  = 19,
                        finish = 19,
                        effect = 19,
                        parent = "<LOOP>",
                        [1]    = "b",
                    },
                    [3]    = "<LOOP>",
                },
                [1]    = "c",
            },
        },
        [1]    = {
            type   = "return",
            start  = 29,
            finish = 35,
            parent = "<LOOP>",
        },
    },
}
CHECK[[
function m:f()
    return self
end]]
{
    type   = "setmethod",
    start  = 10,
    finish = 12,
    node   = {
        type   = "getglobal",
        start  = 10,
        finish = 10,
        parent = "<LOOP>",
        [1]    = "m",
    },
    colon  = {
        type   = ":",
        start  = 11,
        finish = 11,
    },
    method = {
        type   = "method",
        start  = 12,
        finish = 12,
        [1]    = "f",
    },
    value  = {
        type   = "function",
        start  = 1,
        finish = 34,
        parent = "<LOOP>",
        locals = {
            [1] = {
                type   = "local",
                start  = 0,
                finish = 0,
                effect = 12,
                parent = "<LOOP>",
                method = "<LOOP>",
                ref    = {
                    [1] = {
                        type   = "getlocal",
                        start  = 27,
                        finish = 30,
                        parent = {
                            type   = "return",
                            start  = 20,
                            finish = 30,
                            parent = "<LOOP>",
                            [1]    = "<LOOP>",
                        },
                        loc    = "<LOOP>",
                        [1]    = "self",
                    },
                },
                [1]    = "self",
            },
        },
        [1]    = {
            type   = "return",
            start  = 20,
            finish = 30,
            parent = "<LOOP>",
            [1]    = {
                type   = "getlocal",
                start  = 27,
                finish = 30,
                parent = "<LOOP>",
                loc    = {
                    type   = "local",
                    start  = 0,
                    finish = 0,
                    effect = 12,
                    parent = "<LOOP>",
                    method = "<LOOP>",
                    ref    = {
                        [1] = "<LOOP>",
                    },
                    [1]    = "self",
                },
                [1]    = "self",
            },
        },
    },
}

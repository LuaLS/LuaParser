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
        parent = "<IGNORE>",
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
        parent = "<IGNORE>",
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
        parent = "<IGNORE>",
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
        parent = "<IGNORE>",
        [1]    = 1,
    },
    attrs  = {
        [1] = {
            type   = "localattr",
            start  = 10,
            finish = 14,
            parent = "<IGNORE>",
            [1]    = "close",
        },
        [2] = {
            type   = "localattr",
            start  = 18,
            finish = 22,
            parent = "<IGNORE>",
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
        parent = "<IGNORE>",
        [1]    = 1,
    },
    attrs  = {
        [1] = {
            type   = "localattr",
            start  = 11,
            finish = 15,
            parent = "<IGNORE>",
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
    node   = "<IGNORE>",
    dot    = {
        type   = ".",
        start  = 2,
        finish = 2,
    },
    field  = {
        type   = "field",
        start  = 3,
        finish = 3,
        parent = "<IGNORE>",
        [1]    = "y",
    },
    value  = {
        type   = "number",
        start  = 7,
        finish = 7,
        parent = "<IGNORE>",
        [1]    = 1,
    },
}
CHECK 'x[y] = 1'
{
    type   = "setindex",
    start  = 1,
    finish = 4,
    range  = 8,
    node   = "<IGNORE>",
    index  = {
        type   = "getglobal",
        start  = 3,
        finish = 3,
        parent = "<IGNORE>",
        [1]    = "y",
    },
    value  = {
        type   = "number",
        start  = 8,
        finish = 8,
        parent = "<IGNORE>",
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
        parent = "<IGNORE>",
    },
    [1]    = "x",
}
CHECK'x.y = function () end'
{
    type   = "setfield",
    start  = 1,
    finish = 3,
    range  = 21,
    node   = "<IGNORE>",
    dot    = {
        type   = ".",
        start  = 2,
        finish = 2,
    },
    field  = {
        type   = "field",
        start  = 3,
        finish = 3,
        parent = "<IGNORE>",
        [1]    = "y",
    },
    value  = {
        type   = "function",
        start  = 7,
        finish = 21,
        parent = "<IGNORE>",
    },
}
CHECK'require "xxx"'
{
    specials = "<IGNORE>",
    type     = "call",
    start    = 1,
    finish   = 13,
    node     = "<IGNORE>",
    args     = {
        type   = "callargs",
        start  = 9,
        finish = 13,
        parent = "<IGNORE>",
        [1]    = {
            type   = "string",
            start  = 9,
            finish = 13,
            parent = "<IGNORE>",
            [1]    = "xxx",
            [2]    = "\"",
        },
    },
}
CHECK'func.x(1, 2)'
{
    type   = "call",
    start  = 1,
    finish = 12,
    node   = "<IGNORE>",
    args   = {
        type   = "callargs",
        start  = 7,
        finish = 12,
        parent = "<IGNORE>",
        [1]    = {
            type   = "number",
            start  = 8,
            finish = 8,
            parent = "<IGNORE>",
            [1]    = 1,
        },
        [2]    = {
            type   = "number",
            start  = 11,
            finish = 11,
            parent = "<IGNORE>",
            [1]    = 2,
        },
    },
}
CHECK'func:x(1, 2)'
{
    type   = "call",
    start  = 1,
    finish = 12,
    node   = "<IGNORE>",
    args   = {
        type   = "callargs",
        start  = 7,
        finish = 12,
        parent = "<IGNORE>",
        [1]    = {
            type   = "number",
            start  = 8,
            finish = 8,
            parent = "<IGNORE>",
            [1]    = 1,
        },
        [2]    = {
            type   = "number",
            start  = 11,
            finish = 11,
            parent = "<IGNORE>",
            [1]    = 2,
        },
    },
}
CHECK'("%s"):format(1)'
{
    type   = "call",
    start  = 1,
    finish = 16,
    node   = "<IGNORE>",
    args   = {
        type   = "callargs",
        start  = 14,
        finish = 16,
        parent = "<IGNORE>",
        [1]    = {
            type   = "number",
            start  = 15,
            finish = 15,
            parent = "<IGNORE>",
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
        parent = "<IGNORE>",
        value  = {
            type   = "number",
            start  = 8,
            finish = 8,
            parent = "<IGNORE>",
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
        parent = "<IGNORE>",
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
        parent = "<IGNORE>",
        [1]    = 1,
    },
    [2]    = {
        type   = "number",
        start  = 11,
        finish = 11,
        parent = "<IGNORE>",
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
        parent = "<IGNORE>",
        filter = {
            type   = "number",
            start  = 4,
            finish = 4,
            parent = "<IGNORE>",
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
        parent = "<IGNORE>",
        filter = {
            type   = "number",
            start  = 4,
            finish = 4,
            parent = "<IGNORE>",
            [1]    = 1,
        },
        [1]    = {
            type   = "return",
            start  = 15,
            finish = 21,
            parent = "<IGNORE>",
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
        parent = "<IGNORE>",
        filter = {
            type   = "number",
            start  = 4,
            finish = 4,
            parent = "<IGNORE>",
            [1]    = 1,
        },
        [1]    = {
            type   = "return",
            start  = 15,
            finish = 21,
            parent = "<IGNORE>",
        },
    },
    [2]    = {
        type   = "elseblock",
        start  = 22,
        finish = 37,
        parent = "<IGNORE>",
        [1]    = {
            type   = "return",
            start  = 31,
            finish = 37,
            parent = "<IGNORE>",
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
        parent = "<IGNORE>",
        filter = {
            type   = "number",
            start  = 4,
            finish = 4,
            parent = "<IGNORE>",
            [1]    = 1,
        },
        [1]    = {
            type   = "return",
            start  = 15,
            finish = 21,
            parent = "<IGNORE>",
        },
    },
    [2]    = {
        type   = "elseifblock",
        start  = 22,
        finish = 46,
        parent = "<IGNORE>",
        filter = {
            type   = "number",
            start  = 29,
            finish = 29,
            parent = "<IGNORE>",
            [1]    = 1,
        },
        [1]    = {
            type   = "return",
            start  = 40,
            finish = 46,
            parent = "<IGNORE>",
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
        parent = "<IGNORE>",
        filter = {
            type   = "number",
            start  = 4,
            finish = 4,
            parent = "<IGNORE>",
            [1]    = 1,
        },
        [1]    = {
            type   = "return",
            start  = 15,
            finish = 21,
            parent = "<IGNORE>",
        },
    },
    [2]    = {
        type   = "elseifblock",
        start  = 22,
        finish = 46,
        parent = "<IGNORE>",
        filter = {
            type   = "number",
            start  = 29,
            finish = 29,
            parent = "<IGNORE>",
            [1]    = 1,
        },
        [1]    = {
            type   = "return",
            start  = 40,
            finish = 46,
            parent = "<IGNORE>",
        },
    },
    [3]    = {
        type   = "elseblock",
        start  = 47,
        finish = 62,
        parent = "<IGNORE>",
        [1]    = {
            type   = "return",
            start  = 56,
            finish = 62,
            parent = "<IGNORE>",
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
        parent = "<IGNORE>",
        filter = {
            type   = "number",
            start  = 4,
            finish = 4,
            parent = "<IGNORE>",
            [1]    = 1,
        },
    },
    [2]    = {
        type   = "elseifblock",
        start  = 11,
        finish = 23,
        parent = "<IGNORE>",
        filter = {
            type   = "number",
            start  = 18,
            finish = 18,
            parent = "<IGNORE>",
            [1]    = 1,
        },
    },
    [3]    = {
        type   = "elseifblock",
        start  = 25,
        finish = 37,
        parent = "<IGNORE>",
        filter = {
            type   = "number",
            start  = 32,
            finish = 32,
            parent = "<IGNORE>",
            [1]    = 1,
        },
    },
    [4]    = {
        type   = "elseifblock",
        start  = 39,
        finish = 51,
        parent = "<IGNORE>",
        filter = {
            type   = "number",
            start  = 46,
            finish = 46,
            parent = "<IGNORE>",
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
        parent = "<IGNORE>",
        filter = {
            type   = "number",
            start  = 4,
            finish = 4,
            parent = "<IGNORE>",
            [1]    = 1,
        },
        [1]    = {
            type   = "if",
            start  = 15,
            finish = 31,
            parent = "<IGNORE>",
            [1]    = {
                type   = "ifblock",
                start  = 15,
                finish = 23,
                parent = "<IGNORE>",
                filter = {
                    type   = "number",
                    start  = 18,
                    finish = 18,
                    parent = "<IGNORE>",
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
        parent = "<IGNORE>",
        filter = {
            type   = "number",
            start  = 4,
            finish = 4,
            parent = "<IGNORE>",
            [1]    = 1,
        },
    },
    [2]    = {
        type   = "elseifblock",
        start  = 11,
        finish = 23,
        parent = "<IGNORE>",
        filter = {
            type   = "number",
            start  = 18,
            finish = 18,
            parent = "<IGNORE>",
            [1]    = 1,
        },
    },
    [3]    = {
        type   = "elseblock",
        start  = 25,
        finish = 28,
        parent = "<IGNORE>",
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
        parent = "<IGNORE>",
        value  = {
            type   = "number",
            start  = 9,
            finish = 9,
            parent = "<IGNORE>",
            [1]    = 1,
        },
        [1]    = "i",
    },
    max    = {
        type   = "getglobal",
        start  = 12,
        finish = 12,
        parent = "<IGNORE>",
        [1]    = "i",
    },
    locals = "<IGNORE>",
    [1]    = {
        type   = "return",
        start  = 21,
        finish = 27,
        parent = "<IGNORE>",
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
        parent = "<IGNORE>",
        value  = {
            type   = "number",
            start  = 9,
            finish = 9,
            parent = "<IGNORE>",
            [1]    = 1,
        },
        [1]    = "i",
    },
    max    = {
        type   = "number",
        start  = 12,
        finish = 13,
        parent = "<IGNORE>",
        [1]    = 10,
    },
    step   = {
        type   = "getglobal",
        start  = 16,
        finish = 16,
        parent = "<IGNORE>",
        [1]    = "i",
    },
    locals = "<IGNORE>",
    [1]    = {
        type   = "return",
        start  = 25,
        finish = 31,
        parent = "<IGNORE>",
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
        range  = 10,
        [1]    = {
            type   = "local",
            start  = 5,
            finish = 5,
            effect = 14,
            range  = 10,
            parent = "<IGNORE>",
            value  = {
                type   = "select",
                start  = 10,
                finish = 10,
                parent = "<IGNORE>",
                vararg = {
                    type   = "call",
                    start  = 10,
                    finish = 10,
                    parent = "<IGNORE>",
                    node   = "<IGNORE>",
                    args   = {
                        type   = "callargs",
                        start  = 11,
                        finish = 10,
                        parent = "<IGNORE>",
                    },
                },
                index  = 1,
            },
            [1]    = "a",
        },
    },
    locals = "<IGNORE>",
    [1]    = {
        type   = "return",
        start  = 19,
        finish = 25,
        parent = "<IGNORE>",
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
        range  = 22,
        [1]    = {
            type   = "local",
            start  = 5,
            finish = 5,
            effect = 26,
            range  = 22,
            parent = "<IGNORE>",
            value  = {
                type   = "select",
                start  = 16,
                finish = 22,
                parent = "<IGNORE>",
                vararg = {
                    type      = "call",
                    start     = 16,
                    finish    = 22,
                    parent    = "<IGNORE>",
                    extParent = "<IGNORE>",
                    node      = "<IGNORE>",
                    args      = {
                        type   = "callargs",
                        start  = 17,
                        finish = 22,
                        parent = "<IGNORE>",
                        [1]    = {
                            type   = "getglobal",
                            start  = 19,
                            finish = 19,
                            parent = "<IGNORE>",
                            [1]    = "b",
                        },
                        [2]    = {
                            type   = "getglobal",
                            start  = 22,
                            finish = 22,
                            parent = "<IGNORE>",
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
            parent = "<IGNORE>",
            value  = {
                type   = "select",
                start  = 16,
                finish = 22,
                parent = "<IGNORE>",
                vararg = {
                    type      = "call",
                    start     = 16,
                    finish    = 22,
                    parent    = "<IGNORE>",
                    extParent = "<IGNORE>",
                    node      = "<IGNORE>",
                    args      = {
                        type   = "callargs",
                        start  = 17,
                        finish = 22,
                        parent = "<IGNORE>",
                        [1]    = {
                            type   = "getglobal",
                            start  = 19,
                            finish = 19,
                            parent = "<IGNORE>",
                            [1]    = "b",
                        },
                        [2]    = {
                            type   = "getglobal",
                            start  = 22,
                            finish = 22,
                            parent = "<IGNORE>",
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
            parent = "<IGNORE>",
            value  = {
                type   = "select",
                start  = 16,
                finish = 22,
                parent = "<IGNORE>",
                vararg = {
                    type      = "call",
                    start     = 16,
                    finish    = 22,
                    parent    = "<IGNORE>",
                    extParent = "<IGNORE>",
                    node      = "<IGNORE>",
                    args      = {
                        type   = "callargs",
                        start  = 17,
                        finish = 22,
                        parent = "<IGNORE>",
                        [1]    = {
                            type   = "getglobal",
                            start  = 19,
                            finish = 19,
                            parent = "<IGNORE>",
                            [1]    = "b",
                        },
                        [2]    = {
                            type   = "getglobal",
                            start  = 22,
                            finish = 22,
                            parent = "<IGNORE>",
                            [1]    = "c",
                        },
                    },
                },
                index  = 3,
            },
            [1]    = "c",
        },
    },
    locals = "<IGNORE>",
    [1]    = {
        type   = "return",
        start  = 31,
        finish = 37,
        parent = "<IGNORE>",
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
        parent = "<IGNORE>",
        [1]    = true,
    },
    [1]    = {
        type   = "return",
        start  = 19,
        finish = 25,
        parent = "<IGNORE>",
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
        parent = "<IGNORE>",
        [1]    = 1,
    },
    breaks = {
        [1] = {
            type   = "break",
            start  = 12,
            finish = 16,
            parent = "<IGNORE>",
        },
    },
    [1]    = {
        type   = "break",
        start  = 12,
        finish = 16,
        parent = "<IGNORE>",
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
    range  = 30,
    value  = {
        type    = "function",
        start   = 1,
        finish  = 30,
        parent  = "<IGNORE>",
        returns = {
            [1] = {
                type   = "return",
                start  = 21,
                finish = 27,
                parent = "<IGNORE>",
            },
        },
        [1]     = {
            type   = "return",
            start  = 21,
            finish = 27,
            parent = "<IGNORE>",
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
    range  = 31,
    value  = {
        type    = "function",
        start   = 1,
        finish  = 31,
        parent  = "<IGNORE>",
        args    = {
            type   = "funcargs",
            start  = 14,
            finish = 16,
            parent = "<IGNORE>",
            [1]    = {
                type   = "local",
                start  = 15,
                finish = 15,
                effect = 15,
                parent = "<IGNORE>",
                [1]    = "a",
            },
        },
        locals  = "<IGNORE>",
        returns = {
            [1] = {
                type   = "return",
                start  = 22,
                finish = 28,
                parent = "<IGNORE>",
            },
        },
        [1]     = {
            type   = "return",
            start  = 22,
            finish = 28,
            parent = "<IGNORE>",
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
    range  = 38,
    node   = "<IGNORE>",
    colon  = {
        type   = ":",
        start  = 13,
        finish = 13,
    },
    method = {
        type   = "method",
        start  = 14,
        finish = 14,
        parent = "<IGNORE>",
        [1]    = "c",
    },
    value  = {
        type    = "function",
        start   = 1,
        finish  = 38,
        parent  = "<IGNORE>",
        args    = {
            type   = "funcargs",
            start  = 15,
            finish = 23,
            parent = "<IGNORE>",
            [1]    = {
                type   = "local",
                start  = 16,
                finish = 16,
                effect = 16,
                parent = "<IGNORE>",
                [1]    = "a",
            },
            [2]    = {
                type   = "local",
                start  = 19,
                finish = 19,
                effect = 19,
                parent = "<IGNORE>",
                [1]    = "b",
            },
            [3]    = {
                type   = "local",
                start  = 22,
                finish = 22,
                effect = 22,
                parent = "<IGNORE>",
                [1]    = "c",
            },
        },
        locals  = "<IGNORE>",
        returns = {
            [1] = {
                type   = "return",
                start  = 29,
                finish = 35,
                parent = "<IGNORE>",
            },
        },
        [1]     = {
            type   = "return",
            start  = 29,
            finish = 35,
            parent = "<IGNORE>",
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
    range  = 34,
    node   = "<IGNORE>",
    colon  = {
        type   = ":",
        start  = 11,
        finish = 11,
    },
    method = {
        type   = "method",
        start  = 12,
        finish = 12,
        parent = "<IGNORE>",
        [1]    = "f",
    },
    value  = {
        type    = "function",
        start   = 1,
        finish  = 34,
        parent  = "<IGNORE>",
        locals  = "<IGNORE>",
        returns = {
            [1] = {
                type   = "return",
                start  = 20,
                finish = 30,
                parent = "<IGNORE>",
                [1]    = {
                    type   = "getlocal",
                    start  = 27,
                    finish = 30,
                    parent = "<IGNORE>",
                    node   = "<IGNORE>",
                    loc    = {
                        type   = "local",
                        start  = 0,
                        finish = 0,
                        effect = 12,
                        tag    = "self",
                        parent = "<IGNORE>",
                        method = "<LOOP>",
                        ref    = "<IGNORE>",
                        [1]    = "self",
                    },
                    [1]    = "self",
                },
            },
        },
        [1]     = {
            type   = "return",
            start  = 20,
            finish = 30,
            parent = "<IGNORE>",
            [1]    = {
                type   = "getlocal",
                start  = 27,
                finish = 30,
                parent = "<IGNORE>",
                node   = "<IGNORE>",
                loc    = {
                    type   = "local",
                    start  = 0,
                    finish = 0,
                    effect = 12,
                    tag    = "self",
                    parent = "<IGNORE>",
                    method = "<LOOP>",
                    ref    = "<IGNORE>",
                    [1]    = "self",
                },
                [1]    = "self",
            },
        },
    },
}

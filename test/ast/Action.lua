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
        start  = 10,
        finish = 22,
        [1]    = {
            type   = "localattr",
            start  = 10,
            finish = 14,
            parent = "<IGNORE>",
            [1]    = "close",
        },
        [2]    = {
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
        start  = 11,
        finish = 15,
        [1]    = {
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
    bstart = 2,
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
        type    = "function",
        start   = 5,
        finish  = 19,
        keyword = {
            [1] = 5,
            [2] = 12,
            [3] = 17,
            [4] = 19,
        },
        parent  = "<IGNORE>",
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
        type    = "function",
        start   = 7,
        finish  = 21,
        keyword = {
            [1] = 7,
            [2] = 14,
            [3] = 19,
            [4] = 21,
        },
        parent  = "<IGNORE>",
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
            next   = "<LOOP>",
            type   = "getmethod",
            start  = 1,
            finish = 6,
            parent = "<IGNORE>",
            node   = "<IGNORE>",
            colon  = {
                type   = ":",
                start  = 5,
                finish = 5,
            },
            method = {
                type   = "method",
                start  = 6,
                finish = 6,
                parent = "<IGNORE>",
                [1]    = "x",
            },
        },
        [2]    = {
            type   = "number",
            start  = 8,
            finish = 8,
            parent = "<IGNORE>",
            [1]    = 1,
        },
        [3]    = {
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
            next   = "<LOOP>",
            type   = "getmethod",
            start  = 1,
            finish = 13,
            parent = "<IGNORE>",
            node   = "<IGNORE>",
            colon  = {
                type   = ":",
                start  = 7,
                finish = 7,
            },
            method = {
                type   = "method",
                start  = 8,
                finish = 13,
                parent = "<IGNORE>",
                [1]    = "format",
            },
        },
        [2]    = {
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
    type    = "do",
    start   = 1,
    finish  = 6,
    keyword = {
        [1] = 1,
        [2] = 2,
        [3] = 4,
        [4] = 6,
    },
}
CHECK'do x = 1 end'
{
    type    = "do",
    start   = 1,
    finish  = 12,
    keyword = {
        [1] = 1,
        [2] = 2,
        [3] = 10,
        [4] = 12,
    },
    [1]     = {
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
        type    = "ifblock",
        start   = 1,
        finish  = 9,
        keyword = {
            [1] = 1,
            [2] = 2,
            [3] = 6,
            [4] = 9,
        },
        parent  = "<IGNORE>",
        filter  = {
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
        type    = "ifblock",
        start   = 1,
        finish  = 21,
        keyword = {
            [1] = 1,
            [2] = 2,
            [3] = 6,
            [4] = 9,
        },
        parent  = "<IGNORE>",
        filter  = {
            type   = "number",
            start  = 4,
            finish = 4,
            parent = "<IGNORE>",
            [1]    = 1,
        },
        [1]     = {
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
        type    = "ifblock",
        start   = 1,
        finish  = 21,
        keyword = {
            [1] = 1,
            [2] = 2,
            [3] = 6,
            [4] = 9,
        },
        parent  = "<IGNORE>",
        filter  = {
            type   = "number",
            start  = 4,
            finish = 4,
            parent = "<IGNORE>",
            [1]    = 1,
        },
        [1]     = {
            type   = "return",
            start  = 15,
            finish = 21,
            parent = "<IGNORE>",
        },
    },
    [2]    = {
        type    = "elseblock",
        start   = 22,
        finish  = 37,
        keyword = {
            [1] = 22,
            [2] = 25,
        },
        parent  = "<IGNORE>",
        [1]     = {
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
        type    = "ifblock",
        start   = 1,
        finish  = 21,
        keyword = {
            [1] = 1,
            [2] = 2,
            [3] = 6,
            [4] = 9,
        },
        parent  = "<IGNORE>",
        filter  = {
            type   = "number",
            start  = 4,
            finish = 4,
            parent = "<IGNORE>",
            [1]    = 1,
        },
        [1]     = {
            type   = "return",
            start  = 15,
            finish = 21,
            parent = "<IGNORE>",
        },
    },
    [2]    = {
        type    = "elseifblock",
        start   = 22,
        finish  = 46,
        keyword = {
            [1] = 22,
            [2] = 27,
            [3] = 31,
            [4] = 34,
        },
        parent  = "<IGNORE>",
        filter  = {
            type   = "number",
            start  = 29,
            finish = 29,
            parent = "<IGNORE>",
            [1]    = 1,
        },
        [1]     = {
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
        type    = "ifblock",
        start   = 1,
        finish  = 21,
        keyword = {
            [1] = 1,
            [2] = 2,
            [3] = 6,
            [4] = 9,
        },
        parent  = "<IGNORE>",
        filter  = {
            type   = "number",
            start  = 4,
            finish = 4,
            parent = "<IGNORE>",
            [1]    = 1,
        },
        [1]     = {
            type   = "return",
            start  = 15,
            finish = 21,
            parent = "<IGNORE>",
        },
    },
    [2]    = {
        type    = "elseifblock",
        start   = 22,
        finish  = 46,
        keyword = {
            [1] = 22,
            [2] = 27,
            [3] = 31,
            [4] = 34,
        },
        parent  = "<IGNORE>",
        filter  = {
            type   = "number",
            start  = 29,
            finish = 29,
            parent = "<IGNORE>",
            [1]    = 1,
        },
        [1]     = {
            type   = "return",
            start  = 40,
            finish = 46,
            parent = "<IGNORE>",
        },
    },
    [3]    = {
        type    = "elseblock",
        start   = 47,
        finish  = 62,
        keyword = {
            [1] = 47,
            [2] = 50,
        },
        parent  = "<IGNORE>",
        [1]     = {
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
        type    = "ifblock",
        start   = 1,
        finish  = 9,
        keyword = {
            [1] = 1,
            [2] = 2,
            [3] = 6,
            [4] = 9,
        },
        parent  = "<IGNORE>",
        filter  = {
            type   = "number",
            start  = 4,
            finish = 4,
            parent = "<IGNORE>",
            [1]    = 1,
        },
    },
    [2]    = {
        type    = "elseifblock",
        start   = 11,
        finish  = 23,
        keyword = {
            [1] = 11,
            [2] = 16,
            [3] = 20,
            [4] = 23,
        },
        parent  = "<IGNORE>",
        filter  = {
            type   = "number",
            start  = 18,
            finish = 18,
            parent = "<IGNORE>",
            [1]    = 1,
        },
    },
    [3]    = {
        type    = "elseifblock",
        start   = 25,
        finish  = 37,
        keyword = {
            [1] = 25,
            [2] = 30,
            [3] = 34,
            [4] = 37,
        },
        parent  = "<IGNORE>",
        filter  = {
            type   = "number",
            start  = 32,
            finish = 32,
            parent = "<IGNORE>",
            [1]    = 1,
        },
    },
    [4]    = {
        type    = "elseifblock",
        start   = 39,
        finish  = 51,
        keyword = {
            [1] = 39,
            [2] = 44,
            [3] = 48,
            [4] = 51,
        },
        parent  = "<IGNORE>",
        filter  = {
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
        type    = "ifblock",
        start   = 1,
        finish  = 31,
        keyword = {
            [1] = 1,
            [2] = 2,
            [3] = 6,
            [4] = 9,
        },
        parent  = "<IGNORE>",
        filter  = {
            type   = "number",
            start  = 4,
            finish = 4,
            parent = "<IGNORE>",
            [1]    = 1,
        },
        [1]     = {
            type   = "if",
            start  = 15,
            finish = 31,
            parent = "<IGNORE>",
            [1]    = {
                type    = "ifblock",
                start   = 15,
                finish  = 23,
                keyword = {
                    [1] = 15,
                    [2] = 16,
                    [3] = 20,
                    [4] = 23,
                },
                parent  = "<IGNORE>",
                filter  = {
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
        type    = "ifblock",
        start   = 1,
        finish  = 9,
        keyword = {
            [1] = 1,
            [2] = 2,
            [3] = 6,
            [4] = 9,
        },
        parent  = "<IGNORE>",
        filter  = {
            type   = "number",
            start  = 4,
            finish = 4,
            parent = "<IGNORE>",
            [1]    = 1,
        },
    },
    [2]    = {
        type    = "elseifblock",
        start   = 11,
        finish  = 23,
        keyword = {
            [1] = 11,
            [2] = 16,
            [3] = 20,
            [4] = 23,
        },
        parent  = "<IGNORE>",
        filter  = {
            type   = "number",
            start  = 18,
            finish = 18,
            parent = "<IGNORE>",
            [1]    = 1,
        },
    },
    [3]    = {
        type    = "elseblock",
        start   = 25,
        finish  = 28,
        keyword = {
            [1] = 25,
            [2] = 28,
        },
        parent  = "<IGNORE>",
    },
}
CHECK[[
for i = 1, i do
    return
end]]
{
    type    = "loop",
    start   = 1,
    finish  = 30,
    keyword = {
        [1] = 1,
        [2] = 3,
        [3] = 14,
        [4] = 15,
        [5] = 28,
        [6] = 30,
    },
    loc     = {
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
    max     = {
        type   = "getglobal",
        start  = 12,
        finish = 12,
        parent = "<IGNORE>",
        [1]    = "i",
    },
    locals  = "<IGNORE>",
    [1]     = {
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
    type    = "loop",
    start   = 1,
    finish  = 34,
    keyword = {
        [1] = 1,
        [2] = 3,
        [3] = 18,
        [4] = 19,
        [5] = 32,
        [6] = 34,
    },
    loc     = {
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
    max     = {
        type   = "number",
        start  = 12,
        finish = 13,
        parent = "<IGNORE>",
        [1]    = 10,
    },
    step    = {
        type   = "getglobal",
        start  = 16,
        finish = 16,
        parent = "<IGNORE>",
        [1]    = "i",
    },
    locals  = "<IGNORE>",
    [1]     = {
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
    type    = "in",
    start   = 1,
    finish  = 28,
    keyword = {
        [1] = 1,
        [2] = 3,
        [3] = 7,
        [4] = 8,
        [5] = 12,
        [6] = 13,
        [7] = 26,
        [8] = 28,
    },
    keys    = {
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
    locals  = "<IGNORE>",
    [1]     = {
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
    type    = "in",
    start   = 1,
    finish  = 40,
    keyword = {
        [1] = 1,
        [2] = 3,
        [3] = 13,
        [4] = 14,
        [5] = 24,
        [6] = 25,
        [7] = 38,
        [8] = 40,
    },
    keys    = {
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
    locals  = "<IGNORE>",
    [1]     = {
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
    type    = "while",
    start   = 1,
    finish  = 28,
    keyword = {
        [1] = 1,
        [2] = 5,
        [3] = 12,
        [4] = 13,
        [5] = 26,
        [6] = 28,
    },
    filter  = {
        type   = "boolean",
        start  = 7,
        finish = 10,
        parent = "<IGNORE>",
        [1]    = true,
    },
    [1]     = {
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
    type    = "repeat",
    start   = 1,
    finish  = 25,
    keyword = {
        [1] = 1,
        [2] = 6,
        [3] = 18,
        [4] = 22,
    },
    filter  = {
        type   = "number",
        start  = 24,
        finish = 24,
        parent = "<IGNORE>",
        [1]    = 1,
    },
    breaks  = {
        [1] = {
            type   = "break",
            start  = 12,
            finish = 16,
            parent = "<IGNORE>",
        },
    },
    [1]     = {
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
    vstart = 1,
    finish = 13,
    range  = 30,
    value  = {
        type    = "function",
        start   = 1,
        finish  = 30,
        keyword = {
            [1] = 1,
            [2] = 8,
            [3] = 28,
            [4] = 30,
        },
        parent  = "<IGNORE>",
        returns = "<IGNORE>",
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
    vstart = 1,
    finish = 13,
    range  = 31,
    value  = {
        type    = "function",
        start   = 1,
        finish  = 31,
        keyword = {
            [1] = 1,
            [2] = 8,
            [3] = 29,
            [4] = 31,
        },
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
        returns = "<IGNORE>",
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
    vstart = 1,
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
        keyword = {
            [1] = 1,
            [2] = 8,
            [3] = 36,
            [4] = 38,
        },
        parent  = "<IGNORE>",
        args    = {
            type   = "funcargs",
            start  = 15,
            finish = 23,
            parent = "<IGNORE>",
            [1]    = {
                next   = "<LOOP>",
                type   = "getfield",
                start  = 10,
                finish = 12,
                parent = "<IGNORE>",
                node   = "<IGNORE>",
                dot    = {
                    type   = ".",
                    start  = 11,
                    finish = 11,
                },
                field  = {
                    type   = "field",
                    start  = 12,
                    finish = 12,
                    parent = "<IGNORE>",
                    [1]    = "b",
                },
            },
            [2]    = {
                type   = "local",
                start  = 16,
                finish = 16,
                effect = 16,
                parent = "<IGNORE>",
                [1]    = "a",
            },
            [3]    = {
                type   = "local",
                start  = 19,
                finish = 19,
                effect = 19,
                parent = "<IGNORE>",
                [1]    = "b",
            },
            [4]    = {
                type   = "local",
                start  = 22,
                finish = 22,
                effect = 22,
                parent = "<IGNORE>",
                [1]    = "c",
            },
        },
        locals  = "<IGNORE>",
        returns = "<IGNORE>",
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
    vstart = 1,
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
        keyword = {
            [1] = 1,
            [2] = 8,
            [3] = 32,
            [4] = 34,
        },
        parent  = "<IGNORE>",
        args    = {
            parent = "<IGNORE>",
            [1]    = {
                next   = "<LOOP>",
                type   = "getglobal",
                start  = 10,
                finish = 10,
                parent = "<IGNORE>",
                [1]    = "m",
            },
        },
        locals  = "<IGNORE>",
        returns = "<IGNORE>",
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

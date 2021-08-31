CHECK'x = 1'
{
    type   = "setglobal",
    start  = 0,
    finish = 1,
    range  = 5,
    value  = {
        type   = "integer",
        start  = 4,
        finish = 5,
        parent = "<IGNORE>",
        [1]    = 1,
    },
    [1]    = "x",
}
CHECK'local x'
{
    type   = "local",
    start  = 6,
    finish = 7,
    effect = 7,
    [1]    = "x",
}
CHECK'local x = 1'
{
    type   = "local",
    start  = 6,
    finish = 7,
    effect = 11,
    range  = 11,
    value  = {
        type   = "integer",
        start  = 10,
        finish = 11,
        parent = "<IGNORE>",
        [1]    = 1,
    },
    [1]    = "x",
}
CHECK'local x = x'
{
    type   = "local",
    start  = 6,
    finish = 7,
    effect = 11,
    range  = 11,
    value  = {
        type   = "getglobal",
        start  = 10,
        finish = 11,
        parent = "<IGNORE>",
        [1]    = "x",
    },
    [1]    = "x",
}
CHECK'local x <close> <const> = 1'
{
    type   = "local",
    start  = 6,
    finish = 7,
    effect = 27,
    range  = 27,
    value  = {
        type   = "integer",
        start  = 26,
        finish = 27,
        parent = "<IGNORE>",
        [1]    = 1,
    },
    attrs  = {
        [1]    = {
            type   = "localattr",
            start  = 8,
            finish = 15,
            parent = "<IGNORE>",
            [1]    = "close",
        },
        [2]    = {
            type   = "localattr",
            start  = 16,
            finish = 23,
            parent = "<IGNORE>",
            [1]    = "const",
        },
    },
    [1]    = "x",
}
CHECK'local x < const > = 1'
{
    type   = "local",
    start  = 6,
    finish = 7,
    effect = 21,
    range  = 21,
    value  = {
        type   = "integer",
        start  = 20,
        finish = 21,
        parent = "<IGNORE>",
        [1]    = 1,
    },
    attrs  = {
        [1]    = {
            type   = "localattr",
            start  = 8,
            finish = 17,
            parent = "<IGNORE>",
            [1]    = "const",
        },
    },
    [1]    = "x",
}
CHECK 'x.y = 1'
{
    type   = "setfield",
    start  = 0,
    finish = 3,
    range  = 7,
    node   = "<IGNORE>",
    dot    = {
        type   = ".",
        start  = 1,
        finish = 2,
    },
    field  = {
        type   = "field",
        start  = 2,
        finish = 3,
        parent = "<IGNORE>",
        [1]    = "y",
    },
    value  = {
        type   = "integer",
        start  = 6,
        finish = 7,
        parent = "<IGNORE>",
        [1]    = 1,
    },
}
CHECK 'x[y] = 1'
{
    type   = "setindex",
    start  = 0,
    bstart = 1,
    finish = 4,
    range  = 8,
    node   = "<IGNORE>",
    index  = {
        type   = "getglobal",
        start  = 2,
        finish = 3,
        parent = "<IGNORE>",
        [1]    = "y",
    },
    value  = {
        type   = "integer",
        start  = 7,
        finish = 8,
        parent = "<IGNORE>",
        [1]    = 1,
    },
}
CHECK'x = function () end'
{
    type   = "setglobal",
    start  = 0,
    finish = 1,
    range  = 19,
    value  = {
        type    = "function",
        start   = 4,
        finish  = 19,
        keyword = {
            [1] = 4,
            [2] = 12,
            [3] = 16,
            [4] = 19,
        },
        parent  = "<IGNORE>",
    },
    [1]    = "x",
}
CHECK'x.y = function () end'
{
    type   = "setfield",
    start  = 0,
    finish = 3,
    range  = 21,
    node   = "<IGNORE>",
    dot    = {
        type   = ".",
        start  = 1,
        finish = 2,
    },
    field  = {
        type   = "field",
        start  = 2,
        finish = 3,
        parent = "<IGNORE>",
        [1]    = "y",
    },
    value  = {
        type    = "function",
        start   = 6,
        finish  = 21,
        keyword = {
            [1] = 6,
            [2] = 14,
            [3] = 18,
            [4] = 21,
        },
        parent  = "<IGNORE>",
    },
}
CHECK'require "xxx"'
{
    type   = "call",
    start  = 0,
    finish = 13,
    node   = "<IGNORE>",
    args   = {
        type   = "callargs",
        start  = 8,
        finish = 13,
        parent = "<IGNORE>",
        [1]    = {
            type   = "string",
            start  = 8,
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
    start  = 0,
    finish = 12,
    node   = "<IGNORE>",
    args   = {
        type   = "callargs",
        start  = 6,
        finish = 12,
        parent = "<IGNORE>",
        [1]    = {
            type   = "integer",
            start  = 7,
            finish = 8,
            parent = "<IGNORE>",
            [1]    = 1,
        },
        [2]    = {
            type   = "integer",
            start  = 10,
            finish = 11,
            parent = "<IGNORE>",
            [1]    = 2,
        },
    },
}
CHECK'func:x(1, 2)'
{
    type   = "call",
    start  = 0,
    finish = 12,
    node   = "<IGNORE>",
    args   = {
        type   = "callargs",
        start  = 6,
        finish = 12,
        parent = "<IGNORE>",
        [1]    = {
            next   = {
                next   = "<LOOP>",
                type   = "getmethod",
                start  = 0,
                finish = 6,
                parent = "<IGNORE>",
                node   = "<IGNORE>",
                colon  = {
                    type   = ":",
                    start  = 4,
                    finish = 5,
                },
                method = {
                    type   = "method",
                    start  = 5,
                    finish = 6,
                    parent = "<IGNORE>",
                    [1]    = "x",
                },
            },
            type   = "getglobal",
            start  = 0,
            finish = 4,
            parent = "<IGNORE>",
            mirror = "<IGNORE>",
            dummy  = true,
            [1]    = "func",
        },
        [2]    = {
            type   = "integer",
            start  = 7,
            finish = 8,
            parent = "<IGNORE>",
            [1]    = 1,
        },
        [3]    = {
            type   = "integer",
            start  = 10,
            finish = 11,
            parent = "<IGNORE>",
            [1]    = 2,
        },
    },
}
CHECK'("%s"):format(1)'
{
    type   = "call",
    start  = 0,
    finish = 16,
    node   = "<IGNORE>",
    args   = {
        type   = "callargs",
        start  = 13,
        finish = 16,
        parent = "<IGNORE>",
        [1]    = {
            next   = {
                next   = "<LOOP>",
                type   = "getmethod",
                start  = 0,
                finish = 13,
                parent = "<IGNORE>",
                node   = "<IGNORE>",
                colon  = {
                    type   = ":",
                    start  = 6,
                    finish = 7,
                },
                method = {
                    type   = "method",
                    start  = 7,
                    finish = 13,
                    parent = "<IGNORE>",
                    [1]    = "format",
                },
            },
            type   = "paren",
            start  = 0,
            finish = 6,
            parent = "<IGNORE>",
            mirror = "<IGNORE>",
            dummy  = true,
            exp    = {
                type   = "string",
                start  = 1,
                finish = 5,
                parent = "<IGNORE>",
                [1]    = "%s",
                [2]    = "\"",
            },
        },
        [2]    = {
            type   = "integer",
            start  = 14,
            finish = 15,
            parent = "<IGNORE>",
            [1]    = 1,
        },
    },
}
CHECK'do end'
{
    type    = "do",
    start   = 0,
    finish  = 6,
    keyword = {
        [1] = 0,
        [2] = 2,
        [3] = 3,
        [4] = 6,
    },
}
CHECK'do x = 1 end'
{
    type    = "do",
    start   = 0,
    finish  = 12,
    keyword = {
        [1] = 0,
        [2] = 2,
        [3] = 9,
        [4] = 12,
    },
    [1]     = {
        type   = "setglobal",
        start  = 3,
        finish = 4,
        range  = 8,
        parent = "<IGNORE>",
        value  = {
            type   = "integer",
            start  = 7,
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
    start  = 0,
    finish = 6,
}
CHECK'return 1'
{
    type   = "return",
    start  = 0,
    finish = 8,
    [1]    = {
        type   = "integer",
        start  = 7,
        finish = 8,
        parent = "<IGNORE>",
        [1]    = 1,
    },
}
CHECK'return 1, 2'
{
    type   = "return",
    start  = 0,
    finish = 11,
    [1]    = {
        type   = "integer",
        start  = 7,
        finish = 8,
        parent = "<IGNORE>",
        [1]    = 1,
    },
    [2]    = {
        type   = "integer",
        start  = 10,
        finish = 11,
        parent = "<IGNORE>",
        [1]    = 2,
    },
}
CHECK'::CONTINUE::'
{
    type   = "label",
    start  = 2,
    finish = 10,
    [1]    = "CONTINUE",
}
CHECK'goto CONTINUE'
{
    type   = "goto",
    start  = 5,
    finish = 13,
    [1]    = "CONTINUE",
}
CHECK[[if 1 then
end]]
{
    type   = "if",
    start  = 0,
    finish = 10003,
    [1]    = {
        type    = "ifblock",
        start   = 0,
        finish  = 9,
        keyword = {
            [1] = 0,
            [2] = 2,
            [3] = 5,
            [4] = 9,
        },
        parent  = "<IGNORE>",
        filter  = {
            type   = "integer",
            start  = 3,
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
    start  = 0,
    finish = 20003,
    [1]    = {
        type    = "ifblock",
        start   = 0,
        finish  = 10010,
        keyword = {
            [1] = 0,
            [2] = 2,
            [3] = 5,
            [4] = 9,
        },
        parent  = "<IGNORE>",
        filter  = {
            type   = "integer",
            start  = 3,
            finish = 4,
            parent = "<IGNORE>",
            [1]    = 1,
        },
        [1]     = {
            type   = "return",
            start  = 10004,
            finish = 10010,
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
    start  = 0,
    finish = 40003,
    [1]    = {
        type    = "ifblock",
        start   = 0,
        finish  = 10010,
        keyword = {
            [1] = 0,
            [2] = 2,
            [3] = 5,
            [4] = 9,
        },
        parent  = "<IGNORE>",
        filter  = {
            type   = "integer",
            start  = 3,
            finish = 4,
            parent = "<IGNORE>",
            [1]    = 1,
        },
        [1]     = {
            type   = "return",
            start  = 10004,
            finish = 10010,
            parent = "<IGNORE>",
        },
    },
    [2]    = {
        type    = "elseblock",
        start   = 20000,
        finish  = 30010,
        keyword = {
            [1] = 20000,
            [2] = 20004,
        },
        parent  = "<IGNORE>",
        [1]     = {
            type   = "return",
            start  = 30004,
            finish = 30010,
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
    start  = 0,
    finish = 40003,
    [1]    = {
        type    = "ifblock",
        start   = 0,
        finish  = 10010,
        keyword = {
            [1] = 0,
            [2] = 2,
            [3] = 5,
            [4] = 9,
        },
        parent  = "<IGNORE>",
        filter  = {
            type   = "integer",
            start  = 3,
            finish = 4,
            parent = "<IGNORE>",
            [1]    = 1,
        },
        [1]     = {
            type   = "return",
            start  = 10004,
            finish = 10010,
            parent = "<IGNORE>",
        },
    },
    [2]    = {
        type    = "elseifblock",
        start   = 20000,
        finish  = 30010,
        keyword = {
            [1] = 20000,
            [2] = 20006,
            [3] = 20009,
            [4] = 20013,
        },
        parent  = "<IGNORE>",
        filter  = {
            type   = "integer",
            start  = 20007,
            finish = 20008,
            parent = "<IGNORE>",
            [1]    = 1,
        },
        [1]     = {
            type   = "return",
            start  = 30004,
            finish = 30010,
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
    start  = 0,
    finish = 60003,
    [1]    = {
        type    = "ifblock",
        start   = 0,
        finish  = 10010,
        keyword = {
            [1] = 0,
            [2] = 2,
            [3] = 5,
            [4] = 9,
        },
        parent  = "<IGNORE>",
        filter  = {
            type   = "integer",
            start  = 3,
            finish = 4,
            parent = "<IGNORE>",
            [1]    = 1,
        },
        [1]     = {
            type   = "return",
            start  = 10004,
            finish = 10010,
            parent = "<IGNORE>",
        },
    },
    [2]    = {
        type    = "elseifblock",
        start   = 20000,
        finish  = 30010,
        keyword = {
            [1] = 20000,
            [2] = 20006,
            [3] = 20009,
            [4] = 20013,
        },
        parent  = "<IGNORE>",
        filter  = {
            type   = "integer",
            start  = 20007,
            finish = 20008,
            parent = "<IGNORE>",
            [1]    = 1,
        },
        [1]     = {
            type   = "return",
            start  = 30004,
            finish = 30010,
            parent = "<IGNORE>",
        },
    },
    [3]    = {
        type    = "elseblock",
        start   = 40000,
        finish  = 50010,
        keyword = {
            [1] = 40000,
            [2] = 40004,
        },
        parent  = "<IGNORE>",
        [1]     = {
            type   = "return",
            start  = 50004,
            finish = 50010,
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
    start  = 0,
    finish = 40003,
    [1]    = {
        type    = "ifblock",
        start   = 0,
        finish  = 9,
        keyword = {
            [1] = 0,
            [2] = 2,
            [3] = 5,
            [4] = 9,
        },
        parent  = "<IGNORE>",
        filter  = {
            type   = "integer",
            start  = 3,
            finish = 4,
            parent = "<IGNORE>",
            [1]    = 1,
        },
    },
    [2]    = {
        type    = "elseifblock",
        start   = 10000,
        finish  = 10013,
        keyword = {
            [1] = 10000,
            [2] = 10006,
            [3] = 10009,
            [4] = 10013,
        },
        parent  = "<IGNORE>",
        filter  = {
            type   = "integer",
            start  = 10007,
            finish = 10008,
            parent = "<IGNORE>",
            [1]    = 1,
        },
    },
    [3]    = {
        type    = "elseifblock",
        start   = 20000,
        finish  = 20013,
        keyword = {
            [1] = 20000,
            [2] = 20006,
            [3] = 20009,
            [4] = 20013,
        },
        parent  = "<IGNORE>",
        filter  = {
            type   = "integer",
            start  = 20007,
            finish = 20008,
            parent = "<IGNORE>",
            [1]    = 1,
        },
    },
    [4]    = {
        type    = "elseifblock",
        start   = 30000,
        finish  = 30013,
        keyword = {
            [1] = 30000,
            [2] = 30006,
            [3] = 30009,
            [4] = 30013,
        },
        parent  = "<IGNORE>",
        filter  = {
            type   = "integer",
            start  = 30007,
            finish = 30008,
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
    start  = 0,
    finish = 30003,
    [1]    = {
        type    = "ifblock",
        start   = 0,
        finish  = 20007,
        keyword = {
            [1] = 0,
            [2] = 2,
            [3] = 5,
            [4] = 9,
        },
        parent  = "<IGNORE>",
        filter  = {
            type   = "integer",
            start  = 3,
            finish = 4,
            parent = "<IGNORE>",
            [1]    = 1,
        },
        [1]     = {
            type   = "if",
            start  = 10004,
            finish = 20007,
            parent = "<IGNORE>",
            [1]    = {
                type    = "ifblock",
                start   = 10004,
                finish  = 10013,
                keyword = {
                    [1] = 10004,
                    [2] = 10006,
                    [3] = 10009,
                    [4] = 10013,
                },
                parent  = "<IGNORE>",
                filter  = {
                    type   = "integer",
                    start  = 10007,
                    finish = 10008,
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
    start  = 0,
    finish = 30003,
    [1]    = {
        type    = "ifblock",
        start   = 0,
        finish  = 9,
        keyword = {
            [1] = 0,
            [2] = 2,
            [3] = 5,
            [4] = 9,
        },
        parent  = "<IGNORE>",
        filter  = {
            type   = "integer",
            start  = 3,
            finish = 4,
            parent = "<IGNORE>",
            [1]    = 1,
        },
    },
    [2]    = {
        type    = "elseifblock",
        start   = 10000,
        finish  = 10013,
        keyword = {
            [1] = 10000,
            [2] = 10006,
            [3] = 10009,
            [4] = 10013,
        },
        parent  = "<IGNORE>",
        filter  = {
            type   = "integer",
            start  = 10007,
            finish = 10008,
            parent = "<IGNORE>",
            [1]    = 1,
        },
    },
    [3]    = {
        type    = "elseblock",
        start   = 20000,
        finish  = 20004,
        keyword = {
            [1] = 20000,
            [2] = 20004,
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
    start   = 0,
    finish  = 20003,
    keyword = {
        [1] = 0,
        [2] = 3,
        [3] = 13,
        [4] = 15,
        [5] = 20000,
        [6] = 20003,
    },
    loc     = {
        type   = "local",
        start  = 4,
        finish = 5,
        effect = 12,
        parent = "<IGNORE>",
        [1]    = "i",
    },
    init    = {
        type   = "integer",
        start  = 8,
        finish = 9,
        parent = "<IGNORE>",
        [1]    = 1,
    },
    max     = {
        type   = "getglobal",
        start  = 11,
        finish = 12,
        parent = "<IGNORE>",
        [1]    = "i",
    },
    locals  = "<IGNORE>",
    [1]     = {
        type   = "return",
        start  = 10004,
        finish = 10010,
        parent = "<IGNORE>",
    },
}
CHECK[[
for i = 1, 10, i do
    return
end]]
{
    type    = "loop",
    start   = 0,
    finish  = 20003,
    keyword = {
        [1] = 0,
        [2] = 3,
        [3] = 17,
        [4] = 19,
        [5] = 20000,
        [6] = 20003,
    },
    loc     = {
        type   = "local",
        start  = 4,
        finish = 5,
        effect = 16,
        parent = "<IGNORE>",
        [1]    = "i",
    },
    init    = {
        type   = "integer",
        start  = 8,
        finish = 9,
        parent = "<IGNORE>",
        [1]    = 1,
    },
    max     = {
        type   = "integer",
        start  = 11,
        finish = 13,
        parent = "<IGNORE>",
        [1]    = 10,
    },
    step    = {
        type   = "getglobal",
        start  = 15,
        finish = 16,
        parent = "<IGNORE>",
        [1]    = "i",
    },
    locals  = "<IGNORE>",
    [1]     = {
        type   = "return",
        start  = 10004,
        finish = 10010,
        parent = "<IGNORE>",
    },
}
CHECK[[
for a in a do
    return
end]]
{
    type    = "in",
    start   = 0,
    finish  = 20003,
    keyword = {
        [1] = 0,
        [2] = 3,
        [3] = 6,
        [4] = 8,
        [5] = 11,
        [6] = 13,
        [7] = 20000,
        [8] = 20003,
    },
    keys    = {
        type   = "list",
        start  = 4,
        finish = 5,
        range  = 8,
        [1]    = {
            type   = "local",
            start  = 4,
            finish = 5,
            effect = 10,
            parent = "<IGNORE>",
            [1]    = "a",
        },
    },
    exps    = {
        type   = "list",
        start  = 9,
        finish = 10,
        [1]    = {
            type   = "getglobal",
            start  = 9,
            finish = 10,
            parent = "<IGNORE>",
            [1]    = "a",
        },
    },
    locals  = "<IGNORE>",
    [1]     = {
        type   = "return",
        start  = 10004,
        finish = 10010,
        parent = "<IGNORE>",
    },
}
CHECK[[
for a, b, c in a, b, c do
    return
end]]
{
    type    = "in",
    start   = 0,
    finish  = 20003,
    keyword = {
        [1] = 0,
        [2] = 3,
        [3] = 12,
        [4] = 14,
        [5] = 23,
        [6] = 25,
        [7] = 20000,
        [8] = 20003,
    },
    keys    = {
        type   = "list",
        start  = 4,
        finish = 11,
        range  = 14,
        [1]    = {
            type   = "local",
            start  = 4,
            finish = 5,
            effect = 22,
            parent = "<IGNORE>",
            [1]    = "a",
        },
        [2]    = {
            type   = "local",
            start  = 7,
            finish = 8,
            effect = 22,
            parent = "<IGNORE>",
            [1]    = "b",
        },
        [3]    = {
            type   = "local",
            start  = 10,
            finish = 11,
            effect = 22,
            parent = "<IGNORE>",
            [1]    = "c",
        },
    },
    exps    = {
        type   = "list",
        start  = 15,
        finish = 22,
        [1]    = {
            type   = "getglobal",
            start  = 15,
            finish = 16,
            parent = "<IGNORE>",
            [1]    = "a",
        },
        [2]    = {
            type   = "getglobal",
            start  = 18,
            finish = 19,
            parent = "<IGNORE>",
            [1]    = "b",
        },
        [3]    = {
            type   = "getglobal",
            start  = 21,
            finish = 22,
            parent = "<IGNORE>",
            [1]    = "c",
        },
    },
    locals  = "<IGNORE>",
    [1]     = {
        type   = "return",
        start  = 10004,
        finish = 10010,
        parent = "<IGNORE>",
    },
}
CHECK[[
while true do
    return
end]]
{
    type    = "while",
    start   = 0,
    finish  = 20003,
    keyword = {
        [1] = 0,
        [2] = 5,
        [3] = 11,
        [4] = 13,
        [5] = 20000,
        [6] = 20003,
    },
    filter  = {
        type   = "boolean",
        start  = 6,
        finish = 10,
        parent = "<IGNORE>",
        [1]    = true,
    },
    [1]     = {
        type   = "return",
        start  = 10004,
        finish = 10010,
        parent = "<IGNORE>",
    },
}
CHECK[[
repeat
    break
until 1]]
{
    type    = "repeat",
    start   = 0,
    finish  = 20007,
    keyword = {
        [1] = 0,
        [2] = 6,
        [3] = 20000,
        [4] = 20005,
    },
    filter  = {
        type   = "integer",
        start  = 20006,
        finish = 20007,
        parent = "<IGNORE>",
        [1]    = 1,
    },
    breaks  = {
        [1] = {
            type   = "break",
            start  = 10004,
            finish = 10009,
            parent = "<IGNORE>",
        },
    },
    [1]     = {
        type   = "break",
        start  = 10004,
        finish = 10009,
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
                type   = "local",
                start  = 1,
                finish = 1,
                effect = 14,
                tag    = "self",
                parent = "<IGNORE>",
                dummy  = true,
                method = "<LOOP>",
                [1]    = "self",
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
            type   = "funcargs",
            start  = 10,
            finish = 12,
            parent = "<IGNORE>",
            [1]    = {
                type   = "local",
                start  = 1,
                finish = 1,
                effect = 12,
                tag    = "self",
                parent = "<IGNORE>",
                dummy  = true,
                method = "<LOOP>",
                ref    = "<IGNORE>",
                [1]    = "self",
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
                    start  = 1,
                    finish = 1,
                    effect = 12,
                    tag    = "self",
                    parent = "<IGNORE>",
                    dummy  = true,
                    method = "<LOOP>",
                    ref    = "<IGNORE>",
                    [1]    = "self",
                },
                [1]    = "self",
            },
        },
    },
}

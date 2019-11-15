CHECK'nil'
{
    type   = "nil",
    start  = 1,
    finish = 3,
}
CHECK'a'
{
    type   = "getglobal",
    start  = 1,
    finish = 1,
    [1]    = "a",
}
CHECK'a.b'
{
    type   = "getfield",
    start  = 1,
    finish = 3,
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
        [1]    = "b",
    },
}
CHECK'a.b.c'
{
    type   = "getfield",
    start  = 1,
    finish = 5,
    node   = "<IGNORE>",
    dot    = {
        type   = ".",
        start  = 4,
        finish = 4,
    },
    field  = {
        type   = "field",
        start  = 5,
        finish = 5,
        parent = "<IGNORE>",
        [1]    = "c",
    },
}
CHECK'func()'
{
    type   = "call",
    start  = 1,
    finish = 6,
    node   = "<IGNORE>",
}
CHECK'a.b.c()'
{
    type   = "call",
    start  = 1,
    finish = 7,
    node   = "<IGNORE>",
}
CHECK'1 or 2'
{
    type   = "binary",
    start  = 1,
    finish = 6,
    op     = {
        type   = "or",
        start  = 3,
        finish = 4,
    },
    [1]    = {
        type   = "number",
        start  = 1,
        finish = 1,
        parent = "<IGNORE>",
        [1]    = 1,
    },
    [2]    = {
        type   = "number",
        start  = 6,
        finish = 6,
        parent = "<IGNORE>",
        [1]    = 2,
    },
}
CHECK'1 < 2'
{
    type   = "binary",
    start  = 1,
    finish = 5,
    op     = {
        type   = "<",
        start  = 3,
        finish = 3,
    },
    [1]    = {
        type   = "number",
        start  = 1,
        finish = 1,
        parent = "<IGNORE>",
        [1]    = 1,
    },
    [2]    = {
        type   = "number",
        start  = 5,
        finish = 5,
        parent = "<IGNORE>",
        [1]    = 2,
    },
}
CHECK'- 1'
{
    type   = "unary",
    start  = 1,
    finish = 3,
    op     = {
        type   = "-",
        start  = 1,
        finish = 1,
    },
    [1]    = {
        type   = "number",
        start  = 3,
        finish = 3,
        parent = "<IGNORE>",
        [1]    = 1,
    },
}
CHECK'not not true'
{
    type   = "unary",
    start  = 1,
    finish = 12,
    op     = {
        type   = "not",
        start  = 1,
        finish = 3,
    },
    [1]    = {
        type   = "unary",
        start  = 5,
        finish = 12,
        parent = "<IGNORE>",
        op     = {
            type   = "not",
            start  = 5,
            finish = 7,
        },
        [1]    = {
            type   = "boolean",
            start  = 9,
            finish = 12,
            parent = "<IGNORE>",
            [1]    = true,
        },
    },
}
CHECK'1 ^ 2'
{
    type   = "binary",
    start  = 1,
    finish = 5,
    op     = {
        type   = "^",
        start  = 3,
        finish = 3,
    },
    [1]    = {
        type   = "number",
        start  = 1,
        finish = 1,
        parent = "<IGNORE>",
        [1]    = 1,
    },
    [2]    = {
        type   = "number",
        start  = 5,
        finish = 5,
        parent = "<IGNORE>",
        [1]    = 2,
    },
}
CHECK'1 ^ -2'
{
    type   = "binary",
    start  = 1,
    finish = 6,
    op     = {
        type   = "^",
        start  = 3,
        finish = 3,
    },
    [1]    = {
        type   = "number",
        start  = 1,
        finish = 1,
        parent = "<IGNORE>",
        [1]    = 1,
    },
    [2]    = {
        type   = "unary",
        start  = 5,
        finish = 6,
        parent = "<IGNORE>",
        op     = {
            type   = "-",
            start  = 5,
            finish = 5,
        },
        [1]    = {
            type   = "number",
            start  = 6,
            finish = 6,
            parent = "<IGNORE>",
            [1]    = 2,
        },
    },
}
CHECK'...'
{
    type   = "varargs",
    start  = 1,
    finish = 3,
}
CHECK'1 + 2 + 3'
{
    type   = "binary",
    start  = 1,
    finish = 9,
    op     = {
        type   = "+",
        start  = 7,
        finish = 7,
    },
    [1]    = {
        type   = "binary",
        start  = 1,
        finish = 5,
        parent = "<IGNORE>",
        op     = {
            type   = "+",
            start  = 3,
            finish = 3,
        },
        [1]    = {
            type   = "number",
            start  = 1,
            finish = 1,
            parent = "<IGNORE>",
            [1]    = 1,
        },
        [2]    = {
            type   = "number",
            start  = 5,
            finish = 5,
            parent = "<IGNORE>",
            [1]    = 2,
        },
    },
    [2]    = {
        type   = "number",
        start  = 9,
        finish = 9,
        parent = "<IGNORE>",
        [1]    = 3,
    },
}
CHECK'1 + 2 * 3'
{
    type   = "binary",
    start  = 1,
    finish = 9,
    op     = {
        type   = "+",
        start  = 3,
        finish = 3,
    },
    [1]    = {
        type   = "number",
        start  = 1,
        finish = 1,
        parent = "<IGNORE>",
        [1]    = 1,
    },
    [2]    = {
        type   = "binary",
        start  = 5,
        finish = 9,
        parent = "<IGNORE>",
        op     = {
            type   = "*",
            start  = 7,
            finish = 7,
        },
        [1]    = {
            type   = "number",
            start  = 5,
            finish = 5,
            parent = "<IGNORE>",
            [1]    = 2,
        },
        [2]    = {
            type   = "number",
            start  = 9,
            finish = 9,
            parent = "<IGNORE>",
            [1]    = 3,
        },
    },
}
CHECK'- 1 + 2 * 3'
{
    type   = "binary",
    start  = 1,
    finish = 11,
    op     = {
        type   = "+",
        start  = 5,
        finish = 5,
    },
    [1]    = {
        type   = "unary",
        start  = 1,
        finish = 3,
        parent = "<IGNORE>",
        op     = {
            type   = "-",
            start  = 1,
            finish = 1,
        },
        [1]    = {
            type   = "number",
            start  = 3,
            finish = 3,
            parent = "<IGNORE>",
            [1]    = 1,
        },
    },
    [2]    = {
        type   = "binary",
        start  = 7,
        finish = 11,
        parent = "<IGNORE>",
        op     = {
            type   = "*",
            start  = 9,
            finish = 9,
        },
        [1]    = {
            type   = "number",
            start  = 7,
            finish = 7,
            parent = "<IGNORE>",
            [1]    = 2,
        },
        [2]    = {
            type   = "number",
            start  = 11,
            finish = 11,
            parent = "<IGNORE>",
            [1]    = 3,
        },
    },
}
-- 幂运算从右向左连接
CHECK'1 ^ 2 ^ 3'
{
    type   = "binary",
    start  = 1,
    finish = 9,
    op     = {
        type   = "^",
        start  = 3,
        finish = 3,
    },
    [1]    = {
        type   = "number",
        start  = 1,
        finish = 1,
        parent = "<IGNORE>",
        [1]    = 1,
    },
    [2]    = {
        type   = "binary",
        start  = 5,
        finish = 9,
        parent = "<IGNORE>",
        op     = {
            type   = "^",
            start  = 7,
            finish = 7,
        },
        [1]    = {
            type   = "number",
            start  = 5,
            finish = 5,
            parent = "<IGNORE>",
            [1]    = 2,
        },
        [2]    = {
            type   = "number",
            start  = 9,
            finish = 9,
            parent = "<IGNORE>",
            [1]    = 3,
        },
    },
}
-- 连接运算从右向左连接
CHECK'1 .. 2 .. 3'
{
    type   = "binary",
    start  = 1,
    finish = 11,
    op     = {
        type   = "..",
        start  = 3,
        finish = 4,
    },
    [1]    = {
        type   = "number",
        start  = 1,
        finish = 1,
        parent = "<IGNORE>",
        [1]    = 1,
    },
    [2]    = {
        type   = "binary",
        start  = 6,
        finish = 11,
        parent = "<IGNORE>",
        op     = {
            type   = "..",
            start  = 8,
            finish = 9,
        },
        [1]    = {
            type   = "number",
            start  = 6,
            finish = 6,
            parent = "<IGNORE>",
            [1]    = 2,
        },
        [2]    = {
            type   = "number",
            start  = 11,
            finish = 11,
            parent = "<IGNORE>",
            [1]    = 3,
        },
    },
}
CHECK'(1)'
{
    type   = "paren",
    start  = 1,
    finish = 3,
    exp    = {
        type   = "number",
        start  = 2,
        finish = 2,
        parent = "<IGNORE>",
        [1]    = 1,
    },
}
CHECK'(1 + 2)'
{
    type   = "paren",
    start  = 1,
    finish = 7,
    exp    = {
        type   = "binary",
        start  = 2,
        finish = 6,
        parent = "<IGNORE>",
        op     = {
            type   = "+",
            start  = 4,
            finish = 4,
        },
        [1]    = {
            type   = "number",
            start  = 2,
            finish = 2,
            parent = "<IGNORE>",
            [1]    = 1,
        },
        [2]    = {
            type   = "number",
            start  = 6,
            finish = 6,
            parent = "<IGNORE>",
            [1]    = 2,
        },
    },
}
CHECK'func(1)'
{
    type   = "call",
    start  = 1,
    finish = 7,
    node   = "<IGNORE>",
    args   = {
        type   = "callargs",
        start  = 5,
        finish = 7,
        parent = "<IGNORE>",
        [1]    = {
            type   = "number",
            start  = 6,
            finish = 6,
            parent = "<IGNORE>",
            [1]    = 1,
        },
    },
}
CHECK'func(1, 2)'
{
    type   = "call",
    start  = 1,
    finish = 10,
    node   = "<IGNORE>",
    args   = {
        type   = "callargs",
        start  = 5,
        finish = 10,
        parent = "<IGNORE>",
        [1]    = {
            type   = "number",
            start  = 6,
            finish = 6,
            parent = "<IGNORE>",
            [1]    = 1,
        },
        [2]    = {
            type   = "number",
            start  = 9,
            finish = 9,
            parent = "<IGNORE>",
            [1]    = 2,
        },
    },
}
CHECK'func(...)'
{
    type   = "call",
    start  = 1,
    finish = 9,
    node   = "<IGNORE>",
    args   = {
        type   = "callargs",
        start  = 5,
        finish = 9,
        parent = "<IGNORE>",
        [1]    = {
            type   = "varargs",
            start  = 6,
            finish = 8,
            parent = "<IGNORE>",
        },
    },
}
CHECK'func(1, ...)'
{
    type   = "call",
    start  = 1,
    finish = 12,
    node   = "<IGNORE>",
    args   = {
        type   = "callargs",
        start  = 5,
        finish = 12,
        parent = "<IGNORE>",
        [1]    = {
            type   = "number",
            start  = 6,
            finish = 6,
            parent = "<IGNORE>",
            [1]    = 1,
        },
        [2]    = {
            type   = "varargs",
            start  = 9,
            finish = 11,
            parent = "<IGNORE>",
        },
    },
}
CHECK'func ""'
{
    type   = "call",
    start  = 1,
    finish = 7,
    node   = "<IGNORE>",
    args   = {
        type   = "callargs",
        start  = 6,
        finish = 7,
        parent = "<IGNORE>",
        [1]    = {
            type   = "string",
            start  = 6,
            finish = 7,
            parent = "<IGNORE>",
            [1]    = "",
            [2]    = "\"",
        },
    },
}
CHECK'func {}'
{
    type   = "call",
    start  = 1,
    finish = 7,
    node   = "<IGNORE>",
    args   = {
        type   = "callargs",
        start  = 6,
        finish = 7,
        parent = "<IGNORE>",
        [1]    = {
            type   = "table",
            start  = 6,
            finish = 7,
            parent = "<IGNORE>",
        },
    },
}
CHECK'table[1]'
{
    type   = "getindex",
    start  = 1,
    finish = 8,
    node   = "<IGNORE>",
    index  = {
        type   = "number",
        start  = 7,
        finish = 7,
        parent = "<IGNORE>",
        [1]    = 1,
    },
}
CHECK'get_point().x'
{
    type   = "getfield",
    start  = 1,
    finish = 13,
    node   = "<IGNORE>",
    dot    = {
        type   = ".",
        start  = 12,
        finish = 12,
    },
    field  = {
        type   = "field",
        start  = 13,
        finish = 13,
        parent = "<IGNORE>",
        [1]    = "x",
    },
}
CHECK'obj:remove()'
{
    type   = "call",
    start  = 1,
    finish = 12,
    node   = "<IGNORE>",
}
CHECK'(...)[1]'
{
    type   = "getindex",
    start  = 1,
    finish = 8,
    node   = "<IGNORE>",
    index  = {
        type   = "number",
        start  = 7,
        finish = 7,
        parent = "<IGNORE>",
        [1]    = 1,
    },
}
CHECK'function () end'
{
    type   = "function",
    start  = 1,
    finish = 15,
}
CHECK'function (...) end'
{
    type   = "function",
    start  = 1,
    finish = 18,
    args   = {
        type   = "funcargs",
        start  = 10,
        finish = 14,
        parent = "<IGNORE>",
        [1]    = {
            type   = "...",
            start  = 11,
            finish = 13,
            parent = "<IGNORE>",
        },
    },
}
CHECK'function (a, ...) end'
{
    type   = "function",
    start  = 1,
    finish = 21,
    args   = {
        type   = "funcargs",
        start  = 10,
        finish = 17,
        parent = "<IGNORE>",
        [1]    = {
            type   = "local",
            start  = 11,
            finish = 11,
            effect = 11,
            parent = "<IGNORE>",
            [1]    = "a",
        },
        [2]    = {
            type   = "...",
            start  = 14,
            finish = 16,
            parent = "<IGNORE>",
        },
    },
    locals = "<IGNORE>",
}
CHECK'{}'
{
    type   = "table",
    start  = 1,
    finish = 2,
}
CHECK'{...}'
{
    type   = "table",
    start  = 1,
    finish = 5,
    [1]    = {
        type   = "varargs",
        start  = 2,
        finish = 4,
        parent = "<IGNORE>",
    },
}
CHECK'{1, 2, 3}'
{
    type   = "table",
    start  = 1,
    finish = 9,
    [1]    = {
        type   = "number",
        start  = 2,
        finish = 2,
        parent = "<IGNORE>",
        [1]    = 1,
    },
    [2]    = {
        type   = "number",
        start  = 5,
        finish = 5,
        parent = "<IGNORE>",
        [1]    = 2,
    },
    [3]    = {
        type   = "number",
        start  = 8,
        finish = 8,
        parent = "<IGNORE>",
        [1]    = 3,
    },
}
CHECK'{x = 1, y = 2}'
{
    type   = "table",
    start  = 1,
    finish = 14,
    [1]    = {
        type   = "tablefield",
        start  = 2,
        finish = 6,
        parent = "<IGNORE>",
        field  = {
            type   = "field",
            start  = 2,
            finish = 2,
            parent = "<IGNORE>",
            [1]    = "x",
        },
        value  = {
            type   = "number",
            start  = 6,
            finish = 6,
            parent = "<IGNORE>",
            [1]    = 1,
        },
    },
    [2]    = {
        type   = "tablefield",
        start  = 9,
        finish = 13,
        parent = "<IGNORE>",
        field  = {
            type   = "field",
            start  = 9,
            finish = 9,
            parent = "<IGNORE>",
            [1]    = "y",
        },
        value  = {
            type   = "number",
            start  = 13,
            finish = 13,
            parent = "<IGNORE>",
            [1]    = 2,
        },
    },
}
CHECK'{["x"] = 1, ["y"] = 2}'
{
    type   = "table",
    start  = 1,
    finish = 22,
    [1]    = {
        type   = "tableindex",
        start  = 2,
        finish = 10,
        parent = "<IGNORE>",
        index  = {
            type   = "index",
            start  = 2,
            finish = 6,
            parent = "<IGNORE>",
            index  = {
                type   = "string",
                start  = 3,
                finish = 5,
                parent = "<IGNORE>",
                [1]    = "x",
                [2]    = "\"",
            },
        },
        value  = {
            type   = "number",
            start  = 10,
            finish = 10,
            parent = "<IGNORE>",
            [1]    = 1,
        },
    },
    [2]    = {
        type   = "tableindex",
        start  = 13,
        finish = 21,
        parent = "<IGNORE>",
        index  = {
            type   = "index",
            start  = 13,
            finish = 17,
            parent = "<IGNORE>",
            index  = {
                type   = "string",
                start  = 14,
                finish = 16,
                parent = "<IGNORE>",
                [1]    = "y",
                [2]    = "\"",
            },
        },
        value  = {
            type   = "number",
            start  = 21,
            finish = 21,
            parent = "<IGNORE>",
            [1]    = 2,
        },
    },
}
CHECK'{[x] = 1, [y] = 2}'
{
    type   = "table",
    start  = 1,
    finish = 18,
    [1]    = {
        type   = "tableindex",
        start  = 2,
        finish = 8,
        parent = "<IGNORE>",
        index  = {
            type   = "index",
            start  = 2,
            finish = 4,
            parent = "<IGNORE>",
            index  = {
                type   = "getglobal",
                start  = 3,
                finish = 3,
                parent = "<IGNORE>",
                [1]    = "x",
            },
        },
        value  = {
            type   = "number",
            start  = 8,
            finish = 8,
            parent = "<IGNORE>",
            [1]    = 1,
        },
    },
    [2]    = {
        type   = "tableindex",
        start  = 11,
        finish = 17,
        parent = "<IGNORE>",
        index  = {
            type   = "index",
            start  = 11,
            finish = 13,
            parent = "<IGNORE>",
            index  = {
                type   = "getglobal",
                start  = 12,
                finish = 12,
                parent = "<IGNORE>",
                [1]    = "y",
            },
        },
        value  = {
            type   = "number",
            start  = 17,
            finish = 17,
            parent = "<IGNORE>",
            [1]    = 2,
        },
    },
}
CHECK'{{}}'
{
    type   = "table",
    start  = 1,
    finish = 4,
    [1]    = {
        type   = "table",
        start  = 2,
        finish = 3,
        parent = "<IGNORE>",
    },
}
CHECK'{ a = { b = { c = {} } } }'
{
    type   = "table",
    start  = 1,
    finish = 26,
    [1]    = {
        type   = "tablefield",
        start  = 3,
        finish = 24,
        parent = "<IGNORE>",
        field  = {
            type   = "field",
            start  = 3,
            finish = 3,
            parent = "<IGNORE>",
            [1]    = "a",
        },
        value  = {
            type   = "table",
            start  = 7,
            finish = 24,
            parent = "<IGNORE>",
            [1]    = {
                type   = "tablefield",
                start  = 9,
                finish = 22,
                parent = "<IGNORE>",
                field  = {
                    type   = "field",
                    start  = 9,
                    finish = 9,
                    parent = "<IGNORE>",
                    [1]    = "b",
                },
                value  = {
                    type   = "table",
                    start  = 13,
                    finish = 22,
                    parent = "<IGNORE>",
                    [1]    = {
                        type   = "tablefield",
                        start  = 15,
                        finish = 20,
                        parent = "<IGNORE>",
                        field  = {
                            type   = "field",
                            start  = 15,
                            finish = 15,
                            parent = "<IGNORE>",
                            [1]    = "c",
                        },
                        value  = {
                            type   = "table",
                            start  = 19,
                            finish = 20,
                            parent = "<IGNORE>",
                        },
                    },
                },
            },
        },
    },
}
CHECK'{{}, {}, {{}, {}}}'
{
    type   = "table",
    start  = 1,
    finish = 18,
    [1]    = {
        type   = "table",
        start  = 2,
        finish = 3,
        parent = "<IGNORE>",
    },
    [2]    = {
        type   = "table",
        start  = 6,
        finish = 7,
        parent = "<IGNORE>",
    },
    [3]    = {
        type   = "table",
        start  = 10,
        finish = 17,
        parent = "<IGNORE>",
        [1]    = {
            type   = "table",
            start  = 11,
            finish = 12,
            parent = "<IGNORE>",
        },
        [2]    = {
            type   = "table",
            start  = 15,
            finish = 16,
            parent = "<IGNORE>",
        },
    },
}
CHECK'{1, 2, 3,}'
{
    type   = "table",
    start  = 1,
    finish = 10,
    [1]    = {
        type   = "number",
        start  = 2,
        finish = 2,
        parent = "<IGNORE>",
        [1]    = 1,
    },
    [2]    = {
        type   = "number",
        start  = 5,
        finish = 5,
        parent = "<IGNORE>",
        [1]    = 2,
    },
    [3]    = {
        type   = "number",
        start  = 8,
        finish = 8,
        parent = "<IGNORE>",
        [1]    = 3,
    },
}

CHECK 'notify'
{
    type   = "getglobal",
    start  = 1,
    finish = 6,
    [1]    = "notify",
}

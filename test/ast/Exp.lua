CHECK'nil'
{
    [1] = {
        type   = 'nil',
        start  = 1,
        finish = 3,
    }
}
CHECK'a'
{
    [1] = {
        type   = "getname",
        start  = 1,
        finish = 1,
        [1]    = 'a',
    },
}
CHECK'a.b'
{
    [1] = {
        type   = "getfield",
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
            [1]    = "b",
        },
    },
    [2] = {
        type   = "getname",
        start  = 1,
        finish = 1,
        parent = 1,
        [1]    = "a",
    },
}
CHECK'a.b.c'
{
    [1] = {
        type   = "getfield",
        start  = 1,
        finish = 5,
        node   = 2,
        dot    = {
            type   = ".",
            start  = 4,
            finish = 4,
        },
        field  = {
            type   = "field",
            start  = 5,
            finish = 5,
            [1]    = "c",
        },
    },
    [2] = {
        type   = "getfield",
        start  = 1,
        finish = 3,
        parent = 1,
        node   = 3,
        dot    = {
            type   = ".",
            start  = 2,
            finish = 2,
        },
        field  = {
            type   = "field",
            start  = 3,
            finish = 3,
            [1]    = "b",
        },
    },
    [3] = {
        type   = "getname",
        start  = 1,
        finish = 1,
        parent = 2,
        [1]    = "a",
    },
}
CHECK'func()'
{
    [1] = {
        type   = "call",
        start  = 1,
        finish = 6,
        node   = 2,
    },
    [2] = {
        type   = "getname",
        start  = 1,
        finish = 4,
        parent = 1,
        [1]    = "func",
    },
}
CHECK'a.b.c()'
{
    [1] = {
        type   = "call",
        start  = 1,
        finish = 7,
        node   = 2,
    },
    [2] = {
        type   = "getfield",
        start  = 1,
        finish = 5,
        parent = 1,
        node   = 3,
        dot    = {
            type   = ".",
            start  = 4,
            finish = 4,
        },
        field  = {
            type   = "field",
            start  = 5,
            finish = 5,
            [1]    = "c",
        },
    },
    [3] = {
        type   = "getfield",
        start  = 1,
        finish = 3,
        parent = 2,
        node   = 4,
        dot    = {
            type   = ".",
            start  = 2,
            finish = 2,
        },
        field  = {
            type   = "field",
            start  = 3,
            finish = 3,
            [1]    = "b",
        },
    },
    [4] = {
        type   = "getname",
        start  = 1,
        finish = 1,
        parent = 3,
        [1]    = "a",
    },
}
CHECK'1 or 2'
{
    [1] = {
        type   = "binary",
        start  = 1,
        finish = 6,
        op     = {
            type   = "or",
            start  = 3,
            finish = 4,
        },
        [1]    = 2,
        [2]    = 3,
    },
    [2] = {
        type   = "number",
        start  = 1,
        finish = 1,
        parent = 1,
        [1]    = 1,
    },
    [3] = {
        type   = "number",
        start  = 6,
        finish = 6,
        parent = 1,
        [1]    = 2,
    },
}
CHECK'1 < 2'
{
    [1] = {
        type   = "binary",
        start  = 1,
        finish = 5,
        op     = {
            type   = "<",
            start  = 3,
            finish = 3,
        },
        [1]    = 2,
        [2]    = 3,
    },
    [2] = {
        type   = "number",
        start  = 1,
        finish = 1,
        parent = 1,
        [1]    = 1,
    },
    [3] = {
        type   = "number",
        start  = 5,
        finish = 5,
        parent = 1,
        [1]    = 2,
    },
}
CHECK'- 1'
{
    [1] = {
        type   = "unary",
        start  = 1,
        finish = 3,
        op     = {
            type   = "-",
            start  = 1,
            finish = 1,
        },
        [1]    = 2,
    },
    [2] = {
        type   = "number",
        start  = 3,
        finish = 3,
        parent = 1,
        [1]    = 1,
    },
}
CHECK'not not true'
{
    [1] = {
        type   = "unary",
        start  = 1,
        finish = 12,
        op     = {
            type   = "not",
            start  = 1,
            finish = 3,
        },
        [1]    = 2,
    },
    [2] = {
        type   = "unary",
        start  = 5,
        finish = 12,
        parent = 1,
        op     = {
            type   = "not",
            start  = 5,
            finish = 7,
        },
        [1]    = 3,
    },
    [3] = {
        type   = "boolean",
        start  = 9,
        finish = 12,
        parent = 2,
        [1]    = true,
    },
}
CHECK'1 ^ 2'
{
    [1] = {
        type   = "binary",
        start  = 1,
        finish = 5,
        op     = {
            type   = "^",
            start  = 3,
            finish = 3,
        },
        [1]    = 2,
        [2]    = 3,
    },
    [2] = {
        type   = "number",
        start  = 1,
        finish = 1,
        parent = 1,
        [1]    = 1,
    },
    [3] = {
        type   = "number",
        start  = 5,
        finish = 5,
        parent = 1,
        [1]    = 2,
    },
}
CHECK'1 ^ -2'
{
    [1] = {
        type   = "binary",
        start  = 1,
        finish = 6,
        op     = {
            type   = "^",
            start  = 3,
            finish = 3,
        },
        [1]    = 2,
        [2]    = 3,
    },
    [2] = {
        type   = "number",
        start  = 1,
        finish = 1,
        parent = 1,
        [1]    = 1,
    },
    [3] = {
        type   = "unary",
        start  = 5,
        finish = 6,
        parent = 1,
        op     = {
            type   = "-",
            start  = 5,
            finish = 5,
        },
        [1]    = 4,
    },
    [4] = {
        type   = "number",
        start  = 6,
        finish = 6,
        parent = 3,
        [1]    = 2,
    },
}
CHECK'...'
{
    [1] = {
        type   = 'varargs',
        start  = 1,
        finish = 3,
    }
}
CHECK'1 + 2 + 3'
{
    [1] = {
        type   = "binary",
        start  = 1,
        finish = 9,
        op     = {
            type   = "+",
            start  = 7,
            finish = 7,
        },
        [1]    = 2,
        [2]    = 5,
    },
    [2] = {
        type   = "binary",
        start  = 1,
        finish = 5,
        parent = 1,
        op     = {
            type   = "+",
            start  = 3,
            finish = 3,
        },
        [1]    = 3,
        [2]    = 4,
    },
    [3] = {
        type   = "number",
        start  = 1,
        finish = 1,
        parent = 2,
        [1]    = 1,
    },
    [4] = {
        type   = "number",
        start  = 5,
        finish = 5,
        parent = 2,
        [1]    = 2,
    },
    [5] = {
        type   = "number",
        start  = 9,
        finish = 9,
        parent = 1,
        [1]    = 3,
    },
}
CHECK'1 + 2 * 3'
{
    [1] = {
        type   = "binary",
        start  = 1,
        finish = 9,
        op     = {
            type   = "+",
            start  = 3,
            finish = 3,
        },
        [1]    = 2,
        [2]    = 3,
    },
    [2] = {
        type   = "number",
        start  = 1,
        finish = 1,
        parent = 1,
        [1]    = 1,
    },
    [3] = {
        type   = "binary",
        start  = 5,
        finish = 9,
        parent = 1,
        op     = {
            type   = "*",
            start  = 7,
            finish = 7,
        },
        [1]    = 4,
        [2]    = 5,
    },
    [4] = {
        type   = "number",
        start  = 5,
        finish = 5,
        parent = 3,
        [1]    = 2,
    },
    [5] = {
        type   = "number",
        start  = 9,
        finish = 9,
        parent = 3,
        [1]    = 3,
    },
}
CHECK'- 1 + 2 * 3'
{
    [1] = {
        type   = "binary",
        start  = 1,
        finish = 11,
        op     = {
            type   = "+",
            start  = 5,
            finish = 5,
        },
        [1]    = 2,
        [2]    = 4,
    },
    [2] = {
        type   = "unary",
        start  = 1,
        finish = 3,
        parent = 1,
        op     = {
            type   = "-",
            start  = 1,
            finish = 1,
        },
        [1]    = 3,
    },
    [3] = {
        type   = "number",
        start  = 3,
        finish = 3,
        parent = 2,
        [1]    = 1,
    },
    [4] = {
        type   = "binary",
        start  = 7,
        finish = 11,
        parent = 1,
        op     = {
            type   = "*",
            start  = 9,
            finish = 9,
        },
        [1]    = 5,
        [2]    = 6,
    },
    [5] = {
        type   = "number",
        start  = 7,
        finish = 7,
        parent = 4,
        [1]    = 2,
    },
    [6] = {
        type   = "number",
        start  = 11,
        finish = 11,
        parent = 4,
        [1]    = 3,
    },
}
-- 幂运算从右向左连接
CHECK'1 ^ 2 ^ 3'
{
    [1] = {
        type   = "binary",
        start  = 1,
        finish = 9,
        op     = {
            type   = "^",
            start  = 3,
            finish = 3,
        },
        [1]    = 2,
        [2]    = 3,
    },
    [2] = {
        type   = "number",
        start  = 1,
        finish = 1,
        parent = 1,
        [1]    = 1,
    },
    [3] = {
        type   = "binary",
        start  = 5,
        finish = 9,
        parent = 1,
        op     = {
            type   = "^",
            start  = 7,
            finish = 7,
        },
        [1]    = 4,
        [2]    = 5,
    },
    [4] = {
        type   = "number",
        start  = 5,
        finish = 5,
        parent = 3,
        [1]    = 2,
    },
    [5] = {
        type   = "number",
        start  = 9,
        finish = 9,
        parent = 3,
        [1]    = 3,
    },
}
-- 连接运算从右向左连接
CHECK'1 .. 2 .. 3'
{
    [1] = {
        type   = "binary",
        start  = 1,
        finish = 11,
        op     = {
            type   = "..",
            start  = 3,
            finish = 4,
        },
        [1]    = 2,
        [2]    = 3,
    },
    [2] = {
        type   = "number",
        start  = 1,
        finish = 1,
        parent = 1,
        [1]    = 1,
    },
    [3] = {
        type   = "binary",
        start  = 6,
        finish = 11,
        parent = 1,
        op     = {
            type   = "..",
            start  = 8,
            finish = 9,
        },
        [1]    = 4,
        [2]    = 5,
    },
    [4] = {
        type   = "number",
        start  = 6,
        finish = 6,
        parent = 3,
        [1]    = 2,
    },
    [5] = {
        type   = "number",
        start  = 11,
        finish = 11,
        parent = 3,
        [1]    = 3,
    },
}
CHECK'(1)'
{
    [1] = {
        exp    = 2,
        type   = "paren",
        start  = 1,
        finish = 3,
    },
    [2] = {
        type   = "number",
        start  = 2,
        finish = 2,
        parent = 1,
        [1]    = 1,
    },
}
CHECK'(1 + 2)'
{
    [1] = {
        type   = "paren",
        start  = 1,
        finish = 7,
        exp    = 2,
    },
    [2] = {
        type   = "binary",
        start  = 2,
        finish = 6,
        parent = 1,
        op     = {
            type   = "+",
            start  = 4,
            finish = 4,
        },
        [1]    = 3,
        [2]    = 4,
    },
    [3] = {
        type   = "number",
        start  = 2,
        finish = 2,
        parent = 2,
        [1]    = 1,
    },
    [4] = {
        type   = "number",
        start  = 6,
        finish = 6,
        parent = 2,
        [1]    = 2,
    },
}
CHECK'func(1)'
{
    [1] = {
        type   = "call",
        start  = 1,
        finish = 7,
        node   = 2,
        args   = 3,
    },
    [2] = {
        type   = "getname",
        start  = 1,
        finish = 4,
        parent = 1,
        [1]    = "func",
    },
    [3] = {
        type   = "callargs",
        start  = 5,
        finish = 7,
        parent = 1,
        [1]    = 4,
    },
    [4] = {
        type   = "number",
        start  = 6,
        finish = 6,
        parent = 3,
        [1]    = 1,
    },
}
CHECK'func(1, 2)'
{
    [1] = {
        type   = "call",
        start  = 1,
        finish = 10,
        node   = 2,
        args   = 3,
    },
    [2] = {
        type   = "getname",
        start  = 1,
        finish = 4,
        parent = 1,
        [1]    = "func",
    },
    [3] = {
        type   = "callargs",
        start  = 5,
        finish = 10,
        parent = 1,
        [1]    = 4,
        [2]    = 5,
    },
    [4] = {
        type   = "number",
        start  = 6,
        finish = 6,
        parent = 3,
        [1]    = 1,
    },
    [5] = {
        type   = "number",
        start  = 9,
        finish = 9,
        parent = 3,
        [1]    = 2,
    },
}
CHECK'func(...)'
{
    [1] = {
        type   = "call",
        start  = 1,
        finish = 9,
        node   = 2,
        args   = 3,
    },
    [2] = {
        type   = "getname",
        start  = 1,
        finish = 4,
        parent = 1,
        [1]    = "func",
    },
    [3] = {
        type   = "callargs",
        start  = 5,
        finish = 9,
        parent = 1,
        [1]    = 4,
    },
    [4] = {
        type   = "varargs",
        start  = 6,
        finish = 8,
        parent = 3,
    },
}
CHECK'func(1, ...)'
{
    [1] = {
        type   = "call",
        start  = 1,
        finish = 12,
        node   = 2,
        args   = 3,
    },
    [2] = {
        type   = "getname",
        start  = 1,
        finish = 4,
        parent = 1,
        [1]    = "func",
    },
    [3] = {
        type   = "callargs",
        start  = 5,
        finish = 12,
        parent = 1,
        [1]    = 4,
        [2]    = 5,
    },
    [4] = {
        type   = "number",
        start  = 6,
        finish = 6,
        parent = 3,
        [1]    = 1,
    },
    [5] = {
        type   = "varargs",
        start  = 9,
        finish = 11,
        parent = 3,
    },
}
CHECK'func ""'
{
    [1] = {
        type   = "call",
        start  = 1,
        finish = 7,
        node   = 2,
        args   = 3,
    },
    [2] = {
        type   = "getname",
        start  = 1,
        finish = 4,
        parent = 1,
        [1]    = "func",
    },
    [3] = {
        type   = "callargs",
        start  = 6,
        finish = 7,
        parent = 1,
        [1]    = 4,
    },
    [4] = {
        type   = "string",
        start  = 6,
        finish = 7,
        parent = 3,
        [1]    = "",
        [2]    = "\"",
    },
}
CHECK'func {}'
{
    [1] = {
        type   = "call",
        start  = 1,
        finish = 7,
        node   = 2,
        args   = 3,
    },
    [2] = {
        type   = "getname",
        start  = 1,
        finish = 4,
        parent = 1,
        [1]    = "func",
    },
    [3] = {
        type   = "callargs",
        start  = 6,
        finish = 7,
        parent = 1,
        [1]    = 4,
    },
    [4] = {
        type   = "table",
        start  = 6,
        finish = 7,
        parent = 3,
    },
}
CHECK'table[1]'
{
    [1] = {
        type   = "getindex",
        start  = 1,
        finish = 8,
        node   = 2,
        index  = 3,
    },
    [2] = {
        type   = "getname",
        start  = 1,
        finish = 5,
        parent = 1,
        [1]    = "table",
    },
    [3] = {
        type   = "number",
        start  = 7,
        finish = 7,
        parent = 1,
        [1]    = 1,
    },
}
CHECK'get_point().x'
{
    [1] = {
        type   = "getfield",
        start  = 1,
        finish = 13,
        node   = 2,
        dot    = {
            type   = ".",
            start  = 12,
            finish = 12,
        },
        field  = {
            type   = "field",
            start  = 13,
            finish = 13,
            [1]    = "x",
        },
    },
    [2] = {
        type   = "call",
        start  = 1,
        finish = 11,
        parent = 1,
        node   = 3,
    },
    [3] = {
        type   = "getname",
        start  = 1,
        finish = 9,
        parent = 2,
        [1]    = "get_point",
    },
}
CHECK'obj:remove()'
{
    [1] = {
        type   = "call",
        start  = 1,
        finish = 12,
        node   = 2,
    },
    [2] = {
        type   = "getmethod",
        start  = 1,
        finish = 10,
        parent = 1,
        node   = 3,
        colon  = {
            type   = ":",
            start  = 4,
            finish = 4,
        },
        method = 4,
    },
    [3] = {
        type   = "getname",
        start  = 1,
        finish = 3,
        parent = 2,
        [1]    = "obj",
    },
    [4] = {
        type   = "method",
        start  = 5,
        finish = 10,
        parent = 2,
        [1]    = "remove",
    },
}
CHECK'(...)[1]'
{
    [1] = {
        type   = "getindex",
        start  = 1,
        finish = 8,
        node   = 2,
        index  = 4,
    },
    [2] = {
        type   = "paren",
        start  = 1,
        finish = 5,
        parent = 1,
        exp    = 3,
    },
    [3] = {
        type   = "varargs",
        start  = 2,
        finish = 4,
        parent = 2,
    },
    [4] = {
        type   = "number",
        start  = 7,
        finish = 7,
        parent = 1,
        [1]    = 1,
    },
}
CHECK'function () end'
{
    [1] = {
        type   = "function",
        start  = 1,
        finish = 15,
    },
}
CHECK'function (...) end'
{
    [1] = {
        type   = "function",
        start  = 1,
        finish = 18,
        args   = 2,
    },
    [2] = {
        type   = "funcargs",
        start  = 10,
        finish = 14,
        parent = 1,
        [1]    = 3,
    },
    [3] = {
        type   = "...",
        start  = 11,
        finish = 13,
        parent = 2,
    },
}
CHECK'function (a, ...) end'
{
    [1] = {
        type   = "function",
        start  = 1,
        finish = 21,
        args   = 2,
    },
    [2] = {
        type   = "funcargs",
        start  = 10,
        finish = 17,
        parent = 1,
        [1]    = 3,
        [2]    = 4,
    },
    [3] = {
        type   = "local",
        start  = 11,
        finish = 11,
        parent = 2,
        [1]    = "a",
    },
    [4] = {
        type   = "...",
        start  = 14,
        finish = 16,
        parent = 2,
    },
}
CHECK'{}'
{
    [1] = {
        type   = "table",
        start  = 1,
        finish = 2,
    },
}
CHECK'{...}'
{
    [1] = {
        type   = "table",
        start  = 1,
        finish = 5,
        [1]    = 2,
    },
    [2] = {
        type   = "varargs",
        start  = 2,
        finish = 4,
        parent = 1,
    },
}
CHECK'{1, 2, 3}'
{
    [1] = {
        type   = "table",
        start  = 1,
        finish = 9,
        [1]    = 2,
        [2]    = 3,
        [3]    = 4,
    },
    [2] = {
        type   = "number",
        start  = 2,
        finish = 2,
        parent = 1,
        [1]    = 1,
    },
    [3] = {
        type   = "number",
        start  = 5,
        finish = 5,
        parent = 1,
        [1]    = 2,
    },
    [4] = {
        type   = "number",
        start  = 8,
        finish = 8,
        parent = 1,
        [1]    = 3,
    },
}
CHECK'{x = 1, y = 2}'
{
    [1] = {
        type   = "table",
        start  = 1,
        finish = 14,
        [1]    = 2,
        [2]    = 4,
    },
    [2] = {
        type   = "tablefield",
        start  = 2,
        finish = 6,
        parent = 1,
        field  = {
            type   = "field",
            start  = 2,
            finish = 2,
            [1]    = "x",
        },
        value  = 3,
    },
    [3] = {
        type   = "number",
        start  = 6,
        finish = 6,
        parent = 2,
        [1]    = 1,
    },
    [4] = {
        type   = "tablefield",
        start  = 9,
        finish = 13,
        parent = 1,
        field  = {
            type   = "field",
            start  = 9,
            finish = 9,
            [1]    = "y",
        },
        value  = 5,
    },
    [5] = {
        type   = "number",
        start  = 13,
        finish = 13,
        parent = 4,
        [1]    = 2,
    },
}
CHECK'{["x"] = 1, ["y"] = 2}'
{
    [1] = {
        type   = "table",
        start  = 1,
        finish = 22,
        [1]    = 2,
        [2]    = 6,
    },
    [2] = {
        type   = "tableindex",
        start  = 2,
        finish = 10,
        parent = 1,
        index  = 3,
        value  = 5,
    },
    [3] = {
        type   = "index",
        start  = 2,
        finish = 6,
        parent = 2,
        index  = 4,
    },
    [4] = {
        type   = "string",
        start  = 3,
        finish = 5,
        parent = 3,
        [1]    = "x",
        [2]    = "\"",
    },
    [5] = {
        type   = "number",
        start  = 10,
        finish = 10,
        parent = 2,
        [1]    = 1,
    },
    [6] = {
        type   = "tableindex",
        start  = 13,
        finish = 21,
        parent = 1,
        index  = 7,
        value  = 9,
    },
    [7] = {
        type   = "index",
        start  = 13,
        finish = 17,
        parent = 6,
        index  = 8,
    },
    [8] = {
        type   = "string",
        start  = 14,
        finish = 16,
        parent = 7,
        [1]    = "y",
        [2]    = "\"",
    },
    [9] = {
        type   = "number",
        start  = 21,
        finish = 21,
        parent = 6,
        [1]    = 2,
    },
}
CHECK'{[x] = 1, [y] = 2}'
{
    [1] = {
        type   = "table",
        start  = 1,
        finish = 18,
        [1]    = 2,
        [2]    = 6,
    },
    [2] = {
        type   = "tableindex",
        start  = 2,
        finish = 8,
        parent = 1,
        index  = 3,
        value  = 5,
    },
    [3] = {
        type   = "index",
        start  = 2,
        finish = 4,
        parent = 2,
        index  = 4,
    },
    [4] = {
        type   = "getname",
        start  = 3,
        finish = 3,
        parent = 3,
        [1]    = "x",
    },
    [5] = {
        type   = "number",
        start  = 8,
        finish = 8,
        parent = 2,
        [1]    = 1,
    },
    [6] = {
        type   = "tableindex",
        start  = 11,
        finish = 17,
        parent = 1,
        index  = 7,
        value  = 9,
    },
    [7] = {
        type   = "index",
        start  = 11,
        finish = 13,
        parent = 6,
        index  = 8,
    },
    [8] = {
        type   = "getname",
        start  = 12,
        finish = 12,
        parent = 7,
        [1]    = "y",
    },
    [9] = {
        type   = "number",
        start  = 17,
        finish = 17,
        parent = 6,
        [1]    = 2,
    },
}
CHECK'{{}}'
{
    [1] = {
        type   = "table",
        start  = 1,
        finish = 4,
        [1]    = 2,
    },
    [2] = {
        type   = "table",
        start  = 2,
        finish = 3,
        parent = 1,
    },
}
CHECK'{ a = { b = { c = {} } } }'
{
    [1] = {
        type   = "table",
        start  = 1,
        finish = 26,
        [1]    = 2,
    },
    [2] = {
        type   = "tablefield",
        start  = 3,
        finish = 24,
        parent = 1,
        field  = {
            type   = "field",
            start  = 3,
            finish = 3,
            [1]    = "a",
        },
        value  = 3,
    },
    [3] = {
        type   = "table",
        start  = 7,
        finish = 24,
        parent = 2,
        [1]    = 4,
    },
    [4] = {
        type   = "tablefield",
        start  = 9,
        finish = 22,
        parent = 3,
        field  = {
            type   = "field",
            start  = 9,
            finish = 9,
            [1]    = "b",
        },
        value  = 5,
    },
    [5] = {
        type   = "table",
        start  = 13,
        finish = 22,
        parent = 4,
        [1]    = 6,
    },
    [6] = {
        type   = "tablefield",
        start  = 15,
        finish = 20,
        parent = 5,
        field  = {
            type   = "field",
            start  = 15,
            finish = 15,
            [1]    = "c",
        },
        value  = 7,
    },
    [7] = {
        type   = "table",
        start  = 19,
        finish = 20,
        parent = 6,
    },
}
CHECK'{{}, {}, {{}, {}}}'
{
    [1] = {
        type   = "table",
        start  = 1,
        finish = 18,
        [1]    = 2,
        [2]    = 3,
        [3]    = 4,
    },
    [2] = {
        type   = "table",
        start  = 2,
        finish = 3,
        parent = 1,
    },
    [3] = {
        type   = "table",
        start  = 6,
        finish = 7,
        parent = 1,
    },
    [4] = {
        type   = "table",
        start  = 10,
        finish = 17,
        parent = 1,
        [1]    = 5,
        [2]    = 6,
    },
    [5] = {
        type   = "table",
        start  = 11,
        finish = 12,
        parent = 4,
    },
    [6] = {
        type   = "table",
        start  = 15,
        finish = 16,
        parent = 4,
    },
}
CHECK'{1, 2, 3,}'
{
    [1] = {
        type   = "table",
        start  = 1,
        finish = 10,
        [1]    = 2,
        [2]    = 3,
        [3]    = 4,
    },
    [2] = {
        type   = "number",
        start  = 2,
        finish = 2,
        parent = 1,
        [1]    = 1,
    },
    [3] = {
        type   = "number",
        start  = 5,
        finish = 5,
        parent = 1,
        [1]    = 2,
    },
    [4] = {
        type   = "number",
        start  = 8,
        finish = 8,
        parent = 1,
        [1]    = 3,
    },
}

CHECK 'notify'
{
    [1] = {
        type   = "getname",
        start  = 1,
        finish = 6,
        [1]    = "notify",
    },
}

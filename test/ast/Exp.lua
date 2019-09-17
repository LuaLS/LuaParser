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
        finish = 6,
        parent = 1,
    },
}
CHECK'a.b.c()'
{
    [1] = {
        type   = "call",
        start  = 1,
        finish = 7,
        node   = 2,
        args   = 5,
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
    [5] = {
        type   = "callargs",
        start  = 6,
        finish = 7,
        parent = 1,
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
        args   = 4,
    },
    [3] = {
        type   = "getname",
        start  = 1,
        finish = 9,
        parent = 2,
        [1]    = "get_point",
    },
    [4] = {
        type   = "callargs",
        start  = 10,
        finish = 11,
        parent = 2,
    },
}
CHECK'obj:remove()'
{
    [1] = {
        type   = "call",
        start  = 1,
        finish = 12,
        node   = 2,
        args   = 4,
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
    },
    [3] = {
        type   = "getname",
        start  = 1,
        finish = 3,
        parent = 2,
        [1]    = "obj",
    },
    [4] = {
        type   = "callargs",
        start  = 11,
        finish = 12,
        parent = 1,
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
        type   = "funcargs",
        start  = 10,
        finish = 11,
    },
    [2] = {
        type   = "function",
        start  = 1,
        finish = 15,
        args   = 1,
    },
}
CHECK'function (...) end'
{
    [1] = {
        type   = "...",
        start  = 11,
        finish = 13,
    },
    [2] = {
        type   = "funcargs",
        start  = 10,
        finish = 14,
        [1]    = 1,
    },
    [3] = {
        type   = "function",
        start  = 1,
        finish = 18,
        args   = 2,
    },
}
CHECK'function (a, ...) end'
{
    [1] = {
        type   = "name",
        start  = 11,
        finish = 11,
        [1]    = "a",
    },
    [2] = {
        type   = ",",
        start  = 12,
        finish = 12,
    },
    [3] = {
        type   = "...",
        start  = 14,
        finish = 16,
    },
    [4] = {
        type   = "funcargs",
        start  = 10,
        finish = 17,
        [1]    = 1,
        [2]    = 3,
    },
    [5] = {
        type   = "function",
        start  = 1,
        finish = 21,
        args   = 4,
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
        type   = "varargs",
        start  = 2,
        finish = 4,
    },
    [2] = {
        type   = "table",
        start  = 1,
        finish = 5,
        [1]    = 1,
    },
}
CHECK'{1, 2, 3}'
{
    [1] = {
        type   = "number",
        start  = 2,
        finish = 2,
        [1]    = 1,
    },
    [2] = {
        type   = ",",
        start  = 3,
        finish = 3,
    },
    [3] = {
        type   = "number",
        start  = 5,
        finish = 5,
        [1]    = 2,
    },
    [4] = {
        type   = ",",
        start  = 6,
        finish = 6,
    },
    [5] = {
        type   = "number",
        start  = 8,
        finish = 8,
        [1]    = 3,
    },
    [6] = {
        type   = "table",
        start  = 1,
        finish = 9,
        [1]    = 1,
        [2]    = 3,
        [3]    = 5,
    },
}
CHECK'{x = 1, y = 2}'
{
    [1] = {
        type   = "name",
        start  = 2,
        finish = 2,
        [1]    = "x",
    },
    [2] = {
        type   = "number",
        start  = 6,
        finish = 6,
        [1]    = 1,
    },
    [3] = {
        type   = "tablefield",
        start  = 2,
        finish = 6,
        field  = 1,
        value  = 2,
    },
    [4] = {
        type   = ",",
        start  = 7,
        finish = 7,
    },
    [5] = {
        type   = "name",
        start  = 9,
        finish = 9,
        [1]    = "y",
    },
    [6] = {
        type   = "number",
        start  = 13,
        finish = 13,
        [1]    = 2,
    },
    [7] = {
        type   = "tablefield",
        start  = 9,
        finish = 13,
        field  = 5,
        value  = 6,
    },
    [8] = {
        type   = "table",
        start  = 1,
        finish = 14,
        [1]    = 3,
        [2]    = 7,
    },
}
CHECK'{["x"] = 1, ["y"] = 2}'
{
    [1]  = {
        type   = "string",
        start  = 3,
        finish = 5,
        [1]    = "x",
        [2]    = "\"",
    },
    [2]  = {
        type   = "index",
        start  = 2,
        finish = 6,
        index  = 1,
    },
    [3]  = {
        type   = "number",
        start  = 10,
        finish = 10,
        [1]    = 1,
    },
    [4]  = {
        type   = "tableindex",
        start  = 2,
        finish = 10,
        index  = 2,
        value  = 3,
    },
    [5]  = {
        type   = ",",
        start  = 11,
        finish = 11,
    },
    [6]  = {
        type   = "string",
        start  = 14,
        finish = 16,
        [1]    = "y",
        [2]    = "\"",
    },
    [7]  = {
        type   = "index",
        start  = 13,
        finish = 17,
        index  = 6,
    },
    [8]  = {
        type   = "number",
        start  = 21,
        finish = 21,
        [1]    = 2,
    },
    [9]  = {
        type   = "tableindex",
        start  = 13,
        finish = 21,
        index  = 7,
        value  = 8,
    },
    [10] = {
        type   = "table",
        start  = 1,
        finish = 22,
        [1]    = 4,
        [2]    = 9,
    },
}
CHECK'{[x] = 1, [y] = 2}'
{
    [01] = {
        type   = "getname",
        start  = 3,
        finish = 3,
        [1]    = "x",
    },
    [02] = {
        type   = "index",
        start  = 2,
        finish = 4,
        index  = 1,
    },
    [03] = {
        type   = "number",
        start  = 8,
        finish = 8,
        [1]    = 1,
    },
    [04] = {
        value  = 3,
        type   = "tableindex",
        start  = 2,
        finish = 8,
        index  = 2,
    },
    [05] = {
        type   = ",",
        start  = 9,
        finish = 9,
    },
    [06] = {
        type   = "getname",
        start  = 12,
        finish = 12,
        [1]    = "y",
    },
    [07] = {
        type   = "index",
        start  = 11,
        finish = 13,
        index  = 6,
    },
    [08] = {
        type   = "number",
        start  = 17,
        finish = 17,
        [1]    = 2,
    },
    [09] = {
        value  = 8,
        type   = "tableindex",
        start  = 11,
        finish = 17,
        index  = 7,
    },
    [10] = {
        type   = "table",
        start  = 1,
        finish = 18,
        [1]    = 4,
        [2]    = 9,
    },
}
CHECK'{{}}'
{
    [1] = {
        type   = "table",
        start  = 2,
        finish = 3,
    },
    [2] = {
        type   = "table",
        start  = 1,
        finish = 4,
        [1]    = 1,
    },
}
CHECK'{ a = { b = { c = {} } } }'
{
    [1]  = {
        type   = "name",
        start  = 3,
        finish = 3,
        [1]    = "a",
    },
    [2]  = {
        type   = "name",
        start  = 9,
        finish = 9,
        [1]    = "b",
    },
    [3]  = {
        type   = "name",
        start  = 15,
        finish = 15,
        [1]    = "c",
    },
    [4]  = {
        type   = "table",
        start  = 19,
        finish = 20,
    },
    [5]  = {
        type   = "tablefield",
        start  = 15,
        finish = 20,
        field  = 3,
        value  = 4,
    },
    [6]  = {
        type   = "table",
        start  = 13,
        finish = 22,
        [1]    = 5,
    },
    [7]  = {
        type   = "tablefield",
        start  = 9,
        finish = 22,
        field  = 2,
        value  = 6,
    },
    [8]  = {
        type   = "table",
        start  = 7,
        finish = 24,
        [1]    = 7,
    },
    [9]  = {
        type   = "tablefield",
        start  = 3,
        finish = 24,
        field  = 1,
        value  = 8,
    },
    [10] = {
        type   = "table",
        start  = 1,
        finish = 26,
        [1]    = 9,
    },
}
CHECK'{{}, {}, {{}, {}}}'
{
    [1] = {
        type   = "table",
        start  = 2,
        finish = 3,
    },
    [2] = {
        type   = ",",
        start  = 4,
        finish = 4,
    },
    [3] = {
        type   = "table",
        start  = 6,
        finish = 7,
    },
    [4] = {
        type   = ",",
        start  = 8,
        finish = 8,
    },
    [5] = {
        type   = "table",
        start  = 11,
        finish = 12,
    },
    [6] = {
        type   = ",",
        start  = 13,
        finish = 13,
    },
    [7] = {
        type   = "table",
        start  = 15,
        finish = 16,
    },
    [8] = {
        type   = "table",
        start  = 10,
        finish = 17,
        [1]    = 5,
        [2]    = 7,
    },
    [9] = {
        type   = "table",
        start  = 1,
        finish = 18,
        [1]    = 1,
        [2]    = 3,
        [3]    = 8,
    },
}
CHECK'{1, 2, 3,}'
{
    [1] = {
        type   = "number",
        start  = 2,
        finish = 2,
        [1]    = 1,
    },
    [2] = {
        type   = ",",
        start  = 3,
        finish = 3,
    },
    [3] = {
        type   = "number",
        start  = 5,
        finish = 5,
        [1]    = 2,
    },
    [4] = {
        type   = ",",
        start  = 6,
        finish = 6,
    },
    [5] = {
        type   = "number",
        start  = 8,
        finish = 8,
        [1]    = 3,
    },
    [6] = {
        type   = ",",
        start  = 9,
        finish = 9,
    },
    [7] = {
        type   = "table",
        start  = 1,
        finish = 10,
        [1]    = 1,
        [2]    = 3,
        [3]    = 5,
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

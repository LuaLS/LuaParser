local class = require 'class'

local function TEST(code)
    return function (expect)
        local ast = class.new 'LuaParser.Ast' (code)
        local node = ast:parseExp()
        assert(node)
        Match(node, expect)
    end
end

TEST 'nil'
{
    start  = 0,
    finish = 3,
}

TEST 'a'
{
    start  = 0,
    finish = 1,
    id     = 'a'
}

TEST 'a.b'
{
    start     = 0,
    finish    = 3,
    symbolPos = 1,
    subtype   = 'field',
    key       = {
        start  = 2,
        finish = 3,
        id     = 'b',
        parent = {},
    },
    last = {
        start  = 0,
        finish = 1,
        id     = 'a',
        parent = {},
        next   = {
            __class__ = 'LuaParser.Node.Field',
        },
    }
}

TEST 'a.b.c'
{
    start     = 0,
    finish    = 5,
    symbolPos = 3,
    subtype   = 'field',
    key        = {
        start  = 4,
        finish = 5,
        id     = 'c',
        parent = {},
    },
    last = {
        start     = 0,
        finish    = 3,
        symbolPos = 1,
        parent    = {},
        key       = {
            start  = 2,
            finish = 3,
            id     = 'b',
            parent = {},
        },
        next = {
            __class__ = 'LuaParser.Node.Field',
        },
        last = {
            start  = 0,
            finish = 1,
            id     = 'a',
            parent = {},
            next   = {
                __class__ = 'LuaParser.Node.Field',
            },
        },
    }
}

TEST 'func()'
{
    start  = 0,
    finish = 6,
    argPos = 4,
    node   = {
        start  = 0,
        finish = 4,
        id     = 'func',
        parent = {
            __class__ = 'LuaParser.Node.Call',
        },
    },
    args = {},
}

TEST 'a.b.c()'
{
    start  = 0,
    finish = 7,
    argPos = 5,
    node   = {
        start  = 0,
        finish = 5,
        key    = {},
        parent = {},
    }
}

TEST '1 or 2'
{
    start     = 0,
    finish    = 6,
    op        = 'or',
    symbolPos = 2,
    exp1      = {
        value = 1,
    },
    exp2      = {
        value = 2,
    }
}

TEST '1 < 2'
{
    start  = 0,
    finish = 5,
    op     = '<',
    exp1   = {
        value = 1,
    },
    exp2   = {
        value = 2,
    }
}

TEST '- 1'
{
    __class__ = 'LuaParser.Node.Integer',
    start  = 0,
    finish = 3,
    value  = -1,
}

TEST '- x'
{
    __class__ = 'LuaParser.Node.Unary',
    start  = 0,
    finish = 3,
    op     = '-',
    exp    = {
        __class__ = 'LuaParser.Node.Var',
        start  = 2,
        finish = 3,
        id     = 'x',
    }
}

TEST 'not not true'
{
    type   = "unary",
    start  = 0,
    finish = 12,
    op     = {
        type   = "not",
        start  = 0,
        finish = 3,
    },
    [1]    = {
        type   = "unary",
        start  = 4,
        finish = 12,
        parent = "<IGNORE>",
        op     = {
            type   = "not",
            start  = 4,
            finish = 7,
        },
        [1]    = {
            type   = "boolean",
            start  = 8,
            finish = 12,
            parent = "<IGNORE>",
            [1]    = true,
        },
    },
}

TEST '1 ^ 2'
{
    type   = "binary",
    start  = 0,
    finish = 5,
    op     = {
        type   = "^",
        start  = 2,
        finish = 3,
    },
    [1]    = {
        type   = "integer",
        start  = 0,
        finish = 1,
        parent = "<IGNORE>",
        [1]    = 1,
    },
    [2]    = {
        type   = "integer",
        start  = 4,
        finish = 5,
        parent = "<IGNORE>",
        [1]    = 2,
    },
}
TEST '1 ^ -2'
{
    type   = "binary",
    start  = 0,
    finish = 6,
    op     = {
        type   = "^",
        start  = 2,
        finish = 3,
    },
    [1]    = {
        type   = "integer",
        start  = 0,
        finish = 1,
        parent = "<IGNORE>",
        [1]    = 1,
    },
    [2]    = {
        type   = "integer",
        start  = 4,
        finish = 6,
        parent = "<IGNORE>",
        [1]    = -2,
    },
}
TEST '-1 ^ 2'
{
    type   = "unary",
    start  = 0,
    finish = 6,
    op     = {
        type   = "-",
        start  = 0,
        finish = 1,
    },
    [1]    = {
        type   = "binary",
        start  = 1,
        finish = 6,
        parent = "<IGNORE>",
        op     = {
            type   = "^",
            start  = 3,
            finish = 4,
        },
        [1]    = {
            type   = 'integer',
            start  = 1,
            finish = 2,
            parent = "<IGNORE>",
            [1]    = 1,
        },
        [2]    = {
            type   = 'integer',
            start  = 5,
            finish = 6,
            parent = "<IGNORE>",
            [1]    = 2,
        },
    },
}
TEST '...'
{
    type   = "varargs",
    start  = 0,
    finish = 3,
}
TEST '1 + 2 + 3'
{
    type   = "binary",
    start  = 0,
    finish = 9,
    op     = {
        type   = "+",
        start  = 6,
        finish = 7,
    },
    [1]    = {
        type   = "binary",
        start  = 0,
        finish = 5,
        parent = "<IGNORE>",
        op     = {
            type   = "+",
            start  = 2,
            finish = 3,
        },
        [1]    = {
            type   = "integer",
            start  = 0,
            finish = 1,
            parent = "<IGNORE>",
            [1]    = 1,
        },
        [2]    = {
            type   = "integer",
            start  = 4,
            finish = 5,
            parent = "<IGNORE>",
            [1]    = 2,
        },
    },
    [2]    = {
        type   = "integer",
        start  = 8,
        finish = 9,
        parent = "<IGNORE>",
        [1]    = 3,
    },
}
TEST '1 + 2 * 3'
{
    type   = "binary",
    start  = 0,
    finish = 9,
    op     = {
        type   = "+",
        start  = 2,
        finish = 3,
    },
    [1]    = {
        type   = "integer",
        start  = 0,
        finish = 1,
        parent = "<IGNORE>",
        [1]    = 1,
    },
    [2]    = {
        type   = "binary",
        start  = 4,
        finish = 9,
        parent = "<IGNORE>",
        op     = {
            type   = "*",
            start  = 6,
            finish = 7,
        },
        [1]    = {
            type   = "integer",
            start  = 4,
            finish = 5,
            parent = "<IGNORE>",
            [1]    = 2,
        },
        [2]    = {
            type   = "integer",
            start  = 8,
            finish = 9,
            parent = "<IGNORE>",
            [1]    = 3,
        },
    },
}
TEST '- 1 + 2 * 3'
{
    type   = "binary",
    start  = 0,
    finish = 11,
    op     = {
        type   = "+",
        start  = 4,
        finish = 5,
    },
    [1]    = {
        type   = "integer",
        start  = 0,
        finish = 3,
        parent = "<IGNORE>",
        [1]    = -1,
    },
    [2]    = {
        type   = "binary",
        start  = 6,
        finish = 11,
        parent = "<IGNORE>",
        op     = {
            type   = "*",
            start  = 8,
            finish = 9,
        },
        [1]    = {
            type   = "integer",
            start  = 6,
            finish = 7,
            parent = "<IGNORE>",
            [1]    = 2,
        },
        [2]    = {
            type   = "integer",
            start  = 10,
            finish = 11,
            parent = "<IGNORE>",
            [1]    = 3,
        },
    },
}
TEST '-1 + 2 * 3'
{
    type   = "binary",
    start  = 0,
    finish = 10,
    op     = {
        type   = "+",
        start  = 3,
        finish = 4,
    },
    [1]    = {
        type   = "integer",
        start  = 0,
        finish = 2,
        parent = "<IGNORE>",
        [1]    = -1,
    },
    [2]    = {
        type   = "binary",
        start  = 5,
        finish = 10,
        parent = "<IGNORE>",
        op     = {
            type   = "*",
            start  = 7,
            finish = 8,
        },
        [1]    = {
            type   = "integer",
            start  = 5,
            finish = 6,
            parent = "<IGNORE>",
            [1]    = 2,
        },
        [2]    = {
            type   = "integer",
            start  = 9,
            finish = 10,
            parent = "<IGNORE>",
            [1]    = 3,
        },
    },
}
CHECK"x and y == 'unary' and z"
{
    type   = "binary",
    start  = 0,
    finish = 24,
    op     = {
        type   = "and",
        start  = 19,
        finish = 22,
    },
    [1]    = {
        type   = "binary",
        start  = 0,
        finish = 18,
        parent = "<IGNORE>",
        op     = {
            type   = "and",
            start  = 2,
            finish = 5,
        },
        [1]    = {
            type   = "getglobal",
            start  = 0,
            finish = 1,
            parent = "<IGNORE>",
            [1]    = "x",
        },
        [2]    = {
            type   = "binary",
            start  = 6,
            finish = 18,
            parent = "<IGNORE>",
            op     = {
                type   = "==",
                start  = 8,
                finish = 10,
            },
            [1]    = {
                type   = "getglobal",
                start  = 6,
                finish = 7,
                parent = "<IGNORE>",
                [1]    = "y",
            },
            [2]    = {
                type   = "string",
                start  = 11,
                finish = 18,
                parent = "<IGNORE>",
                [1]    = "unary",
                [2]    = "'",
            },
        },
    },
    [2]    = {
        type   = "getglobal",
        start  = 23,
        finish = 24,
        parent = "<IGNORE>",
        [1]    = "z",
    },
}
CHECK"x and y or '' .. z"
{
    type   = "binary",
    start  = 0,
    finish = 18,
    op     = {
        type   = "or",
        start  = 8,
        finish = 10,
    },
    [1]    = {
        type   = "binary",
        start  = 0,
        finish = 7,
        parent = "<IGNORE>",
        op     = {
            type   = "and",
            start  = 2,
            finish = 5,
        },
        [1]    = {
            type   = "getglobal",
            start  = 0,
            finish = 1,
            parent = "<IGNORE>",
            [1]    = "x",
        },
        [2]    = {
            type   = "getglobal",
            start  = 6,
            finish = 7,
            parent = "<IGNORE>",
            [1]    = "y",
        },
    },
    [2]    = {
        type   = "binary",
        start  = 11,
        finish = 18,
        parent = "<IGNORE>",
        op     = {
            type   = "..",
            start  = 14,
            finish = 16,
        },
        [1]    = {
            type   = "string",
            start  = 11,
            finish = 13,
            parent = "<IGNORE>",
            [1]    = "",
            [2]    = "'",
        },
        [2]    = {
            type   = "getglobal",
            start  = 17,
            finish = 18,
            parent = "<IGNORE>",
            [1]    = "z",
        },
    },
}
-- 幂运算从右向左连接
TEST '1 ^ 2 ^ 3'
{
    type   = "binary",
    start  = 0,
    finish = 9,
    op     = {
        type   = "^",
        start  = 2,
        finish = 3,
    },
    [1]    = {
        type   = "integer",
        start  = 0,
        finish = 1,
        parent = "<IGNORE>",
        [1]    = 1,
    },
    [2]    = {
        type   = "binary",
        start  = 4,
        finish = 9,
        parent = "<IGNORE>",
        op     = {
            type   = "^",
            start  = 6,
            finish = 7,
        },
        [1]    = {
            type   = "integer",
            start  = 4,
            finish = 5,
            parent = "<IGNORE>",
            [1]    = 2,
        },
        [2]    = {
            type   = "integer",
            start  = 8,
            finish = 9,
            parent = "<IGNORE>",
            [1]    = 3,
        },
    },
}
-- 连接运算从右向左连接
TEST '1 .. 2 .. 3'
{
    type   = "binary",
    start  = 0,
    finish = 11,
    op     = {
        type   = "..",
        start  = 2,
        finish = 4,
    },
    [1]    = {
        type   = "integer",
        start  = 0,
        finish = 1,
        parent = "<IGNORE>",
        [1]    = 1,
    },
    [2]    = {
        type   = "binary",
        start  = 5,
        finish = 11,
        parent = "<IGNORE>",
        op     = {
            type   = "..",
            start  = 7,
            finish = 9,
        },
        [1]    = {
            type   = "integer",
            start  = 5,
            finish = 6,
            parent = "<IGNORE>",
            [1]    = 2,
        },
        [2]    = {
            type   = "integer",
            start  = 10,
            finish = 11,
            parent = "<IGNORE>",
            [1]    = 3,
        },
    },
}
TEST '1 + - - - - - - - 1'
{
    type   = "binary",
    start  = 0,
    finish = 19,
    op     = {
        type   = "+",
        start  = 2,
        finish = 3,
    },
    [1]    = {
        type   = "integer",
        start  = 0,
        finish = 1,
        parent = "<IGNORE>",
        [1]    = 1,
    },
    [2]    = {
        type   = "integer",
        start  = 4,
        finish = 19,
        parent = "<IGNORE>",
        [1]    = -1,
    },
}
TEST '(1)'
{
    type   = "paren",
    start  = 0,
    finish = 3,
    exp    = {
        type   = "integer",
        start  = 1,
        finish = 2,
        parent = "<IGNORE>",
        [1]    = 1,
    },
}
TEST '(1 + 2)'
{
    type   = "paren",
    start  = 0,
    finish = 7,
    exp    = {
        type   = "binary",
        start  = 1,
        finish = 6,
        parent = "<IGNORE>",
        op     = {
            type   = "+",
            start  = 3,
            finish = 4,
        },
        [1]    = {
            type   = "integer",
            start  = 1,
            finish = 2,
            parent = "<IGNORE>",
            [1]    = 1,
        },
        [2]    = {
            type   = "integer",
            start  = 5,
            finish = 6,
            parent = "<IGNORE>",
            [1]    = 2,
        },
    },
}
TEST 'func(1)'
{
    type   = "call",
    start  = 0,
    finish = 7,
    node   = "<IGNORE>",
    args   = {
        type   = "callargs",
        start  = 4,
        finish = 7,
        parent = "<IGNORE>",
        [1]    = {
            type   = "integer",
            start  = 5,
            finish = 6,
            parent = "<IGNORE>",
            [1]    = 1,
        },
    },
}
TEST 'func(1, 2)'
{
    type   = "call",
    start  = 0,
    finish = 10,
    node   = "<IGNORE>",
    args   = {
        type   = "callargs",
        start  = 4,
        finish = 10,
        parent = "<IGNORE>",
        [1]    = {
            type   = "integer",
            start  = 5,
            finish = 6,
            parent = "<IGNORE>",
            [1]    = 1,
        },
        [2]    = {
            type   = "integer",
            start  = 8,
            finish = 9,
            parent = "<IGNORE>",
            [1]    = 2,
        },
    },
}
TEST 'func(...)'
{
    type   = "call",
    start  = 0,
    finish = 9,
    node   = "<IGNORE>",
    args   = {
        type   = "callargs",
        start  = 4,
        finish = 9,
        parent = "<IGNORE>",
        [1]    = {
            type   = "varargs",
            start  = 5,
            finish = 8,
            parent = "<IGNORE>",
        },
    },
}
TEST 'func(1, ...)'
{
    type   = "call",
    start  = 0,
    finish = 12,
    node   = "<IGNORE>",
    args   = {
        type   = "callargs",
        start  = 4,
        finish = 12,
        parent = "<IGNORE>",
        [1]    = {
            type   = "integer",
            start  = 5,
            finish = 6,
            parent = "<IGNORE>",
            [1]    = 1,
        },
        [2]    = {
            type   = "varargs",
            start  = 8,
            finish = 11,
            parent = "<IGNORE>",
        },
    },
}
TEST 'func ""'
{
    type   = "call",
    start  = 0,
    finish = 7,
    node   = "<IGNORE>",
    args   = {
        type   = "callargs",
        start  = 5,
        finish = 7,
        parent = "<IGNORE>",
        [1]    = {
            type   = "string",
            start  = 5,
            finish = 7,
            parent = "<IGNORE>",
            [1]    = "",
            [2]    = "\"",
        },
    },
}
TEST 'func {}'
{
    type   = "call",
    start  = 0,
    finish = 7,
    node   = "<IGNORE>",
    args   = {
        type   = "callargs",
        start  = 5,
        finish = 7,
        parent = "<IGNORE>",
        [1]    = {
            type   = "table",
            start  = 5,
            finish = 7,
            parent = "<IGNORE>",
        },
    },
}
TEST 'table[1]'
{
    type   = "getindex",
    start  = 0,
    finish = 8,
    node   = "<IGNORE>",
    index  = {
        type   = "integer",
        start  = 6,
        finish = 7,
        parent = "<IGNORE>",
        [1]    = 1,
    },
}
TEST 'table[[1]]'
{
    type   = "call",
    start  = 0,
    finish = 10,
    node   = "<IGNORE>",
    args   = {
        type   = "callargs",
        start  = 5,
        finish = 10,
        parent = "<IGNORE>",
        [1]    = {
            type   = "string",
            start  = 5,
            finish = 10,
            parent = "<IGNORE>",
            [1]    = '1',
            [2]    = '[['
        },
    },
}
TEST 'get_point().x'
{
    type   = "getfield",
    start  = 0,
    finish = 13,
    node   = "<IGNORE>",
    dot    = {
        type   = ".",
        start  = 11,
        finish = 12,
    },
    field  = {
        type   = "field",
        start  = 12,
        finish = 13,
        parent = "<IGNORE>",
        [1]    = "x",
    },
}
TEST 'obj:remove()'
{
    type   = "call",
    start  = 0,
    finish = 12,
    node   = "<IGNORE>",
    args   = {
        type   = "callargs",
        start  = 0,
        finish = 12,
        parent = "<IGNORE>",
        [1]    = {
            type   = "self",
            start  = 3,
            finish = 4,
            parent = "<IGNORE>",
            [1]    = "self",
        },
    },
}
TEST '(...)[1]'
{
    type   = "getindex",
    start  = 0,
    finish = 8,
    node   = "<IGNORE>",
    index  = {
        type   = "integer",
        start  = 6,
        finish = 7,
        parent = "<IGNORE>",
        [1]    = 1,
    },
}
TEST 'function () end'
{
    type    = "function",
    start   = 0,
    bstart  = 11,
    finish  = 15,
    keyword = {
        [1] = 0,
        [2] = 8,
        [3] = 12,
        [4] = 15,
    },
    args    = {
        type   = "funcargs",
        start  = 9,
        finish = 11,
        parent = "<IGNORE>",
    },
}
TEST 'function (...) end'
{
    type    = "function",
    start   = 0,
    bstart  = 14,
    finish  = 18,
    keyword = {
        [1] = 0,
        [2] = 8,
        [3] = 15,
        [4] = 18,
    },
    vararg  = "<IGNORE>",
    args    = {
        type   = "funcargs",
        start  = 9,
        finish = 14,
        parent = "<IGNORE>",
        [1]    = {
            type   = "...",
            start  = 10,
            finish = 13,
            parent = "<IGNORE>",
            [1]    = "...",
        },
    },
}
TEST 'function (a, ...) end'
{
    type    = "function",
    start   = 0,
    bstart  = 17,
    finish  = 21,
    keyword = {
        [1] = 0,
        [2] = 8,
        [3] = 18,
        [4] = 21,
    },
    vararg  = "<IGNORE>",
    args    = {
        type   = "funcargs",
        start  = 9,
        finish = 17,
        parent = "<IGNORE>",
        [1]    = {
            type   = "local",
            start  = 10,
            finish = 11,
            effect = 11,
            parent = "<IGNORE>",
            [1]    = "a",
        },
        [2]    = {
            type   = "...",
            start  = 13,
            finish = 16,
            parent = "<IGNORE>",
            [1]    = "...",
        },
    },
    locals  = "<IGNORE>",
}

CHECK 'notify'
{
    type   = "getglobal",
    start  = 0,
    finish = 6,
    [1]    = "notify",
}

CHECK 'a ^ - b'
{
    type   = "binary",
    start  = 0,
    finish = 7,
    op     = {
        type   = "^",
        start  = 2,
        finish = 3,
    },
    [1]    = {
        type   = "getglobal",
        start  = 0,
        finish = 1,
        parent = "<IGNORE>",
        [1]    = "a",
    },
    [2]    = {
        type   = "unary",
        start  = 4,
        finish = 7,
        parent = "<IGNORE>",
        op     = {
            type   = "-",
            start  = 4,
            finish = 5,
        },
        [1]    = {
            type   = "getglobal",
            start  = 6,
            finish = 7,
            parent = "<IGNORE>",
            [1]    = "b",
        },
    },
}

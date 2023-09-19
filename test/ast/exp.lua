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
    start  = 0,
    finish = 12,
    op     = 'not',
    exp    = {
        start  = 4,
        finish = 12,
        op     = 'not',
        exp    = {
            value = true,
        }
    }
}

TEST '1 ^ 2'
{
    start  = 0,
    finish = 5,
    op     = '^',
    exp1   = {
        value = 1,
    },
    exp2   = {
        value = 2,
    }
}
TEST '1 ^ -2'
{
    start  = 0,
    finish = 6,
    op     = '^',
    exp1   = {
        value = 1,
    },
    exp2   = {
        value = -2,
    }
}

TEST '-1 ^ 2'
{
    start  = 0,
    finish = 6,
    op     = '^',
    exp1   = {
        value = -1,
    },
    exp2   = {
        value = 2,
    }
}

TEST '1 + 2 + 3'
{
    op   = '+',
    exp1 = {
        op   = '+',
        exp1 = {
            value = 1,
        },
        exp2 = {
            value = 2,
        }
    },
    exp2 = {
        value = 3,
    }
}

TEST '1 + 2 * 3'
{
    op   = '+',
    exp1 = {
        value = 1,
    },
    exp2 = {
        op   = '*',
        exp1 = {
            value = 2,
        },
        exp2 = {
            value = 3,
        }
    }
}

TEST '- 1 + 2 * 3'
{
    op   = '+',
    exp1 = {
        value = -1,
    },
    exp2 = {
        op   = '*',
        exp1 = {
            value = 2,
        },
        exp2 = {
            value = 3,
        }
    }
}
TEST '-1 + 2 * 3'
{
    op   = '+',
    exp1 = {
        value = -1,
    },
    exp2 = {
        op   = '*',
        exp1 = {
            value = 2,
        },
        exp2 = {
            value = 3,
        }
    }
}

TEST "x and y == 'unary' and z"
{
    start  = 0,
    finish = 24,
    op     = 'and',
    exp1   = {
        op   = 'and',
        exp1 = {
            id = 'x'
        },
        exp2   = {
            op   = '==',
            exp1 = {
                id = 'y'
            },
            exp2 = {
                value = 'unary'
            },
        },
    },
    exp2   = {
        id = 'z'
    },
}

TEST "x and y or '' .. z"
{
    op   = 'or',
    exp1 = {
        op   = 'and',
        exp1 = {
            id = 'x',
        },
        exp2 = {
            id = 'y',
        },
    },
    exp2 = {
        op   = '..',
        exp1 = {
            value = '',
        },
        exp2 = {
            id = 'z',
        },
    },
}

-- 幂运算从右向左连接
TEST '1 ^ 2 ^ 3'
{
    op     = '^',
    exp1   = {
        value = 1,
    },
    exp2   = {
        op     = '^',
        exp1   = {
            value = 2,
        },
        exp2   = {
            value = 3,
        },
    },
}

-- 连接运算从右向左连接
TEST '1 .. 2 .. 3'
{
    op     = '..',
    exp1   = {
        value = 1,
    },
    exp2   = {
        op     = '..',
        exp1   = {
            value = 2,
        },
        exp2   = {
            value = 3,
        },
    },
}

TEST '1 + - - 1'
{
    op  = '+',
    exp1 = {
        value = 1,
    },
    exp2 = {
        op  = '-',
        exp = {
            value = -1
        }
    }
}

TEST '(1)'
{
    start  = 0,
    finish = 3,
    exp    = {
        start  = 1,
        finish = 2,
        value  = 1,
    },
}

TEST '(1 + 2)'
{
    exp = {
        op   = '+',
        exp1 = {
            value = 1,
        },
        exp2 = {
            value = 2,
        }
    }
}

TEST 'func(1)'
{
    start  = 0,
    finish = 7,
    argPos = 4,
    node   = {
        __class__ = 'LuaParser.Node.Var',
        id = 'func',
    },
    args   = {
        [1] = {
            value = 1
        },
    },
}

TEST 'func(1, 2)'
{
    node = {
        id = 'func',
    },
    args = {
        [1] = {
            value = 1,
        },
        [2] = {
            value = 2,
        },
    }
}

TEST 'func(...)'
{
    args   = {
        [1] = {
            __class__ = 'LuaParser.Node.Varargs',
        },
    },
}

TEST 'func(1, ...)'
{
    args   = {
        [1] = {
            value = 1,
        },
        [2] = {
            __class__ = 'LuaParser.Node.Varargs',
        },
    },
}

TEST 'func ""'
{
    args = {
        [1] = {
            value = ''
        },
    },
}

TEST 'func {}'
{
    args = {
        [1] = {
            __class__ = 'LuaParser.Node.Table',
        }
    },
}

TEST 'table[1]'
{
    subtype    = 'index',
    symbolPos  = 5,
    symbolPos2 = 7,
    key        = {
        value = 1,
    }
}

TEST 'table[[1]]'
{
    start  = 0,
    finish = 10,
    node   = {
        id = 'table'
    },
    args   = {
        [1] = {
            value = '1'
        },
    },
}

TEST 'get_point().x'
{
    subtype = 'field',
    key     = {
        id = 'x'
    },
    last    = {
        __class__ = 'LuaParser.Node.Call',
        node      = {
            id = 'get_point',
        },
    }
}

TEST 'obj:remove()'
{
    args = {},
    node = {
        subtype = 'method',
        key     = {
            id = 'remove'
        },
        last    = {
            id = 'obj'
        }
    }
}

TEST '(...)[1]'
{
    subtype = 'index',
    key     = {
        value = 1,
    },
    last    = {
        exp = {
            __class__ = 'LuaParser.Node.Varargs',
        }
    }
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

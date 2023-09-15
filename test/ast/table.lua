local class = require 'class'

local function TEST(code)
    return function (expect)
        local ast = class.new 'LuaParser.Ast' (code)
        local node = ast:parseTable()
        assert(node)
        Match(node, expect)
    end
end

TEST '{}'
{
    start  = 0,
    finish = 2,
}

TEST '{...}'
{
    start  = 0,
    finish = 5,
    fields = {
        [1] = {
            subtype = 'exp',
            start = 1,
            finish = 4,
            key = {
                dummy = true,
                asInteger = 1,
            },
            value = {
                type   = 'varargs',
                start  = 1,
                finish = 4,
            },
        }
    }
}
TEST '{1, 2, 3}'
{
    type   = "table",
    start  = 0,
    finish = 9,
    [1]    = {
        type   = "tableexp",
        start  = 1,
        finish = 2,
        tindex = 1,
        parent = "<IGNORE>",
        value  = {
            type   = "integer",
            start  = 1,
            finish = 2,
            parent = "<IGNORE>",
            [1]    = 1,
        },
    },
    [2]    = {
        type   = "tableexp",
        start  = 4,
        finish = 5,
        tindex = 2,
        parent = "<IGNORE>",
        value  = {
            type   = "integer",
            start  = 4,
            finish = 5,
            parent = "<IGNORE>",
            [1]    = 2,
        },
    },
    [3]    = {
        type   = "tableexp",
        start  = 7,
        finish = 8,
        tindex = 3,
        parent = "<IGNORE>",
        value  = {
            type   = "integer",
            start  = 7,
            finish = 8,
            parent = "<IGNORE>",
            [1]    = 3,
        },
    },
}
TEST '{x = 1, y = 2}'
{
    type   = "table",
    start  = 0,
    finish = 14,
    [1]    = {
        type   = "tablefield",
        start  = 1,
        finish = 2,
        range  = 6,
        parent = "<IGNORE>",
        node   = "<IGNORE>",
        field  = {
            type   = "field",
            start  = 1,
            finish = 2,
            parent = "<IGNORE>",
            [1]    = "x",
        },
        value  = {
            type   = "integer",
            start  = 5,
            finish = 6,
            parent = "<IGNORE>",
            [1]    = 1,
        },
    },
    [2]    = {
        type   = "tablefield",
        start  = 8,
        finish = 9,
        range  = 13,
        parent = "<IGNORE>",
        node   = "<IGNORE>",
        field  = {
            type   = "field",
            start  = 8,
            finish = 9,
            parent = "<IGNORE>",
            [1]    = "y",
        },
        value  = {
            type   = "integer",
            start  = 12,
            finish = 13,
            parent = "<IGNORE>",
            [1]    = 2,
        },
    },
}
TEST '{["x"] = 1, ["y"] = 2}'
{
    type   = "table",
    start  = 0,
    finish = 22,
    [1]    = {
        type   = "tableindex",
        start  = 1,
        finish = 6,
        range  = 10,
        parent = "<IGNORE>",
        node   = "<IGNORE>",
        index  = {
            type   = "string",
            start  = 2,
            finish = 5,
            parent = "<IGNORE>",
            [1]    = "x",
            [2]    = "\"",
        },
        value  = {
            type   = "integer",
            start  = 9,
            finish = 10,
            parent = "<IGNORE>",
            [1]    = 1,
        },
    },
    [2]    = {
        type   = "tableindex",
        start  = 12,
        finish = 17,
        range  = 21,
        parent = "<IGNORE>",
        node   = "<IGNORE>",
        index  = {
            type   = "string",
            start  = 13,
            finish = 16,
            parent = "<IGNORE>",
            [1]    = "y",
            [2]    = "\"",
        },
        value  = {
            type   = "integer",
            start  = 20,
            finish = 21,
            parent = "<IGNORE>",
            [1]    = 2,
        },
    },
}
TEST '{[x] = 1, [y] = 2}'
{
    type   = "table",
    start  = 0,
    finish = 18,
    [1]    = {
        type   = "tableindex",
        start  = 1,
        finish = 4,
        range  = 8,
        parent = "<IGNORE>",
        node   = "<IGNORE>",
        index  = {
            type   = "getglobal",
            start  = 2,
            finish = 3,
            parent = "<IGNORE>",
            [1]    = "x",
        },
        value  = {
            type   = "integer",
            start  = 7,
            finish = 8,
            parent = "<IGNORE>",
            [1]    = 1,
        },
    },
    [2]    = {
        type   = "tableindex",
        start  = 10,
        finish = 13,
        range  = 17,
        parent = "<IGNORE>",
        node   = "<IGNORE>",
        index  = {
            type   = "getglobal",
            start  = 11,
            finish = 12,
            parent = "<IGNORE>",
            [1]    = "y",
        },
        value  = {
            type   = "integer",
            start  = 16,
            finish = 17,
            parent = "<IGNORE>",
            [1]    = 2,
        },
    },
}
TEST '{x = 1, y = 2, 3}'
{
    type   = "table",
    start  = 0,
    finish = 17,
    [1]    = {
        type   = "tablefield",
        start  = 1,
        finish = 2,
        range  = 6,
        parent = "<IGNORE>",
        node   = "<IGNORE>",
        field  = {
            type   = "field",
            start  = 1,
            finish = 2,
            parent = "<IGNORE>",
            [1]    = "x",
        },
        value  = {
            type   = "integer",
            start  = 5,
            finish = 6,
            parent = "<IGNORE>",
            [1]    = 1,
        },
    },
    [2]    = {
        type   = "tablefield",
        start  = 8,
        finish = 9,
        range  = 13,
        parent = "<IGNORE>",
        node   = "<IGNORE>",
        field  = {
            type   = "field",
            start  = 8,
            finish = 9,
            parent = "<IGNORE>",
            [1]    = "y",
        },
        value  = {
            type   = "integer",
            start  = 12,
            finish = 13,
            parent = "<IGNORE>",
            [1]    = 2,
        },
    },
    [3]    = {
        type   = "tableexp",
        start  = 15,
        finish = 16,
        tindex = 1,
        parent = "<IGNORE>",
        value  = {
            type   = "integer",
            start  = 15,
            finish = 16,
            parent = "<IGNORE>",
            [1]    = 3,
        },
    },
}
TEST '{{}}'
{
    type   = "table",
    start  = 0,
    finish = 4,
    [1]    = {
        type   = "tableexp",
        start  = 1,
        finish = 3,
        tindex = 1,
        parent = "<IGNORE>",
        value  = {
            type   = "table",
            start  = 1,
            finish = 3,
            parent = "<IGNORE>",
        },
    },
}
TEST '{ a = { b = { c = {} } } }'
{
    type   = "table",
    start  = 0,
    finish = 26,
    [1]    = {
        type   = "tablefield",
        start  = 2,
        finish = 3,
        range  = 24,
        parent = "<IGNORE>",
        node   = "<IGNORE>",
        field  = {
            type   = "field",
            start  = 2,
            finish = 3,
            parent = "<IGNORE>",
            [1]    = "a",
        },
        value  = {
            type   = "table",
            start  = 6,
            finish = 24,
            parent = "<IGNORE>",
            [1]    = {
                type   = "tablefield",
                start  = 8,
                finish = 9,
                range  = 22,
                parent = "<IGNORE>",
                node   = "<IGNORE>",
                field  = {
                    type   = "field",
                    start  = 8,
                    finish = 9,
                    parent = "<IGNORE>",
                    [1]    = "b",
                },
                value  = {
                    type   = "table",
                    start  = 12,
                    finish = 22,
                    parent = "<IGNORE>",
                    [1]    = {
                        type   = "tablefield",
                        start  = 14,
                        finish = 15,
                        range  = 20,
                        parent = "<IGNORE>",
                        node   = "<IGNORE>",
                        field  = {
                            type   = "field",
                            start  = 14,
                            finish = 15,
                            parent = "<IGNORE>",
                            [1]    = "c",
                        },
                        value  = {
                            type   = "table",
                            start  = 18,
                            finish = 20,
                            parent = "<IGNORE>",
                        },
                    },
                },
            },
        },
    },
}
TEST '{{}, {}, {{}, {}}}'
{
    type   = "table",
    start  = 0,
    finish = 18,
    [1]    = {
        type   = "tableexp",
        start  = 1,
        finish = 3,
        tindex = 1,
        parent = "<IGNORE>",
        value  = {
            type   = "table",
            start  = 1,
            finish = 3,
            parent = "<IGNORE>",
        },
    },
    [2]    = {
        type   = "tableexp",
        start  = 5,
        finish = 7,
        tindex = 2,
        parent = "<IGNORE>",
        value  = {
            type   = "table",
            start  = 5,
            finish = 7,
            parent = "<IGNORE>",
        },
    },
    [3]    = {
        type   = "tableexp",
        start  = 9,
        finish = 17,
        tindex = 3,
        parent = "<IGNORE>",
        value  = {
            type   = "table",
            start  = 9,
            finish = 17,
            parent = "<IGNORE>",
            [1]    = {
                type   = "tableexp",
                start  = 10,
                finish = 12,
                tindex = 1,
                parent = "<IGNORE>",
                value  = {
                    type   = "table",
                    start  = 10,
                    finish = 12,
                    parent = "<IGNORE>",
                },
            },
            [2]    = {
                type   = "tableexp",
                start  = 14,
                finish = 16,
                tindex = 2,
                parent = "<IGNORE>",
                value  = {
                    type   = "table",
                    start  = 14,
                    finish = 16,
                    parent = "<IGNORE>",
                },
            },
        },
    },
}
TEST '{1, 2, 3,}'
{
    type   = "table",
    start  = 0,
    finish = 10,
    [1]    = {
        type   = "tableexp",
        start  = 1,
        finish = 2,
        tindex = 1,
        parent = "<IGNORE>",
        value  = {
            type   = "integer",
            start  = 1,
            finish = 2,
            parent = "<IGNORE>",
            [1]    = 1,
        },
    },
    [2]    = {
        type   = "tableexp",
        start  = 4,
        finish = 5,
        tindex = 2,
        parent = "<IGNORE>",
        value  = {
            type   = "integer",
            start  = 4,
            finish = 5,
            parent = "<IGNORE>",
            [1]    = 2,
        },
    },
    [3]    = {
        type   = "tableexp",
        start  = 7,
        finish = 8,
        tindex = 3,
        parent = "<IGNORE>",
        value  = {
            type   = "integer",
            start  = 7,
            finish = 8,
            parent = "<IGNORE>",
            [1]    = 3,
        },
    },
}

CHECK [=[
{
[[]]
}]=]
{
    type   = "table",
    start  = 0,
    finish = 20001,
    [1]    = {
        type   = "tableexp",
        start  = 10000,
        finish = 10004,
        tindex = 1,
        parent = "<IGNORE>",
        value  = {
            type   = "string",
            start  = 10000,
            finish = 10004,
            parent = "<IGNORE>",
            [1]    = "",
            [2]    = "[[",
        },
    },
}

CHECK [[
{
    [xxx]
}
]]
{
    type   = "table",
    start  = 0,
    finish = 20001,
    [1]    = {
        type   = "tableindex",
        start  = 10004,
        finish = 10009,
        parent = "<IGNORE>",
        node   = "<IGNORE>",
        index  = {
            type   = "getglobal",
            start  = 10005,
            finish = 10008,
            parent = "<IGNORE>",
            [1]    = "xxx",
        },
    },
}

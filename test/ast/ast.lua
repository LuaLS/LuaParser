---@param code string
---@param optional? LuaParser.CompileOptions
---@return fun(table)
local function TEST(code, optional)
    return function (expect)
        local parser = require 'parser'
        local ast = parser.compile(code, nil, optional)
        assert(ast)
        Match(ast, expect)
    end
end

TEST ''
{
    main = {
        type   = 'Main',
        start  = 0,
        finish = 0,
    }
}

TEST ';;;'
{
    main = {
        start  = 0,
        finish = 3,
    }
}

TEST ';;;x = 1'
{
    main = {
        locals = {
            [1] = {
                id = '...',
                dummy = true,
            },
            [2] = {
                id = '_ENV',
                dummy = true,
                envRefs  = {
                    [1] = {
                        start = 3
                    }
                }
            }
        },
        childs = {
            [1] = {
                type = 'Assign',
                exps = {
                    [1] = {
                        id = 'x',
                        env = {
                            id    = '_ENV',
                            start = 0,
                        }
                    }
                }
            }
        }
    }
}

TEST([[
local x = 1 // 2
]], {
    nonestandardSymbols = { '//' }
})
{
    type   = "main",
    start  = 0,
    finish = 10000,
    locals = "<IGNORE>",
    [1]    = {
        type   = "local",
        start  = 6,
        finish = 7,
        effect = 11,
        range  = 11,
        parent = "<IGNORE>",
        locPos = 0,
        value  = {
            type   = "integer",
            start  = 10,
            finish = 11,
            parent = "<IGNORE>",
            [1]    = 1,
        },
        [1]    = "x",
    },
}

CHECK([[
local x = {
    1, // BAD
    2, // GOOD
    3, // GOOD
}
]], {
    nonstandardSymbol = { ['//'] = true }
})
{
    type   = "main",
    start  = 0,
    finish = 50000,
    locals = "<IGNORE>",
    [1]    = {
        type   = "local",
        start  = 6,
        finish = 7,
        effect = 40001,
        range  = 40001,
        parent = "<IGNORE>",
        locPos = 0,
        value  = {
            type   = "table",
            start  = 10,
            finish = 40001,
            parent = "<IGNORE>",
            [1]    = {
                type   = "tableexp",
                start  = 10004,
                finish = 10005,
                tindex = 1,
                parent = "<IGNORE>",
                value  = {
                    type   = "integer",
                    start  = 10004,
                    finish = 10005,
                    parent = "<IGNORE>",
                    [1]    = 1,
                },
            },
            [2]    = {
                type   = "tableexp",
                start  = 20004,
                finish = 20005,
                tindex = 2,
                parent = "<IGNORE>",
                value  = {
                    type   = "integer",
                    start  = 20004,
                    finish = 20005,
                    parent = "<IGNORE>",
                    [1]    = 2,
                },
            },
            [3]    = {
                type   = "tableexp",
                start  = 30004,
                finish = 30005,
                tindex = 3,
                parent = "<IGNORE>",
                value  = {
                    type   = "integer",
                    start  = 30004,
                    finish = 30005,
                    parent = "<IGNORE>",
                    [1]    = 3,
                },
            },
        },
        [1]    = "x",
    },
}

CHECK [[
local x
return {
    x = 1,
}
]]
{
    type    = "main",
    start   = 0,
    finish  = 40000,
    locals  = "<IGNORE>",
    returns = "<IGNORE>",
    [1]     = {
        type   = "local",
        start  = 6,
        finish = 7,
        effect = 7,
        parent = "<IGNORE>",
        locPos = 0,
        [1]    = "x",
    },
    [2]     = {
        type   = "return",
        start  = 10000,
        finish = 30001,
        parent = "<IGNORE>",
        [1]    = {
            type   = "table",
            start  = 10007,
            finish = 30001,
            parent = "<IGNORE>",
            [1]    = {
                type   = "tablefield",
                start  = 20004,
                finish = 20005,
                range  = 20009,
                parent = "<IGNORE>",
                node   = "<IGNORE>",
                field  = {
                    type   = "field",
                    start  = 20004,
                    finish = 20005,
                    parent = "<IGNORE>",
                    [1]    = "x",
                },
                value  = {
                    type   = "integer",
                    start  = 20008,
                    finish = 20009,
                    parent = "<IGNORE>",
                    [1]    = 1,
                },
            },
        },
    },
}

CHECK [[
local x
a = {
    x
}
]]
{
    type   = "main",
    start  = 0,
    finish = 40000,
    locals = "<IGNORE>",
    [1]    = {
        type   = "local",
        start  = 6,
        finish = 7,
        effect = 7,
        parent = "<IGNORE>",
        locPos = 0,
        ref    = "<IGNORE>",
        [1]    = "x",
    },
    [2]    = {
        type   = "setglobal",
        start  = 10000,
        finish = 10001,
        range  = 30001,
        parent = "<IGNORE>",
        node   = "<IGNORE>",
        value  = {
            type   = "table",
            start  = 10004,
            finish = 30001,
            parent = "<IGNORE>",
            [1]    = {
                type   = "tableexp",
                start  = 20004,
                finish = 20005,
                tindex = 1,
                parent = "<IGNORE>",
                value  = {
                    type   = "getlocal",
                    start  = 20004,
                    finish = 20005,
                    parent = "<IGNORE>",
                    node   = "<IGNORE>",
                    [1]    = "x",
                },
            },
        },
        [1]    = "a",
    },
}

CHECK [[
x, y, z = 1, func()
]]
{
    type   = "main",
    start  = 0,
    finish = 10000,
    locals = "<IGNORE>",
    [1]    = {
        type   = "setglobal",
        start  = 0,
        finish = 1,
        range  = 11,
        parent = "<IGNORE>",
        node   = "<IGNORE>",
        value  = {
            type   = "integer",
            start  = 10,
            finish = 11,
            parent = "<IGNORE>",
            [1]    = 1,
        },
        [1]    = "x",
    },
    [2]    = {
        type   = "setglobal",
        start  = 3,
        finish = 4,
        range  = 19,
        parent = "<IGNORE>",
        node   = "<IGNORE>",
        value  = {
            type   = "select",
            start  = 13,
            finish = 19,
            parent = "<IGNORE>",
            vararg = "<IGNORE>",
            sindex = 1,
        },
        [1]    = "y",
    },
    [3]    = {
        type   = "setglobal",
        start  = 6,
        finish = 7,
        range  = 19,
        parent = "<IGNORE>",
        node   = "<IGNORE>",
        value  = {
            type   = "select",
            start  = 13,
            finish = 19,
            parent = "<IGNORE>",
            vararg = "<IGNORE>",
            sindex = 2,
        },
        [1]    = "z",
    },
}

CHECK [[
local x, y
-- comments
]]
{
    type   = "main",
    start  = 0,
    finish = 20000,
    locals = "<IGNORE>",
    [1]    = {
        type   = "local",
        start  = 6,
        finish = 7,
        effect = 10,
        parent = "<IGNORE>",
        locPos = 0,
        [1]    = "x",
    },
    [2]    = {
        type   = "local",
        start  = 9,
        finish = 10,
        effect = 10,
        parent = "<IGNORE>",
        [1]    = "y",
    },
}

CHECK [[
local _ENV = nil
]]
{
    type   = "main",
    start  = 0,
    finish = 10000,
    locals = "<IGNORE>",
    [1]    = {
        type   = "local",
        start  = 6,
        finish = 10,
        effect = 16,
        range  = 16,
        parent = "<IGNORE>",
        locPos = 0,
        value  = {
            type   = "nil",
            start  = 13,
            finish = 16,
            parent = "<IGNORE>",
        },
        [1]    = "_ENV",
    },
}

CHECK [[
_ENV = nil
]]
{
    type   = "main",
    start  = 0,
    finish = 10000,
    locals = "<IGNORE>",
    [1]    = {
        type   = "local",
        start  = 0,
        finish = 4,
        effect = 10,
        range  = 10,
        parent = "<IGNORE>",
        node   = "<IGNORE>",
        locPos = 0,
        value  = {
            type   = "nil",
            start  = 7,
            finish = 10,
            parent = "<IGNORE>",
        },
        [1]    = "_ENV",
    },
}

local class = require 'class'

local function TEST(code)
    return function (expect)
        local ast = class.new 'LuaParser.Ast' (code)
        local node = ast:parseState()
        assert(node)
        Match(node, expect)
    end
end

TEST [[local x, y = 1, 2, 3]]
{
    __class__ = 'LuaParser.Node.LocalDef',
    start   = 0,
    finish  = 20,
    vars    = {
        [1] = {
            id      = 'x',
            value   = {
                value   = 1,
            }
        },
        [2] = {
            id      = 'y',
            value   = {
                value   = 2,
            }
        },
    },
    values  = {
        [1] = {
            value   = 1,
        },
        [2] = {
            value   = 2,
        },
        [3] = {
            value   = 3,
        },
    }
}

TEST [[x = 1]]
{
    __class__ = 'LuaParser.Node.Assign',
    start   = 0,
    finish  = 5,
    exps    = {
        [1] = {
            start   = 0,
            finish  = 1,
            id      = 'x',
            value   = {
                value   = 1,
            }
        },
    },
    values  = {
        [1] = {
            value   = 1,
        },
    }
}

TEST [[x.x, y.y = 1, 2, 3]]
{
    __class__ = 'LuaParser.Node.Assign',
    exps = {
        [1] = {
            subtype = 'field',
            last    = {
                id = 'x',
            },
            key     = {
                id = 'x',
            },
            value   = {
                value = 1,
            },
        },
        [2] = {
            subtype = 'field',
            key     = {
                id = 'y',
            },
            value   = {
                value = 2,
            },
        },
    },
    values = {
        [1] = {
            value = 1,
        },
        [2] = {
            value = 2,
        },
        [3] = {
            value = 3,
        },
    },
}

TEST [[x.y()]]
{
    __class__ = 'LuaParser.Node.Call',
}

TEST [[x.y().z = 1]]
{
    __class__ = 'LuaParser.Node.Assign',
    exps = {
        [1] = {
            subtype = 'field',
            last    = {
                __class__ = 'LuaParser.Node.Call',
            },
            key     = {
                id = 'z',
            },
            value   = {
                value = 1,
            },
        },
    },
    values = {
        [1] = {
            value = 1,
        }
    }
}

TEST [[:: continue ::]]
{
    __class__ = 'LuaParser.Node.Label',
    start  = 0,
    finish = 14,
    label  = {
        start  = 3,
        finish = 11,
        id     = 'continue',
    }
}

TEST [[goto continue]]
{
    __class__ = 'LuaParser.Node.Goto',
    start  = 0,
    finish = 13,
    label  = {
        start  = 5,
        finish = 13,
        id     = 'continue',
    }
}

TEST [[
do
end
]]
{
    __class__ = 'LuaParser.Node.Do',
    left  = 0,
    right = 10003,
}

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
    type    = 'LocalDef',
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
    type    = 'Assign',
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
    type = 'Assign',
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
    type = 'Call',
}

TEST [[x.y().z = 1]]
{
    type = 'Assign',
    exps = {
        [1] = {
            subtype = 'field',
            last    = {
                type   = 'Call',
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
    type   = 'Label',
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
    type   = 'Goto',
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
    type  = 'Do',
    left  = 0,
    right = 10003,
}

TEST [[
if x then
elseif y then
else
end
]]
{
    type   = 'If',
    left   = 0,
    right  = 30003,
    childs = {
        [1] = {
            type    = 'IfChild',
            subtype = 'if',
            condition = {
                id = 'x',
            },
        },
        [2] = {
            type    = 'IfChild',
            subtype = 'elseif',
            condition = {
                id = 'y',
            },
        },
        [3] = {
            type    = 'IfChild',
            subtype = 'else',
        },
    }
}

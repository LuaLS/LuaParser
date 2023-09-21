local class = require 'class'

local function TEST(code)
    return function (expect)
        ---@class LuaParser.Ast
        local ast = class.new 'LuaParser.Ast' (code)
        local node = ast:parseState()
        assert(node)
        Match(node, expect)
    end
end

TEST [[
do
    x = 1
    y = 2
end
]]
{
    type   = 'Do',
    left   = 0,
    right  = 30003,
    childs = {
        [1] = {
            type   = 'Assign',
            left   = 10004,
            right  = 10009,
        },
        [2] = {
            type   = 'Assign',
            left   = 20004,
            right  = 20009,
        },
    }
}
do return end
TEST [[
do
    local x = x
    x = 1
    print(x)
end
]]
{
    childs = {
        [1] = {
            type   = 'LocalDef',
            vars   = {
                [1] = {
                    id   = 'x',
                    sets = {
                        [1] = {
                            left = 20004,
                        }
                    },
                    gets = {
                        [1] = {
                            left = 30010,
                        }
                    },
                    value = {
                        loc = NIL,
                    }
                },
            },
        },
        [2] = {
            type = 'Assign',
            exps = {
                [1] = {
                    id  = 'x',
                    loc = {
                        left = 10004,
                    }
                }
            }
        },
        [3] = {
            type = 'Call',
            args = {
                [1] = {
                    id  = 'x',
                    loc = {
                        left = 10004,
                    }
                }
            }
        },
    }
}

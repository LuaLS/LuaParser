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

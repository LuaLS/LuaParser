local class = require 'class'

local function TEST(code)
    return function (expect)
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

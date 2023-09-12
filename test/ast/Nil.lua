local class  = require 'class'

local function TEST(code)
    return function (expect)
        local ast = class.new 'LuaParser.Ast' (code)
        local node = ast:parseNil()
        assert(node)
        Match(node, expect)
    end
end

TEST [[nil]]
{
    type    = "nil",
    left    = 0,
    right   = 3,
}
TEST [[   nil]]
{
    type    = "nil",
    left    = 3,
    right   = 6,
}

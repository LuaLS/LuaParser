local class = require 'class'

local function TEST(code)
    return function (expect)
        local ast = class.new 'LuaParser.Ast' (code)
        local node = ast:parseBoolean()
        assert(node)
        Match(node, expect)
    end
end

TEST [[true]]
{
    type    = "boolean",
    left    = 0,
    finish  = 4,
    value   = true,
}
TEST [[false]]
{
    type    = "boolean",
    left    = 0,
    right   = 5,
    value   = false,
}

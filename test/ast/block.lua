local class = require 'class'

local function TEST(code)
    return function (expect)
        local ast = class.new 'LuaParser.Ast' (code)
        local node = ast:parseBoolean()
        assert(node)
        Match(node, expect)
    end
end

TEST [[

]]

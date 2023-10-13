local class = require 'class'

local function TEST(code)
    return function (expect)
        ---@class LuaParser.Ast
        local ast = class.new 'LuaParser.Ast' (code)
        local cat = ast:parseCats()
        Match(cat, expect)
    end
end

TEST [[
---@class A
]]

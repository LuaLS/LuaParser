local class = require 'class'

local function TEST(code)
    return function (expect)
        ---@class LuaParser.Ast
        local ast = class.new 'LuaParser.Ast' (code)
        local cat = ast:parseCat()
        Match(cat, expect)
    end
end

TEST [[
---@class A
]]
{
    subtype = 'class',
    start   = 0,
    finish  = 11,
    symbolPos = 3,
    value   = {
        start   = 10,
        finish  = 11,
        classID = {
            start  = 10,
            finish = 11,
            id     = 'A',
        },
    }
}

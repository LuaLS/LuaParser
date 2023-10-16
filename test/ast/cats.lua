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

TEST [[
---@class(exact, what1, what2) A
]]
{
    subtype = 'class',
    start   = 0,
    finish  = 32,
    symbolPos = 3,
    attrPos1  = 9,
    attrPos2  = 29,
    attrs   = {
        [1] = {
            start  = 10,
            finish = 15,
            id     = 'exact',
        },
        [2] = {
            start  = 17,
            finish = 22,
            id     = 'what1',
        },
        [3] = {
            start  = 24,
            finish = 29,
            id     = 'what2',
        },
    },
    value   = {
        start   = 31,
        finish  = 32,
        classID = {
            start  = 31,
            finish = 32,
            id     = 'A',
        },
    }
}

TEST [[
---@class A: B
]]
{
    subtype = 'class',
    start   = 0,
    finish  = 14,
    symbolPos = 3,
    value   = {
        start   = 10,
        finish  = 14,
        classID = {
            start  = 10,
            finish = 11,
            id     = 'A',
        },
        symbolPos = 11,
        extends = {
            id     = 'B',
            start  = 13,
            finish = 14,
        }
    }
}

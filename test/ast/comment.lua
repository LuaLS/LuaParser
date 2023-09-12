local class = require 'class'

local function TEST(code)
    return function (expect)
        local ast = class.new 'LuaParser.Ast' (code)
        local node = ast:parseComment(true)
        assert(node)
        Match(node, expect)
    end
end

TEST [[--AAA]]
{
    type    = "comment",
    left    = 0,
    right   = 5,
    subtype = 'short',
    value   = 'AAA',
}

TEST [[//AAA]]
{
    type    = "comment",
    left    = 0,
    right   = 5,
    subtype = 'short',
    value   = 'AAA',
}

TEST [===[--[[
1234
]]]===]
{
    type    = "comment",
    left    = 0,
    right   = 20002,
    subtype = 'long',
    value   = '\n1234\n',
}

TEST [===[/*
1234
*/]===]
{
    type    = "comment",
    left    = 0,
    right   = 20002,
    subtype = 'long',
    value   = '\n1234\n',
}

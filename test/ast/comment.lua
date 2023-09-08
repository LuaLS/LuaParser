local parser = require 'parser'

local function TEST(code)
    return function (expect)
        local ast = parser.compile(code)
        local node = ast:parseNil()
        assert(node)
        Match(node, expect)
    end
end

TEST [[--AAA]]
{
    [1] = {
        type    = "comment",
        left    = 0,
        right   = 5,
    },
}

TEST [[
--AAA
]]
{
    [1] = {
        type    = "comment",
        left    = 0,
        right   = 5,
    },
}

TEST [[//AAA]]
{
    [1] = {
        type    = "comment",
        left    = 0,
        right   = 5,
    },
}

TEST [[
//AAA
]]
{
    [1] = {
        type    = "comment",
        left    = 0,
        right   = 5,
    },
}

local parser = require 'parser'

local function TEST(code)
    return function (expect)
        local ast = parser.compile(code)
        local node = ast:parseString()
        assert(node)
        Match(node, expect)
    end
end

TEST [['123']]
{
    type   = "string",
    left   = 0,
    right  = 5,
    value  = "123",
    quo    = "'",
}
TEST [['123\'']]
{
    type   = "string",
    left   = 0,
    right  = 7,
    escs   = {
        [1] = 4,
        [2] = 6,
        [3] = "normal",
    },
    value  = "123'",
    quo    = "'",
}
TEST [['123\z
    345']]
{
    type   = "string",
    left   = 0,
    right  = 10008,
    escs   = {
        [1] = 4,
        [2] = 6,
        [3] = "normal",
    },
    value  = "123345",
    quo    = "'",
}

TEST [['123\
345']]
{
    type   = "string",
    left   = 0,
    right  = 10004,
    escs   = {
        [1] = 4,
        [2] = 5,
        [3] = "normal",
    },
    value  = "123\
345",
    quo    = "'",
}
TEST [===[[[123]]]===]
{
    type   = "string",
    left   = 0,
    right  = 7,
    value  = "123",
    quo    = "[[",
}
TEST [===[[[123
345]]]===]
{
    type   = "string",
    left   = 0,
    right  = 10005,
    value  = "123\
345",
    quo    = "[[",
}
TEST [['alo\n123"']]
{
    type   = "string",
    left   = 0,
    right  = 11,
    escs   = {
        [1] = 4,
        [2] = 6,
        [3] = "normal",
    },
    value  = "alo\
123\"",
    quo    = "'",
}
TEST [['\97lo\10\04923"']]
{
    type   = "string",
    left   = 0,
    right  = 17,
    escs   = {
        [1] = 1,
        [2] = 4,
        [3] = "byte",
        [4] = 6,
        [5] = 9,
        [6] = "byte",
        [7] = 9,
        [8] = 13,
        [9] = "byte",
    },
    value  = "alo\
123\"",
    quo    = "'",
}
TEST [['\xff']]
{
    type   = "string",
    left   = 0,
    right  = 6,
    escs   = {
        [1] = 1,
        [2] = 6,
        [3] = "byte",
    },
    value  = "\xff",
    quo    = "'",
}
TEST [['\x1A']]
{
    type   = "string",
    left   = 0,
    right  = 6,
    escs   = {
        [1] = 1,
        [2] = 6,
        [3] = "byte",
    },
    value  = "\26",
    quo    = "'",
}
TEST [['\492']]
{
    type   = "string",
    left   = 0,
    right  = 6,
    escs   = {
        [1] = 1,
        [2] = 5,
        [3] = "byte",
    },
    value  = "",
    quo    = "'",
}
TEST [['\u{3b1}']]
{
    type   = "string",
    left   = 0,
    right  = 9,
    escs   = {
        [1] = 1,
        [2] = 9,
        [3] = "unicode",
    },
    value  = "α",
    quo    = "'",
}
TEST [['\u{0}']]
{
    type   = "string",
    left   = 0,
    right  = 7,
    escs   = {
        [1] = 1,
        [2] = 7,
        [3] = "unicode",
    },
    value  = "\0",
    quo    = "'",
}
TEST [['\u{ffffff}']]
{
    type   = "string",
    left   = 0,
    right  = 12,
    escs   = {
        [1] = 1,
        [2] = 12,
        [3] = "unicode",
    },
    value  = "",
    quo    = "'",
}
TEST [=[[[
abcdef]]]=]
{
    type   = "string",
    left   = 0,
    right  = 10008,
    value  = "abcdef",
    quo    = "[[",
}
TEST [['aaa]]
{
    type   = "string",
    left   = 0,
    right  = 4,
    value  = "aaa",
    quo    = "'",
}
TEST [['aaa
]]
{
    type   = "string",
    left   = 0,
    right  = 4,
    value  = "aaa",
    quo    = "'",
}
TEST [[`12345`]]
{
    type   = "string",
    left   = 0,
    right  = 7,
    value  = "12345",
    quo    = "`",
}

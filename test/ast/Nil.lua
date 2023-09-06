local parser = require 'parser'

local function TEST(code)
    return function (expect)
        local status = parser.compile(code)
        local node = status:parseNil()
        assert(node)
        for k, v in pairs(expect) do
            assert(node[k] == v)
        end
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

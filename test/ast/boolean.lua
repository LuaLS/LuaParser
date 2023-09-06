local parser = require 'parser'

local function TEST(code)
    return function (expect)
        local ast = parser.compile(code)
        local node = ast:parseBoolean()
        assert(node)
        for k, v in pairs(expect) do
            assert(node[k] == v)
        end
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

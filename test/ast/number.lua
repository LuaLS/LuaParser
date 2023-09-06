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

TEST '345'
{
    type    = "integer",
    left    = 0,
    right   = 3,
    value   = 345,
    numBase = 10,
}
TEST '345.0'
{
    type    = "number",
    left    = 0,
    right   = 5,
    value   = 0x1.59p+8,
    numBase = 10,
}
TEST '0xff'
{
    type    = "integer",
    left    = 0,
    right   = 4,
    value   = 255,
    numBase = 16,
}
TEST '314.16e-2'
{
    type    = "number",
    left    = 0,
    right   = 9,
    value   = 3.1416,
    numBase = 10,
}
TEST '0.31416E1'
{
    type    = "number",
    left    = 0,
    right   = 9,
    value   = 0x1.921ff2e48e8a7p+1,
    numBase = 10,
}
TEST '.31416E1'
{
    type    = "number",
    left    = 0,
    right   = 8,
    value   = 0x1.921ff2e48e8a7p+1,
    numBase = 10,
}
TEST '34e1'
{
    type    = "number",
    left    = 0,
    right   = 4,
    value   = 0x1.54p+8,
    numBase = 10,
}
TEST '0x0.1E'
{
    type    = "number",
    left    = 0,
    right   = 6,
    value   = 0x1.ep-4,
    numBase = 16,
}
TEST '0xA23p-4'
{
    type    = "number",
    left    = 0,
    right   = 8,
    value   = 0x1.446p+7,
}
TEST '0X1.921FB54442D18P+1'
{
    type    = "number",
    left    = 0,
    right   = 20,
    value   = 0x1.921fb54442d18p+1,
}
TEST '-345'
{
    type    = "integer",
    left    = 0,
    right   = 4,
    value   = -345,
}
TEST '0b110110'
{
    type    = "integer",
    left    = 0,
    right   = 8,
    value   = 54,
}

local parser = require 'parser'

local function TEST(code)
    return function (expect)
        local ast = parser.compile(code)
        local node = ast:parseNumber()
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
    view    = '345',
}
TEST '345.0'
{
    type    = "float",
    left    = 0,
    right   = 5,
    value   = 0x1.59p+8,
    numBase = 10,
    view    = '345.0',
}
TEST '0xff'
{
    type    = "integer",
    left    = 0,
    right   = 4,
    value   = 255,
    numBase = 16,
    view    = '255',
}
TEST '314.16e-2'
{
    type    = "float",
    left    = 0,
    right   = 9,
    value   = 3.1416,
    numBase = 10,
    view    = '3.1416',
}
TEST '0.31416E1'
{
    type    = "float",
    left    = 0,
    right   = 9,
    value   = 0x1.921ff2e48e8a7p+1,
    numBase = 10,
    view    = '3.1416',
}
TEST '.31416E1'
{
    type    = "float",
    left    = 0,
    right   = 8,
    value   = 0x1.921ff2e48e8a7p+1,
    numBase = 10,
    view    = '3.1416',
}
TEST '34e1'
{
    type    = "float",
    left    = 0,
    right   = 4,
    value   = 0x1.54p+8,
    numBase = 10,
    view    = '340.0',
}
TEST '0x0.1E'
{
    type    = "float",
    left    = 0,
    right   = 6,
    value   = 0x1.ep-4,
    numBase = 16,
    view    = '0.1171875',
}
TEST '0xA23p-4'
{
    type    = "float",
    left    = 0,
    right   = 8,
    value   = 0x1.446p+7,
    numBase = 16,
    view    = '162.1875'
}
TEST '0X1.921FB54442D18P+1'
{
    type    = "float",
    left    = 0,
    right   = 20,
    value   = 0x1.921fb54442d18p+1,
    numBase = 16,
    view    = '3.1415926536'
}
TEST '-345'
{
    type    = "integer",
    left    = 0,
    right   = 4,
    value   = -345,
    numBase = 10,
    view    = '-345',
}
TEST '0b110110'
{
    type    = "integer",
    left    = 0,
    right   = 8,
    value   = 54,
    numBase = 2,
    view    = '54',
}
TEST '123ll'
{
    type    = "integer",
    left    = 0,
    right   = 5,
    value   = 123,
    numBase = 10,
    view    = '123LL',
}
TEST '123ull'
{
    type    = "integer",
    left    = 0,
    right   = 6,
    value   = 123,
    numBase = 10,
    view    = '123ULL',
}
TEST '123llu'
{
    type    = "integer",
    left    = 0,
    right   = 6,
    value   = 123,
    numBase = 10,
    view    = '123ULL',
}
TEST '123i'
{
    type    = "integer",
    left    = 0,
    right   = 4,
    value   = 0,
    valuei  = 123,
    numBase = 10,
    view    = '0+123i',
}
TEST '123.45i'
{
    type    = "float",
    left    = 0,
    right   = 7,
    value   = 0,
    valuei  = 123.45,
    numBase = 10,
    view    = '0+123.45i',
}

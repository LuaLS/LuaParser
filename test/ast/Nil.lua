local parser = require 'parser'

local function TEST(code)
    return function (expect)
        local status = parser.compile(code)
    end
end

CHECK [[nil]]
{
    type   = "nil",
    start  = 0,
    finish = 3,
}
CHECK [[   nil]]
{
    type   = "nil",
    start  = 3,
    finish = 6,
}

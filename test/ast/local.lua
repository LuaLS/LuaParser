local parser = require 'parser'

local function TEST(code)
    return function (expect)
        local ast = parser.compile(code)
        local node = ast:parseLocal()
        assert(node)
        Match(node, expect)
    end
end

TEST [[local x]]
{
    type    = 'localdef',
    left    = 0,
    finish  = 7,
    vars    = {
        [1] = {
            type    = 'local',
            start   = 6,
            finish  = 7,
            id      = 'x',
        },
    },
}
TEST [[local x, y, z]]
{
    type    = 'localdef',
    left    = 0,
    finish  = 13,
    vars    = {
        [1] = {
            type    = 'local',
            start   = 6,
            finish  = 7,
            id      = 'x',
        },
        [2] = {
            type    = 'local',
            start   = 9,
            finish  = 10,
            id      = 'y',
        },
        [3] = {
            type    = 'local',
            start   = 12,
            finish  = 13,
            id      = 'z',
        },
    },
}

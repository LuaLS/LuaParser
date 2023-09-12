local class = require 'class'

local function TEST(code)
    return function (expect)
        local ast = class.new 'LuaParser.Ast' (code)
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
            index   = 1,
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
            index   = 1,
        },
        [2] = {
            type    = 'local',
            start   = 9,
            finish  = 10,
            id      = 'y',
            index   = 2,
        },
        [3] = {
            type    = 'local',
            start   = 12,
            finish  = 13,
            id      = 'z',
            index   = 3,
        },
    },
}

TEST [[local x = 1]]
{
    type    = 'localdef',
    left    = 0,
    finish  = 11,
    vars    = {
        [1] = {
            type    = 'local',
            start   = 6,
            finish  = 7,
            id      = 'x',
            value   = {
                type    = 'integer',
                start   = 10,
                finish  = 11,
                value   = 1,
            }
        },
    },
    values  = {
        [1] = {
            type    = 'integer',
            start   = 10,
            finish  = 11,
            value   = 1,
        },
    }
}

TEST [[local x, y = 1, 2, 3]]
{
    type    = 'localdef',
    left    = 0,
    finish  = 20,
    vars    = {
        [1] = {
            type    = 'local',
            start   = 6,
            finish  = 7,
            id      = 'x',
            value   = {
                type    = 'integer',
                start   = 13,
                finish  = 14,
                value   = 1,
            }
        },
        [2] = {
            type    = 'local',
            start   = 9,
            finish  = 10,
            id      = 'y',
            value   = {
                type    = 'integer',
                start   = 16,
                finish  = 17,
                value   = 2,
            }
        },
    },
    values  = {
        [1] = {
            type    = 'integer',
            start   = 13,
            finish  = 14,
            value   = 1,
        },
        [2] = {
            type    = 'integer',
            start   = 16,
            finish  = 17,
            value   = 2,
        },
        [3] = {
            type    = 'integer',
            start   = 19,
            finish  = 20,
            value   = 3,
        },
    }
}

CHECK [[
---@class Class
local x = 1
]]
{
    [1] = {
        type = 'local',
        emmy = {
            class = {
                type   = 'name',
                start  = 11,
                finish = 15,
                [1]    = 'Class',
            },
        },
        [1]  = {
            type   = 'name',
            start  = 23,
            finish = 23,
            [1]    = 'x',
        },
        [2]  = {
            type   = 'number',
            start  = 27,
            finish = 27,
            [1]    = 1,
        }
    }
}

CHECK [[
---@class Class : SuperClass
local x = 1
]]
{
    [1] = {
        type = 'local',
        emmy = {
            class = {
                type   = 'name',
                start  = 11,
                finish = 15,
                [1]    = 'Class',
            },
            extends = {
                type   = 'name',
                start  = 19,
                finish = 28,
                [1]    = 'SuperClass',
            },
        },
        [1]  = {
            type   = 'name',
            start  = 36,
            finish = 36,
            [1]    = 'x',
        },
        [2]  = {
            type   = 'number',
            start  = 40,
            finish = 40,
            [1]    = 1,
        }
    }
}

CHECK [[
---@class Class
x = 1
]]
{
    [1] = {
        type = 'set',
        emmy = {
            class = {
                type   = 'name',
                start  = 11,
                finish = 15,
                [1]    = 'Class',
            },
        },
        [1]  = {
            type   = 'name',
            start  = 17,
            finish = 17,
            [1]    = 'x',
        },
        [2]  = {
            type   = 'number',
            start  = 21,
            finish = 21,
            [1]    = 1,
        }
    }
}

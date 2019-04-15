CHECK [[
---@class Class
local x = 1
]]
{
    [1] = {
        type = 'local',
        emmy = {
            type = 'class',
            class = {
                type   = 'name',
                start  = 11,
                finish = 15,
                [1]    = 'Class',
            },
        },
        [1]  = {
            start  = 23,
            finish = 23,
            [1]    = {
                type   = 'name',
                start  = 23,
                finish = 23,
                [1]    = 'x',
            }
        },
        [2]  = {
            start  = 27,
            finish = 27,
            [1]    = {
                type   = 'number',
                start  = 27,
                finish = 27,
                [1]    = 1,
            }
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
            type = 'class',
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
            start  = 36,
            finish = 36,
            [1]    = {
                type   = 'name',
                start  = 36,
                finish = 36,
                [1]    = 'x',
            }
        },
        [2]  = {
            start  = 40,
            finish = 40,
            [1]    = {
                type   = 'number',
                start  = 40,
                finish = 40,
                [1]    = 1,
            }
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
            type = 'class',
            class = {
                type   = 'name',
                start  = 11,
                finish = 15,
                [1]    = 'Class',
            },
        },
        [1]  = {
            start  = 17,
            finish = 17,
            [1]    = {
                type   = 'name',
                start  = 17,
                finish = 17,
                [1]    = 'x',
            }
        },
        [2]  = {
            start  = 21,
            finish = 21,
            [1]    = {
                type   = 'number',
                start  = 21,
                finish = 21,
                [1]    = 1,
            }
        }
    }
}

CHECK [[
---@type Type
x = 1
]]
{
    [1] = {
        type = 'set',
        emmy = {
            type = 'type',
            [1] = {
                type   = 'name',
                start  = 10,
                finish = 13,
                [1]    = 'Type',
            },
        },
        [1]  = {
            start  = 15,
            finish = 15,
            [1]    = {
                type   = 'name',
                start  = 15,
                finish = 15,
                [1]    = 'x',
            }
        },
        [2]  = {
            start  = 19,
            finish = 19,
            [1]    = {
                type   = 'number',
                start  = 19,
                finish = 19,
                [1]    = 1,
            }
        }
    }
}

CHECK [[
---@type Type1|Type2|Type3
x = 1
]]
{
    [1] = {
        type = 'set',
        emmy = {
            type = 'type',
            [1] = {
                type   = 'name',
                start  = 10,
                finish = 14,
                [1]    = 'Type1',
            },
            [2] = {
                type   = 'name',
                start  = 16,
                finish = 20,
                [1]    = 'Type2',
            },
            [3] = {
                type   = 'name',
                start  = 22,
                finish = 26,
                [1]    = 'Type3',
            },
        },
        [1]  = {
            start  = 28,
            finish = 28,
            [1]    = {
                type   = 'name',
                start  = 28,
                finish = 28,
                [1]    = 'x',
            }
        },
        [2]  = {
            start  = 32,
            finish = 32,
            [1]    = {
                type   = 'number',
                start  = 32,
                finish = 32,
                [1]    = 1,
            }
        }
    }
}

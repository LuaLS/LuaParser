CHECK'a.'
{
    [1] = {
        type   = 'simple',
        start  = 1,
        finish = 2,
        [1]  = {
            type   = 'name',
            start  = 1,
            finish = 1,
            [1]    = 'a',
        },
        [2]  = {
            type   = '.',
            start  = 2,
            finish = 2,
        },
    }
}

CHECK'a:'
{
    [1] = {
        type   = 'simple',
        start  = 1,
        finish = 2,
        [1]  = {
            type   = 'name',
            start  = 1,
            finish = 1,
            [1]    = 'a',
        },
        [2]  = {
            type   = ':',
            start  = 2,
            finish = 2,
        },
    }
}

CHECK [[
if true
a
]]
{
    [1] = {
        type   = 'if',
        start  = 1,
        finish = 7,
        [1]    = {
            start  = 8,
            finish = 8,
            filter = {
                type   = 'boolean',
                start  = 4,
                finish = 7,
                [1]    = true,
            },
        },
    },
    [2] = {
        type   = 'name',
        start  = 9,
        finish = 9,
        [1]    = 'a',
    }
}

CHECK [[
if true then
a
]]
{
    [1] = {
        type   = 'if',
        start  = 1,
        finish = 14,
        [1]    = {
            start  = 13,
            finish = 15,
            filter = {
                type   = 'boolean',
                start  = 4,
                finish = 7,
                [1]    = true,
            },
            [1] = {
                type   = 'name',
                start  = 14,
                finish = 14,
                [1]    = 'a',
            }
        },
    },
}

CHECK [[
x =
]]
{
    [1] = {
        type   = 'set',
        [1]    = {
            type   = 'name',
            start  = 1,
            finish = 1,
            [1]    = 'x'
        },
    }
}

CHECK'1 == 2'
{
    [1] = {
        type   = 'binary',
        op     = '==',
        start  = 1,
        finish = 6,
        [1]  = {
            type   = 'number',
            start  = 1,
            finish = 1,
            [1]    = 1,
        },
        [2]  = {
            type   = 'number',
            start  = 6,
            finish = 6,
            [1]    = 2,
        },
    }
}

CHECK 'local function a'
{
    [1] = {
        type      = 'localfunction',
        start     = 1,
        finish    = 16,
        argStart  = 16,
        argFinish = 16,
        name      = {
            type   = 'name',
            start  = 16,
            finish = 16,
            [1]    = 'a',
        },
    }
}

CHECK 'local function'
{
    [1] = {
        type      = 'localfunction',
        start     = 1,
        finish    = 14,
        argStart  = 14,
        argFinish = 14,
        name      = {
            type   = 'name',
            start  = 14,
            finish = 14,
            [1]    = '',
        }
    }
}

CHECK 'local function a(v'
{
    [1] = {
        type      = 'localfunction',
        start     = 1,
        finish    = 18,
        argStart  = 17,
        argFinish = 18,
        name      = {
            type   = 'name',
            start  = 16,
            finish = 16,
            [1]    = 'a',
        },
        arg       = {
            type   = 'name',
            start  = 18,
            finish = 18,
            [1]    = 'v',
        }
    }
}

CHECK 'function a'
{
    [1] = {
        type      = 'function',
        start     = 1,
        finish    = 10,
        argStart  = 10,
        argFinish = 10,
        name      = {
            type   = 'name',
            start  = 10,
            finish = 10,
            [1]    = 'a',
        },
    }
}

CHECK 'function a:'
{
    [1] = {
        type      = 'function',
        start     = 1,
        finish    = 11,
        argStart  = 11,
        argFinish = 11,
        name   = {
            type   = 'simple',
            start  = 10,
            finish = 11,
            [1]    = {
                type   = 'name',
                start  = 10,
                finish = 10,
                [1]    = 'a',
            },
            [2]    = {
                type   = ':',
                start  = 11,
                finish = 11,
            },
        },
    }
}

CHECK 'function a:b(v'
{
    [1] = {
        type      = 'function',
        start     = 1,
        finish    = 14,
        argStart  = 13,
        argFinish = 14,
        name      = {
            type   = 'simple',
            start  = 10,
            finish = 12,
            [1]    = {
                type   = 'name',
                start  = 10,
                finish = 10,
                [1]    = 'a',
            },
            [2]    = {
                type   = ':',
                start  = 11,
                finish = 11,
            },
            [3]    = {
                type   = 'name',
                start  = 12,
                finish = 12,
                [1]    = 'b',
            },
        },
        arg   = {
            type   = 'name',
            start  = 14,
            finish = 14,
            [1]    = 'v'
        },
    }
}

CHECK 'return local a'
{
    [1] = {
        type   = 'return',
        start  = 1,
        finish = 6,
    },
    [2] = {
        type   = 'local',
        [1]    = {
            type   = 'name',
            start  = 14,
            finish = 14,
            [1]    = 'a',
        }
    }
}

CHECK 'end'
{
    [1] = false,
}

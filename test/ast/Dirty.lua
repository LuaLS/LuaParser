CHECK'a.'
{
    [1] = {
        type   = 'simple',
        start  = 1,
        finish = 3,
        [1]  = {
            type   = 'name',
            start  = 1,
            finish = 1,
            [1]    = 'a',
        },
        [2]  = {
            type   = 'name',
            start  = 3,
            finish = 3,
            [1]    = '',
        },
    }
}

CHECK'a:'
{
    [1] = {
        type   = 'simple',
        start  = 1,
        finish = 3,
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
        [3]  = {
            type   = 'name',
            start  = 3,
            finish = 3,
            [1]    = '',
        },
    }
}

CHECK [[
if
a
]]
{
    [1] = {
        type   = 'if',
        start  = 1,
        finish = 3,
        [1]    = {
            filter = {
                type   = 'name',
                start  = 3,
                finish = 3,
                [1]    = '',
            },
        },
    },
    [2] = {
        type   = 'name',
        start  = 4,
        finish = 4,
        [1]    = 'a',
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
        finish = 8,
        [1]    = {
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

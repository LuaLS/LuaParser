CHECK''
{}

CHECK';;;'
{
    [1] = false,
    [2] = false,
    [3] = false,
}

CHECK';;;x = 1'
{
    [1] = false,
    [2] = false,
    [3] = false,
    [4] = {
        type = 'set',
        [1]  = {
            type   = 'name',
            start  = 4,
            finish = 4,
            [1]    = 'x',
        },
        [2]  = {
            type   = 'number',
            start  = 8,
            finish = 8,
            [1]    = 1,
        },
    }
}

CHECK[[
x = 1
y = 2
]]
{
    [1] = {
        type = 'set',
        [1]  = {
            type   = 'name',
            start  = 1,
            finish = 1,
            [1]    = 'x',
        },
        [2]  = {
            type   = 'number',
            start  = 5,
            finish = 5,
            [1]    = 1,
        },
    },
    [2] = {
        type = 'set',
        [1]  = {
            type   = 'name',
            start  = 7,
            finish = 7,
            [1]    = 'y',
        },
        [2]  = {
            type   = 'number',
            start  = 11,
            finish = 11,
            [1]    = 2,
        }
    }
}

CHECK'a.'
{
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

CHECK'a:'
{
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

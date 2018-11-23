CHECK[['123']]
{
    type   = 'string',
    start  = 1,
    finish = 5,
    [1]    = [[123]],
}
CHECK[['123\'']]
{
    type   = 'string',
    start  = 1,
    finish = 7,
    [1]    = [[123']],
}
CHECK[['123\z
    345']]
{
    type   = 'string',
    start  = 1,
    finish = 15,
    [1]    = [[123345]],
}
CHECK[===[[[123]]]===]
{
    type   = 'string',
    start  = 1,
    finish = 7,
    [1]    = [[123]],
}
CHECK[===[[[123
345]]]===]
{
    type   = 'string',
    start  = 1,
    finish = 11,
    [1]    = [[123
345]],
}
CHECK[['alo\n123"']]
{
    type   = 'string',
    start  = 1,
    finish = 11,
    [1]    = [[alo
123"]],
}

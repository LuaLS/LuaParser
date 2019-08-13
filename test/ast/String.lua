CHECK[['123']]
{
    [1] = {
        type   = 'string',
        start  = 1,
        finish = 5,
        [1]    = [[123]],
        [2]    = [[']],
    }
}
CHECK[['123\'']]
{
    [1] = {
        type   = 'string',
        start  = 1,
        finish = 7,
        [1]    = [[123']],
        [2]    = [[']],
    }
}
CHECK[['123\z
    345']]
{
    [1] = {
        type   = 'string',
        start  = 1,
        finish = 15,
        [1]    = [[123345]],
        [2]    = [[']],
    }
}
CHECK[===[[[123]]]===]
{
    [1] = {
        type   = 'string',
        start  = 1,
        finish = 7,
        [1]    = [[123]],
        [2]    = [=[[[]=],
    }
}
CHECK[===[[[123
345]]]===]
{
    [1] = {
        type   = 'string',
        start  = 1,
        finish = 11,
        [1]    = [[123
345]],
        [2]    = [=[[[]=],
    }
}
CHECK[['alo\n123"']]
{
    [1] = {
        type   = 'string',
        start  = 1,
        finish = 11,
        [1]    = [[alo
123"]],
        [2]    = [=[']=],
    }
}
CHECK[['\97lo\10\04923"']]
{
    [1] = {
        type   = 'string',
        start  = 1,
        finish = 17,
        [1]    = [[alo
123"]],
        [2]    = [=[']=],
    }
}
CHECK[['\xff']]
{
    [1] = {
        type   = 'string',
        start  = 1,
        finish = 6,
        [1]    = '\xff',
        [2]    = [=[']=],
    }
}
CHECK[['\x1A']]
{
    [1] = {
        type   = 'string',
        start  = 1,
        finish = 6,
        [1]    = '\x1A',
        [2]    = [=[']=],
    }
}
CHECK[['\492']]
{
    [1] = {
        type   = 'string',
        start  = 1,
        finish = 6,
        [1]    = '',
        [2]    = [=[']=],
    }
}
CHECK[['\u{3b1}']]
{
    [1] = {
        type   = 'string',
        start  = 1,
        finish = 9,
        [1]    = '\u{3b1}',
        [2]    = [=[']=],
    }
}
CHECK[['\u{0}']]
{
    [1] = {
        type   = 'string',
        start  = 1,
        finish = 7,
        [1]    = '\0',
        [2]    = [=[']=],
    }
}
CHECK[['\u{ffffff}']]
{
    [1] = {
        type   = 'string',
        start  = 1,
        finish = 12,
        [1]    = '',
        [2]    = [=[']=],
    }
}
CHECK[=[[[
abcdef]]]=]
{
    [1] = {
        type   = 'string',
        start  = 1,
        finish = 11,
        [1]    = 'abcdef',
        [2]    = '[[',
    }
}

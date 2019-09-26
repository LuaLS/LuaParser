CHECK[['123']]
{
    type   = "string",
    start  = 1,
    finish = 5,
    [1]    = "123",
    [2]    = "'",
}
CHECK[['123\'']]
{
    type   = "string",
    start  = 1,
    finish = 7,
    [1]    = "123'",
    [2]    = "'",
}
CHECK[['123\z
    345']]
{
    type   = "string",
    start  = 1,
    finish = 15,
    [1]    = "123345",
    [2]    = "'",
}
CHECK[===[[[123]]]===]
{
    type   = "string",
    start  = 1,
    finish = 7,
    [1]    = "123",
    [2]    = "[[",
}
CHECK[===[[[123
345]]]===]
{
    type   = "string",
    start  = 1,
    finish = 11,
    [1]    = "123\
345",
    [2]    = "[[",
}
CHECK[['alo\n123"']]
{
    type   = "string",
    start  = 1,
    finish = 11,
    [1]    = "alo\
123\"",
    [2]    = "'",
}
CHECK[['\97lo\10\04923"']]
{
    type   = "string",
    start  = 1,
    finish = 17,
    [1]    = "alo\
123\"",
    [2]    = "'",
}
CHECK[['\xff']]
{
    type   = "string",
    start  = 1,
    finish = 6,
    [1]    = "\xff",
    [2]    = "'",
}
CHECK[['\x1A']]
{
    type   = "string",
    start  = 1,
    finish = 6,
    [1]    = "\26",
    [2]    = "'",
}
CHECK[['\492']]
{
    type   = "string",
    start  = 1,
    finish = 6,
    [1]    = "",
    [2]    = "'",
}
CHECK[['\u{3b1}']]
{
    type   = "string",
    start  = 1,
    finish = 9,
    [1]    = "α",
    [2]    = "'",
}
CHECK[['\u{0}']]
{
    type   = "string",
    start  = 1,
    finish = 7,
    [1]    = "\0",
    [2]    = "'",
}
CHECK[['\u{ffffff}']]
{
    type   = "string",
    start  = 1,
    finish = 12,
    [1]    = "",
    [2]    = "'",
}
CHECK[=[[[
abcdef]]]=]
{
    type   = "string",
    start  = 1,
    finish = 11,
    [1]    = "abcdef",
    [2]    = "[[",
}

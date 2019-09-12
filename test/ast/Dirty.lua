CHECK'a.'
{
    [1] = {
        type   = "getname",
        start  = 1,
        finish = 1,
        [1]    = "a",
    },
    [2] = {
        type   = ".",
        start  = 2,
        finish = 2,
    },
    [3] = {
        type   = "getfield",
        start  = 1,
        finish = 2,
        parent = 1,
        dot    = 2,
    },
    [4] = {
        type = "main",
        [1]  = 3,
    },
}

CHECK'a:'
{
    [1] = {
        type   = "getname",
        start  = 1,
        finish = 1,
        [1]    = "a",
    },
    [2] = {
        type   = ":",
        start  = 2,
        finish = 2,
    },
    [3] = {
        type   = "getmethod",
        start  = 1,
        finish = 2,
        parent = 1,
        colon  = 2,
    },
    [4] = {
        type = "main",
        [1]  = 3,
    },
}

CHECK [[
if true
a
]]
{
    [1] = {
        type   = "boolean",
        start  = 4,
        finish = 7,
        [1]    = true,
    },
    [2] = {
        type   = "getname",
        start  = 9,
        finish = 9,
        [1]    = "a",
    },
    [3] = {
        type   = "ifblock",
        start  = 1,
        finish = 9,
        filter = 1,
        [1]    = 2,
    },
    [4] = {
        type   = "if",
        start  = 1,
        finish = 9,
        [1]    = 3,
    },
    [5] = {
        type = "main",
        [1]  = 4,
    },
}

CHECK [[
if true then
a
]]
{
    [1] = {
        type   = "boolean",
        start  = 4,
        finish = 7,
        [1]    = true,
    },
    [2] = {
        type   = "getname",
        start  = 14,
        finish = 14,
        [1]    = "a",
    },
    [3] = {
        type   = "ifblock",
        start  = 1,
        finish = 14,
        filter = 1,
        [1]    = 2,
    },
    [4] = {
        type   = "if",
        start  = 1,
        finish = 14,
        [1]    = 3,
    },
    [5] = {
        type = "main",
        [1]  = 4,
    },
}

CHECK [[
x =
]]
{
    [1] = {
        type   = "setname",
        start  = 1,
        finish = 1,
        [1]    = "x",
    },
    [2] = {
        type = "main",
        [1]  = 1,
    },
}

CHECK'1 == 2'
{
    [1] = {
        type   = "number",
        start  = 1,
        finish = 1,
        [1]    = 1,
    },
    [2] = {
        type   = "==",
        start  = 3,
        finish = 4,
    },
    [3] = {
        type   = "number",
        start  = 6,
        finish = 6,
        [1]    = 2,
    },
    [4] = {
        type   = "binary",
        start  = 1,
        finish = 6,
        op     = 2,
        [1]    = 1,
        [2]    = 3,
    },
    [5] = {
        type = "main",
        [1]  = 4,
    },
}

CHECK 'local function a'
{
    [1] = {
        type   = "local",
        start  = 16,
        finish = 16,
        [1]    = "a",
    },
    [2] = {
        type   = "function",
        start  = 1,
        finish = 16,
    },
    [3] = {
        type   = "setname",
        start  = 16,
        finish = 16,
        value  = 2,
        [1]    = "a",
    },
    [4] = {
        type = "main",
        [1]  = 1,
        [2]  = 3,
    },
}

CHECK 'local function'
{
    [1] = {
        type   = "function",
        start  = 1,
        finish = 14,
    },
    [2] = {
        type = "main",
    },
}

CHECK 'local function a(v'
{
    [1] = {
        type   = "local",
        start  = 16,
        finish = 16,
        [1]    = "a",
    },
    [2] = {
        type   = "name",
        start  = 18,
        finish = 18,
        [1]    = "v",
    },
    [3] = {
        type   = "funcargs",
        start  = 17,
        finish = 18,
        [1]    = 2,
    },
    [4] = {
        type   = "function",
        start  = 1,
        finish = 18,
        args   = 3,
    },
    [5] = {
        type   = "setname",
        start  = 16,
        finish = 16,
        value  = 4,
        [1]    = "a",
    },
    [6] = {
        type = "main",
        [1]  = 1,
        [2]  = 5,
    },
}

CHECK 'function a'
{
    [1] = {
        type   = "setname",
        start  = 10,
        finish = 10,
        value  = 2,
        [1]    = "a",
    },
    [2] = {
        type   = "function",
        start  = 1,
        finish = 10,
    },
    [3] = {
        type = "main",
        [1]  = 1,
    },
}

CHECK 'function a:'
{
    [1] = {
        type   = "getname",
        start  = 10,
        finish = 10,
        [1]    = "a",
    },
    [2] = {
        type   = ":",
        start  = 11,
        finish = 11,
    },
    [3] = {
        type   = "setmethod",
        start  = 10,
        finish = 11,
        parent = 1,
        colon  = 2,
        value  = 4,
    },
    [4] = {
        type   = "function",
        start  = 1,
        finish = 11,
    },
    [5] = {
        type = "main",
        [1]  = 3,
    },
}

CHECK 'function a:b(v'
{
    [1] = {
        type   = "getname",
        start  = 10,
        finish = 10,
        [1]    = "a",
    },
    [2] = {
        type   = ":",
        start  = 11,
        finish = 11,
    },
    [3] = {
        type   = "name",
        start  = 12,
        finish = 12,
        [1]    = "b",
    },
    [4] = {
        type   = "setmethod",
        start  = 10,
        finish = 12,
        parent = 1,
        colon  = 2,
        method = 3,
        value  = 7,
    },
    [5] = {
        type   = "name",
        start  = 14,
        finish = 14,
        [1]    = "v",
    },
    [6] = {
        type   = "funcargs",
        start  = 13,
        finish = 14,
        [1]    = 5,
    },
    [7] = {
        type   = "function",
        start  = 1,
        finish = 14,
        args   = 6,
    },
    [8] = {
        type = "main",
        [1]  = 4,
    },
}

CHECK 'return local a'
{
    [1] = {
        type   = "return",
        start  = 1,
        finish = 7,
    },
    [2] = {
        type   = "local",
        start  = 14,
        finish = 14,
        [1]    = "a",
    },
    [3] = {
        type = "main",
        [1]  = 1,
        [2]  = 2,
    },
}

CHECK 'end'
{
    [1] = {
        type = "main",
    },
}

CHECK 'local x = ,'
{
    [1] = {
        type   = "local",
        start  = 7,
        finish = 7,
        [1]    = "x",
    },
    [2] = {
        type = "main",
        [1]  = 1,
    },
}

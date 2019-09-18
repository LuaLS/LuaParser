CHECK'a.'
{
    [1] = {
        type = "main",
        [1]  = 2,
    },
    [2] = {
        type   = "getfield",
        start  = 1,
        finish = 2,
        parent = 1,
        node   = 3,
        dot    = {
            type   = ".",
            start  = 2,
            finish = 2,
        },
    },
    [3] = {
        type   = "getname",
        start  = 1,
        finish = 1,
        parent = 2,
        [1]    = "a",
    },
}

CHECK'a:'
{
    [1] = {
        type = "main",
        [1]  = 2,
    },
    [2] = {
        type   = "getmethod",
        start  = 1,
        finish = 2,
        parent = 1,
        node   = 3,
        colon  = {
            type   = ":",
            start  = 2,
            finish = 2,
        },
    },
    [3] = {
        type   = "getname",
        start  = 1,
        finish = 1,
        parent = 2,
        [1]    = "a",
    },
}

CHECK [[
if true
a
]]
{
    [1] = {
        type = "main",
        [1]  = 2,
    },
    [2] = {
        type   = "if",
        start  = 1,
        finish = 9,
        parent = 1,
        [1]    = 3,
    },
    [3] = {
        type   = "ifblock",
        start  = 1,
        finish = 9,
        parent = 2,
        filter = 4,
        [1]    = 5,
    },
    [4] = {
        type   = "boolean",
        start  = 4,
        finish = 7,
        parent = 3,
        [1]    = true,
    },
    [5] = {
        type   = "getname",
        start  = 9,
        finish = 9,
        parent = 3,
        [1]    = "a",
    },
}

CHECK [[
if true then
a
]]
{
    [1] = {
        type = "main",
        [1]  = 2,
    },
    [2] = {
        type   = "if",
        start  = 1,
        finish = 14,
        parent = 1,
        [1]    = 3,
    },
    [3] = {
        type   = "ifblock",
        start  = 1,
        finish = 14,
        parent = 2,
        filter = 4,
        [1]    = 5,
    },
    [4] = {
        type   = "boolean",
        start  = 4,
        finish = 7,
        parent = 3,
        [1]    = true,
    },
    [5] = {
        type   = "getname",
        start  = 14,
        finish = 14,
        parent = 3,
        [1]    = "a",
    },
}

CHECK [[
x =
]]
{
    [1] = {
        type = "main",
        [1]  = 2,
    },
    [2] = {
        type   = "setname",
        start  = 1,
        finish = 1,
        parent = 1,
        [1]    = "x",
    },
}

CHECK'1 == 2'
{
    [1] = {
        type = "main",
        [1]  = 2,
    },
    [2] = {
        type   = "binary",
        start  = 1,
        finish = 6,
        parent = 1,
        op     = {
            type   = "==",
            start  = 3,
            finish = 4,
        },
        [1]    = 3,
        [2]    = 4,
    },
    [3] = {
        type   = "number",
        start  = 1,
        finish = 1,
        parent = 2,
        [1]    = 1,
    },
    [4] = {
        type   = "number",
        start  = 6,
        finish = 6,
        parent = 2,
        [1]    = 2,
    },
}

CHECK 'local function a'
{
    [1] = {
        type = "main",
        [1]  = 2,
        [2]  = 3,
    },
    [2] = {
        type   = "local",
        start  = 16,
        finish = 16,
        parent = 1,
        [1]    = "a",
    },
    [3] = {
        type   = "setname",
        start  = 16,
        finish = 16,
        parent = 1,
        value  = 4,
        [1]    = "a",
    },
    [4] = {
        type   = "function",
        start  = 1,
        finish = 16,
        parent = 3,
    },
}

CHECK 'local function'
{
    [1] = {
        type = "main",
    },
}

CHECK 'local function a(v'
{
    [1] = {
        type = "main",
        [1]  = 2,
        [2]  = 3,
    },
    [2] = {
        type   = "local",
        start  = 16,
        finish = 16,
        parent = 1,
        [1]    = "a",
    },
    [3] = {
        type   = "setname",
        start  = 16,
        finish = 16,
        parent = 1,
        value  = 4,
        [1]    = "a",
    },
    [4] = {
        type   = "function",
        start  = 1,
        finish = 18,
        parent = 3,
        args   = 5,
    },
    [5] = {
        type   = "funcargs",
        start  = 17,
        finish = 18,
        parent = 4,
        [1]    = 6,
    },
    [6] = {
        type   = "local",
        start  = 18,
        finish = 18,
        parent = 5,
        [1]    = "v",
    },
}

CHECK 'function a'
{
    [1] = {
        type = "main",
        [1]  = 2,
    },
    [2] = {
        type   = "setname",
        start  = 10,
        finish = 10,
        parent = 1,
        value  = 3,
        [1]    = "a",
    },
    [3] = {
        type   = "function",
        start  = 1,
        finish = 10,
        parent = 2,
    },
}

CHECK 'function a:'
{
    [1] = {
        type = "main",
        [1]  = 2,
    },
    [2] = {
        type   = "setmethod",
        start  = 10,
        finish = 11,
        parent = 1,
        node   = 3,
        colon  = {
            type   = ":",
            start  = 11,
            finish = 11,
        },
        value  = 4,
    },
    [3] = {
        type   = "getname",
        start  = 10,
        finish = 10,
        parent = 2,
        [1]    = "a",
    },
    [4] = {
        type   = "function",
        start  = 1,
        finish = 11,
        parent = 2,
    },
}

CHECK 'function a:b(v'
{
    [1] = {
        type = "main",
        [1]  = 2,
    },
    [2] = {
        type   = "setmethod",
        start  = 10,
        finish = 12,
        parent = 1,
        node   = 3,
        colon  = {
            type   = ":",
            start  = 11,
            finish = 11,
        },
        method = 4,
        value  = 5,
    },
    [3] = {
        type   = "getname",
        start  = 10,
        finish = 10,
        parent = 2,
        [1]    = "a",
    },
    [4] = {
        type   = "method",
        start  = 12,
        finish = 12,
        parent = 2,
        [1]    = "b",
    },
    [5] = {
        type   = "function",
        start  = 1,
        finish = 14,
        parent = 2,
        args   = 6,
    },
    [6] = {
        type   = "funcargs",
        start  = 13,
        finish = 14,
        parent = 5,
        [1]    = 7,
    },
    [7] = {
        type   = "local",
        start  = 14,
        finish = 14,
        parent = 6,
        [1]    = "v",
    },
}

CHECK 'return local a'
{
    [1] = {
        type = "main",
        [1]  = 2,
        [2]  = 3,
    },
    [2] = {
        type   = "return",
        start  = 1,
        finish = 7,
        parent = 1,
    },
    [3] = {
        type   = "local",
        start  = 14,
        finish = 14,
        parent = 1,
        [1]    = "a",
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
        type = "main",
        [1]  = 2,
    },
    [2] = {
        type   = "local",
        start  = 7,
        finish = 7,
        parent = 1,
        [1]    = "x",
    },
}

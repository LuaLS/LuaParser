CHECK'a.'
{
    [1] = {
        type   = "name",
        start  = 1,
        finish = 1,
        [1]    = "a",
    },
    [2] = {
        type   = "getname",
        start  = 1,
        finish = 1,
        name   = 1,
    },
    [3] = {
        type   = ".",
        start  = 2,
        finish = 2,
    },
    [4] = {
        type   = "getfield",
        start  = 1,
        finish = 2,
        parent = 2,
        dot    = 3,
    },
    [5] = {
        type = "main",
        [1]  = 4,
    },
}

CHECK'a:'
{
    [1] = {
        type   = "name",
        start  = 1,
        finish = 1,
        [1]    = "a",
    },
    [2] = {
        type   = "getname",
        start  = 1,
        finish = 1,
        name   = 1,
    },
    [3] = {
        type   = ":",
        start  = 2,
        finish = 2,
    },
    [4] = {
        type   = "getmethod",
        start  = 1,
        finish = 2,
        parent = 2,
        colon  = 3,
    },
    [5] = {
        type = "main",
        [1]  = 4,
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
        type   = "name",
        start  = 9,
        finish = 9,
        [1]    = "a",
    },
    [3] = {
        type   = "getname",
        start  = 9,
        finish = 9,
        name   = 2,
    },
    [4] = {
        type = "main",
        [1]  = 1,
        [2]  = 3,
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
        type   = "name",
        start  = 14,
        finish = 14,
        [1]    = "a",
    },
    [3] = {
        type   = "getname",
        start  = 14,
        finish = 14,
        name   = 2,
    },
    [4] = {
        type   = "ifblock",
        start  = 1,
        finish = 14,
        filter = 1,
        [1]    = 3,
    },
    [5] = {
        type   = "if",
        start  = 1,
        finish = 14,
        [1]    = 4,
    },
    [6] = {
        type = "main",
        [1]  = 5,
    },
}

CHECK [[
x =
]]
{
    [1] = {
        type   = "name",
        start  = 1,
        finish = 1,
        [1]    = "x",
    },
    [2] = {
        type   = "setname",
        start  = 1,
        finish = 1,
        name   = 1,
    },
    [3] = {
        type = "main",
        [1]  = 2,
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
        type   = "name",
        start  = 16,
        finish = 16,
        [1]    = "a",
    },
    [2] = {
        type   = "setname",
        start  = 16,
        finish = 16,
        name   = 1,
        value  = 3,
    },
    [3] = {
        type   = "function",
        start  = 1,
        finish = 16,
    },
    [4] = {
        type   = "local",
        start  = 16,
        finish = 16,
        loc    = 1,
    },
    [5] = {
        type = "main",
        [1]  = 4,
        [2]  = 2,
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
        type   = "name",
        start  = 16,
        finish = 16,
        [1]    = "a",
    },
    [2] = {
        type   = "setname",
        start  = 16,
        finish = 16,
        name   = 1,
        value  = 5,
    },
    [3] = {
        type   = "name",
        start  = 18,
        finish = 18,
        [1]    = "v",
    },
    [4] = {
        type   = "funcargs",
        start  = 17,
        finish = 18,
        [1]    = 3,
    },
    [5] = {
        type   = "function",
        start  = 1,
        finish = 18,
        args   = 4,
    },
    [6] = {
        type   = "local",
        start  = 16,
        finish = 16,
        loc    = 1,
    },
    [7] = {
        type = "main",
        [1]  = 6,
        [2]  = 2,
    },
}

CHECK 'function a'
{
    [1] = {
        type   = "name",
        start  = 10,
        finish = 10,
        [1]    = "a",
    },
    [2] = {
        type   = "setname",
        start  = 10,
        finish = 10,
        name   = 1,
        value  = 3,
    },
    [3] = {
        type   = "function",
        start  = 1,
        finish = 10,
    },
    [4] = {
        type = "main",
        [1]  = 2,
    },
}

CHECK 'function a:'
{
    [1] = {
        type   = "name",
        start  = 10,
        finish = 10,
        [1]    = "a",
    },
    [2] = {
        type   = "getname",
        start  = 10,
        finish = 10,
        name   = 1,
    },
    [3] = {
        type   = ":",
        start  = 11,
        finish = 11,
    },
    [4] = {
        type   = "setmethod",
        start  = 10,
        finish = 11,
        parent = 2,
        colon  = 3,
        value  = 5,
    },
    [5] = {
        type   = "function",
        start  = 1,
        finish = 11,
    },
    [6] = {
        type = "main",
        [1]  = 4,
    },
}

CHECK 'function a:b(v'
{
    [1] = {
        type   = "name",
        start  = 10,
        finish = 10,
        [1]    = "a",
    },
    [2] = {
        type   = "getname",
        start  = 10,
        finish = 10,
        name   = 1,
    },
    [3] = {
        type   = ":",
        start  = 11,
        finish = 11,
    },
    [4] = {
        type   = "name",
        start  = 12,
        finish = 12,
        [1]    = "b",
    },
    [5] = {
        type   = "setmethod",
        start  = 10,
        finish = 12,
        parent = 2,
        colon  = 3,
        method = 4,
        value  = 8,
    },
    [6] = {
        type   = "name",
        start  = 14,
        finish = 14,
        [1]    = "v",
    },
    [7] = {
        type   = "funcargs",
        start  = 13,
        finish = 14,
        [1]    = 6,
    },
    [8] = {
        type   = "function",
        start  = 1,
        finish = 14,
        args   = 7,
    },
    [9] = {
        type = "main",
        [1]  = 5,
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
        type   = "name",
        start  = 14,
        finish = 14,
        [1]    = "a",
    },
    [3] = {
        type   = "local",
        start  = 14,
        finish = 14,
        loc    = 2,
    },
    [4] = {
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
        type   = "name",
        start  = 7,
        finish = 7,
        [1]    = "x",
    },
    [2] = {
        type   = "local",
        start  = 7,
        finish = 7,
        loc    = 1,
    },
    [3] = {
        type = "main",
        [1]  = 1,
    },
}

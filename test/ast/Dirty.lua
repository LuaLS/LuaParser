CHECK'a.'
{
    [1] = {
        type   = "main",
        start  = 1,
        finish = 2,
        locals = {
            [1] = 2,
        },
        [1]    = 3,
    },
    [2] = {
        type   = "local",
        start  = 0,
        finish = 0,
        effect = 0,
        parent = 1,
        [1]    = "_ENV",
    },
    [3] = {
        type   = "getfield",
        start  = 1,
        finish = 2,
        parent = 1,
        node   = 4,
        dot    = {
            type   = ".",
            start  = 2,
            finish = 2,
        },
    },
    [4] = {
        type   = "getglobal",
        start  = 1,
        finish = 1,
        parent = 3,
        [1]    = "a",
    },
}

CHECK'a:'
{
    [1] = {
        type   = "main",
        start  = 1,
        finish = 2,
        locals = {
            [1] = 2,
        },
        [1]    = 3,
    },
    [2] = {
        type   = "local",
        start  = 0,
        finish = 0,
        effect = 0,
        parent = 1,
        [1]    = "_ENV",
    },
    [3] = {
        type   = "getmethod",
        start  = 1,
        finish = 2,
        parent = 1,
        node   = 4,
        colon  = {
            type   = ":",
            start  = 2,
            finish = 2,
        },
    },
    [4] = {
        type   = "getglobal",
        start  = 1,
        finish = 1,
        parent = 3,
        [1]    = "a",
    },
}

CHECK [[
if true
a
]]
{
    [1] = {
        type   = "main",
        start  = 1,
        finish = 9,
        locals = {
            [1] = 2,
        },
        [1]    = 3,
    },
    [2] = {
        type   = "local",
        start  = 0,
        finish = 0,
        effect = 0,
        parent = 1,
        [1]    = "_ENV",
    },
    [3] = {
        type   = "if",
        start  = 1,
        finish = 9,
        parent = 1,
        [1]    = 4,
    },
    [4] = {
        type   = "ifblock",
        start  = 1,
        finish = 9,
        parent = 3,
        filter = 5,
        [1]    = 6,
    },
    [5] = {
        type   = "boolean",
        start  = 4,
        finish = 7,
        parent = 4,
        [1]    = true,
    },
    [6] = {
        type   = "getglobal",
        start  = 9,
        finish = 9,
        parent = 4,
        [1]    = "a",
    },
}

CHECK [[
if true then
a
]]
{
    [1] = {
        type   = "main",
        start  = 1,
        finish = 14,
        locals = {
            [1] = 2,
        },
        [1]    = 3,
    },
    [2] = {
        type   = "local",
        start  = 0,
        finish = 0,
        effect = 0,
        parent = 1,
        [1]    = "_ENV",
    },
    [3] = {
        type   = "if",
        start  = 1,
        finish = 14,
        parent = 1,
        [1]    = 4,
    },
    [4] = {
        type   = "ifblock",
        start  = 1,
        finish = 14,
        parent = 3,
        filter = 5,
        [1]    = 6,
    },
    [5] = {
        type   = "boolean",
        start  = 4,
        finish = 7,
        parent = 4,
        [1]    = true,
    },
    [6] = {
        type   = "getglobal",
        start  = 14,
        finish = 14,
        parent = 4,
        [1]    = "a",
    },
}

CHECK [[
x =
]]
{
    [1] = {
        type   = "main",
        start  = 1,
        finish = 4,
        locals = {
            [1] = 2,
        },
        [1]    = 3,
    },
    [2] = {
        type   = "local",
        start  = 0,
        finish = 0,
        effect = 0,
        parent = 1,
        [1]    = "_ENV",
    },
    [3] = {
        type   = "setglobal",
        start  = 1,
        finish = 1,
        parent = 1,
        [1]    = "x",
    },
}

CHECK'1 == 2'
{
    [1] = {
        type   = "main",
        start  = 1,
        finish = 6,
        locals = {
            [1] = 2,
        },
        [1]    = 3,
    },
    [2] = {
        type   = "local",
        start  = 0,
        finish = 0,
        effect = 0,
        parent = 1,
        [1]    = "_ENV",
    },
    [3] = {
        type   = "binary",
        start  = 1,
        finish = 6,
        parent = 1,
        op     = {
            type   = "==",
            start  = 3,
            finish = 4,
        },
        [1]    = 4,
        [2]    = 5,
    },
    [4] = {
        type   = "number",
        start  = 1,
        finish = 1,
        parent = 3,
        [1]    = 1,
    },
    [5] = {
        type   = "number",
        start  = 6,
        finish = 6,
        parent = 3,
        [1]    = 2,
    },
}

CHECK 'local function a'
{
    [1] = {
        type   = "main",
        start  = 1,
        finish = 16,
        locals = {
            [1] = 2,
            [2] = 3,
        },
        [1]    = 3,
    },
    [2] = {
        type   = "local",
        start  = 0,
        finish = 0,
        effect = 0,
        parent = 1,
        [1]    = "_ENV",
    },
    [3] = {
        type   = "local",
        start  = 16,
        finish = 16,
        effect = 1,
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
        type   = "main",
        start  = 1,
        finish = 14,
        locals = {
            [1] = 2,
        },
    },
    [2] = {
        type   = "local",
        start  = 0,
        finish = 0,
        effect = 0,
        parent = 1,
        [1]    = "_ENV",
    },
}

CHECK 'local function a(v'
{
    [1] = {
        type   = "main",
        start  = 1,
        finish = 18,
        locals = {
            [1] = 2,
            [2] = 3,
        },
        [1]    = 3,
    },
    [2] = {
        type   = "local",
        start  = 0,
        finish = 0,
        effect = 0,
        parent = 1,
        [1]    = "_ENV",
    },
    [3] = {
        type   = "local",
        start  = 16,
        finish = 16,
        effect = 1,
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
        locals = {
            [1] = 6,
        },
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
        effect = 18,
        parent = 5,
        [1]    = "v",
    },
}

CHECK 'function a'
{
    [1] = {
        type   = "main",
        start  = 1,
        finish = 10,
        locals = {
            [1] = 2,
        },
        [1]    = 3,
    },
    [2] = {
        type   = "local",
        start  = 0,
        finish = 0,
        effect = 0,
        parent = 1,
        [1]    = "_ENV",
    },
    [3] = {
        type   = "setglobal",
        start  = 10,
        finish = 10,
        parent = 1,
        value  = 4,
        [1]    = "a",
    },
    [4] = {
        type   = "function",
        start  = 1,
        finish = 10,
        parent = 3,
    },
}

CHECK 'function a:'
{
    [1] = {
        type   = "main",
        start  = 1,
        finish = 11,
        locals = {
            [1] = 2,
        },
        [1]    = 3,
    },
    [2] = {
        type   = "local",
        start  = 0,
        finish = 0,
        effect = 0,
        parent = 1,
        [1]    = "_ENV",
    },
    [3] = {
        type   = "setmethod",
        start  = 10,
        finish = 11,
        parent = 1,
        node   = 4,
        colon  = {
            type   = ":",
            start  = 11,
            finish = 11,
        },
        value  = 5,
    },
    [4] = {
        type   = "getglobal",
        start  = 10,
        finish = 10,
        parent = 3,
        [1]    = "a",
    },
    [5] = {
        type   = "function",
        start  = 1,
        finish = 11,
        parent = 3,
        locals = {
            [1] = 6,
        },
    },
    [6] = {
        type   = "local",
        start  = 0,
        finish = 0,
        effect = 11,
        parent = 5,
        [1]    = "self",
    },
}

CHECK 'function a:b(v'
{
    [1] = {
        type   = "main",
        start  = 1,
        finish = 14,
        locals = {
            [1] = 2,
        },
        [1]    = 3,
    },
    [2] = {
        type   = "local",
        start  = 0,
        finish = 0,
        effect = 0,
        parent = 1,
        [1]    = "_ENV",
    },
    [3] = {
        type   = "setmethod",
        start  = 10,
        finish = 12,
        parent = 1,
        node   = 4,
        colon  = {
            type   = ":",
            start  = 11,
            finish = 11,
        },
        method = 5,
        value  = 6,
    },
    [4] = {
        type   = "getglobal",
        start  = 10,
        finish = 10,
        parent = 3,
        [1]    = "a",
    },
    [5] = {
        type   = "method",
        start  = 12,
        finish = 12,
        parent = 3,
        [1]    = "b",
    },
    [6] = {
        type   = "function",
        start  = 1,
        finish = 14,
        parent = 3,
        args   = 8,
        locals = {
            [1] = 7,
            [2] = 9,
        },
    },
    [7] = {
        type   = "local",
        start  = 0,
        finish = 0,
        effect = 12,
        parent = 6,
        [1]    = "self",
    },
    [8] = {
        type   = "funcargs",
        start  = 13,
        finish = 14,
        parent = 6,
        [1]    = 9,
    },
    [9] = {
        type   = "local",
        start  = 14,
        finish = 14,
        effect = 14,
        parent = 8,
        [1]    = "v",
    },
}

CHECK 'return local a'
{
    [1] = {
        type   = "main",
        start  = 1,
        finish = 14,
        locals = {
            [1] = 2,
            [2] = 4,
        },
        [1]    = 3,
        [2]    = 4,
    },
    [2] = {
        type   = "local",
        start  = 0,
        finish = 0,
        effect = 0,
        parent = 1,
        [1]    = "_ENV",
    },
    [3] = {
        type   = "return",
        start  = 1,
        finish = 7,
        parent = 1,
    },
    [4] = {
        type   = "local",
        start  = 14,
        finish = 14,
        effect = 15,
        parent = 1,
        [1]    = "a",
    },
}

CHECK 'end'
{
    [1] = {
        type   = "main",
        start  = 1,
        finish = 3,
        locals = {
            [1] = 2,
        },
    },
    [2] = {
        type   = "local",
        start  = 0,
        finish = 0,
        effect = 0,
        parent = 1,
        [1]    = "_ENV",
    },
}

CHECK 'local x = ,'
{
    [1] = {
        type   = "main",
        start  = 1,
        finish = 11,
        locals = {
            [1] = 2,
            [2] = 3,
        },
        [1]    = 3,
    },
    [2] = {
        type   = "local",
        start  = 0,
        finish = 0,
        effect = 0,
        parent = 1,
        [1]    = "_ENV",
    },
    [3] = {
        type   = "local",
        start  = 7,
        finish = 7,
        effect = 12,
        parent = 1,
        [1]    = "x",
    },
}

CHECK 'local x = (a && b)'
{
    [1] = {
        type   = "main",
        start  = 1,
        finish = 18,
        locals = {
            [1] = 2,
            [2] = 3,
        },
        [1]    = 3,
    },
    [2] = {
        type   = "local",
        start  = 0,
        finish = 0,
        effect = 0,
        parent = 1,
        [1]    = "_ENV",
    },
    [3] = {
        type   = "local",
        start  = 7,
        finish = 7,
        effect = 19,
        parent = 1,
        value  = 4,
        [1]    = "x",
    },
    [4] = {
        type   = "paren",
        start  = 11,
        finish = 18,
        parent = 3,
        exp    = 5,
    },
    [5] = {
        type   = "binary",
        start  = 12,
        finish = 17,
        parent = 4,
        op     = {
            type   = "&",
            start  = 15,
            finish = 15,
        },
        [1]    = 6,
        [2]    = 7,
    },
    [6] = {
        type   = "getglobal",
        start  = 12,
        finish = 12,
        parent = 5,
        [1]    = "a",
    },
    [7] = {
        type   = "getglobal",
        start  = 17,
        finish = 17,
        parent = 5,
        [1]    = "b",
    },
}

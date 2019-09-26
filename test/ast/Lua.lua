CHECK''
{
    [1] = {
        type   = "main",
        start  = 1,
        finish = 0,
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

CHECK';;;'
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

CHECK';;;x = 1'
{
    [1] = {
        type   = "main",
        start  = 1,
        finish = 8,
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
        ref    = {
            [1] = 3,
        },
        [1]    = "_ENV",
    },
    [3] = {
        type   = "setglobal",
        start  = 4,
        finish = 4,
        parent = 1,
        node   = 2,
        value  = 4,
        [1]    = "x",
    },
    [4] = {
        type   = "number",
        start  = 8,
        finish = 8,
        parent = 3,
        [1]    = 1,
    },
}
CHECK'x, y, z = 1, 2, 3'
{
    [1] = {
        type   = "main",
        start  = 1,
        finish = 17,
        locals = {
            [1] = 2,
        },
        [1]    = 3,
        [2]    = 5,
        [3]    = 7,
    },
    [2] = {
        type   = "local",
        start  = 0,
        finish = 0,
        effect = 0,
        parent = 1,
        ref    = {
            [1] = 3,
            [2] = 5,
            [3] = 7,
        },
        [1]    = "_ENV",
    },
    [3] = {
        type   = "setglobal",
        start  = 1,
        finish = 1,
        parent = 1,
        node   = 2,
        value  = 4,
        [1]    = "x",
    },
    [4] = {
        type   = "number",
        start  = 11,
        finish = 11,
        parent = 3,
        [1]    = 1,
    },
    [5] = {
        type   = "setglobal",
        start  = 4,
        finish = 4,
        parent = 1,
        node   = 2,
        value  = 6,
        [1]    = "y",
    },
    [6] = {
        type   = "number",
        start  = 14,
        finish = 14,
        parent = 5,
        [1]    = 2,
    },
    [7] = {
        type   = "setglobal",
        start  = 7,
        finish = 7,
        parent = 1,
        node   = 2,
        value  = 8,
        [1]    = "z",
    },
    [8] = {
        type   = "number",
        start  = 17,
        finish = 17,
        parent = 7,
        [1]    = 3,
    },
}
CHECK'local x, y, z'
{
    [1] = {
        type   = "main",
        start  = 1,
        finish = 13,
        locals = {
            [1] = 2,
            [2] = 3,
            [3] = 4,
            [4] = 5,
        },
        [1]    = 3,
        [2]    = 4,
        [3]    = 5,
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
        effect = 14,
        parent = 1,
        [1]    = "x",
    },
    [4] = {
        type   = "local",
        start  = 10,
        finish = 10,
        effect = 14,
        parent = 1,
        [1]    = "y",
    },
    [5] = {
        type   = "local",
        start  = 13,
        finish = 13,
        effect = 14,
        parent = 1,
        [1]    = "z",
    },
}
CHECK'local x, y, z = 1, 2, 3'
{
    [1] = {
        type   = "main",
        start  = 1,
        finish = 23,
        locals = {
            [1] = 2,
            [2] = 3,
            [3] = 5,
            [4] = 7,
        },
        [1]    = 3,
        [2]    = 5,
        [3]    = 7,
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
        effect = 24,
        parent = 1,
        value  = 4,
        [1]    = "x",
    },
    [4] = {
        type   = "number",
        start  = 17,
        finish = 17,
        parent = 3,
        [1]    = 1,
    },
    [5] = {
        type   = "local",
        start  = 10,
        finish = 10,
        effect = 24,
        parent = 1,
        value  = 6,
        [1]    = "y",
    },
    [6] = {
        type   = "number",
        start  = 20,
        finish = 20,
        parent = 5,
        [1]    = 2,
    },
    [7] = {
        type   = "local",
        start  = 13,
        finish = 13,
        effect = 24,
        parent = 1,
        value  = 8,
        [1]    = "z",
    },
    [8] = {
        type   = "number",
        start  = 23,
        finish = 23,
        parent = 7,
        [1]    = 3,
    },
}
CHECK'local x, y = y, x'
{
    [1] = {
        type   = "main",
        start  = 1,
        finish = 17,
        locals = {
            [1] = 2,
            [2] = 3,
            [3] = 5,
        },
        [1]    = 3,
        [2]    = 5,
    },
    [2] = {
        type   = "local",
        start  = 0,
        finish = 0,
        effect = 0,
        parent = 1,
        ref    = {
            [1] = 4,
            [2] = 6,
        },
        [1]    = "_ENV",
    },
    [3] = {
        type   = "local",
        start  = 7,
        finish = 7,
        effect = 18,
        parent = 1,
        value  = 4,
        [1]    = "x",
    },
    [4] = {
        type   = "getglobal",
        start  = 14,
        finish = 14,
        parent = 3,
        node   = 2,
        [1]    = "y",
    },
    [5] = {
        type   = "local",
        start  = 10,
        finish = 10,
        effect = 18,
        parent = 1,
        value  = 6,
        [1]    = "y",
    },
    [6] = {
        type   = "getglobal",
        start  = 17,
        finish = 17,
        parent = 5,
        node   = 2,
        [1]    = "x",
    },
}
CHECK'local x, y = f()'
{
    [1] = {
        type   = "main",
        start  = 1,
        finish = 16,
        locals = {
            [1] = 2,
            [2] = 3,
            [3] = 7,
        },
        [1]    = 3,
        [2]    = 7,
    },
    [2] = {
        type   = "local",
        start  = 0,
        finish = 0,
        effect = 0,
        parent = 1,
        ref    = {
            [1] = 6,
        },
        [1]    = "_ENV",
    },
    [3] = {
        type   = "local",
        start  = 7,
        finish = 7,
        effect = 17,
        parent = 1,
        value  = 4,
        [1]    = "x",
    },
    [4] = {
        type   = "select",
        parent = 3,
        vararg = 5,
        index  = 1,
    },
    [5] = {
        type      = "call",
        start     = 14,
        finish    = 16,
        parent    = 4,
        extParent = {
            [1] = 8,
        },
        node      = 6,
    },
    [6] = {
        type   = "getglobal",
        start  = 14,
        finish = 14,
        parent = 5,
        node   = 2,
        [1]    = "f",
    },
    [7] = {
        type   = "local",
        start  = 10,
        finish = 10,
        effect = 17,
        parent = 1,
        value  = 8,
        [1]    = "y",
    },
    [8] = {
        type   = "select",
        parent = 7,
        vararg = 5,
        index  = 2,
    },
}
CHECK'local x, y = (f())'
{
    [1] = {
        type   = "main",
        start  = 1,
        finish = 18,
        locals = {
            [1] = 2,
            [2] = 3,
            [3] = 7,
        },
        [1]    = 3,
        [2]    = 7,
    },
    [2] = {
        type   = "local",
        start  = 0,
        finish = 0,
        effect = 0,
        parent = 1,
        ref    = {
            [1] = 6,
        },
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
        start  = 14,
        finish = 18,
        parent = 3,
        exp    = 5,
    },
    [5] = {
        type   = "call",
        start  = 15,
        finish = 17,
        parent = 4,
        node   = 6,
    },
    [6] = {
        type   = "getglobal",
        start  = 15,
        finish = 15,
        parent = 5,
        node   = 2,
        [1]    = "f",
    },
    [7] = {
        type   = "local",
        start  = 10,
        finish = 10,
        effect = 19,
        parent = 1,
        [1]    = "y",
    },
}
CHECK'local x, y = f(), nil'
{
    [1] = {
        type   = "main",
        start  = 1,
        finish = 21,
        locals = {
            [1] = 2,
            [2] = 3,
            [3] = 7,
        },
        [1]    = 3,
        [2]    = 7,
    },
    [2] = {
        type   = "local",
        start  = 0,
        finish = 0,
        effect = 0,
        parent = 1,
        ref    = {
            [1] = 6,
        },
        [1]    = "_ENV",
    },
    [3] = {
        type   = "local",
        start  = 7,
        finish = 7,
        effect = 22,
        parent = 1,
        value  = 4,
        [1]    = "x",
    },
    [4] = {
        type   = "select",
        parent = 3,
        vararg = 5,
        index  = 1,
    },
    [5] = {
        type   = "call",
        start  = 14,
        finish = 16,
        parent = 4,
        node   = 6,
    },
    [6] = {
        type   = "getglobal",
        start  = 14,
        finish = 14,
        parent = 5,
        node   = 2,
        [1]    = "f",
    },
    [7] = {
        type   = "local",
        start  = 10,
        finish = 10,
        effect = 22,
        parent = 1,
        value  = 8,
        [1]    = "y",
    },
    [8] = {
        type   = "nil",
        start  = 19,
        finish = 21,
        parent = 7,
    },
}
CHECK'local x, y = ...'
{
    [1] = {
        type   = "main",
        start  = 1,
        finish = 16,
        locals = {
            [1] = 2,
            [2] = 3,
            [3] = 6,
        },
        [1]    = 3,
        [2]    = 6,
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
        effect = 17,
        parent = 1,
        value  = 4,
        [1]    = "x",
    },
    [4] = {
        type   = "select",
        parent = 3,
        vararg = 5,
        index  = 1,
    },
    [5] = {
        type      = "varargs",
        start     = 14,
        finish    = 16,
        parent    = 4,
        extParent = {
            [1] = 7,
        },
    },
    [6] = {
        type   = "local",
        start  = 10,
        finish = 10,
        effect = 17,
        parent = 1,
        value  = 7,
        [1]    = "y",
    },
    [7] = {
        type   = "select",
        parent = 6,
        vararg = 5,
        index  = 2,
    },
}
CHECK'local x, y = (...)'
{
    [1] = {
        type   = "main",
        start  = 1,
        finish = 18,
        locals = {
            [1] = 2,
            [2] = 3,
            [3] = 6,
        },
        [1]    = 3,
        [2]    = 6,
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
        start  = 14,
        finish = 18,
        parent = 3,
        exp    = 5,
    },
    [5] = {
        type   = "varargs",
        start  = 15,
        finish = 17,
        parent = 4,
    },
    [6] = {
        type   = "local",
        start  = 10,
        finish = 10,
        effect = 19,
        parent = 1,
        [1]    = "y",
    },
}
CHECK'local x, y = ..., nil'
{
    [1] = {
        type   = "main",
        start  = 1,
        finish = 21,
        locals = {
            [1] = 2,
            [2] = 3,
            [3] = 6,
        },
        [1]    = 3,
        [2]    = 6,
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
        effect = 22,
        parent = 1,
        value  = 4,
        [1]    = "x",
    },
    [4] = {
        type   = "select",
        parent = 3,
        vararg = 5,
        index  = 1,
    },
    [5] = {
        type   = "varargs",
        start  = 14,
        finish = 16,
        parent = 4,
    },
    [6] = {
        type   = "local",
        start  = 10,
        finish = 10,
        effect = 22,
        parent = 1,
        value  = 7,
        [1]    = "y",
    },
    [7] = {
        type   = "nil",
        start  = 19,
        finish = 21,
        parent = 6,
    },
}
CHECK'local x <const>, y <close> = 1'
{
    [1] = {
        type   = "main",
        start  = 1,
        finish = 30,
        locals = {
            [1] = 2,
            [2] = 3,
            [3] = 6,
        },
        [1]    = 3,
        [2]    = 6,
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
        effect = 31,
        parent = 1,
        value  = 5,
        attrs  = {
            [1] = 4,
        },
        [1]    = "x",
    },
    [4] = {
        type   = "localattr",
        start  = 10,
        finish = 14,
        parent = 3,
        [1]    = "const",
    },
    [5] = {
        type   = "number",
        start  = 30,
        finish = 30,
        parent = 3,
        [1]    = 1,
    },
    [6] = {
        type   = "local",
        start  = 18,
        finish = 18,
        effect = 31,
        parent = 1,
        attrs  = {
            [1] = 7,
        },
        [1]    = "y",
    },
    [7] = {
        type   = "localattr",
        start  = 21,
        finish = 25,
        parent = 6,
        [1]    = "close",
    },
}
CHECK[[
x = 1
y = 2
]]
{
    [1] = {
        type   = "main",
        start  = 1,
        finish = 11,
        locals = {
            [1] = 2,
        },
        [1]    = 3,
        [2]    = 5,
    },
    [2] = {
        type   = "local",
        start  = 0,
        finish = 0,
        effect = 0,
        parent = 1,
        ref    = {
            [1] = 3,
            [2] = 5,
        },
        [1]    = "_ENV",
    },
    [3] = {
        type   = "setglobal",
        start  = 1,
        finish = 1,
        parent = 1,
        node   = 2,
        value  = 4,
        [1]    = "x",
    },
    [4] = {
        type   = "number",
        start  = 5,
        finish = 5,
        parent = 3,
        [1]    = 1,
    },
    [5] = {
        type   = "setglobal",
        start  = 7,
        finish = 7,
        parent = 1,
        node   = 2,
        value  = 6,
        [1]    = "y",
    },
    [6] = {
        type   = "number",
        start  = 11,
        finish = 11,
        parent = 5,
        [1]    = 2,
    },
}

CHECK[[
x, y = 1, 2
]]
{
    [1] = {
        type   = "main",
        start  = 1,
        finish = 11,
        locals = {
            [1] = 2,
        },
        [1]    = 3,
        [2]    = 5,
    },
    [2] = {
        type   = "local",
        start  = 0,
        finish = 0,
        effect = 0,
        parent = 1,
        ref    = {
            [1] = 3,
            [2] = 5,
        },
        [1]    = "_ENV",
    },
    [3] = {
        type   = "setglobal",
        start  = 1,
        finish = 1,
        parent = 1,
        node   = 2,
        value  = 4,
        [1]    = "x",
    },
    [4] = {
        type   = "number",
        start  = 8,
        finish = 8,
        parent = 3,
        [1]    = 1,
    },
    [5] = {
        type   = "setglobal",
        start  = 4,
        finish = 4,
        parent = 1,
        node   = 2,
        value  = 6,
        [1]    = "y",
    },
    [6] = {
        type   = "number",
        start  = 11,
        finish = 11,
        parent = 5,
        [1]    = 2,
    },
}
CHECK[[
local function a()
    return
end]]
{
    [1] = {
        type   = "main",
        start  = 1,
        finish = 33,
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
        finish = 33,
        parent = 3,
        [1]    = 5,
    },
    [5] = {
        type   = "return",
        start  = 24,
        finish = 30,
        parent = 4,
    },
}
CHECK[[
local function f()
    return f()
end]]
{
    [1] = {
        type   = "main",
        start  = 1,
        finish = 37,
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
        ref    = {
            [1] = 7,
        },
        [1]    = "f",
    },
    [4] = {
        type   = "function",
        start  = 1,
        finish = 37,
        parent = 3,
        [1]    = 5,
    },
    [5] = {
        type   = "return",
        start  = 24,
        finish = 33,
        parent = 4,
        [1]    = 6,
    },
    [6] = {
        type   = "call",
        start  = 31,
        finish = 33,
        parent = 5,
        node   = 7,
    },
    [7] = {
        type   = "getlocal",
        start  = 31,
        finish = 31,
        parent = 6,
        loc    = 3,
        [1]    = "f",
    },
}
CHECK[[
local function a(b, c)
    return
end]]
{
    [1] = {
        type   = "main",
        start  = 1,
        finish = 37,
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
        finish = 37,
        parent = 3,
        args   = 5,
        locals = {
            [1] = 6,
            [2] = 7,
        },
        [1]    = 8,
    },
    [5] = {
        type   = "funcargs",
        start  = 17,
        finish = 22,
        parent = 4,
        [1]    = 6,
        [2]    = 7,
    },
    [6] = {
        type   = "local",
        start  = 18,
        finish = 18,
        effect = 18,
        parent = 5,
        [1]    = "b",
    },
    [7] = {
        type   = "local",
        start  = 21,
        finish = 21,
        effect = 21,
        parent = 5,
        [1]    = "c",
    },
    [8] = {
        type   = "return",
        start  = 28,
        finish = 34,
        parent = 4,
    },
}

CHECK[[
local x, y, z = 1, 2
local function f()
end
y, z = 3, 4
]]
{
    [01] = {
        type   = "main",
        start  = 1,
        finish = 55,
        locals = {
            [1] = 2,
            [2] = 3,
            [3] = 5,
            [4] = 7,
            [5] = 8,
        },
        [1]    = 3,
        [2]    = 5,
        [3]    = 7,
        [4]    = 8,
        [5]    = 10,
        [6]    = 12,
    },
    [02] = {
        type   = "local",
        start  = 0,
        finish = 0,
        effect = 0,
        parent = 1,
        [1]    = "_ENV",
    },
    [03] = {
        type   = "local",
        start  = 7,
        finish = 7,
        effect = 21,
        parent = 1,
        value  = 4,
        [1]    = "x",
    },
    [04] = {
        type   = "number",
        start  = 17,
        finish = 17,
        parent = 3,
        [1]    = 1,
    },
    [05] = {
        type   = "local",
        start  = 10,
        finish = 10,
        effect = 21,
        parent = 1,
        value  = 6,
        ref    = {
            [1] = 10,
        },
        [1]    = "y",
    },
    [06] = {
        type   = "number",
        start  = 20,
        finish = 20,
        parent = 5,
        [1]    = 2,
    },
    [07] = {
        type   = "local",
        start  = 13,
        finish = 13,
        effect = 21,
        parent = 1,
        ref    = {
            [1] = 12,
        },
        [1]    = "z",
    },
    [08] = {
        type   = "local",
        start  = 37,
        finish = 37,
        effect = 22,
        parent = 1,
        value  = 9,
        [1]    = "f",
    },
    [09] = {
        type   = "function",
        start  = 22,
        finish = 43,
        parent = 8,
    },
    [10] = {
        type   = "setlocal",
        start  = 45,
        finish = 45,
        parent = 1,
        loc    = 5,
        value  = 11,
        [1]    = "y",
    },
    [11] = {
        type   = "number",
        start  = 52,
        finish = 52,
        parent = 10,
        [1]    = 3,
    },
    [12] = {
        type   = "setlocal",
        start  = 48,
        finish = 48,
        parent = 1,
        loc    = 7,
        value  = 13,
        [1]    = "z",
    },
    [13] = {
        type   = "number",
        start  = 55,
        finish = 55,
        parent = 12,
        [1]    = 4,
    },
}

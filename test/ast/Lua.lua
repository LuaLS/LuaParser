CHECK''
{
    [1] = {
        type = "main",
    },
}

CHECK';;;'
{
    [1] = {
        type = "main",
    },
}

CHECK';;;x = 1'
{
    [1] = {
        type = "main",
        [1]  = 2,
    },
    [2] = {
        type   = "setname",
        start  = 4,
        finish = 4,
        parent = 1,
        value  = 3,
        [1]    = "x",
    },
    [3] = {
        type   = "number",
        start  = 8,
        finish = 8,
        parent = 2,
        [1]    = 1,
    },
}
CHECK'x, y, z = 1, 2, 3'
{
    [1] = {
        type = "main",
        [1]  = 2,
        [2]  = 4,
        [3]  = 6,
    },
    [2] = {
        type   = "setname",
        start  = 1,
        finish = 1,
        parent = 1,
        value  = 3,
        [1]    = "x",
    },
    [3] = {
        type   = "number",
        start  = 11,
        finish = 11,
        parent = 2,
        [1]    = 1,
    },
    [4] = {
        type   = "setname",
        start  = 4,
        finish = 4,
        parent = 1,
        value  = 5,
        [1]    = "y",
    },
    [5] = {
        type   = "number",
        start  = 14,
        finish = 14,
        parent = 4,
        [1]    = 2,
    },
    [6] = {
        type   = "setname",
        start  = 7,
        finish = 7,
        parent = 1,
        value  = 7,
        [1]    = "z",
    },
    [7] = {
        type   = "number",
        start  = 17,
        finish = 17,
        parent = 6,
        [1]    = 3,
    },
}
CHECK'local x, y, z'
{
    [1] = {
        type = "main",
        [1]  = 2,
        [2]  = 3,
        [3]  = 4,
    },
    [2] = {
        type   = "local",
        start  = 7,
        finish = 7,
        parent = 1,
        [1]    = "x",
    },
    [3] = {
        type   = "local",
        start  = 10,
        finish = 10,
        parent = 1,
        [1]    = "y",
    },
    [4] = {
        type   = "local",
        start  = 13,
        finish = 13,
        parent = 1,
        [1]    = "z",
    },
}
CHECK'local x, y, z = 1, 2, 3'
{
    [1] = {
        type = "main",
        [1]  = 2,
        [2]  = 4,
        [3]  = 6,
    },
    [2] = {
        type   = "local",
        start  = 7,
        finish = 7,
        parent = 1,
        value  = 3,
        [1]    = "x",
    },
    [3] = {
        type   = "number",
        start  = 17,
        finish = 17,
        parent = 2,
        [1]    = 1,
    },
    [4] = {
        type   = "local",
        start  = 10,
        finish = 10,
        parent = 1,
        value  = 5,
        [1]    = "y",
    },
    [5] = {
        type   = "number",
        start  = 20,
        finish = 20,
        parent = 4,
        [1]    = 2,
    },
    [6] = {
        type   = "local",
        start  = 13,
        finish = 13,
        parent = 1,
        value  = 7,
        [1]    = "z",
    },
    [7] = {
        type   = "number",
        start  = 23,
        finish = 23,
        parent = 6,
        [1]    = 3,
    },
}
CHECK'local x, y = f()'
{
    [1] = {
        type = "main",
        [1]  = 2,
        [2]  = 6,
    },
    [2] = {
        type   = "local",
        start  = 7,
        finish = 7,
        parent = 1,
        value  = 3,
        [1]    = "x",
    },
    [3] = {
        type   = "select",
        parent = 2,
        vararg = 4,
        index  = 1,
    },
    [4] = {
        type      = "call",
        start     = 14,
        finish    = 16,
        parent    = 3,
        extParent = {
            [1] = 7,
        },
        node      = 5,
    },
    [5] = {
        type   = "getname",
        start  = 14,
        finish = 14,
        parent = 4,
        [1]    = "f",
    },
    [6] = {
        type   = "local",
        start  = 10,
        finish = 10,
        parent = 1,
        value  = 7,
        [1]    = "y",
    },
    [7] = {
        type   = "select",
        parent = 6,
        vararg = 4,
        index  = 2,
    },
}
CHECK'local x, y = (f())'
{
    [1] = {
        type = "main",
        [1]  = 2,
        [2]  = 6,
    },
    [2] = {
        type   = "local",
        start  = 7,
        finish = 7,
        parent = 1,
        value  = 3,
        [1]    = "x",
    },
    [3] = {
        type   = "paren",
        start  = 14,
        finish = 18,
        parent = 2,
        exp    = 4,
    },
    [4] = {
        type   = "call",
        start  = 15,
        finish = 17,
        parent = 3,
        node   = 5,
    },
    [5] = {
        type   = "getname",
        start  = 15,
        finish = 15,
        parent = 4,
        [1]    = "f",
    },
    [6] = {
        type   = "local",
        start  = 10,
        finish = 10,
        parent = 1,
        [1]    = "y",
    },
}
CHECK'local x, y = f(), nil'
{
    [1] = {
        type = "main",
        [1]  = 2,
        [2]  = 6,
    },
    [2] = {
        type   = "local",
        start  = 7,
        finish = 7,
        parent = 1,
        value  = 3,
        [1]    = "x",
    },
    [3] = {
        type   = "select",
        parent = 2,
        vararg = 4,
        index  = 1,
    },
    [4] = {
        type   = "call",
        start  = 14,
        finish = 16,
        parent = 3,
        node   = 5,
    },
    [5] = {
        type   = "getname",
        start  = 14,
        finish = 14,
        parent = 4,
        [1]    = "f",
    },
    [6] = {
        type   = "local",
        start  = 10,
        finish = 10,
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
CHECK'local x, y = ...'
{
    [1] = {
        type = "main",
        [1]  = 2,
        [2]  = 5,
    },
    [2] = {
        type   = "local",
        start  = 7,
        finish = 7,
        parent = 1,
        value  = 3,
        [1]    = "x",
    },
    [3] = {
        type   = "select",
        parent = 2,
        vararg = 4,
        index  = 1,
    },
    [4] = {
        type      = "varargs",
        start     = 14,
        finish    = 16,
        parent    = 3,
        extParent = {
            [1] = 6,
        },
    },
    [5] = {
        type   = "local",
        start  = 10,
        finish = 10,
        parent = 1,
        value  = 6,
        [1]    = "y",
    },
    [6] = {
        type   = "select",
        parent = 5,
        vararg = 4,
        index  = 2,
    },
}
CHECK'local x, y = (...)'
{
    [1] = {
        type = "main",
        [1]  = 2,
        [2]  = 5,
    },
    [2] = {
        type   = "local",
        start  = 7,
        finish = 7,
        parent = 1,
        value  = 3,
        [1]    = "x",
    },
    [3] = {
        type   = "paren",
        start  = 14,
        finish = 18,
        parent = 2,
        exp    = 4,
    },
    [4] = {
        type   = "varargs",
        start  = 15,
        finish = 17,
        parent = 3,
    },
    [5] = {
        type   = "local",
        start  = 10,
        finish = 10,
        parent = 1,
        [1]    = "y",
    },
}
CHECK'local x, y = ..., nil'
{
    [1] = {
        type = "main",
        [1]  = 2,
        [2]  = 5,
    },
    [2] = {
        type   = "local",
        start  = 7,
        finish = 7,
        parent = 1,
        value  = 3,
        [1]    = "x",
    },
    [3] = {
        type   = "select",
        parent = 2,
        vararg = 4,
        index  = 1,
    },
    [4] = {
        type   = "varargs",
        start  = 14,
        finish = 16,
        parent = 3,
    },
    [5] = {
        type   = "local",
        start  = 10,
        finish = 10,
        parent = 1,
        value  = 6,
        [1]    = "y",
    },
    [6] = {
        type   = "nil",
        start  = 19,
        finish = 21,
        parent = 5,
    },
}
CHECK'local x <const>, y <close> = 1'
{
    [1] = {
        type = "main",
        [1]  = 2,
        [2]  = 5,
    },
    [2] = {
        type   = "local",
        start  = 7,
        finish = 7,
        parent = 1,
        value  = 4,
        attrs  = {
            [1] = 3,
        },
        [1]    = "x",
    },
    [3] = {
        type   = "localattr",
        start  = 10,
        finish = 14,
        parent = 2,
        [1]    = "const",
    },
    [4] = {
        type   = "number",
        start  = 30,
        finish = 30,
        parent = 2,
        [1]    = 1,
    },
    [5] = {
        type   = "local",
        start  = 18,
        finish = 18,
        parent = 1,
        attrs  = {
            [1] = 6,
        },
        [1]    = "y",
    },
    [6] = {
        type   = "localattr",
        start  = 21,
        finish = 25,
        parent = 5,
        [1]    = "close",
    },
}
CHECK[[
x = 1
y = 2
]]
{
    [1] = {
        type = "main",
        [1]  = 2,
        [2]  = 4,
    },
    [2] = {
        type   = "setname",
        start  = 1,
        finish = 1,
        parent = 1,
        value  = 3,
        [1]    = "x",
    },
    [3] = {
        type   = "number",
        start  = 5,
        finish = 5,
        parent = 2,
        [1]    = 1,
    },
    [4] = {
        type   = "setname",
        start  = 7,
        finish = 7,
        parent = 1,
        value  = 5,
        [1]    = "y",
    },
    [5] = {
        type   = "number",
        start  = 11,
        finish = 11,
        parent = 4,
        [1]    = 2,
    },
}

CHECK[[
x, y = 1, 2
]]
{
    [1] = {
        type = "main",
        [1]  = 2,
        [2]  = 4,
    },
    [2] = {
        type   = "setname",
        start  = 1,
        finish = 1,
        parent = 1,
        value  = 3,
        [1]    = "x",
    },
    [3] = {
        type   = "number",
        start  = 8,
        finish = 8,
        parent = 2,
        [1]    = 1,
    },
    [4] = {
        type   = "setname",
        start  = 4,
        finish = 4,
        parent = 1,
        value  = 5,
        [1]    = "y",
    },
    [5] = {
        type   = "number",
        start  = 11,
        finish = 11,
        parent = 4,
        [1]    = 2,
    },
}

CHECK[[
local function a()
    return
end]]
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
local function a(b, c)
    return
end]]
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
        finish = 37,
        parent = 3,
        args   = 5,
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
        parent = 5,
        [1]    = "b",
    },
    [7] = {
        type   = "local",
        start  = 21,
        finish = 21,
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
        type = "main",
        [1]  = 2,
        [2]  = 4,
        [3]  = 6,
        [4]  = 7,
        [5]  = 8,
        [6]  = 10,
        [7]  = 12,
    },
    [02] = {
        type   = "local",
        start  = 7,
        finish = 7,
        parent = 1,
        value  = 3,
        [1]    = "x",
    },
    [03] = {
        type   = "number",
        start  = 17,
        finish = 17,
        parent = 2,
        [1]    = 1,
    },
    [04] = {
        type   = "local",
        start  = 10,
        finish = 10,
        parent = 1,
        value  = 5,
        [1]    = "y",
    },
    [05] = {
        type   = "number",
        start  = 20,
        finish = 20,
        parent = 4,
        [1]    = 2,
    },
    [06] = {
        type   = "local",
        start  = 13,
        finish = 13,
        parent = 1,
        [1]    = "z",
    },
    [07] = {
        type   = "local",
        start  = 37,
        finish = 37,
        parent = 1,
        [1]    = "f",
    },
    [08] = {
        type   = "setname",
        start  = 37,
        finish = 37,
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
        type   = "setname",
        start  = 45,
        finish = 45,
        parent = 1,
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
        type   = "setname",
        start  = 48,
        finish = 48,
        parent = 1,
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

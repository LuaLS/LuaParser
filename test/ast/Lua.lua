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
        type   = "setname",
        start  = 4,
        finish = 4,
        value  = 2,
        [1]    = "x",
    },
    [2] = {
        type   = "number",
        start  = 8,
        finish = 8,
        [1]    = 1,
    },
    [3] = {
        type = "main",
        [1]  = 1,
    },
}

CHECK[[
x = 1
y = 2
]]
{
    [1] = {
        type   = "setname",
        start  = 1,
        finish = 1,
        value  = 2,
        [1]    = "x",
    },
    [2] = {
        type   = "number",
        start  = 5,
        finish = 5,
        [1]    = 1,
    },
    [3] = {
        type   = "setname",
        start  = 7,
        finish = 7,
        value  = 4,
        [1]    = "y",
    },
    [4] = {
        type   = "number",
        start  = 11,
        finish = 11,
        [1]    = 2,
    },
    [5] = {
        type = "main",
        [1]  = 1,
        [2]  = 3,
    },
}

CHECK[[
x, y = 1, 2
]]
{
    [1] = {
        type   = "setname",
        start  = 1,
        finish = 1,
        value  = 3,
        [1]    = "x",
    },
    [2] = {
        type   = "setname",
        start  = 4,
        finish = 4,
        value  = 4,
        [1]    = "y",
    },
    [3] = {
        type   = "number",
        start  = 8,
        finish = 8,
        [1]    = 1,
    },
    [4] = {
        type   = "number",
        start  = 11,
        finish = 11,
        [1]    = 2,
    },
    [5] = {
        type = "main",
        [1]  = 1,
        [2]  = 2,
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
        type   = "local",
        start  = 7,
        finish = 7,
        value  = 4,
        [1]    = "x",
    },
    [02] = {
        type   = "local",
        start  = 10,
        finish = 10,
        value  = 5,
        [1]    = "y",
    },
    [03] = {
        type   = "local",
        start  = 13,
        finish = 13,
        [1]    = "z",
    },
    [04] = {
        type   = "number",
        start  = 17,
        finish = 17,
        [1]    = 1,
    },
    [05] = {
        type   = "number",
        start  = 20,
        finish = 20,
        [1]    = 2,
    },
    [06] = {
        type   = "local",
        start  = 37,
        finish = 37,
        [1]    = "f",
    },
    [07] = {
        type   = "funcargs",
        start  = 38,
        finish = 39,
    },
    [08] = {
        type   = "function",
        start  = 22,
        finish = 43,
        args   = 7,
    },
    [09] = {
        type   = "setname",
        start  = 37,
        finish = 37,
        value  = 8,
        [1]    = "f",
    },
    [10] = {
        type   = "setname",
        start  = 45,
        finish = 45,
        value  = 12,
        [1]    = "y",
    },
    [11] = {
        type   = "setname",
        start  = 48,
        finish = 48,
        value  = 13,
        [1]    = "z",
    },
    [12] = {
        type   = "number",
        start  = 52,
        finish = 52,
        [1]    = 3,
    },
    [13] = {
        type   = "number",
        start  = 55,
        finish = 55,
        [1]    = 4,
    },
    [14] = {
        type = "main",
        [1]  = 1,
        [2]  = 2,
        [3]  = 3,
        [4]  = 6,
        [5]  = 9,
        [6]  = 10,
        [7]  = 11,
    },
}

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
        type   = "name",
        start  = 4,
        finish = 4,
        [1]    = "x",
    },
    [2] = {
        value  = 3,
        type   = "setname",
        start  = 4,
        name   = 1,
        finish = 4,
    },
    [3] = {
        type   = "number",
        start  = 8,
        finish = 8,
        [1]    = 1,
    },
    [4] = {
        type = "main",
        [1]  = 2,
    },
}

CHECK[[
x = 1
y = 2
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
        value  = 3,
    },
    [3] = {
        type   = "number",
        start  = 5,
        finish = 5,
        [1]    = 1,
    },
    [4] = {
        type   = "name",
        start  = 7,
        finish = 7,
        [1]    = "y",
    },
    [5] = {
        type   = "setname",
        start  = 7,
        finish = 7,
        name   = 4,
        value  = 6,
    },
    [6] = {
        type   = "number",
        start  = 11,
        finish = 11,
        [1]    = 2,
    },
    [7] = {
        type = "main",
        [1]  = 2,
        [2]  = 5,
    },
}

CHECK[[
x, y = 1, 2
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
        value  = 5,
    },
    [3] = {
        type   = "name",
        start  = 4,
        finish = 4,
        [1]    = "y",
    },
    [4] = {
        type   = "setname",
        start  = 4,
        finish = 4,
        name   = 3,
        value  = 6,
    },
    [5] = {
        type   = "number",
        start  = 8,
        finish = 8,
        [1]    = 1,
    },
    [6] = {
        type   = "number",
        start  = 11,
        finish = 11,
        [1]    = 2,
    },
    [7] = {
        type = "main",
        [1]  = 2,
        [2]  = 4,
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
        type   = "name",
        start  = 7,
        finish = 7,
        [1]    = "x",
    },
    [02] = {
        type   = "name",
        start  = 10,
        finish = 10,
        [1]    = "y",
    },
    [03] = {
        type   = "name",
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
        start  = 7,
        finish = 7,
        loc    = 1,
        value  = 4,
    },
    [07] = {
        type   = "local",
        start  = 10,
        finish = 10,
        loc    = 2,
        value  = 5,
    },
    [08] = {
        type   = "local",
        start  = 13,
        finish = 13,
        loc    = 3,
    },
    [09] = {
        type   = "name",
        start  = 37,
        finish = 37,
        [1]    = "f",
    },
    [10] = {
        type   = "setname",
        start  = 37,
        finish = 37,
        name   = 9,
        value  = 12,
    },
    [11] = {
        type   = "funcargs",
        start  = 38,
        finish = 39,
    },
    [12] = {
        type   = "function",
        start  = 22,
        finish = 43,
        args   = 11,
    },
    [13] = {
        type   = "local",
        start  = 37,
        finish = 37,
        loc    = 9,
    },
    [14] = {
        type   = "name",
        start  = 45,
        finish = 45,
        [1]    = "y",
    },
    [15] = {
        type   = "setname",
        start  = 45,
        finish = 45,
        name   = 14,
        value  = 18,
    },
    [16] = {
        type   = "name",
        start  = 48,
        finish = 48,
        [1]    = "z",
    },
    [17] = {
        type   = "setname",
        start  = 48,
        finish = 48,
        name   = 16,
        value  = 19,
    },
    [18] = {
        type   = "number",
        start  = 52,
        finish = 52,
        [1]    = 3,
    },
    [19] = {
        type   = "number",
        start  = 55,
        finish = 55,
        [1]    = 4,
    },
    [20] = {
        type = "main",
        [1]  = 1,
        [2]  = 2,
        [3]  = 3,
        [4]  = 13,
        [5]  = 10,
        [6]  = 15,
        [7]  = 17,
    },
}

CHECK''
{
    type   = "main",
    start  = 0,
    finish = 0,
    locals = "<IGNORE>",
}

CHECK';;;'
{
    type   = "main",
    start  = 0,
    finish = 3,
    locals = "<IGNORE>",
}

CHECK';;;x = 1'
{
    type   = "main",
    start  = 0,
    finish = 8,
    locals = "<IGNORE>",
    [1]    = {
        type   = "setglobal",
        start  = 3,
        finish = 4,
        range  = 8,
        parent = "<IGNORE>",
        node   = "<IGNORE>",
        value  = {
            type   = "integer",
            start  = 7,
            finish = 8,
            parent = "<IGNORE>",
            [1]    = 1,
        },
        [1]    = "x",
    },
}
CHECK'x, y, z = 1, 2, 3'
{
    type   = "main",
    start  = 0,
    finish = 17,
    locals = "<IGNORE>",
    [1]    = {
        type   = "setglobal",
        start  = 0,
        finish = 1,
        range  = 11,
        parent = "<IGNORE>",
        node   = "<IGNORE>",
        value  = {
            type   = "integer",
            start  = 10,
            finish = 11,
            parent = "<IGNORE>",
            [1]    = 1,
        },
        [1]    = "x",
    },
    [2]    = {
        type   = "setglobal",
        start  = 3,
        finish = 4,
        range  = 14,
        parent = "<IGNORE>",
        node   = "<IGNORE>",
        value  = {
            type   = "integer",
            start  = 13,
            finish = 14,
            parent = "<IGNORE>",
            [1]    = 2,
        },
        [1]    = "y",
    },
    [3]    = {
        type   = "setglobal",
        start  = 6,
        finish = 7,
        range  = 17,
        parent = "<IGNORE>",
        node   = "<IGNORE>",
        value  = {
            type   = "integer",
            start  = 16,
            finish = 17,
            parent = "<IGNORE>",
            [1]    = 3,
        },
        [1]    = "z",
    },
}
CHECK'local x, y, z'
{
    type   = "main",
    start  = 0,
    finish = 13,
    locals = "<IGNORE>",
    [1]    = {
        type   = "local",
        start  = 6,
        finish = 7,
        effect = 13,
        parent = "<IGNORE>",
        [1]    = "x",
    },
    [2]    = {
        type   = "local",
        start  = 9,
        finish = 10,
        effect = 13,
        parent = "<IGNORE>",
        [1]    = "y",
    },
    [3]    = {
        type   = "local",
        start  = 12,
        finish = 13,
        effect = 13,
        parent = "<IGNORE>",
        [1]    = "z",
    },
}
CHECK'local x, y, z = 1, 2, 3'
{
    type   = "main",
    start  = 0,
    finish = 23,
    locals = "<IGNORE>",
    [1]    = {
        type   = "local",
        start  = 6,
        finish = 7,
        effect = 23,
        range  = 17,
        parent = "<IGNORE>",
        value  = {
            type   = "integer",
            start  = 16,
            finish = 17,
            parent = "<IGNORE>",
            [1]    = 1,
        },
        [1]    = "x",
    },
    [2]    = {
        type   = "local",
        start  = 9,
        finish = 10,
        effect = 23,
        range  = 20,
        parent = "<IGNORE>",
        value  = {
            type   = "integer",
            start  = 19,
            finish = 20,
            parent = "<IGNORE>",
            [1]    = 2,
        },
        [1]    = "y",
    },
    [3]    = {
        type   = "local",
        start  = 12,
        finish = 13,
        effect = 23,
        range  = 23,
        parent = "<IGNORE>",
        value  = {
            type   = "integer",
            start  = 22,
            finish = 23,
            parent = "<IGNORE>",
            [1]    = 3,
        },
        [1]    = "z",
    },
}
CHECK'local x, y = y, x'
{
    type   = "main",
    start  = 0,
    finish = 17,
    locals = "<IGNORE>",
    [1]    = {
        type   = "local",
        start  = 6,
        finish = 7,
        effect = 17,
        range  = 14,
        parent = "<IGNORE>",
        value  = {
            type   = "getglobal",
            start  = 13,
            finish = 14,
            parent = "<IGNORE>",
            node   = "<IGNORE>",
            [1]    = "y",
        },
        [1]    = "x",
    },
    [2]    = {
        type   = "local",
        start  = 9,
        finish = 10,
        effect = 17,
        range  = 17,
        parent = "<IGNORE>",
        value  = {
            type   = "getglobal",
            start  = 16,
            finish = 17,
            parent = "<IGNORE>",
            node   = "<IGNORE>",
            [1]    = "x",
        },
        [1]    = "y",
    },
}
CHECK'local x, y = f()'
{
    type   = "main",
    start  = 0,
    finish = 16,
    locals = "<IGNORE>",
    [1]    = {
        type   = "local",
        start  = 6,
        finish = 7,
        effect = 16,
        range  = 16,
        parent = "<IGNORE>",
        value  = {
            sindex = 1,
            type   = "select",
            start  = 13,
            finish = 16,
            parent = "<IGNORE>",
            vararg = {
                type      = "call",
                start     = 13,
                finish    = 16,
                parent    = "<IGNORE>",
                extParent = "<IGNORE>",
                node      = "<IGNORE>",
            },
        },
        [1]    = "x",
    },
    [2]    = {
        type   = "local",
        start  = 9,
        finish = 10,
        effect = 16,
        range  = 16,
        parent = "<IGNORE>",
        value  = {
            sindex = 2,
            type   = "select",
            start  = 13,
            finish = 16,
            parent = "<IGNORE>",
            vararg = {
                type      = "call",
                start     = 13,
                finish    = 16,
                parent    = "<IGNORE>",
                extParent = "<IGNORE>",
                node      = "<IGNORE>",
            },
        },
        [1]    = "y",
    },
}
CHECK'local x, y = (f())'
{
    type   = "main",
    start  = 0,
    finish = 18,
    locals = "<IGNORE>",
    [1]    = {
        type   = "local",
        start  = 6,
        finish = 7,
        effect = 18,
        range  = 18,
        parent = "<IGNORE>",
        value  = {
            type   = "paren",
            start  = 13,
            finish = 18,
            parent = "<IGNORE>",
            exp    = {
                type   = "call",
                start  = 14,
                finish = 17,
                parent = "<IGNORE>",
                node   = "<IGNORE>",
            },
        },
        [1]    = "x",
    },
    [2]    = {
        type   = "local",
        start  = 9,
        finish = 10,
        effect = 18,
        parent = "<IGNORE>",
        [1]    = "y",
    },
}
CHECK'local x, y = f(), nil'
{
    type   = "main",
    start  = 0,
    finish = 21,
    locals = "<IGNORE>",
    [1]    = {
        type   = "local",
        start  = 6,
        finish = 7,
        effect = 21,
        range  = 16,
        parent = "<IGNORE>",
        value  = {
            sindex = 1,
            type   = "select",
            start  = 13,
            finish = 16,
            parent = "<IGNORE>",
            vararg = {
                type   = "call",
                start  = 13,
                finish = 16,
                parent = "<IGNORE>",
                node   = "<IGNORE>",
            },
        },
        [1]    = "x",
    },
    [2]    = {
        type   = "local",
        start  = 9,
        finish = 10,
        effect = 21,
        range  = 21,
        parent = "<IGNORE>",
        value  = {
            type   = "nil",
            start  = 18,
            finish = 21,
            parent = "<IGNORE>",
        },
        [1]    = "y",
    },
}
CHECK'local x, y = ...'
{
    type   = "main",
    start  = 0,
    finish = 16,
    locals = "<IGNORE>",
    [1]    = {
        type   = "local",
        start  = 6,
        finish = 7,
        effect = 16,
        range  = 16,
        parent = "<IGNORE>",
        value  = {
            sindex = 1,
            type   = "select",
            start  = 13,
            finish = 16,
            parent = "<IGNORE>",
            vararg = {
                type      = "varargs",
                start     = 13,
                finish    = 16,
                parent    = "<IGNORE>",
                extParent = "<IGNORE>",
            },
        },
        [1]    = "x",
    },
    [2]    = {
        type   = "local",
        start  = 9,
        finish = 10,
        effect = 16,
        range  = 16,
        parent = "<IGNORE>",
        value  = {
            sindex = 2,
            type   = "select",
            start  = 13,
            finish = 16,
            parent = "<IGNORE>",
            vararg = {
                type      = "varargs",
                start     = 13,
                finish    = 16,
                parent    = "<IGNORE>",
                extParent = "<IGNORE>",
            },
        },
        [1]    = "y",
    },
}
CHECK'local x, y = (...)'
{
    type   = "main",
    start  = 0,
    finish = 18,
    locals = "<IGNORE>",
    [1]    = {
        type   = "local",
        start  = 6,
        finish = 7,
        effect = 18,
        range  = 18,
        parent = "<IGNORE>",
        value  = {
            type   = "paren",
            start  = 13,
            finish = 18,
            parent = "<IGNORE>",
            exp    = {
                type   = "varargs",
                start  = 14,
                finish = 17,
                parent = "<IGNORE>",
            },
        },
        [1]    = "x",
    },
    [2]    = {
        type   = "local",
        start  = 9,
        finish = 10,
        effect = 18,
        parent = "<IGNORE>",
        [1]    = "y",
    },
}
CHECK'local x, y = ..., nil'
{
    type   = "main",
    start  = 0,
    finish = 21,
    locals = "<IGNORE>",
    [1]    = {
        type   = "local",
        start  = 6,
        finish = 7,
        effect = 21,
        range  = 16,
        parent = "<IGNORE>",
        value  = {
            sindex = 1,
            type   = "select",
            start  = 13,
            finish = 16,
            parent = "<IGNORE>",
            vararg = {
                type   = "varargs",
                start  = 13,
                finish = 16,
                parent = "<IGNORE>",
            },
        },
        [1]    = "x",
    },
    [2]    = {
        type   = "local",
        start  = 9,
        finish = 10,
        effect = 21,
        range  = 21,
        parent = "<IGNORE>",
        value  = {
            type   = "nil",
            start  = 18,
            finish = 21,
            parent = "<IGNORE>",
        },
        [1]    = "y",
    },
}
CHECK'local x <const>, y <close> = 1'
{
    type   = "main",
    start  = 0,
    finish = 30,
    locals = "<IGNORE>",
    [1]    = {
        type   = "local",
        start  = 6,
        finish = 7,
        effect = 30,
        range  = 30,
        parent = "<IGNORE>",
        value  = {
            type   = "integer",
            start  = 29,
            finish = 30,
            parent = "<IGNORE>",
            [1]    = 1,
        },
        attrs  = {
            [1] = {
                type   = "localattr",
                start  = 8,
                finish = 15,
                parent = "<IGNORE>",
                [1]    = "const",
            },
        },
        [1]    = "x",
    },
    [2]    = {
        type   = "local",
        start  = 17,
        finish = 18,
        effect = 30,
        parent = "<IGNORE>",
        attrs  = {
            [1] = {
                type   = "localattr",
                start  = 19,
                finish = 26,
                parent = "<IGNORE>",
                [1]    = "close",
            },
        },
        [1]    = "y",
    },
}
CHECK[[
x = 1
y = 2
]]
{
    type   = "main",
    start  = 0,
    finish = 20000,
    locals = "<IGNORE>",
    [1]    = {
        type   = "setglobal",
        start  = 0,
        finish = 1,
        range  = 5,
        parent = "<IGNORE>",
        node   = "<IGNORE>",
        value  = {
            type   = "integer",
            start  = 4,
            finish = 5,
            parent = "<IGNORE>",
            [1]    = 1,
        },
        [1]    = "x",
    },
    [2]    = {
        type   = "setglobal",
        start  = 10000,
        finish = 10001,
        range  = 10005,
        parent = "<IGNORE>",
        node   = "<IGNORE>",
        value  = {
            type   = "integer",
            start  = 10004,
            finish = 10005,
            parent = "<IGNORE>",
            [1]    = 2,
        },
        [1]    = "y",
    },
}

CHECK[[
x, y = 1, 2
]]
{
    type   = "main",
    start  = 0,
    finish = 10000,
    locals = "<IGNORE>",
    [1]    = {
        type   = "setglobal",
        start  = 0,
        finish = 1,
        range  = 8,
        parent = "<IGNORE>",
        node   = "<IGNORE>",
        value  = {
            type   = "integer",
            start  = 7,
            finish = 8,
            parent = "<IGNORE>",
            [1]    = 1,
        },
        [1]    = "x",
    },
    [2]    = {
        type   = "setglobal",
        start  = 3,
        finish = 4,
        range  = 11,
        parent = "<IGNORE>",
        node   = "<IGNORE>",
        value  = {
            type   = "integer",
            start  = 10,
            finish = 11,
            parent = "<IGNORE>",
            [1]    = 2,
        },
        [1]    = "y",
    },
}
CHECK[[
local function a()
    return
end]]
{
    type   = "main",
    start  = 0,
    finish = 20003,
    locals = "<IGNORE>",
    [1]    = {
        type   = "local",
        start  = 15,
        vstart = 6,
        finish = 16,
        effect = 16,
        range  = 20003,
        parent = "<IGNORE>",
        value  = {
            type    = "function",
            start   = 6,
            finish  = 20003,
            keyword = {
                [1] = 6,
                [2] = 14,
                [3] = 20000,
                [4] = 20003,
            },
            parent  = "<IGNORE>",
            returns = "<IGNORE>",
            [1]     = {
                type   = "return",
                start  = 10004,
                finish = 10010,
                parent = "<IGNORE>",
            },
        },
        [1]    = "a",
    },
}
CHECK[[
local function f()
    return f()
end]]
{
    type   = "main",
    start  = 0,
    finish = 20003,
    locals = "<IGNORE>",
    [1]    = {
        type   = "local",
        start  = 15,
        vstart = 6,
        finish = 16,
        effect = 16,
        range  = 20003,
        parent = "<IGNORE>",
        value  = {
            type    = "function",
            start   = 6,
            finish  = 20003,
            keyword = {
                [1] = 6,
                [2] = 14,
                [3] = 20000,
                [4] = 20003,
            },
            parent  = "<IGNORE>",
            returns = "<IGNORE>",
            [1]     = {
                type   = "return",
                start  = 10004,
                finish = 10014,
                parent = "<IGNORE>",
                [1]    = {
                    type   = "call",
                    start  = 10011,
                    finish = 10014,
                    parent = "<IGNORE>",
                    node   = "<IGNORE>",
                },
            },
        },
        ref    = "<IGNORE>",
        [1]    = "f",
    },
}
CHECK[[
local function a(b, c)
    return
end]]
{
    type   = "main",
    start  = 0,
    finish = 20003,
    locals = "<IGNORE>",
    [1]    = {
        type   = "local",
        start  = 15,
        vstart = 6,
        finish = 16,
        effect = 16,
        range  = 20003,
        parent = "<IGNORE>",
        value  = {
            type    = "function",
            start   = 6,
            finish  = 20003,
            keyword = {
                [1] = 6,
                [2] = 14,
                [3] = 20000,
                [4] = 20003,
            },
            parent  = "<IGNORE>",
            args    = {
                type   = "funcargs",
                start  = 16,
                finish = 22,
                parent = "<IGNORE>",
                [1]    = {
                    type   = "local",
                    start  = 17,
                    finish = 18,
                    effect = 18,
                    parent = "<IGNORE>",
                    [1]    = "b",
                },
                [2]    = {
                    type   = "local",
                    start  = 20,
                    finish = 21,
                    effect = 21,
                    parent = "<IGNORE>",
                    [1]    = "c",
                },
            },
            locals  = "<IGNORE>",
            returns = "<IGNORE>",
            [1]     = {
                type   = "return",
                start  = 10004,
                finish = 10010,
                parent = "<IGNORE>",
            },
        },
        [1]    = "a",
    },
}

CHECK[[
local x, y, z = 1, 2
local function f()
end
y, z = 3, 4
]]
{
    type   = "main",
    start  = 0,
    finish = 40000,
    locals = "<IGNORE>",
    [1]    = {
        type   = "local",
        start  = 6,
        finish = 7,
        effect = 10000,
        range  = 17,
        parent = "<IGNORE>",
        value  = {
            type   = "integer",
            start  = 16,
            finish = 17,
            parent = "<IGNORE>",
            [1]    = 1,
        },
        [1]    = "x",
    },
    [2]    = {
        type   = "local",
        start  = 9,
        finish = 10,
        effect = 20,
        range  = 20,
        parent = "<IGNORE>",
        value  = {
            type   = "integer",
            start  = 19,
            finish = 20,
            parent = "<IGNORE>",
            [1]    = 2,
        },
        ref    = "<IGNORE>",
        [1]    = "y",
    },
    [3]    = {
        type   = "local",
        start  = 12,
        finish = 13,
        effect = 10000,
        parent = "<IGNORE>",
        ref    = "<IGNORE>",
        [1]    = "z",
    },
    [4]    = {
        type   = "local",
        start  = 10015,
        vstart = 10006,
        finish = 10016,
        effect = 10016,
        range  = 20003,
        parent = "<IGNORE>",
        value  = {
            type    = "function",
            start   = 10006,
            finish  = 20003,
            keyword = {
                [1] = 10006,
                [2] = 10014,
                [3] = 20000,
                [4] = 20003,
            },
            parent  = "<IGNORE>",
        },
        [1]    = "f",
    },
    [5]    = {
        type   = "setlocal",
        start  = 30000,
        finish = 30001,
        range  = 30008,
        parent = "<IGNORE>",
        node   = "<IGNORE>",
        value  = {
            type   = "integer",
            start  = 30007,
            finish = 30008,
            parent = "<IGNORE>",
            [1]    = 3,
        },
        [1]    = "y",
    },
    [6]    = {
        type   = "setlocal",
        start  = 30003,
        finish = 30004,
        range  = 30011,
        parent = "<IGNORE>",
        node   = "<IGNORE>",
        value  = {
            type   = "integer",
            start  = 30010,
            finish = 30011,
            parent = "<IGNORE>",
            [1]    = 4,
        },
        [1]    = "z",
    },
}
CHECK[[
local f = require
local z = f
z'xxx'
]]
{
    type   = "main",
    start  = 0,
    finish = 30000,
    locals = "<IGNORE>",
    [1]    = {
        type   = "local",
        start  = 6,
        finish = 7,
        effect = 10000,
        range  = 17,
        parent = "<IGNORE>",
        value  = {
            type    = "getglobal",
            start   = 10,
            finish  = 17,
            special = "require",
            parent  = "<IGNORE>",
            node    = "<IGNORE>",
            [1]     = "require",
        },
        ref    = "<IGNORE>",
        [1]    = "f",
    },
    [2]    = {
        type   = "local",
        start  = 10006,
        finish = 10007,
        effect = 20000,
        range  = 10011,
        parent = "<IGNORE>",
        value  = {
            type   = "getlocal",
            start  = 10010,
            finish = 10011,
            parent = "<IGNORE>",
            node   = "<IGNORE>",
            [1]    = "f",
        },
        ref    = "<IGNORE>",
        [1]    = "z",
    },
    [3]    = {
        type   = "call",
        start  = 20000,
        finish = 20006,
        parent = "<IGNORE>",
        node   = "<IGNORE>",
        args   = {
            type   = "callargs",
            start  = 20001,
            finish = 20006,
            parent = "<IGNORE>",
            [1]    = {
                type   = "string",
                start  = 20001,
                finish = 20006,
                parent = "<IGNORE>",
                [1]    = "xxx",
                [2]    = "'",
            },
        },
    },
}
CHECK[[
A:B(1):C(2)
]]
{
    type   = "main",
    start  = 0,
    finish = 10000,
    locals = "<IGNORE>",
    [1]    = {
        type   = "call",
        start  = 0,
        finish = 11,
        parent = "<IGNORE>",
        node   = "<IGNORE>",
        args   = {
            type   = "callargs",
            start  = 8,
            finish = 11,
            parent = "<IGNORE>",
            [1]    = {
                next   = "<IGNORE>",
                type   = "call",
                start  = 0,
                finish = 6,
                parent = "<IGNORE>",
                mirror = "<IGNORE>",
                dummy  = true,
                node   = "<IGNORE>",
                args   = {
                    type   = "callargs",
                    start  = 3,
                    finish = 6,
                    parent = "<IGNORE>",
                    [1]    = {
                        next   = "<IGNORE>",
                        type   = "getglobal",
                        start  = 0,
                        finish = 1,
                        parent = "<IGNORE>",
                        mirror = "<IGNORE>",
                        dummy  = true,
                        node   = "<IGNORE>",
                        [1]    = "A",
                    },
                    [2]    = {
                        type   = "integer",
                        start  = 4,
                        finish = 5,
                        parent = "<IGNORE>",
                        [1]    = 1,
                    },
                },
            },
            [2]    = {
                type   = "integer",
                start  = 9,
                finish = 10,
                parent = "<IGNORE>",
                [1]    = 2,
            },
        },
    },
}

CHECK [[
f(x: number, y?: table<number, boolean>, z?: number|boolean, 1)
]]
{
    type   = "main",
    start  = 1,
    finish = 63,
    locals = "<IGNORE>",
    [1]    = {
        type   = "call",
        start  = 1,
        finish = 63,
        parent = "<IGNORE>",
        node   = "<IGNORE>",
        args   = {
            type   = "callargs",
            start  = 2,
            finish = 63,
            parent = "<IGNORE>",
            [1]    = {
                type   = "name",
                start  = 3,
                finish = 3,
                parent = "<IGNORE>",
                [1]    = "x",
            },
            [2]    = {
                type   = "name",
                start  = 14,
                finish = 14,
                parent = "<IGNORE>",
                [1]    = "y",
            },
            [3]    = {
                type   = "name",
                start  = 42,
                finish = 42,
                parent = "<IGNORE>",
                [1]    = "z",
            },
            [4]    = {
                type   = "integer",
                start  = 62,
                finish = 62,
                parent = "<IGNORE>",
                [1]    = 1,
            },
        },
    },
}

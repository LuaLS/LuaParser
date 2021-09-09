CHECK'a.'
{
    type   = "main",
    start  = 0,
    finish = 2,
    locals = "<IGNORE>",
    [1]    = {
        type   = "getfield",
        start  = 0,
        finish = 2,
        parent = "<IGNORE>",
        node   = "<IGNORE>",
        dot    = {
            type   = ".",
            start  = 1,
            finish = 2,
        },
    },
}

CHECK'a:'
{
    type   = "main",
    start  = 0,
    finish = 2,
    locals = "<IGNORE>",
    [1]    = {
        type   = "getmethod",
        start  = 0,
        finish = 2,
        parent = "<IGNORE>",
        node   = "<IGNORE>",
        colon  = {
            type   = ":",
            start  = 1,
            finish = 2,
        },
    },
}

CHECK [[
if true
a
]]
{
    type   = "main",
    start  = 0,
    finish = 20000,
    locals = "<IGNORE>",
    [1]    = {
        type   = "if",
        start  = 0,
        finish = 10001,
        parent = "<IGNORE>",
        [1]    = {
            type    = "ifblock",
            start   = 0,
            finish  = 10001,
            keyword = {
                [1] = 0,
                [2] = 2,
            },
            parent  = "<IGNORE>",
            filter  = {
                type   = "boolean",
                start  = 3,
                finish = 7,
                parent = "<IGNORE>",
                [1]    = true,
            },
            [1]     = {
                type   = "getglobal",
                start  = 10000,
                finish = 10001,
                parent = "<IGNORE>",
                node   = "<IGNORE>",
                [1]    = "a",
            },
        },
    },
}

CHECK [[
if true then
a
]]
{
    type   = "main",
    start  = 0,
    finish = 20000,
    locals = "<IGNORE>",
    [1]    = {
        type   = "if",
        start  = 0,
        finish = 10001,
        parent = "<IGNORE>",
        [1]    = {
            type    = "ifblock",
            start   = 0,
            finish  = 10001,
            keyword = {
                [1] = 0,
                [2] = 2,
                [3] = 8,
                [4] = 12,
            },
            parent  = "<IGNORE>",
            filter  = {
                type   = "boolean",
                start  = 3,
                finish = 7,
                parent = "<IGNORE>",
                [1]    = true,
            },
            [1]     = {
                type   = "getglobal",
                start  = 10000,
                finish = 10001,
                parent = "<IGNORE>",
                node   = "<IGNORE>",
                [1]    = "a",
            },
        },
    },
}

CHECK [[
x =
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
        parent = "<IGNORE>",
        node   = "<IGNORE>",
        [1]    = "x",
    },
}

CHECK'1 == 2'
{
    type   = "main",
    start  = 0,
    finish = 6,
    locals = "<IGNORE>",
    [1]    = {
        type   = "binary",
        start  = 0,
        finish = 6,
        parent = "<IGNORE>",
        op     = {
            type   = "==",
            start  = 2,
            finish = 4,
        },
        [1]    = {
            type   = "integer",
            start  = 0,
            finish = 1,
            parent = "<IGNORE>",
            [1]    = 1,
        },
        [2]    = {
            type   = "integer",
            start  = 5,
            finish = 6,
            parent = "<IGNORE>",
            [1]    = 2,
        },
    },
}

CHECK 'local function a'
{
    type   = "main",
    start  = 0,
    finish = 16,
    locals = "<IGNORE>",
    [1]    = {
        type   = "local",
        start  = 15,
        vstart = 6,
        finish = 16,
        effect = 16,
        range  = 16,
        parent = "<IGNORE>",
        value  = {
            type    = "function",
            start   = 6,
            finish  = 16,
            keyword = {
                [1] = 6,
                [2] = 14,
            },
            parent  = "<IGNORE>",
        },
        [1]    = "a",
    },
}

CHECK 'local function'
{
    type   = "main",
    start  = 0,
    finish = 14,
    locals = "<IGNORE>",
    [1]    = {
        type    = "function",
        start   = 6,
        finish  = 14,
        keyword = {
            [1] = 6,
            [2] = 14,
        },
        parent  = "<IGNORE>",
    },
}

CHECK 'local function a(v'
{
    type   = "main",
    start  = 0,
    finish = 18,
    locals = "<IGNORE>",
    [1]    = {
        type   = "local",
        start  = 15,
        vstart = 6,
        finish = 16,
        effect = 16,
        range  = 18,
        parent = "<IGNORE>",
        value  = {
            type    = "function",
            start   = 6,
            finish  = 18,
            keyword = {
                [1] = 6,
                [2] = 14,
            },
            parent  = "<IGNORE>",
            args    = {
                type   = "funcargs",
                start  = 16,
                finish = 18,
                parent = "<IGNORE>",
                [1]    = {
                    type   = "local",
                    start  = 17,
                    finish = 18,
                    effect = 18,
                    parent = "<IGNORE>",
                    [1]    = "v",
                },
            },
            locals  = "<IGNORE>",
        },
        [1]    = "a",
    },
}

CHECK 'function a'
{
    type   = "main",
    start  = 0,
    finish = 10,
    locals = "<IGNORE>",
    [1]    = {
        type   = "setglobal",
        start  = 9,
        vstart = 0,
        finish = 10,
        range  = 10,
        parent = "<IGNORE>",
        node   = "<IGNORE>",
        value  = {
            type    = "function",
            start   = 0,
            finish  = 10,
            keyword = {
                [1] = 0,
                [2] = 8,
            },
            parent  = "<IGNORE>",
        },
        [1]    = "a",
    },
}

CHECK 'function a:'
{
    type   = "main",
    start  = 0,
    finish = 11,
    locals = "<IGNORE>",
    [1]    = {
        type   = "setmethod",
        start  = 9,
        vstart = 0,
        finish = 11,
        range  = 11,
        parent = "<IGNORE>",
        node   = "<IGNORE>",
        colon  = {
            type   = ":",
            start  = 10,
            finish = 11,
        },
        value  = {
            type    = "function",
            start   = 0,
            finish  = 11,
            keyword = {
                [1] = 0,
                [2] = 8,
            },
            parent  = "<IGNORE>",
            locals  = "<IGNORE>",
        },
    },
}

CHECK 'function a:b(v'
{
    type   = "main",
    start  = 0,
    finish = 14,
    locals = "<IGNORE>",
    [1]    = {
        type   = "setmethod",
        start  = 9,
        vstart = 0,
        finish = 12,
        range  = 14,
        parent = "<IGNORE>",
        node   = "<IGNORE>",
        colon  = {
            type   = ":",
            start  = 10,
            finish = 11,
        },
        method = {
            type   = "method",
            start  = 11,
            finish = 12,
            parent = "<IGNORE>",
            [1]    = "b",
        },
        value  = {
            type    = "function",
            start   = 0,
            finish  = 14,
            keyword = {
                [1] = 0,
                [2] = 8,
            },
            parent  = "<IGNORE>",
            args    = {
                type   = "funcargs",
                start  = 12,
                finish = 14,
                parent = "<IGNORE>",
                [1]    = {
                    type   = "local",
                    start  = 8,
                    finish = 8,
                    effect = 8,
                    tag    = "self",
                    parent = "<IGNORE>",
                    dummy  = true,
                    method = "<LOOP>",
                    [1]    = "self",
                },
                [2]    = {
                    type   = "local",
                    start  = 13,
                    finish = 14,
                    effect = 14,
                    parent = "<IGNORE>",
                    [1]    = "v",
                },
            },
            locals  = "<IGNORE>",
        },
    },
}

CHECK 'return local a'
{
    type    = "main",
    start   = 0,
    finish  = 14,
    locals  = "<IGNORE>",
    returns = "<IGNORE>",
    [1]     = {
        type   = "return",
        start  = 0,
        finish = 14,
        parent = "<IGNORE>",
        [1]    = {
            type   = "getglobal",
            start  = 7,
            finish = 12,
            parent = "<IGNORE>",
            node   = "<IGNORE>",
            [1]    = "local",
        },
        [2]    = {
            type   = "getglobal",
            start  = 13,
            finish = 14,
            parent = "<IGNORE>",
            node   = "<IGNORE>",
            [1]    = "a",
        },
    },
}

CHECK 'end'
{
    type   = "main",
    start  = 0,
    finish = 3,
    locals = "<IGNORE>",
}

CHECK 'local x = ,'
{
    type   = "main",
    start  = 0,
    finish = 11,
    locals = "<IGNORE>",
    [1]    = {
        type   = "local",
        start  = 6,
        finish = 7,
        effect = 9,
        parent = "<IGNORE>",
        [1]    = "x",
    },
}

CHECK 'local x = (a && b)'
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
            start  = 10,
            finish = 18,
            parent = "<IGNORE>",
            exp    = {
                type   = "binary",
                start  = 11,
                finish = 17,
                parent = "<IGNORE>",
                op     = {
                    type   = "and",
                    start  = 13,
                    finish = 15,
                },
                [1]    = {
                    type   = "getglobal",
                    start  = 11,
                    finish = 12,
                    parent = "<IGNORE>",
                    node   = "<IGNORE>",
                    [1]    = "a",
                },
                [2]    = {
                    type   = "getglobal",
                    start  = 16,
                    finish = 17,
                    parent = "<IGNORE>",
                    node   = "<IGNORE>",
                    [1]    = "b",
                },
            },
        },
        [1]    = "x",
    },
}

CHECK 'return 1 + + 1'
{
    type    = "main",
    start   = 0,
    finish  = 14,
    locals  = "<IGNORE>",
    returns = "<IGNORE>",
    [1]     = {
        type   = "return",
        start  = 0,
        finish = 14,
        parent = "<IGNORE>",
        [1]    = {
            type   = "binary",
            start  = 7,
            finish = 14,
            parent = "<IGNORE>",
            op     = {
                type   = "+",
                start  = 9,
                finish = 10,
            },
            [1]    = {
                type   = "integer",
                start  = 7,
                finish = 8,
                parent = "<IGNORE>",
                [1]    = 1,
            },
            [2]    = {
                type   = "integer",
                start  = 13,
                finish = 14,
                parent = "<IGNORE>",
                [1]    = 1,
            },
        },
    },
}

CHECK 'return 1 + # + 2'
{
    type    = "main",
    start   = 0,
    finish  = 16,
    locals  = "<IGNORE>",
    returns = "<IGNORE>",
    [1]     = {
        type   = "return",
        start  = 0,
        finish = 16,
        parent = "<IGNORE>",
        [1]    = {
            type   = "binary",
            start  = 7,
            finish = 16,
            parent = "<IGNORE>",
            op     = {
                type   = "+",
                start  = 13,
                finish = 14,
            },
            [1]    = {
                type   = "binary",
                start  = 7,
                finish = 12,
                parent = "<IGNORE>",
                op     = {
                    type   = "+",
                    start  = 9,
                    finish = 10,
                },
                [1]    = {
                    type   = "integer",
                    start  = 7,
                    finish = 8,
                    parent = "<IGNORE>",
                    [1]    = 1,
                },
                [2]    = {
                    type   = "unary",
                    start  = 11,
                    finish = 12,
                    parent = "<IGNORE>",
                    op     = {
                        type   = "#",
                        start  = 11,
                        finish = 12,
                    },
                },
            },
            [2]    = {
                type   = "integer",
                start  = 15,
                finish = 16,
                parent = "<IGNORE>",
                [1]    = 2,
            },
        },
    },
}

CHECK 'return 1 + 2 + # + 3'
{
    type    = "main",
    start   = 0,
    finish  = 20,
    locals  = "<IGNORE>",
    returns = "<IGNORE>",
    [1]     = {
        type   = "return",
        start  = 0,
        finish = 20,
        parent = "<IGNORE>",
        [1]    = {
            type   = "binary",
            start  = 7,
            finish = 20,
            parent = "<IGNORE>",
            op     = {
                type   = "+",
                start  = 17,
                finish = 18,
            },
            [1]    = {
                type   = "binary",
                start  = 7,
                finish = 16,
                parent = "<IGNORE>",
                op     = {
                    type   = "+",
                    start  = 13,
                    finish = 14,
                },
                [1]    = {
                    type   = "binary",
                    start  = 7,
                    finish = 12,
                    parent = "<IGNORE>",
                    op     = {
                        type   = "+",
                        start  = 9,
                        finish = 10,
                    },
                    [1]    = {
                        type   = "integer",
                        start  = 7,
                        finish = 8,
                        parent = "<IGNORE>",
                        [1]    = 1,
                    },
                    [2]    = {
                        type   = "integer",
                        start  = 11,
                        finish = 12,
                        parent = "<IGNORE>",
                        [1]    = 2,
                    },
                },
                [2]    = {
                    type   = "unary",
                    start  = 15,
                    finish = 16,
                    parent = "<IGNORE>",
                    op     = {
                        type   = "#",
                        start  = 15,
                        finish = 16,
                    },
                },
            },
            [2]    = {
                type   = "integer",
                start  = 19,
                finish = 20,
                parent = "<IGNORE>",
                [1]    = 3,
            },
        },
    },
}

CHECK [[
-
return
]]
{
    type   = "main",
    start  = 0,
    finish = 20000,
    locals = "<IGNORE>",
    [1]    = {
        type   = "unary",
        start  = 0,
        finish = 10006,
        parent = "<IGNORE>",
        op     = {
            type   = "-",
            start  = 0,
            finish = 1,
        },
        [1]    = {
            type   = "getglobal",
            start  = 10000,
            finish = 10006,
            parent = "<IGNORE>",
            node   = "<IGNORE>",
            [1]    = "return",
        },
    },
}

CHECK [[
return;
::::
return;
]]
{
    type    = "main",
    start   = 0,
    finish  = 30000,
    locals  = "<IGNORE>",
    returns = "<IGNORE>",
    [1]     = {
        type   = "return",
        start  = 0,
        finish = 6,
        parent = "<IGNORE>",
    },
    [2]     = {
        type   = "return",
        start  = 20000,
        finish = 20006,
        parent = "<IGNORE>",
    },
}

CHECK [[
return;
goto;
return;
]]
{
    type    = "main",
    start   = 0,
    finish  = 30000,
    locals  = "<IGNORE>",
    returns = "<IGNORE>",
    [1]     = {
        type   = "return",
        start  = 0,
        finish = 6,
        parent = "<IGNORE>",
    },
    [2]     = {
        type   = "return",
        start  = 20000,
        finish = 20006,
        parent = "<IGNORE>",
    },
}

CHECK [[
call(,-,not,1)
]]
{
    type   = "main",
    start  = 0,
    finish = 10000,
    locals = "<IGNORE>",
    [1]    = {
        type   = "call",
        start  = 0,
        finish = 14,
        parent = "<IGNORE>",
        node   = "<IGNORE>",
        args   = {
            type   = "callargs",
            start  = 4,
            finish = 14,
            parent = "<IGNORE>",
            [1]    = {
                type   = "unary",
                start  = 6,
                finish = 7,
                parent = "<IGNORE>",
                op     = {
                    type   = "-",
                    start  = 6,
                    finish = 7,
                },
            },
            [2]    = {
                type   = "unary",
                start  = 8,
                finish = 11,
                parent = "<IGNORE>",
                op     = {
                    type   = "not",
                    start  = 8,
                    finish = 11,
                },
            },
            [3]    = {
                type   = "integer",
                start  = 12,
                finish = 13,
                parent = "<IGNORE>",
                [1]    = 1,
            },
        },
    },
}

CHECK [[
{
    ;,-;,1
}
]]
{
    type   = "main",
    start  = 0,
    finish = 30000,
    locals = "<IGNORE>",
    [1]    = {
        type   = "table",
        start  = 0,
        finish = 20001,
        parent = "<IGNORE>",
        [1]    = {
            type   = "tableexp",
            start  = 10006,
            finish = 10007,
            tindex = 1,
            parent = "<IGNORE>",
            value  = {
                type   = "unary",
                start  = 10006,
                finish = 10007,
                parent = "<IGNORE>",
                op     = {
                    type   = "-",
                    start  = 10006,
                    finish = 10007,
                },
            },
        },
        [2]    = {
            type   = "tableexp",
            start  = 10009,
            finish = 10010,
            tindex = 2,
            parent = "<IGNORE>",
            value  = {
                type   = "integer",
                start  = 10009,
                finish = 10010,
                parent = "<IGNORE>",
                [1]    = 1,
            },
        },
    },
}

CHECK [[
local a,b,,d
]]
{
    type   = "main",
    start  = 0,
    finish = 10000,
    locals = "<IGNORE>",
    [1]    = {
        type   = "local",
        start  = 6,
        finish = 7,
        effect = 12,
        parent = "<IGNORE>",
        [1]    = "a",
    },
    [2]    = {
        type   = "local",
        start  = 8,
        finish = 9,
        effect = 12,
        parent = "<IGNORE>",
        [1]    = "b",
    },
    [3]    = {
        type   = "local",
        start  = 11,
        finish = 12,
        effect = 12,
        parent = "<IGNORE>",
        [1]    = "d",
    },
}

CHECK [[
if /**/ then
end
]]
{
    type   = "main",
    start  = 0,
    finish = 20000,
    locals = "<IGNORE>",
    [1]    = {
        type   = "if",
        start  = 0,
        finish = 10003,
        parent = "<IGNORE>",
        [1]    = {
            type    = "ifblock",
            start   = 0,
            finish  = 12,
            keyword = {
                [1] = 0,
                [2] = 2,
                [3] = 8,
                [4] = 12,
            },
            parent  = "<IGNORE>",
        },
    },
}

CHECK [[
f(if)
]]
{
    type   = "main",
    start  = 0,
    finish = 10000,
    locals = "<IGNORE>",
    [1]    = {
        type   = "call",
        start  = 0,
        finish = 5,
        parent = "<IGNORE>",
        node   = "<IGNORE>",
        args   = {
            type   = "callargs",
            start  = 1,
            finish = 5,
            parent = "<IGNORE>",
            [1]    = {
                type   = "getglobal",
                start  = 2,
                finish = 4,
                parent = "<IGNORE>",
                node   = "<IGNORE>",
                [1]    = "if",
            },
        },
    },
}

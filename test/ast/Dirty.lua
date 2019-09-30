CHECK'a.'
{
    type   = "main",
    start  = 1,
    finish = 2,
    locals = {
        [1] = {
            type   = "local",
            start  = 0,
            finish = 0,
            effect = 0,
            parent = "<LOOP>",
            vref   = {
                [1] = {
                    id   = 1,
                    type = "table",
                    tag  = "_ENV",
                    ref  = {
                        [1] = "<LOOP>",
                    },
                },
            },
            ref    = {
                [1] = {
                    type   = "getglobal",
                    start  = 1,
                    finish = 1,
                    parent = {
                        type   = "getfield",
                        start  = 1,
                        finish = 2,
                        parent = "<LOOP>",
                        node   = "<LOOP>",
                        dot    = {
                            type   = ".",
                            start  = 2,
                            finish = 2,
                        },
                    },
                    node   = "<LOOP>",
                    [1]    = "a",
                },
            },
            [1]    = "_ENV",
        },
    },
    [1]    = {
        type   = "getfield",
        start  = 1,
        finish = 2,
        parent = "<LOOP>",
        node   = {
            type   = "getglobal",
            start  = 1,
            finish = 1,
            parent = "<LOOP>",
            node   = {
                type   = "local",
                start  = 0,
                finish = 0,
                effect = 0,
                parent = "<LOOP>",
                vref   = {
                    [1] = {
                        id   = 1,
                        type = "table",
                        tag  = "_ENV",
                        ref  = {
                            [1] = "<LOOP>",
                        },
                    },
                },
                ref    = {
                    [1] = "<LOOP>",
                },
                [1]    = "_ENV",
            },
            [1]    = "a",
        },
        dot    = {
            type   = ".",
            start  = 2,
            finish = 2,
        },
    },
}

CHECK'a:'
{
    type   = "main",
    start  = 1,
    finish = 2,
    locals = {
        [1] = {
            type   = "local",
            start  = 0,
            finish = 0,
            effect = 0,
            parent = "<LOOP>",
            vref   = {
                [1] = {
                    id   = 1,
                    type = "table",
                    tag  = "_ENV",
                    ref  = {
                        [1] = "<LOOP>",
                    },
                },
            },
            ref    = {
                [1] = {
                    type   = "getglobal",
                    start  = 1,
                    finish = 1,
                    parent = {
                        type   = "getmethod",
                        start  = 1,
                        finish = 2,
                        parent = "<LOOP>",
                        node   = "<LOOP>",
                        colon  = {
                            type   = ":",
                            start  = 2,
                            finish = 2,
                        },
                    },
                    node   = "<LOOP>",
                    [1]    = "a",
                },
            },
            [1]    = "_ENV",
        },
    },
    [1]    = {
        type   = "getmethod",
        start  = 1,
        finish = 2,
        parent = "<LOOP>",
        node   = {
            type   = "getglobal",
            start  = 1,
            finish = 1,
            parent = "<LOOP>",
            node   = {
                type   = "local",
                start  = 0,
                finish = 0,
                effect = 0,
                parent = "<LOOP>",
                vref   = {
                    [1] = {
                        id   = 1,
                        type = "table",
                        tag  = "_ENV",
                        ref  = {
                            [1] = "<LOOP>",
                        },
                    },
                },
                ref    = {
                    [1] = "<LOOP>",
                },
                [1]    = "_ENV",
            },
            [1]    = "a",
        },
        colon  = {
            type   = ":",
            start  = 2,
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
    start  = 1,
    finish = 9,
    locals = {
        [1] = {
            type   = "local",
            start  = 0,
            finish = 0,
            effect = 0,
            parent = "<LOOP>",
            vref   = {
                [1] = {
                    id   = 1,
                    type = "table",
                    tag  = "_ENV",
                    ref  = {
                        [1] = "<LOOP>",
                    },
                },
            },
            ref    = {
                [1] = {
                    type   = "getglobal",
                    start  = 9,
                    finish = 9,
                    parent = {
                        type   = "ifblock",
                        start  = 1,
                        finish = 9,
                        parent = {
                            type   = "if",
                            start  = 1,
                            finish = 9,
                            parent = "<LOOP>",
                            [1]    = "<LOOP>",
                        },
                        filter = {
                            type   = "boolean",
                            start  = 4,
                            finish = 7,
                            [1]    = true,
                        },
                        [1]    = "<LOOP>",
                    },
                    node   = "<LOOP>",
                    [1]    = "a",
                },
            },
            [1]    = "_ENV",
        },
    },
    [1]    = {
        type   = "if",
        start  = 1,
        finish = 9,
        parent = "<LOOP>",
        [1]    = {
            type   = "ifblock",
            start  = 1,
            finish = 9,
            parent = "<LOOP>",
            filter = {
                type   = "boolean",
                start  = 4,
                finish = 7,
                [1]    = true,
            },
            [1]    = {
                type   = "getglobal",
                start  = 9,
                finish = 9,
                parent = "<LOOP>",
                node   = {
                    type   = "local",
                    start  = 0,
                    finish = 0,
                    effect = 0,
                    parent = "<LOOP>",
                    vref   = {
                        [1] = {
                            id   = 1,
                            type = "table",
                            tag  = "_ENV",
                            ref  = {
                                [1] = "<LOOP>",
                            },
                        },
                    },
                    ref    = {
                        [1] = "<LOOP>",
                    },
                    [1]    = "_ENV",
                },
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
    start  = 1,
    finish = 14,
    locals = {
        [1] = {
            type   = "local",
            start  = 0,
            finish = 0,
            effect = 0,
            parent = "<LOOP>",
            vref   = {
                [1] = {
                    id   = 1,
                    type = "table",
                    tag  = "_ENV",
                    ref  = {
                        [1] = "<LOOP>",
                    },
                },
            },
            ref    = {
                [1] = {
                    type   = "getglobal",
                    start  = 14,
                    finish = 14,
                    parent = {
                        type   = "ifblock",
                        start  = 1,
                        finish = 14,
                        parent = {
                            type   = "if",
                            start  = 1,
                            finish = 14,
                            parent = "<LOOP>",
                            [1]    = "<LOOP>",
                        },
                        filter = {
                            type   = "boolean",
                            start  = 4,
                            finish = 7,
                            [1]    = true,
                        },
                        [1]    = "<LOOP>",
                    },
                    node   = "<LOOP>",
                    [1]    = "a",
                },
            },
            [1]    = "_ENV",
        },
    },
    [1]    = {
        type   = "if",
        start  = 1,
        finish = 14,
        parent = "<LOOP>",
        [1]    = {
            type   = "ifblock",
            start  = 1,
            finish = 14,
            parent = "<LOOP>",
            filter = {
                type   = "boolean",
                start  = 4,
                finish = 7,
                [1]    = true,
            },
            [1]    = {
                type   = "getglobal",
                start  = 14,
                finish = 14,
                parent = "<LOOP>",
                node   = {
                    type   = "local",
                    start  = 0,
                    finish = 0,
                    effect = 0,
                    parent = "<LOOP>",
                    vref   = {
                        [1] = {
                            id   = 1,
                            type = "table",
                            tag  = "_ENV",
                            ref  = {
                                [1] = "<LOOP>",
                            },
                        },
                    },
                    ref    = {
                        [1] = "<LOOP>",
                    },
                    [1]    = "_ENV",
                },
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
    start  = 1,
    finish = 4,
    locals = {
        [1] = {
            type   = "local",
            start  = 0,
            finish = 0,
            effect = 0,
            parent = "<LOOP>",
            vref   = {
                [1] = {
                    id   = 1,
                    type = "table",
                    tag  = "_ENV",
                    ref  = {
                        [1] = "<LOOP>",
                    },
                },
            },
            ref    = {
                [1] = {
                    type   = "setglobal",
                    start  = 1,
                    finish = 1,
                    parent = "<LOOP>",
                    node   = "<LOOP>",
                    [1]    = "x",
                },
            },
            [1]    = "_ENV",
        },
    },
    [1]    = {
        type   = "setglobal",
        start  = 1,
        finish = 1,
        parent = "<LOOP>",
        node   = {
            type   = "local",
            start  = 0,
            finish = 0,
            effect = 0,
            parent = "<LOOP>",
            vref   = {
                [1] = {
                    id   = 1,
                    type = "table",
                    tag  = "_ENV",
                    ref  = {
                        [1] = "<LOOP>",
                    },
                },
            },
            ref    = {
                [1] = "<LOOP>",
            },
            [1]    = "_ENV",
        },
        [1]    = "x",
    },
}

CHECK'1 == 2'
{
    type   = "main",
    start  = 1,
    finish = 6,
    locals = {
        [1] = {
            type   = "local",
            start  = 0,
            finish = 0,
            effect = 0,
            parent = "<LOOP>",
            vref   = {
                [1] = {
                    id   = 1,
                    type = "table",
                    tag  = "_ENV",
                    ref  = {
                        [1] = "<LOOP>",
                    },
                },
            },
            [1]    = "_ENV",
        },
    },
    [1]    = {
        type   = "binary",
        start  = 1,
        finish = 6,
        parent = "<LOOP>",
        op     = {
            type   = "==",
            start  = 3,
            finish = 4,
        },
        [1]    = {
            type   = "number",
            start  = 1,
            finish = 1,
            [1]    = 1,
        },
        [2]    = {
            type   = "number",
            start  = 6,
            finish = 6,
            [1]    = 2,
        },
    },
}

CHECK 'local function a'
{
    type   = "main",
    start  = 1,
    finish = 16,
    locals = {
        [1] = {
            type   = "local",
            start  = 0,
            finish = 0,
            effect = 0,
            parent = "<LOOP>",
            vref   = {
                [1] = {
                    id   = 1,
                    type = "table",
                    tag  = "_ENV",
                    ref  = {
                        [1] = "<LOOP>",
                    },
                },
            },
            [1]    = "_ENV",
        },
        [2] = {
            type   = "local",
            start  = 16,
            finish = 16,
            effect = 1,
            range  = 16,
            parent = "<LOOP>",
            value  = {
                type   = "function",
                start  = 1,
                finish = 16,
                parent = "<LOOP>",
            },
            [1]    = "a",
        },
    },
    [1]    = {
        type   = "local",
        start  = 16,
        finish = 16,
        effect = 1,
        range  = 16,
        parent = "<LOOP>",
        value  = {
            type   = "function",
            start  = 1,
            finish = 16,
            parent = "<LOOP>",
        },
        [1]    = "a",
    },
}

CHECK 'local function'
{
    type   = "main",
    start  = 1,
    finish = 14,
    locals = {
        [1] = {
            type   = "local",
            start  = 0,
            finish = 0,
            effect = 0,
            parent = "<LOOP>",
            vref   = {
                [1] = {
                    id   = 1,
                    type = "table",
                    tag  = "_ENV",
                    ref  = {
                        [1] = "<LOOP>",
                    },
                },
            },
            [1]    = "_ENV",
        },
    },
}

CHECK 'local function a(v'
{
    type   = "main",
    start  = 1,
    finish = 18,
    locals = {
        [1] = {
            type   = "local",
            start  = 0,
            finish = 0,
            effect = 0,
            parent = "<LOOP>",
            vref   = {
                [1] = {
                    id   = 1,
                    type = "table",
                    tag  = "_ENV",
                    ref  = {
                        [1] = "<LOOP>",
                    },
                },
            },
            [1]    = "_ENV",
        },
        [2] = {
            type   = "local",
            start  = 16,
            finish = 16,
            effect = 1,
            range  = 18,
            parent = "<LOOP>",
            value  = {
                type   = "function",
                start  = 1,
                finish = 18,
                parent = "<LOOP>",
                args   = {
                    type   = "funcargs",
                    start  = 17,
                    finish = 18,
                    parent = "<LOOP>",
                    [1]    = {
                        type   = "local",
                        start  = 18,
                        finish = 18,
                        effect = 18,
                        parent = "<LOOP>",
                        [1]    = "v",
                    },
                },
                locals = {
                    [1] = {
                        type   = "local",
                        start  = 18,
                        finish = 18,
                        effect = 18,
                        parent = {
                            type   = "funcargs",
                            start  = 17,
                            finish = 18,
                            parent = "<LOOP>",
                            [1]    = "<LOOP>",
                        },
                        [1]    = "v",
                    },
                },
            },
            [1]    = "a",
        },
    },
    [1]    = {
        type   = "local",
        start  = 16,
        finish = 16,
        effect = 1,
        range  = 18,
        parent = "<LOOP>",
        value  = {
            type   = "function",
            start  = 1,
            finish = 18,
            parent = "<LOOP>",
            args   = {
                type   = "funcargs",
                start  = 17,
                finish = 18,
                parent = "<LOOP>",
                [1]    = {
                    type   = "local",
                    start  = 18,
                    finish = 18,
                    effect = 18,
                    parent = "<LOOP>",
                    [1]    = "v",
                },
            },
            locals = {
                [1] = {
                    type   = "local",
                    start  = 18,
                    finish = 18,
                    effect = 18,
                    parent = {
                        type   = "funcargs",
                        start  = 17,
                        finish = 18,
                        parent = "<LOOP>",
                        [1]    = "<LOOP>",
                    },
                    [1]    = "v",
                },
            },
        },
        [1]    = "a",
    },
}

CHECK 'function a'
{
    type   = "main",
    start  = 1,
    finish = 10,
    locals = {
        [1] = {
            type   = "local",
            start  = 0,
            finish = 0,
            effect = 0,
            parent = "<LOOP>",
            vref   = {
                [1] = {
                    id    = 1,
                    type  = "table",
                    tag   = "_ENV",
                    child = {
                        ["s|a"] = {
                            [1] = {
                                id  = 2,
                                ref = {
                                    [1] = {
                                        type   = "function",
                                        start  = 1,
                                        finish = 10,
                                        parent = {
                                            type   = "setglobal",
                                            start  = 10,
                                            finish = 10,
                                            parent = "<LOOP>",
                                            node   = "<LOOP>",
                                            value  = "<LOOP>",
                                            [1]    = "a",
                                        },
                                        vref   = "<LOOP>",
                                    },
                                },
                            },
                        },
                    },
                    ref   = {
                        [1] = "<LOOP>",
                    },
                },
            },
            ref    = {
                [1] = {
                    type   = "setglobal",
                    start  = 10,
                    finish = 10,
                    parent = "<LOOP>",
                    node   = "<LOOP>",
                    value  = {
                        type   = "function",
                        start  = 1,
                        finish = 10,
                        parent = "<LOOP>",
                        vref   = {
                            [1] = {
                                id  = 2,
                                ref = {
                                    [1] = "<LOOP>",
                                },
                            },
                        },
                    },
                    [1]    = "a",
                },
            },
            [1]    = "_ENV",
        },
    },
    [1]    = {
        type   = "setglobal",
        start  = 10,
        finish = 10,
        parent = "<LOOP>",
        node   = {
            type   = "local",
            start  = 0,
            finish = 0,
            effect = 0,
            parent = "<LOOP>",
            vref   = {
                [1] = {
                    id    = 1,
                    type  = "table",
                    tag   = "_ENV",
                    child = {
                        ["s|a"] = {
                            [1] = {
                                id  = 2,
                                ref = {
                                    [1] = {
                                        type   = "function",
                                        start  = 1,
                                        finish = 10,
                                        parent = "<LOOP>",
                                        vref   = "<LOOP>",
                                    },
                                },
                            },
                        },
                    },
                    ref   = {
                        [1] = "<LOOP>",
                    },
                },
            },
            ref    = {
                [1] = "<LOOP>",
            },
            [1]    = "_ENV",
        },
        value  = {
            type   = "function",
            start  = 1,
            finish = 10,
            parent = "<LOOP>",
            vref   = {
                [1] = {
                    id  = 2,
                    ref = {
                        [1] = "<LOOP>",
                    },
                },
            },
        },
        [1]    = "a",
    },
}

CHECK 'function a:'
{
    type   = "main",
    start  = 1,
    finish = 11,
    locals = {
        [1] = {
            type   = "local",
            start  = 0,
            finish = 0,
            effect = 0,
            parent = "<LOOP>",
            vref   = {
                [1] = {
                    id   = 1,
                    type = "table",
                    tag  = "_ENV",
                    ref  = {
                        [1] = "<LOOP>",
                    },
                },
            },
            ref    = {
                [1] = {
                    type   = "getglobal",
                    start  = 10,
                    finish = 10,
                    parent = {
                        type   = "setmethod",
                        start  = 10,
                        finish = 11,
                        parent = "<LOOP>",
                        node   = "<LOOP>",
                        colon  = {
                            type   = ":",
                            start  = 11,
                            finish = 11,
                        },
                        value  = {
                            type   = "function",
                            start  = 1,
                            finish = 11,
                            parent = "<LOOP>",
                            locals = {
                                [1] = {
                                    type   = "local",
                                    start  = 0,
                                    finish = 0,
                                    effect = 11,
                                    parent = "<LOOP>",
                                    method = "<LOOP>",
                                    [1]    = "self",
                                },
                            },
                        },
                    },
                    node   = "<LOOP>",
                    [1]    = "a",
                },
            },
            [1]    = "_ENV",
        },
    },
    [1]    = {
        type   = "setmethod",
        start  = 10,
        finish = 11,
        parent = "<LOOP>",
        node   = {
            type   = "getglobal",
            start  = 10,
            finish = 10,
            parent = "<LOOP>",
            node   = {
                type   = "local",
                start  = 0,
                finish = 0,
                effect = 0,
                parent = "<LOOP>",
                vref   = {
                    [1] = {
                        id   = 1,
                        type = "table",
                        tag  = "_ENV",
                        ref  = {
                            [1] = "<LOOP>",
                        },
                    },
                },
                ref    = {
                    [1] = "<LOOP>",
                },
                [1]    = "_ENV",
            },
            [1]    = "a",
        },
        colon  = {
            type   = ":",
            start  = 11,
            finish = 11,
        },
        value  = {
            type   = "function",
            start  = 1,
            finish = 11,
            parent = "<LOOP>",
            locals = {
                [1] = {
                    type   = "local",
                    start  = 0,
                    finish = 0,
                    effect = 11,
                    parent = "<LOOP>",
                    method = "<LOOP>",
                    [1]    = "self",
                },
            },
        },
    },
}

CHECK 'function a:b(v'
{
    type   = "main",
    start  = 1,
    finish = 14,
    locals = {
        [1] = {
            type   = "local",
            start  = 0,
            finish = 0,
            effect = 0,
            parent = "<LOOP>",
            vref   = {
                [1] = {
                    id   = 1,
                    type = "table",
                    tag  = "_ENV",
                    ref  = {
                        [1] = "<LOOP>",
                    },
                },
            },
            ref    = {
                [1] = {
                    type   = "getglobal",
                    start  = 10,
                    finish = 10,
                    parent = {
                        type   = "setmethod",
                        start  = 10,
                        finish = 12,
                        parent = "<LOOP>",
                        node   = "<LOOP>",
                        colon  = {
                            type   = ":",
                            start  = 11,
                            finish = 11,
                        },
                        method = {
                            type   = "method",
                            start  = 12,
                            finish = 12,
                            [1]    = "b",
                        },
                        value  = {
                            type   = "function",
                            start  = 1,
                            finish = 14,
                            parent = "<LOOP>",
                            args   = {
                                type   = "funcargs",
                                start  = 13,
                                finish = 14,
                                parent = "<LOOP>",
                                [1]    = {
                                    type   = "local",
                                    start  = 14,
                                    finish = 14,
                                    effect = 14,
                                    parent = "<LOOP>",
                                    [1]    = "v",
                                },
                            },
                            locals = {
                                [1] = {
                                    type   = "local",
                                    start  = 0,
                                    finish = 0,
                                    effect = 12,
                                    parent = "<LOOP>",
                                    method = "<LOOP>",
                                    [1]    = "self",
                                },
                                [2] = {
                                    type   = "local",
                                    start  = 14,
                                    finish = 14,
                                    effect = 14,
                                    parent = {
                                        type   = "funcargs",
                                        start  = 13,
                                        finish = 14,
                                        parent = "<LOOP>",
                                        [1]    = "<LOOP>",
                                    },
                                    [1]    = "v",
                                },
                            },
                        },
                    },
                    node   = "<LOOP>",
                    [1]    = "a",
                },
            },
            [1]    = "_ENV",
        },
    },
    [1]    = {
        type   = "setmethod",
        start  = 10,
        finish = 12,
        parent = "<LOOP>",
        node   = {
            type   = "getglobal",
            start  = 10,
            finish = 10,
            parent = "<LOOP>",
            node   = {
                type   = "local",
                start  = 0,
                finish = 0,
                effect = 0,
                parent = "<LOOP>",
                vref   = {
                    [1] = {
                        id   = 1,
                        type = "table",
                        tag  = "_ENV",
                        ref  = {
                            [1] = "<LOOP>",
                        },
                    },
                },
                ref    = {
                    [1] = "<LOOP>",
                },
                [1]    = "_ENV",
            },
            [1]    = "a",
        },
        colon  = {
            type   = ":",
            start  = 11,
            finish = 11,
        },
        method = {
            type   = "method",
            start  = 12,
            finish = 12,
            [1]    = "b",
        },
        value  = {
            type   = "function",
            start  = 1,
            finish = 14,
            parent = "<LOOP>",
            args   = {
                type   = "funcargs",
                start  = 13,
                finish = 14,
                parent = "<LOOP>",
                [1]    = {
                    type   = "local",
                    start  = 14,
                    finish = 14,
                    effect = 14,
                    parent = "<LOOP>",
                    [1]    = "v",
                },
            },
            locals = {
                [1] = {
                    type   = "local",
                    start  = 0,
                    finish = 0,
                    effect = 12,
                    parent = "<LOOP>",
                    method = "<LOOP>",
                    [1]    = "self",
                },
                [2] = {
                    type   = "local",
                    start  = 14,
                    finish = 14,
                    effect = 14,
                    parent = {
                        type   = "funcargs",
                        start  = 13,
                        finish = 14,
                        parent = "<LOOP>",
                        [1]    = "<LOOP>",
                    },
                    [1]    = "v",
                },
            },
        },
    },
}

CHECK 'return local a'
{
    type   = "main",
    start  = 1,
    finish = 14,
    locals = {
        [1] = {
            type   = "local",
            start  = 0,
            finish = 0,
            effect = 0,
            parent = "<LOOP>",
            vref   = {
                [1] = {
                    id   = 1,
                    type = "table",
                    tag  = "_ENV",
                    ref  = {
                        [1] = "<LOOP>",
                    },
                },
            },
            [1]    = "_ENV",
        },
        [2] = {
            type   = "local",
            start  = 14,
            finish = 14,
            effect = 15,
            parent = "<LOOP>",
            [1]    = "a",
        },
    },
    [1]    = {
        type   = "return",
        start  = 1,
        finish = 7,
        parent = "<LOOP>",
    },
    [2]    = {
        type   = "local",
        start  = 14,
        finish = 14,
        effect = 15,
        parent = "<LOOP>",
        [1]    = "a",
    },
}

CHECK 'end'
{
    type   = "main",
    start  = 1,
    finish = 3,
    locals = {
        [1] = {
            type   = "local",
            start  = 0,
            finish = 0,
            effect = 0,
            parent = "<LOOP>",
            vref   = {
                [1] = {
                    id   = 1,
                    type = "table",
                    tag  = "_ENV",
                    ref  = {
                        [1] = "<LOOP>",
                    },
                },
            },
            [1]    = "_ENV",
        },
    },
}

CHECK 'local x = ,'
{
    type   = "main",
    start  = 1,
    finish = 11,
    locals = {
        [1] = {
            type   = "local",
            start  = 0,
            finish = 0,
            effect = 0,
            parent = "<LOOP>",
            vref   = {
                [1] = {
                    id   = 1,
                    type = "table",
                    tag  = "_ENV",
                    ref  = {
                        [1] = "<LOOP>",
                    },
                },
            },
            [1]    = "_ENV",
        },
        [2] = {
            type   = "local",
            start  = 7,
            finish = 7,
            effect = 12,
            parent = "<LOOP>",
            [1]    = "x",
        },
    },
    [1]    = {
        type   = "local",
        start  = 7,
        finish = 7,
        effect = 12,
        parent = "<LOOP>",
        [1]    = "x",
    },
}

CHECK 'local x = (a && b)'
{
    type   = "main",
    start  = 1,
    finish = 18,
    locals = {
        [1] = {
            type   = "local",
            start  = 0,
            finish = 0,
            effect = 0,
            parent = "<LOOP>",
            vref   = {
                [1] = {
                    id   = 1,
                    type = "table",
                    tag  = "_ENV",
                    ref  = {
                        [1] = "<LOOP>",
                    },
                },
            },
            ref    = {
                [1] = {
                    type   = "getglobal",
                    start  = 12,
                    finish = 12,
                    parent = {
                        type   = "binary",
                        start  = 12,
                        finish = 17,
                        parent = {
                            type   = "paren",
                            start  = 11,
                            finish = 18,
                            parent = {
                                type   = "local",
                                start  = 7,
                                finish = 7,
                                effect = 19,
                                range  = 18,
                                parent = "<LOOP>",
                                value  = "<LOOP>",
                                [1]    = "x",
                            },
                            exp    = "<LOOP>",
                        },
                        op     = {
                            type   = "&",
                            start  = 15,
                            finish = 15,
                        },
                        [1]    = "<LOOP>",
                        [2]    = {
                            type   = "getglobal",
                            start  = 17,
                            finish = 17,
                            parent = "<LOOP>",
                            node   = "<LOOP>",
                            [1]    = "b",
                        },
                    },
                    node   = "<LOOP>",
                    [1]    = "a",
                },
                [2] = {
                    type   = "getglobal",
                    start  = 17,
                    finish = 17,
                    parent = {
                        type   = "binary",
                        start  = 12,
                        finish = 17,
                        parent = {
                            type   = "paren",
                            start  = 11,
                            finish = 18,
                            parent = {
                                type   = "local",
                                start  = 7,
                                finish = 7,
                                effect = 19,
                                range  = 18,
                                parent = "<LOOP>",
                                value  = "<LOOP>",
                                [1]    = "x",
                            },
                            exp    = "<LOOP>",
                        },
                        op     = {
                            type   = "&",
                            start  = 15,
                            finish = 15,
                        },
                        [1]    = {
                            type   = "getglobal",
                            start  = 12,
                            finish = 12,
                            parent = "<LOOP>",
                            node   = "<LOOP>",
                            [1]    = "a",
                        },
                        [2]    = "<LOOP>",
                    },
                    node   = "<LOOP>",
                    [1]    = "b",
                },
            },
            [1]    = "_ENV",
        },
        [2] = {
            type   = "local",
            start  = 7,
            finish = 7,
            effect = 19,
            range  = 18,
            parent = "<LOOP>",
            value  = {
                type   = "paren",
                start  = 11,
                finish = 18,
                parent = "<LOOP>",
                exp    = {
                    type   = "binary",
                    start  = 12,
                    finish = 17,
                    parent = "<LOOP>",
                    op     = {
                        type   = "&",
                        start  = 15,
                        finish = 15,
                    },
                    [1]    = {
                        type   = "getglobal",
                        start  = 12,
                        finish = 12,
                        parent = "<LOOP>",
                        node   = {
                            type   = "local",
                            start  = 0,
                            finish = 0,
                            effect = 0,
                            parent = "<LOOP>",
                            vref   = {
                                [1] = {
                                    id   = 1,
                                    type = "table",
                                    tag  = "_ENV",
                                    ref  = {
                                        [1] = "<LOOP>",
                                    },
                                },
                            },
                            ref    = {
                                [1] = "<LOOP>",
                                [2] = {
                                    type   = "getglobal",
                                    start  = 17,
                                    finish = 17,
                                    parent = "<LOOP>",
                                    node   = "<LOOP>",
                                    [1]    = "b",
                                },
                            },
                            [1]    = "_ENV",
                        },
                        [1]    = "a",
                    },
                    [2]    = {
                        type   = "getglobal",
                        start  = 17,
                        finish = 17,
                        parent = "<LOOP>",
                        node   = {
                            type   = "local",
                            start  = 0,
                            finish = 0,
                            effect = 0,
                            parent = "<LOOP>",
                            vref   = {
                                [1] = {
                                    id   = 1,
                                    type = "table",
                                    tag  = "_ENV",
                                    ref  = {
                                        [1] = "<LOOP>",
                                    },
                                },
                            },
                            ref    = {
                                [1] = {
                                    type   = "getglobal",
                                    start  = 12,
                                    finish = 12,
                                    parent = "<LOOP>",
                                    node   = "<LOOP>",
                                    [1]    = "a",
                                },
                                [2] = "<LOOP>",
                            },
                            [1]    = "_ENV",
                        },
                        [1]    = "b",
                    },
                },
            },
            [1]    = "x",
        },
    },
    [1]    = {
        type   = "local",
        start  = 7,
        finish = 7,
        effect = 19,
        range  = 18,
        parent = "<LOOP>",
        value  = {
            type   = "paren",
            start  = 11,
            finish = 18,
            parent = "<LOOP>",
            exp    = {
                type   = "binary",
                start  = 12,
                finish = 17,
                parent = "<LOOP>",
                op     = {
                    type   = "&",
                    start  = 15,
                    finish = 15,
                },
                [1]    = {
                    type   = "getglobal",
                    start  = 12,
                    finish = 12,
                    parent = "<LOOP>",
                    node   = {
                        type   = "local",
                        start  = 0,
                        finish = 0,
                        effect = 0,
                        parent = "<LOOP>",
                        vref   = {
                            [1] = {
                                id   = 1,
                                type = "table",
                                tag  = "_ENV",
                                ref  = {
                                    [1] = "<LOOP>",
                                },
                            },
                        },
                        ref    = {
                            [1] = "<LOOP>",
                            [2] = {
                                type   = "getglobal",
                                start  = 17,
                                finish = 17,
                                parent = "<LOOP>",
                                node   = "<LOOP>",
                                [1]    = "b",
                            },
                        },
                        [1]    = "_ENV",
                    },
                    [1]    = "a",
                },
                [2]    = {
                    type   = "getglobal",
                    start  = 17,
                    finish = 17,
                    parent = "<LOOP>",
                    node   = {
                        type   = "local",
                        start  = 0,
                        finish = 0,
                        effect = 0,
                        parent = "<LOOP>",
                        vref   = {
                            [1] = {
                                id   = 1,
                                type = "table",
                                tag  = "_ENV",
                                ref  = {
                                    [1] = "<LOOP>",
                                },
                            },
                        },
                        ref    = {
                            [1] = {
                                type   = "getglobal",
                                start  = 12,
                                finish = 12,
                                parent = "<LOOP>",
                                node   = "<LOOP>",
                                [1]    = "a",
                            },
                            [2] = "<LOOP>",
                        },
                        [1]    = "_ENV",
                    },
                    [1]    = "b",
                },
            },
        },
        [1]    = "x",
    },
}

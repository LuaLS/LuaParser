CHECK''
{
    type   = "main",
    start  = 1,
    finish = 0,
    locals = {
        [1] = {
            type   = "local",
            start  = 0,
            finish = 0,
            effect = 0,
            parent = "<LOOP>",
            vref   = {
                [1] = {
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

CHECK';;;'
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

CHECK';;;x = 1'
{
    type   = "main",
    start  = 1,
    finish = 8,
    locals = {
        [1] = {
            type   = "local",
            start  = 0,
            finish = 0,
            effect = 0,
            parent = "<LOOP>",
            vref   = {
                [1] = {
                    type  = "table",
                    tag   = "_ENV",
                    child = {
                        ["string|x"] = {
                            [1] = {
                                ref = {
                                    [1] = {
                                        type   = "number",
                                        start  = 8,
                                        finish = 8,
                                        vref   = "<LOOP>",
                                        [1]    = 1,
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
                    start  = 4,
                    finish = 4,
                    range  = 8,
                    parent = "<LOOP>",
                    node   = "<LOOP>",
                    value  = {
                        type   = "number",
                        start  = 8,
                        finish = 8,
                        vref   = {
                            [1] = {
                                ref = {
                                    [1] = "<LOOP>",
                                },
                            },
                        },
                        [1]    = 1,
                    },
                    [1]    = "x",
                },
            },
            [1]    = "_ENV",
        },
    },
    [1]    = {
        type   = "setglobal",
        start  = 4,
        finish = 4,
        range  = 8,
        parent = "<LOOP>",
        node   = {
            type   = "local",
            start  = 0,
            finish = 0,
            effect = 0,
            parent = "<LOOP>",
            vref   = {
                [1] = {
                    type  = "table",
                    tag   = "_ENV",
                    child = {
                        ["string|x"] = {
                            [1] = {
                                ref = {
                                    [1] = {
                                        type   = "number",
                                        start  = 8,
                                        finish = 8,
                                        vref   = "<LOOP>",
                                        [1]    = 1,
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
            type   = "number",
            start  = 8,
            finish = 8,
            vref   = {
                [1] = {
                    ref = {
                        [1] = "<LOOP>",
                    },
                },
            },
            [1]    = 1,
        },
        [1]    = "x",
    },
}
CHECK'x, y, z = 1, 2, 3'
{
    type   = "main",
    start  = 1,
    finish = 17,
    locals = {
        [1] = {
            type   = "local",
            start  = 0,
            finish = 0,
            effect = 0,
            parent = "<LOOP>",
            vref   = {
                [1] = {
                    type  = "table",
                    tag   = "_ENV",
                    child = {
                        ["string|x"] = {
                            [1] = {
                                ref = {
                                    [1] = {
                                        type   = "number",
                                        start  = 11,
                                        finish = 11,
                                        vref   = "<LOOP>",
                                        [1]    = 1,
                                    },
                                },
                            },
                        },
                        ["string|y"] = {
                            [1] = {
                                ref = {
                                    [1] = {
                                        type   = "number",
                                        start  = 14,
                                        finish = 14,
                                        vref   = "<LOOP>",
                                        [1]    = 2,
                                    },
                                },
                            },
                        },
                        ["string|z"] = {
                            [1] = {
                                ref = {
                                    [1] = {
                                        type   = "number",
                                        start  = 17,
                                        finish = 17,
                                        vref   = "<LOOP>",
                                        [1]    = 3,
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
                    start  = 1,
                    finish = 1,
                    range  = 11,
                    parent = "<LOOP>",
                    node   = "<LOOP>",
                    value  = {
                        type   = "number",
                        start  = 11,
                        finish = 11,
                        vref   = {
                            [1] = {
                                ref = {
                                    [1] = "<LOOP>",
                                },
                            },
                        },
                        [1]    = 1,
                    },
                    [1]    = "x",
                },
                [2] = {
                    type   = "setglobal",
                    start  = 4,
                    finish = 4,
                    range  = 14,
                    parent = "<LOOP>",
                    node   = "<LOOP>",
                    value  = {
                        type   = "number",
                        start  = 14,
                        finish = 14,
                        vref   = {
                            [1] = {
                                ref = {
                                    [1] = "<LOOP>",
                                },
                            },
                        },
                        [1]    = 2,
                    },
                    [1]    = "y",
                },
                [3] = {
                    type   = "setglobal",
                    start  = 7,
                    finish = 7,
                    range  = 17,
                    parent = "<LOOP>",
                    node   = "<LOOP>",
                    value  = {
                        type   = "number",
                        start  = 17,
                        finish = 17,
                        vref   = {
                            [1] = {
                                ref = {
                                    [1] = "<LOOP>",
                                },
                            },
                        },
                        [1]    = 3,
                    },
                    [1]    = "z",
                },
            },
            [1]    = "_ENV",
        },
    },
    [1]    = {
        type   = "setglobal",
        start  = 1,
        finish = 1,
        range  = 11,
        parent = "<LOOP>",
        node   = {
            type   = "local",
            start  = 0,
            finish = 0,
            effect = 0,
            parent = "<LOOP>",
            vref   = {
                [1] = {
                    type  = "table",
                    tag   = "_ENV",
                    child = {
                        ["string|x"] = {
                            [1] = {
                                ref = {
                                    [1] = {
                                        type   = "number",
                                        start  = 11,
                                        finish = 11,
                                        vref   = "<LOOP>",
                                        [1]    = 1,
                                    },
                                },
                            },
                        },
                        ["string|y"] = {
                            [1] = {
                                ref = {
                                    [1] = {
                                        type   = "number",
                                        start  = 14,
                                        finish = 14,
                                        vref   = "<LOOP>",
                                        [1]    = 2,
                                    },
                                },
                            },
                        },
                        ["string|z"] = {
                            [1] = {
                                ref = {
                                    [1] = {
                                        type   = "number",
                                        start  = 17,
                                        finish = 17,
                                        vref   = "<LOOP>",
                                        [1]    = 3,
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
                [2] = {
                    type   = "setglobal",
                    start  = 4,
                    finish = 4,
                    range  = 14,
                    parent = "<LOOP>",
                    node   = "<LOOP>",
                    value  = {
                        type   = "number",
                        start  = 14,
                        finish = 14,
                        vref   = {
                            [1] = {
                                ref = {
                                    [1] = "<LOOP>",
                                },
                            },
                        },
                        [1]    = 2,
                    },
                    [1]    = "y",
                },
                [3] = {
                    type   = "setglobal",
                    start  = 7,
                    finish = 7,
                    range  = 17,
                    parent = "<LOOP>",
                    node   = "<LOOP>",
                    value  = {
                        type   = "number",
                        start  = 17,
                        finish = 17,
                        vref   = {
                            [1] = {
                                ref = {
                                    [1] = "<LOOP>",
                                },
                            },
                        },
                        [1]    = 3,
                    },
                    [1]    = "z",
                },
            },
            [1]    = "_ENV",
        },
        value  = {
            type   = "number",
            start  = 11,
            finish = 11,
            vref   = {
                [1] = {
                    ref = {
                        [1] = "<LOOP>",
                    },
                },
            },
            [1]    = 1,
        },
        [1]    = "x",
    },
    [2]    = {
        type   = "setglobal",
        start  = 4,
        finish = 4,
        range  = 14,
        parent = "<LOOP>",
        node   = {
            type   = "local",
            start  = 0,
            finish = 0,
            effect = 0,
            parent = "<LOOP>",
            vref   = {
                [1] = {
                    type  = "table",
                    tag   = "_ENV",
                    child = {
                        ["string|x"] = {
                            [1] = {
                                ref = {
                                    [1] = {
                                        type   = "number",
                                        start  = 11,
                                        finish = 11,
                                        vref   = "<LOOP>",
                                        [1]    = 1,
                                    },
                                },
                            },
                        },
                        ["string|y"] = {
                            [1] = {
                                ref = {
                                    [1] = {
                                        type   = "number",
                                        start  = 14,
                                        finish = 14,
                                        vref   = "<LOOP>",
                                        [1]    = 2,
                                    },
                                },
                            },
                        },
                        ["string|z"] = {
                            [1] = {
                                ref = {
                                    [1] = {
                                        type   = "number",
                                        start  = 17,
                                        finish = 17,
                                        vref   = "<LOOP>",
                                        [1]    = 3,
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
                    start  = 1,
                    finish = 1,
                    range  = 11,
                    parent = "<LOOP>",
                    node   = "<LOOP>",
                    value  = {
                        type   = "number",
                        start  = 11,
                        finish = 11,
                        vref   = {
                            [1] = {
                                ref = {
                                    [1] = "<LOOP>",
                                },
                            },
                        },
                        [1]    = 1,
                    },
                    [1]    = "x",
                },
                [2] = "<LOOP>",
                [3] = {
                    type   = "setglobal",
                    start  = 7,
                    finish = 7,
                    range  = 17,
                    parent = "<LOOP>",
                    node   = "<LOOP>",
                    value  = {
                        type   = "number",
                        start  = 17,
                        finish = 17,
                        vref   = {
                            [1] = {
                                ref = {
                                    [1] = "<LOOP>",
                                },
                            },
                        },
                        [1]    = 3,
                    },
                    [1]    = "z",
                },
            },
            [1]    = "_ENV",
        },
        value  = {
            type   = "number",
            start  = 14,
            finish = 14,
            vref   = {
                [1] = {
                    ref = {
                        [1] = "<LOOP>",
                    },
                },
            },
            [1]    = 2,
        },
        [1]    = "y",
    },
    [3]    = {
        type   = "setglobal",
        start  = 7,
        finish = 7,
        range  = 17,
        parent = "<LOOP>",
        node   = {
            type   = "local",
            start  = 0,
            finish = 0,
            effect = 0,
            parent = "<LOOP>",
            vref   = {
                [1] = {
                    type  = "table",
                    tag   = "_ENV",
                    child = {
                        ["string|x"] = {
                            [1] = {
                                ref = {
                                    [1] = {
                                        type   = "number",
                                        start  = 11,
                                        finish = 11,
                                        vref   = "<LOOP>",
                                        [1]    = 1,
                                    },
                                },
                            },
                        },
                        ["string|y"] = {
                            [1] = {
                                ref = {
                                    [1] = {
                                        type   = "number",
                                        start  = 14,
                                        finish = 14,
                                        vref   = "<LOOP>",
                                        [1]    = 2,
                                    },
                                },
                            },
                        },
                        ["string|z"] = {
                            [1] = {
                                ref = {
                                    [1] = {
                                        type   = "number",
                                        start  = 17,
                                        finish = 17,
                                        vref   = "<LOOP>",
                                        [1]    = 3,
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
                    start  = 1,
                    finish = 1,
                    range  = 11,
                    parent = "<LOOP>",
                    node   = "<LOOP>",
                    value  = {
                        type   = "number",
                        start  = 11,
                        finish = 11,
                        vref   = {
                            [1] = {
                                ref = {
                                    [1] = "<LOOP>",
                                },
                            },
                        },
                        [1]    = 1,
                    },
                    [1]    = "x",
                },
                [2] = {
                    type   = "setglobal",
                    start  = 4,
                    finish = 4,
                    range  = 14,
                    parent = "<LOOP>",
                    node   = "<LOOP>",
                    value  = {
                        type   = "number",
                        start  = 14,
                        finish = 14,
                        vref   = {
                            [1] = {
                                ref = {
                                    [1] = "<LOOP>",
                                },
                            },
                        },
                        [1]    = 2,
                    },
                    [1]    = "y",
                },
                [3] = "<LOOP>",
            },
            [1]    = "_ENV",
        },
        value  = {
            type   = "number",
            start  = 17,
            finish = 17,
            vref   = {
                [1] = {
                    ref = {
                        [1] = "<LOOP>",
                    },
                },
            },
            [1]    = 3,
        },
        [1]    = "z",
    },
}
CHECK'local x, y, z'
{
    type   = "main",
    start  = 1,
    finish = 13,
    locals = {
        [1] = {
            type   = "local",
            start  = 0,
            finish = 0,
            effect = 0,
            parent = "<LOOP>",
            vref   = {
                [1] = {
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
            effect = 14,
            parent = "<LOOP>",
            [1]    = "x",
        },
        [3] = {
            type   = "local",
            start  = 10,
            finish = 10,
            effect = 14,
            parent = "<LOOP>",
            [1]    = "y",
        },
        [4] = {
            type   = "local",
            start  = 13,
            finish = 13,
            effect = 14,
            parent = "<LOOP>",
            [1]    = "z",
        },
    },
    [1]    = {
        type   = "local",
        start  = 7,
        finish = 7,
        effect = 14,
        parent = "<LOOP>",
        [1]    = "x",
    },
    [2]    = {
        type   = "local",
        start  = 10,
        finish = 10,
        effect = 14,
        parent = "<LOOP>",
        [1]    = "y",
    },
    [3]    = {
        type   = "local",
        start  = 13,
        finish = 13,
        effect = 14,
        parent = "<LOOP>",
        [1]    = "z",
    },
}
CHECK'local x, y, z = 1, 2, 3'
{
    type   = "main",
    start  = 1,
    finish = 23,
    locals = {
        [1] = {
            type   = "local",
            start  = 0,
            finish = 0,
            effect = 0,
            parent = "<LOOP>",
            vref   = {
                [1] = {
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
            effect = 24,
            range  = 17,
            parent = "<LOOP>",
            value  = {
                type   = "number",
                start  = 17,
                finish = 17,
                [1]    = 1,
            },
            [1]    = "x",
        },
        [3] = {
            type   = "local",
            start  = 10,
            finish = 10,
            effect = 24,
            range  = 20,
            parent = "<LOOP>",
            value  = {
                type   = "number",
                start  = 20,
                finish = 20,
                [1]    = 2,
            },
            [1]    = "y",
        },
        [4] = {
            type   = "local",
            start  = 13,
            finish = 13,
            effect = 24,
            range  = 23,
            parent = "<LOOP>",
            value  = {
                type   = "number",
                start  = 23,
                finish = 23,
                [1]    = 3,
            },
            [1]    = "z",
        },
    },
    [1]    = {
        type   = "local",
        start  = 7,
        finish = 7,
        effect = 24,
        range  = 17,
        parent = "<LOOP>",
        value  = {
            type   = "number",
            start  = 17,
            finish = 17,
            [1]    = 1,
        },
        [1]    = "x",
    },
    [2]    = {
        type   = "local",
        start  = 10,
        finish = 10,
        effect = 24,
        range  = 20,
        parent = "<LOOP>",
        value  = {
            type   = "number",
            start  = 20,
            finish = 20,
            [1]    = 2,
        },
        [1]    = "y",
    },
    [3]    = {
        type   = "local",
        start  = 13,
        finish = 13,
        effect = 24,
        range  = 23,
        parent = "<LOOP>",
        value  = {
            type   = "number",
            start  = 23,
            finish = 23,
            [1]    = 3,
        },
        [1]    = "z",
    },
}
CHECK'local x, y = y, x'
{
    type   = "main",
    start  = 1,
    finish = 17,
    locals = {
        [1] = {
            type   = "local",
            start  = 0,
            finish = 0,
            effect = 0,
            parent = "<LOOP>",
            vref   = {
                [1] = {
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
                        type   = "local",
                        start  = 7,
                        finish = 7,
                        effect = 18,
                        range  = 14,
                        parent = "<LOOP>",
                        value  = "<LOOP>",
                        [1]    = "x",
                    },
                    node   = "<LOOP>",
                    [1]    = "y",
                },
                [2] = {
                    type   = "getglobal",
                    start  = 17,
                    finish = 17,
                    parent = {
                        type   = "local",
                        start  = 10,
                        finish = 10,
                        effect = 18,
                        range  = 17,
                        parent = "<LOOP>",
                        value  = "<LOOP>",
                        [1]    = "y",
                    },
                    node   = "<LOOP>",
                    [1]    = "x",
                },
            },
            [1]    = "_ENV",
        },
        [2] = {
            type   = "local",
            start  = 7,
            finish = 7,
            effect = 18,
            range  = 14,
            parent = "<LOOP>",
            value  = {
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
                            parent = {
                                type   = "local",
                                start  = 10,
                                finish = 10,
                                effect = 18,
                                range  = 17,
                                parent = "<LOOP>",
                                value  = "<LOOP>",
                                [1]    = "y",
                            },
                            node   = "<LOOP>",
                            [1]    = "x",
                        },
                    },
                    [1]    = "_ENV",
                },
                [1]    = "y",
            },
            [1]    = "x",
        },
        [3] = {
            type   = "local",
            start  = 10,
            finish = 10,
            effect = 18,
            range  = 17,
            parent = "<LOOP>",
            value  = {
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
                                type   = "local",
                                start  = 7,
                                finish = 7,
                                effect = 18,
                                range  = 14,
                                parent = "<LOOP>",
                                value  = "<LOOP>",
                                [1]    = "x",
                            },
                            node   = "<LOOP>",
                            [1]    = "y",
                        },
                        [2] = "<LOOP>",
                    },
                    [1]    = "_ENV",
                },
                [1]    = "x",
            },
            [1]    = "y",
        },
    },
    [1]    = {
        type   = "local",
        start  = 7,
        finish = 7,
        effect = 18,
        range  = 14,
        parent = "<LOOP>",
        value  = {
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
                        parent = {
                            type   = "local",
                            start  = 10,
                            finish = 10,
                            effect = 18,
                            range  = 17,
                            parent = "<LOOP>",
                            value  = "<LOOP>",
                            [1]    = "y",
                        },
                        node   = "<LOOP>",
                        [1]    = "x",
                    },
                },
                [1]    = "_ENV",
            },
            [1]    = "y",
        },
        [1]    = "x",
    },
    [2]    = {
        type   = "local",
        start  = 10,
        finish = 10,
        effect = 18,
        range  = 17,
        parent = "<LOOP>",
        value  = {
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
                            type   = "local",
                            start  = 7,
                            finish = 7,
                            effect = 18,
                            range  = 14,
                            parent = "<LOOP>",
                            value  = "<LOOP>",
                            [1]    = "x",
                        },
                        node   = "<LOOP>",
                        [1]    = "y",
                    },
                    [2] = "<LOOP>",
                },
                [1]    = "_ENV",
            },
            [1]    = "x",
        },
        [1]    = "y",
    },
}
CHECK'local x, y = f()'
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
                        type      = "call",
                        start     = 14,
                        finish    = 16,
                        parent    = {
                            type   = "select",
                            start  = 14,
                            finish = 16,
                            parent = {
                                type   = "local",
                                start  = 7,
                                finish = 7,
                                effect = 17,
                                range  = 16,
                                parent = "<LOOP>",
                                value  = "<LOOP>",
                                [1]    = "x",
                            },
                            vararg = "<LOOP>",
                            index  = 1,
                        },
                        extParent = {
                            [1] = {
                                type   = "select",
                                start  = 14,
                                finish = 16,
                                parent = {
                                    type   = "local",
                                    start  = 10,
                                    finish = 10,
                                    effect = 17,
                                    range  = 16,
                                    parent = "<LOOP>",
                                    value  = "<LOOP>",
                                    [1]    = "y",
                                },
                                vararg = "<LOOP>",
                                index  = 2,
                            },
                        },
                        node      = "<LOOP>",
                    },
                    node   = "<LOOP>",
                    [1]    = "f",
                },
            },
            [1]    = "_ENV",
        },
        [2] = {
            type   = "local",
            start  = 7,
            finish = 7,
            effect = 17,
            range  = 16,
            parent = "<LOOP>",
            value  = {
                type   = "select",
                start  = 14,
                finish = 16,
                parent = "<LOOP>",
                vararg = {
                    type      = "call",
                    start     = 14,
                    finish    = 16,
                    parent    = "<LOOP>",
                    extParent = {
                        [1] = {
                            type   = "select",
                            start  = 14,
                            finish = 16,
                            parent = {
                                type   = "local",
                                start  = 10,
                                finish = 10,
                                effect = 17,
                                range  = 16,
                                parent = "<LOOP>",
                                value  = "<LOOP>",
                                [1]    = "y",
                            },
                            vararg = "<LOOP>",
                            index  = 2,
                        },
                    },
                    node      = {
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
                        [1]    = "f",
                    },
                },
                index  = 1,
            },
            [1]    = "x",
        },
        [3] = {
            type   = "local",
            start  = 10,
            finish = 10,
            effect = 17,
            range  = 16,
            parent = "<LOOP>",
            value  = {
                type   = "select",
                start  = 14,
                finish = 16,
                parent = "<LOOP>",
                vararg = {
                    type      = "call",
                    start     = 14,
                    finish    = 16,
                    parent    = {
                        type   = "select",
                        start  = 14,
                        finish = 16,
                        parent = {
                            type   = "local",
                            start  = 7,
                            finish = 7,
                            effect = 17,
                            range  = 16,
                            parent = "<LOOP>",
                            value  = "<LOOP>",
                            [1]    = "x",
                        },
                        vararg = "<LOOP>",
                        index  = 1,
                    },
                    extParent = {
                        [1] = "<LOOP>",
                    },
                    node      = {
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
                        [1]    = "f",
                    },
                },
                index  = 2,
            },
            [1]    = "y",
        },
    },
    [1]    = {
        type   = "local",
        start  = 7,
        finish = 7,
        effect = 17,
        range  = 16,
        parent = "<LOOP>",
        value  = {
            type   = "select",
            start  = 14,
            finish = 16,
            parent = "<LOOP>",
            vararg = {
                type      = "call",
                start     = 14,
                finish    = 16,
                parent    = "<LOOP>",
                extParent = {
                    [1] = {
                        type   = "select",
                        start  = 14,
                        finish = 16,
                        parent = {
                            type   = "local",
                            start  = 10,
                            finish = 10,
                            effect = 17,
                            range  = 16,
                            parent = "<LOOP>",
                            value  = "<LOOP>",
                            [1]    = "y",
                        },
                        vararg = "<LOOP>",
                        index  = 2,
                    },
                },
                node      = {
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
                    [1]    = "f",
                },
            },
            index  = 1,
        },
        [1]    = "x",
    },
    [2]    = {
        type   = "local",
        start  = 10,
        finish = 10,
        effect = 17,
        range  = 16,
        parent = "<LOOP>",
        value  = {
            type   = "select",
            start  = 14,
            finish = 16,
            parent = "<LOOP>",
            vararg = {
                type      = "call",
                start     = 14,
                finish    = 16,
                parent    = {
                    type   = "select",
                    start  = 14,
                    finish = 16,
                    parent = {
                        type   = "local",
                        start  = 7,
                        finish = 7,
                        effect = 17,
                        range  = 16,
                        parent = "<LOOP>",
                        value  = "<LOOP>",
                        [1]    = "x",
                    },
                    vararg = "<LOOP>",
                    index  = 1,
                },
                extParent = {
                    [1] = "<LOOP>",
                },
                node      = {
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
                    [1]    = "f",
                },
            },
            index  = 2,
        },
        [1]    = "y",
    },
}
CHECK'local x, y = (f())'
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
                    start  = 15,
                    finish = 15,
                    parent = {
                        type   = "call",
                        start  = 15,
                        finish = 17,
                        parent = {
                            type   = "paren",
                            start  = 14,
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
                        node   = "<LOOP>",
                    },
                    node   = "<LOOP>",
                    [1]    = "f",
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
                start  = 14,
                finish = 18,
                parent = "<LOOP>",
                exp    = {
                    type   = "call",
                    start  = 15,
                    finish = 17,
                    parent = "<LOOP>",
                    node   = {
                        type   = "getglobal",
                        start  = 15,
                        finish = 15,
                        parent = "<LOOP>",
                        node   = {
                            type   = "local",
                            start  = 0,
                            finish = 0,
                            effect = 0,
                            parent = "<LOOP>",
                            vref   = {
                                [1] = {
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
                        [1]    = "f",
                    },
                },
            },
            [1]    = "x",
        },
        [3] = {
            type   = "local",
            start  = 10,
            finish = 10,
            effect = 19,
            parent = "<LOOP>",
            [1]    = "y",
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
            start  = 14,
            finish = 18,
            parent = "<LOOP>",
            exp    = {
                type   = "call",
                start  = 15,
                finish = 17,
                parent = "<LOOP>",
                node   = {
                    type   = "getglobal",
                    start  = 15,
                    finish = 15,
                    parent = "<LOOP>",
                    node   = {
                        type   = "local",
                        start  = 0,
                        finish = 0,
                        effect = 0,
                        parent = "<LOOP>",
                        vref   = {
                            [1] = {
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
                    [1]    = "f",
                },
            },
        },
        [1]    = "x",
    },
    [2]    = {
        type   = "local",
        start  = 10,
        finish = 10,
        effect = 19,
        parent = "<LOOP>",
        [1]    = "y",
    },
}
CHECK'local x, y = f(), nil'
{
    type   = "main",
    start  = 1,
    finish = 21,
    locals = {
        [1] = {
            type   = "local",
            start  = 0,
            finish = 0,
            effect = 0,
            parent = "<LOOP>",
            vref   = {
                [1] = {
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
                        type   = "call",
                        start  = 14,
                        finish = 16,
                        parent = {
                            type   = "select",
                            start  = 14,
                            finish = 16,
                            parent = {
                                type   = "local",
                                start  = 7,
                                finish = 7,
                                effect = 22,
                                range  = 16,
                                parent = "<LOOP>",
                                value  = "<LOOP>",
                                [1]    = "x",
                            },
                            vararg = "<LOOP>",
                            index  = 1,
                        },
                        node   = "<LOOP>",
                    },
                    node   = "<LOOP>",
                    [1]    = "f",
                },
            },
            [1]    = "_ENV",
        },
        [2] = {
            type   = "local",
            start  = 7,
            finish = 7,
            effect = 22,
            range  = 16,
            parent = "<LOOP>",
            value  = {
                type   = "select",
                start  = 14,
                finish = 16,
                parent = "<LOOP>",
                vararg = {
                    type   = "call",
                    start  = 14,
                    finish = 16,
                    parent = "<LOOP>",
                    node   = {
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
                        [1]    = "f",
                    },
                },
                index  = 1,
            },
            [1]    = "x",
        },
        [3] = {
            type   = "local",
            start  = 10,
            finish = 10,
            effect = 22,
            range  = 21,
            parent = "<LOOP>",
            value  = {
                type   = "nil",
                start  = 19,
                finish = 21,
            },
            [1]    = "y",
        },
    },
    [1]    = {
        type   = "local",
        start  = 7,
        finish = 7,
        effect = 22,
        range  = 16,
        parent = "<LOOP>",
        value  = {
            type   = "select",
            start  = 14,
            finish = 16,
            parent = "<LOOP>",
            vararg = {
                type   = "call",
                start  = 14,
                finish = 16,
                parent = "<LOOP>",
                node   = {
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
                    [1]    = "f",
                },
            },
            index  = 1,
        },
        [1]    = "x",
    },
    [2]    = {
        type   = "local",
        start  = 10,
        finish = 10,
        effect = 22,
        range  = 21,
        parent = "<LOOP>",
        value  = {
            type   = "nil",
            start  = 19,
            finish = 21,
        },
        [1]    = "y",
    },
}
CHECK'local x, y = ...'
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
            effect = 17,
            range  = 16,
            parent = "<LOOP>",
            value  = {
                type   = "select",
                start  = 14,
                finish = 16,
                parent = "<LOOP>",
                vararg = {
                    type      = "varargs",
                    start     = 14,
                    finish    = 16,
                    parent    = "<LOOP>",
                    extParent = {
                        [1] = {
                            type   = "select",
                            start  = 14,
                            finish = 16,
                            parent = {
                                type   = "local",
                                start  = 10,
                                finish = 10,
                                effect = 17,
                                range  = 16,
                                parent = "<LOOP>",
                                value  = "<LOOP>",
                                [1]    = "y",
                            },
                            vararg = "<LOOP>",
                            index  = 2,
                        },
                    },
                },
                index  = 1,
            },
            [1]    = "x",
        },
        [3] = {
            type   = "local",
            start  = 10,
            finish = 10,
            effect = 17,
            range  = 16,
            parent = "<LOOP>",
            value  = {
                type   = "select",
                start  = 14,
                finish = 16,
                parent = "<LOOP>",
                vararg = {
                    type      = "varargs",
                    start     = 14,
                    finish    = 16,
                    parent    = {
                        type   = "select",
                        start  = 14,
                        finish = 16,
                        parent = {
                            type   = "local",
                            start  = 7,
                            finish = 7,
                            effect = 17,
                            range  = 16,
                            parent = "<LOOP>",
                            value  = "<LOOP>",
                            [1]    = "x",
                        },
                        vararg = "<LOOP>",
                        index  = 1,
                    },
                    extParent = {
                        [1] = "<LOOP>",
                    },
                },
                index  = 2,
            },
            [1]    = "y",
        },
    },
    [1]    = {
        type   = "local",
        start  = 7,
        finish = 7,
        effect = 17,
        range  = 16,
        parent = "<LOOP>",
        value  = {
            type   = "select",
            start  = 14,
            finish = 16,
            parent = "<LOOP>",
            vararg = {
                type      = "varargs",
                start     = 14,
                finish    = 16,
                parent    = "<LOOP>",
                extParent = {
                    [1] = {
                        type   = "select",
                        start  = 14,
                        finish = 16,
                        parent = {
                            type   = "local",
                            start  = 10,
                            finish = 10,
                            effect = 17,
                            range  = 16,
                            parent = "<LOOP>",
                            value  = "<LOOP>",
                            [1]    = "y",
                        },
                        vararg = "<LOOP>",
                        index  = 2,
                    },
                },
            },
            index  = 1,
        },
        [1]    = "x",
    },
    [2]    = {
        type   = "local",
        start  = 10,
        finish = 10,
        effect = 17,
        range  = 16,
        parent = "<LOOP>",
        value  = {
            type   = "select",
            start  = 14,
            finish = 16,
            parent = "<LOOP>",
            vararg = {
                type      = "varargs",
                start     = 14,
                finish    = 16,
                parent    = {
                    type   = "select",
                    start  = 14,
                    finish = 16,
                    parent = {
                        type   = "local",
                        start  = 7,
                        finish = 7,
                        effect = 17,
                        range  = 16,
                        parent = "<LOOP>",
                        value  = "<LOOP>",
                        [1]    = "x",
                    },
                    vararg = "<LOOP>",
                    index  = 1,
                },
                extParent = {
                    [1] = "<LOOP>",
                },
            },
            index  = 2,
        },
        [1]    = "y",
    },
}
CHECK'local x, y = (...)'
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
            effect = 19,
            range  = 18,
            parent = "<LOOP>",
            value  = {
                type   = "paren",
                start  = 14,
                finish = 18,
                parent = "<LOOP>",
                exp    = {
                    type   = "varargs",
                    start  = 15,
                    finish = 17,
                    parent = "<LOOP>",
                },
            },
            [1]    = "x",
        },
        [3] = {
            type   = "local",
            start  = 10,
            finish = 10,
            effect = 19,
            parent = "<LOOP>",
            [1]    = "y",
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
            start  = 14,
            finish = 18,
            parent = "<LOOP>",
            exp    = {
                type   = "varargs",
                start  = 15,
                finish = 17,
                parent = "<LOOP>",
            },
        },
        [1]    = "x",
    },
    [2]    = {
        type   = "local",
        start  = 10,
        finish = 10,
        effect = 19,
        parent = "<LOOP>",
        [1]    = "y",
    },
}
CHECK'local x, y = ..., nil'
{
    type   = "main",
    start  = 1,
    finish = 21,
    locals = {
        [1] = {
            type   = "local",
            start  = 0,
            finish = 0,
            effect = 0,
            parent = "<LOOP>",
            vref   = {
                [1] = {
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
            effect = 22,
            range  = 16,
            parent = "<LOOP>",
            value  = {
                type   = "select",
                start  = 14,
                finish = 16,
                parent = "<LOOP>",
                vararg = {
                    type   = "varargs",
                    start  = 14,
                    finish = 16,
                    parent = "<LOOP>",
                },
                index  = 1,
            },
            [1]    = "x",
        },
        [3] = {
            type   = "local",
            start  = 10,
            finish = 10,
            effect = 22,
            range  = 21,
            parent = "<LOOP>",
            value  = {
                type   = "nil",
                start  = 19,
                finish = 21,
            },
            [1]    = "y",
        },
    },
    [1]    = {
        type   = "local",
        start  = 7,
        finish = 7,
        effect = 22,
        range  = 16,
        parent = "<LOOP>",
        value  = {
            type   = "select",
            start  = 14,
            finish = 16,
            parent = "<LOOP>",
            vararg = {
                type   = "varargs",
                start  = 14,
                finish = 16,
                parent = "<LOOP>",
            },
            index  = 1,
        },
        [1]    = "x",
    },
    [2]    = {
        type   = "local",
        start  = 10,
        finish = 10,
        effect = 22,
        range  = 21,
        parent = "<LOOP>",
        value  = {
            type   = "nil",
            start  = 19,
            finish = 21,
        },
        [1]    = "y",
    },
}
CHECK'local x <const>, y <close> = 1'
{
    type   = "main",
    start  = 1,
    finish = 30,
    locals = {
        [1] = {
            type   = "local",
            start  = 0,
            finish = 0,
            effect = 0,
            parent = "<LOOP>",
            vref   = {
                [1] = {
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
            effect = 31,
            range  = 30,
            parent = "<LOOP>",
            value  = {
                type   = "number",
                start  = 30,
                finish = 30,
                [1]    = 1,
            },
            attrs  = {
                [1] = {
                    type   = "localattr",
                    start  = 10,
                    finish = 14,
                    [1]    = "const",
                },
            },
            [1]    = "x",
        },
        [3] = {
            type   = "local",
            start  = 18,
            finish = 18,
            effect = 31,
            parent = "<LOOP>",
            attrs  = {
                [1] = {
                    type   = "localattr",
                    start  = 21,
                    finish = 25,
                    [1]    = "close",
                },
            },
            [1]    = "y",
        },
    },
    [1]    = {
        type   = "local",
        start  = 7,
        finish = 7,
        effect = 31,
        range  = 30,
        parent = "<LOOP>",
        value  = {
            type   = "number",
            start  = 30,
            finish = 30,
            [1]    = 1,
        },
        attrs  = {
            [1] = {
                type   = "localattr",
                start  = 10,
                finish = 14,
                [1]    = "const",
            },
        },
        [1]    = "x",
    },
    [2]    = {
        type   = "local",
        start  = 18,
        finish = 18,
        effect = 31,
        parent = "<LOOP>",
        attrs  = {
            [1] = {
                type   = "localattr",
                start  = 21,
                finish = 25,
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
                    type  = "table",
                    tag   = "_ENV",
                    child = {
                        ["string|x"] = {
                            [1] = {
                                ref = {
                                    [1] = {
                                        type   = "number",
                                        start  = 5,
                                        finish = 5,
                                        vref   = "<LOOP>",
                                        [1]    = 1,
                                    },
                                },
                            },
                        },
                        ["string|y"] = {
                            [1] = {
                                ref = {
                                    [1] = {
                                        type   = "number",
                                        start  = 11,
                                        finish = 11,
                                        vref   = "<LOOP>",
                                        [1]    = 2,
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
                    start  = 1,
                    finish = 1,
                    range  = 5,
                    parent = "<LOOP>",
                    node   = "<LOOP>",
                    value  = {
                        type   = "number",
                        start  = 5,
                        finish = 5,
                        vref   = {
                            [1] = {
                                ref = {
                                    [1] = "<LOOP>",
                                },
                            },
                        },
                        [1]    = 1,
                    },
                    [1]    = "x",
                },
                [2] = {
                    type   = "setglobal",
                    start  = 7,
                    finish = 7,
                    range  = 11,
                    parent = "<LOOP>",
                    node   = "<LOOP>",
                    value  = {
                        type   = "number",
                        start  = 11,
                        finish = 11,
                        vref   = {
                            [1] = {
                                ref = {
                                    [1] = "<LOOP>",
                                },
                            },
                        },
                        [1]    = 2,
                    },
                    [1]    = "y",
                },
            },
            [1]    = "_ENV",
        },
    },
    [1]    = {
        type   = "setglobal",
        start  = 1,
        finish = 1,
        range  = 5,
        parent = "<LOOP>",
        node   = {
            type   = "local",
            start  = 0,
            finish = 0,
            effect = 0,
            parent = "<LOOP>",
            vref   = {
                [1] = {
                    type  = "table",
                    tag   = "_ENV",
                    child = {
                        ["string|x"] = {
                            [1] = {
                                ref = {
                                    [1] = {
                                        type   = "number",
                                        start  = 5,
                                        finish = 5,
                                        vref   = "<LOOP>",
                                        [1]    = 1,
                                    },
                                },
                            },
                        },
                        ["string|y"] = {
                            [1] = {
                                ref = {
                                    [1] = {
                                        type   = "number",
                                        start  = 11,
                                        finish = 11,
                                        vref   = "<LOOP>",
                                        [1]    = 2,
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
                [2] = {
                    type   = "setglobal",
                    start  = 7,
                    finish = 7,
                    range  = 11,
                    parent = "<LOOP>",
                    node   = "<LOOP>",
                    value  = {
                        type   = "number",
                        start  = 11,
                        finish = 11,
                        vref   = {
                            [1] = {
                                ref = {
                                    [1] = "<LOOP>",
                                },
                            },
                        },
                        [1]    = 2,
                    },
                    [1]    = "y",
                },
            },
            [1]    = "_ENV",
        },
        value  = {
            type   = "number",
            start  = 5,
            finish = 5,
            vref   = {
                [1] = {
                    ref = {
                        [1] = "<LOOP>",
                    },
                },
            },
            [1]    = 1,
        },
        [1]    = "x",
    },
    [2]    = {
        type   = "setglobal",
        start  = 7,
        finish = 7,
        range  = 11,
        parent = "<LOOP>",
        node   = {
            type   = "local",
            start  = 0,
            finish = 0,
            effect = 0,
            parent = "<LOOP>",
            vref   = {
                [1] = {
                    type  = "table",
                    tag   = "_ENV",
                    child = {
                        ["string|x"] = {
                            [1] = {
                                ref = {
                                    [1] = {
                                        type   = "number",
                                        start  = 5,
                                        finish = 5,
                                        vref   = "<LOOP>",
                                        [1]    = 1,
                                    },
                                },
                            },
                        },
                        ["string|y"] = {
                            [1] = {
                                ref = {
                                    [1] = {
                                        type   = "number",
                                        start  = 11,
                                        finish = 11,
                                        vref   = "<LOOP>",
                                        [1]    = 2,
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
                    start  = 1,
                    finish = 1,
                    range  = 5,
                    parent = "<LOOP>",
                    node   = "<LOOP>",
                    value  = {
                        type   = "number",
                        start  = 5,
                        finish = 5,
                        vref   = {
                            [1] = {
                                ref = {
                                    [1] = "<LOOP>",
                                },
                            },
                        },
                        [1]    = 1,
                    },
                    [1]    = "x",
                },
                [2] = "<LOOP>",
            },
            [1]    = "_ENV",
        },
        value  = {
            type   = "number",
            start  = 11,
            finish = 11,
            vref   = {
                [1] = {
                    ref = {
                        [1] = "<LOOP>",
                    },
                },
            },
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
                    type  = "table",
                    tag   = "_ENV",
                    child = {
                        ["string|x"] = {
                            [1] = {
                                ref = {
                                    [1] = {
                                        type   = "number",
                                        start  = 8,
                                        finish = 8,
                                        vref   = "<LOOP>",
                                        [1]    = 1,
                                    },
                                },
                            },
                        },
                        ["string|y"] = {
                            [1] = {
                                ref = {
                                    [1] = {
                                        type   = "number",
                                        start  = 11,
                                        finish = 11,
                                        vref   = "<LOOP>",
                                        [1]    = 2,
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
                    start  = 1,
                    finish = 1,
                    range  = 8,
                    parent = "<LOOP>",
                    node   = "<LOOP>",
                    value  = {
                        type   = "number",
                        start  = 8,
                        finish = 8,
                        vref   = {
                            [1] = {
                                ref = {
                                    [1] = "<LOOP>",
                                },
                            },
                        },
                        [1]    = 1,
                    },
                    [1]    = "x",
                },
                [2] = {
                    type   = "setglobal",
                    start  = 4,
                    finish = 4,
                    range  = 11,
                    parent = "<LOOP>",
                    node   = "<LOOP>",
                    value  = {
                        type   = "number",
                        start  = 11,
                        finish = 11,
                        vref   = {
                            [1] = {
                                ref = {
                                    [1] = "<LOOP>",
                                },
                            },
                        },
                        [1]    = 2,
                    },
                    [1]    = "y",
                },
            },
            [1]    = "_ENV",
        },
    },
    [1]    = {
        type   = "setglobal",
        start  = 1,
        finish = 1,
        range  = 8,
        parent = "<LOOP>",
        node   = {
            type   = "local",
            start  = 0,
            finish = 0,
            effect = 0,
            parent = "<LOOP>",
            vref   = {
                [1] = {
                    type  = "table",
                    tag   = "_ENV",
                    child = {
                        ["string|x"] = {
                            [1] = {
                                ref = {
                                    [1] = {
                                        type   = "number",
                                        start  = 8,
                                        finish = 8,
                                        vref   = "<LOOP>",
                                        [1]    = 1,
                                    },
                                },
                            },
                        },
                        ["string|y"] = {
                            [1] = {
                                ref = {
                                    [1] = {
                                        type   = "number",
                                        start  = 11,
                                        finish = 11,
                                        vref   = "<LOOP>",
                                        [1]    = 2,
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
                [2] = {
                    type   = "setglobal",
                    start  = 4,
                    finish = 4,
                    range  = 11,
                    parent = "<LOOP>",
                    node   = "<LOOP>",
                    value  = {
                        type   = "number",
                        start  = 11,
                        finish = 11,
                        vref   = {
                            [1] = {
                                ref = {
                                    [1] = "<LOOP>",
                                },
                            },
                        },
                        [1]    = 2,
                    },
                    [1]    = "y",
                },
            },
            [1]    = "_ENV",
        },
        value  = {
            type   = "number",
            start  = 8,
            finish = 8,
            vref   = {
                [1] = {
                    ref = {
                        [1] = "<LOOP>",
                    },
                },
            },
            [1]    = 1,
        },
        [1]    = "x",
    },
    [2]    = {
        type   = "setglobal",
        start  = 4,
        finish = 4,
        range  = 11,
        parent = "<LOOP>",
        node   = {
            type   = "local",
            start  = 0,
            finish = 0,
            effect = 0,
            parent = "<LOOP>",
            vref   = {
                [1] = {
                    type  = "table",
                    tag   = "_ENV",
                    child = {
                        ["string|x"] = {
                            [1] = {
                                ref = {
                                    [1] = {
                                        type   = "number",
                                        start  = 8,
                                        finish = 8,
                                        vref   = "<LOOP>",
                                        [1]    = 1,
                                    },
                                },
                            },
                        },
                        ["string|y"] = {
                            [1] = {
                                ref = {
                                    [1] = {
                                        type   = "number",
                                        start  = 11,
                                        finish = 11,
                                        vref   = "<LOOP>",
                                        [1]    = 2,
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
                    start  = 1,
                    finish = 1,
                    range  = 8,
                    parent = "<LOOP>",
                    node   = "<LOOP>",
                    value  = {
                        type   = "number",
                        start  = 8,
                        finish = 8,
                        vref   = {
                            [1] = {
                                ref = {
                                    [1] = "<LOOP>",
                                },
                            },
                        },
                        [1]    = 1,
                    },
                    [1]    = "x",
                },
                [2] = "<LOOP>",
            },
            [1]    = "_ENV",
        },
        value  = {
            type   = "number",
            start  = 11,
            finish = 11,
            vref   = {
                [1] = {
                    ref = {
                        [1] = "<LOOP>",
                    },
                },
            },
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
    start  = 1,
    finish = 33,
    locals = {
        [1] = {
            type   = "local",
            start  = 0,
            finish = 0,
            effect = 0,
            parent = "<LOOP>",
            vref   = {
                [1] = {
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
            range  = 33,
            parent = "<LOOP>",
            value  = {
                type   = "function",
                start  = 1,
                finish = 33,
                parent = "<LOOP>",
                [1]    = {
                    type   = "return",
                    start  = 24,
                    finish = 30,
                    parent = "<LOOP>",
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
        range  = 33,
        parent = "<LOOP>",
        value  = {
            type   = "function",
            start  = 1,
            finish = 33,
            parent = "<LOOP>",
            [1]    = {
                type   = "return",
                start  = 24,
                finish = 30,
                parent = "<LOOP>",
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
    start  = 1,
    finish = 37,
    locals = {
        [1] = {
            type   = "local",
            start  = 0,
            finish = 0,
            effect = 0,
            parent = "<LOOP>",
            vref   = {
                [1] = {
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
            range  = 37,
            parent = "<LOOP>",
            value  = {
                type   = "function",
                start  = 1,
                finish = 37,
                parent = "<LOOP>",
                [1]    = {
                    type   = "return",
                    start  = 24,
                    finish = 33,
                    parent = "<LOOP>",
                    [1]    = {
                        type   = "call",
                        start  = 31,
                        finish = 33,
                        parent = "<LOOP>",
                        node   = {
                            type   = "getlocal",
                            start  = 31,
                            finish = 31,
                            parent = "<LOOP>",
                            loc    = "<LOOP>",
                            [1]    = "f",
                        },
                    },
                },
            },
            ref    = {
                [1] = {
                    type   = "getlocal",
                    start  = 31,
                    finish = 31,
                    parent = {
                        type   = "call",
                        start  = 31,
                        finish = 33,
                        parent = {
                            type   = "return",
                            start  = 24,
                            finish = 33,
                            parent = {
                                type   = "function",
                                start  = 1,
                                finish = 37,
                                parent = "<LOOP>",
                                [1]    = "<LOOP>",
                            },
                            [1]    = "<LOOP>",
                        },
                        node   = "<LOOP>",
                    },
                    loc    = "<LOOP>",
                    [1]    = "f",
                },
            },
            [1]    = "f",
        },
    },
    [1]    = {
        type   = "local",
        start  = 16,
        finish = 16,
        effect = 1,
        range  = 37,
        parent = "<LOOP>",
        value  = {
            type   = "function",
            start  = 1,
            finish = 37,
            parent = "<LOOP>",
            [1]    = {
                type   = "return",
                start  = 24,
                finish = 33,
                parent = "<LOOP>",
                [1]    = {
                    type   = "call",
                    start  = 31,
                    finish = 33,
                    parent = "<LOOP>",
                    node   = {
                        type   = "getlocal",
                        start  = 31,
                        finish = 31,
                        parent = "<LOOP>",
                        loc    = "<LOOP>",
                        [1]    = "f",
                    },
                },
            },
        },
        ref    = {
            [1] = {
                type   = "getlocal",
                start  = 31,
                finish = 31,
                parent = {
                    type   = "call",
                    start  = 31,
                    finish = 33,
                    parent = {
                        type   = "return",
                        start  = 24,
                        finish = 33,
                        parent = {
                            type   = "function",
                            start  = 1,
                            finish = 37,
                            parent = "<LOOP>",
                            [1]    = "<LOOP>",
                        },
                        [1]    = "<LOOP>",
                    },
                    node   = "<LOOP>",
                },
                loc    = "<LOOP>",
                [1]    = "f",
            },
        },
        [1]    = "f",
    },
}
CHECK[[
local function a(b, c)
    return
end]]
{
    type   = "main",
    start  = 1,
    finish = 37,
    locals = {
        [1] = {
            type   = "local",
            start  = 0,
            finish = 0,
            effect = 0,
            parent = "<LOOP>",
            vref   = {
                [1] = {
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
            range  = 37,
            parent = "<LOOP>",
            value  = {
                type   = "function",
                start  = 1,
                finish = 37,
                parent = "<LOOP>",
                args   = {
                    type   = "funcargs",
                    start  = 17,
                    finish = 22,
                    parent = "<LOOP>",
                    [1]    = {
                        type   = "local",
                        start  = 18,
                        finish = 18,
                        effect = 18,
                        parent = "<LOOP>",
                        [1]    = "b",
                    },
                    [2]    = {
                        type   = "local",
                        start  = 21,
                        finish = 21,
                        effect = 21,
                        parent = "<LOOP>",
                        [1]    = "c",
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
                            finish = 22,
                            parent = "<LOOP>",
                            [1]    = "<LOOP>",
                            [2]    = {
                                type   = "local",
                                start  = 21,
                                finish = 21,
                                effect = 21,
                                parent = "<LOOP>",
                                [1]    = "c",
                            },
                        },
                        [1]    = "b",
                    },
                    [2] = {
                        type   = "local",
                        start  = 21,
                        finish = 21,
                        effect = 21,
                        parent = {
                            type   = "funcargs",
                            start  = 17,
                            finish = 22,
                            parent = "<LOOP>",
                            [1]    = {
                                type   = "local",
                                start  = 18,
                                finish = 18,
                                effect = 18,
                                parent = "<LOOP>",
                                [1]    = "b",
                            },
                            [2]    = "<LOOP>",
                        },
                        [1]    = "c",
                    },
                },
                [1]    = {
                    type   = "return",
                    start  = 28,
                    finish = 34,
                    parent = "<LOOP>",
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
        range  = 37,
        parent = "<LOOP>",
        value  = {
            type   = "function",
            start  = 1,
            finish = 37,
            parent = "<LOOP>",
            args   = {
                type   = "funcargs",
                start  = 17,
                finish = 22,
                parent = "<LOOP>",
                [1]    = {
                    type   = "local",
                    start  = 18,
                    finish = 18,
                    effect = 18,
                    parent = "<LOOP>",
                    [1]    = "b",
                },
                [2]    = {
                    type   = "local",
                    start  = 21,
                    finish = 21,
                    effect = 21,
                    parent = "<LOOP>",
                    [1]    = "c",
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
                        finish = 22,
                        parent = "<LOOP>",
                        [1]    = "<LOOP>",
                        [2]    = {
                            type   = "local",
                            start  = 21,
                            finish = 21,
                            effect = 21,
                            parent = "<LOOP>",
                            [1]    = "c",
                        },
                    },
                    [1]    = "b",
                },
                [2] = {
                    type   = "local",
                    start  = 21,
                    finish = 21,
                    effect = 21,
                    parent = {
                        type   = "funcargs",
                        start  = 17,
                        finish = 22,
                        parent = "<LOOP>",
                        [1]    = {
                            type   = "local",
                            start  = 18,
                            finish = 18,
                            effect = 18,
                            parent = "<LOOP>",
                            [1]    = "b",
                        },
                        [2]    = "<LOOP>",
                    },
                    [1]    = "c",
                },
            },
            [1]    = {
                type   = "return",
                start  = 28,
                finish = 34,
                parent = "<LOOP>",
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
    start  = 1,
    finish = 55,
    locals = {
        [1] = {
            type   = "local",
            start  = 0,
            finish = 0,
            effect = 0,
            parent = "<LOOP>",
            vref   = {
                [1] = {
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
            effect = 21,
            range  = 17,
            parent = "<LOOP>",
            value  = {
                type   = "number",
                start  = 17,
                finish = 17,
                [1]    = 1,
            },
            [1]    = "x",
        },
        [3] = {
            type   = "local",
            start  = 10,
            finish = 10,
            effect = 21,
            range  = 20,
            parent = "<LOOP>",
            value  = {
                type   = "number",
                start  = 20,
                finish = 20,
                [1]    = 2,
            },
            ref    = {
                [1] = {
                    type   = "setlocal",
                    start  = 45,
                    finish = 45,
                    range  = 52,
                    parent = "<LOOP>",
                    loc    = "<LOOP>",
                    value  = {
                        type   = "number",
                        start  = 52,
                        finish = 52,
                        [1]    = 3,
                    },
                    [1]    = "y",
                },
            },
            [1]    = "y",
        },
        [4] = {
            type   = "local",
            start  = 13,
            finish = 13,
            effect = 21,
            parent = "<LOOP>",
            ref    = {
                [1] = {
                    type   = "setlocal",
                    start  = 48,
                    finish = 48,
                    range  = 55,
                    parent = "<LOOP>",
                    loc    = "<LOOP>",
                    value  = {
                        type   = "number",
                        start  = 55,
                        finish = 55,
                        [1]    = 4,
                    },
                    [1]    = "z",
                },
            },
            [1]    = "z",
        },
        [5] = {
            type   = "local",
            start  = 37,
            finish = 37,
            effect = 22,
            range  = 43,
            parent = "<LOOP>",
            value  = {
                type   = "function",
                start  = 22,
                finish = 43,
                parent = "<LOOP>",
            },
            [1]    = "f",
        },
    },
    [1]    = {
        type   = "local",
        start  = 7,
        finish = 7,
        effect = 21,
        range  = 17,
        parent = "<LOOP>",
        value  = {
            type   = "number",
            start  = 17,
            finish = 17,
            [1]    = 1,
        },
        [1]    = "x",
    },
    [2]    = {
        type   = "local",
        start  = 10,
        finish = 10,
        effect = 21,
        range  = 20,
        parent = "<LOOP>",
        value  = {
            type   = "number",
            start  = 20,
            finish = 20,
            [1]    = 2,
        },
        ref    = {
            [1] = {
                type   = "setlocal",
                start  = 45,
                finish = 45,
                range  = 52,
                parent = "<LOOP>",
                loc    = "<LOOP>",
                value  = {
                    type   = "number",
                    start  = 52,
                    finish = 52,
                    [1]    = 3,
                },
                [1]    = "y",
            },
        },
        [1]    = "y",
    },
    [3]    = {
        type   = "local",
        start  = 13,
        finish = 13,
        effect = 21,
        parent = "<LOOP>",
        ref    = {
            [1] = {
                type   = "setlocal",
                start  = 48,
                finish = 48,
                range  = 55,
                parent = "<LOOP>",
                loc    = "<LOOP>",
                value  = {
                    type   = "number",
                    start  = 55,
                    finish = 55,
                    [1]    = 4,
                },
                [1]    = "z",
            },
        },
        [1]    = "z",
    },
    [4]    = {
        type   = "local",
        start  = 37,
        finish = 37,
        effect = 22,
        range  = 43,
        parent = "<LOOP>",
        value  = {
            type   = "function",
            start  = 22,
            finish = 43,
            parent = "<LOOP>",
        },
        [1]    = "f",
    },
    [5]    = {
        type   = "setlocal",
        start  = 45,
        finish = 45,
        range  = 52,
        parent = "<LOOP>",
        loc    = {
            type   = "local",
            start  = 10,
            finish = 10,
            effect = 21,
            range  = 20,
            parent = "<LOOP>",
            value  = {
                type   = "number",
                start  = 20,
                finish = 20,
                [1]    = 2,
            },
            ref    = {
                [1] = "<LOOP>",
            },
            [1]    = "y",
        },
        value  = {
            type   = "number",
            start  = 52,
            finish = 52,
            [1]    = 3,
        },
        [1]    = "y",
    },
    [6]    = {
        type   = "setlocal",
        start  = 48,
        finish = 48,
        range  = 55,
        parent = "<LOOP>",
        loc    = {
            type   = "local",
            start  = 13,
            finish = 13,
            effect = 21,
            parent = "<LOOP>",
            ref    = {
                [1] = "<LOOP>",
            },
            [1]    = "z",
        },
        value  = {
            type   = "number",
            start  = 55,
            finish = 55,
            [1]    = 4,
        },
        [1]    = "z",
    },
}

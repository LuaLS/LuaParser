CHECK'x = 1'
{
    type = 'set',
    [1]  = {
        type   = 'name',
        start  = 1,
        finish = 1,
        [1]    = 'x',
    },
    [2]  = {
        type   = 'number',
        start  = 5,
        finish = 5,
        [1]    = 1,
    }
}
CHECK'x, y, z = 1, 2, 3'
{
    type = 'set',
    [1]  = {
        type = 'list',
        [1]  = {
            type   = 'name',
            start  = 1,
            finish = 1,
            [1]    = 'x',
        },
        [2]  = {
            type   = 'name',
            start  = 4,
            finish = 4,
            [1]    = 'y',
        },
        [3]  = {
            type   = 'name',
            start  = 7,
            finish = 7,
            [1]    = 'z',
        },
    },
    [2]  = {
        type = 'list',
        [1]  = {
            type   = 'number',
            start  = 11,
            finish = 11,
            [1]    = 1,
        },
        [2]  = {
            type   = 'number',
            start  = 14,
            finish = 14,
            [1]    = 2,
        },
        [3]  = {
            type   = 'number',
            start  = 17,
            finish = 17,
            [1]    = 3,
        },
    },
}
CHECK'local x'
{
    type = 'local',
    [1]  = {
        type   = 'name',
        start  = 7,
        finish = 7,
        [1]    = 'x',
    },
}
CHECK'local x, y, z'
{
    type = 'local',
    [1]  = {
        type = 'list',
        [1]  = {
            type   = 'name',
            start  = 7,
            finish = 7,
            [1]    = 'x',
        },
        [2]  = {
            type   = 'name',
            start  = 10,
            finish = 10,
            [1]    = 'y',
        },
        [3]  = {
            type   = 'name',
            start  = 13,
            finish = 13,
            [1]    = 'z',
        },
    },
}
CHECK'local x = 1'
{
    type = 'local',
    [1]  = {
        type   = 'name',
        start  = 7,
        finish = 7,
        [1]    = 'x',
    },
    [2]  = {
        type   = 'number',
        start  = 11,
        finish = 11,
        [1]    = 1,
    }
}
CHECK'local x, y, z = 1, 2, 3'
{
    type = 'local',
    [1]  = {
        type = 'list',
        [1]  = {
            type   = 'name',
            start  = 7,
            finish = 7,
            [1]    = 'x',
        },
        [2]  = {
            type   = 'name',
            start  = 10,
            finish = 10,
            [1]    = 'y',
        },
        [3]  = {
            type   = 'name',
            start  = 13,
            finish = 13,
            [1]    = 'z',
        },
    },
    [2]  = {
        type = 'list',
        [1]  = {
            type   = 'number',
            start  = 17,
            finish = 17,
            [1]    = 1,
        },
        [2]  = {
            type   = 'number',
            start  = 20,
            finish = 20,
            [1]    = 2,
        },
        [3]  = {
            type   = 'number',
            start  = 23,
            finish = 23,
            [1]    = 3,
        },
    },
}
CHECK'x = function () end'
{
    type = 'set',
    [1]  = {
        type   = 'name',
        start  = 1,
        finish = 1,
        [1]    = 'x',
    },
    [2]  = {
        type   = 'function',
        start  = 5,
        finish = 19,
    }
}
CHECK'x.y = function () end'
{
    type = 'set',
    [1]  = {
        type = 'simple',
        [1]  = {
            type   = 'name',
            start  = 1,
            finish = 1,
            [1]    = 'x',
        },
        [2]  = {
            type   = 'name',
            start  = 3,
            finish = 3,
            [1]    = 'y',
        },
    },
    [2]  = {
        type   = 'function',
        start  = 7,
        finish = 21,
    }
}
CHECK'func.x(1, 2)'
{
    type = 'simple',
    [1]  = {
        type   = 'name',
        start  = 1,
        finish = 4,
        [1]    = 'func',
    },
    [2]  = {
        type   = 'name',
        start  = 6,
        finish = 6,
        [1]    = 'x',
    },
    [3]  = {
        type = 'call',
        [1]  = {
            type   = 'number',
            start  = 8,
            finish = 8,
            [1]    = 1,
        },
        [2]  = {
            type   = 'number',
            start  = 11,
            finish = 11,
            [1]    = 2,
        },
    }
}
CHECK'func:x(1, 2)'
{
    type = 'simple',
    [1]  = {
        type   = 'name',
        start  = 1,
        finish = 4,
        [1]    = 'func',
    },
    [2]  = {
        type   = ':',
        start  = 5,
        finish = 5,
    },
    [3]  = {
        type   = 'name',
        start  = 6,
        finish = 6,
        [1]    = 'x',
    },
    [4]  = {
        type = 'call',
        [1]  = {
            type   = 'number',
            start  = 8,
            finish = 8,
            [1]    = 1,
        },
        [2]  = {
            type   = 'number',
            start  = 11,
            finish = 11,
            [1]    = 2,
        },
    }
}
CHECK'("%s"):format(1)'
{
    type = 'simple',
    [1]  = {
        type   = 'string',
        start  = 2,
        finish = 5,
        [1]    = '%s',
    },
    [2]  = {
        type   = ':',
        start  = 7,
        finish = 7,
    },
    [3]  = {
        type   = 'name',
        start  = 8,
        finish = 13,
        [1]    = 'format',
    },
    [4]  = {
        type   = 'call',
        [1]    = {
            type   = 'number',
            start  = 15,
            finish = 15,
            [1]    = 1,
        }
    }
}
CHECK'do end'
{
    type   = 'do',
    start  = 1,
    finish = 6,
}
CHECK'do x = 1 end'
{
    type   = 'do',
    start  = 1,
    finish = 12,
    [1]    = {
        type = 'set',
        [1]  = {
            type   = 'name',
            start  = 4,
            finish = 4,
            [1]    = 'x',
        },
        [2]  = {
            type   = 'number',
            start  = 8,
            finish = 8,
            [1]    = 1,
        }
    }
}
CHECK'break'
{
    type = 'break',
}
CHECK'return'
{
    type = 'return'
}
CHECK'return 1'
{
    type = 'return',
    [1]  = {
        type   = 'number',
        start  = 8,
        finish = 8,
        [1]    = 1,
    }
}
CHECK'return 1, 2'
{
    type = 'return',
    [1]  = {
        type   = 'number',
        start  = 8,
        finish = 8,
        [1]    = 1,
    },
    [2]  = {
        type   = 'number',
        start  = 11,
        finish = 11,
        [1]    = 2,
    }
}
CHECK'::CONTINUE::'
{
    type   = 'label',
    start  = 3,
    finish = 10,
    [1]    = 'CONTINUE',
}
CHECK'goto CONTINUE'
{
    type   = 'goto',
    start  = 6,
    finish = 13,
    [1]    = 'CONTINUE',
}

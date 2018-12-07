CHECK'nil'
{
    type   = 'nil',
    start  = 1,
    finish = 3,
}
CHECK'a'
{
    type   = 'name',
    start  = 1,
    finish = 1,
    [1]    = 'a',
}
CHECK'a.b.c'
{
    type = 'simple',
    [1]  = {
        type   = 'name',
        start  = 1,
        finish = 1,
        [1]    = 'a',
    },
    [2]  = {
        type   = 'name',
        start  = 3,
        finish = 3,
        [1]    = 'b',
    },
    [3]  = {
        type   = 'name',
        start  = 5,
        finish = 5,
        [1]    = 'c',
    },
}
CHECK'func()'
{
    type = 'simple',
    [1]  = {
        type   = 'name',
        start  = 1,
        finish = 4,
        [1]    = 'func',
    },
    [2]  = {
        type   = 'call',
    },
}
CHECK'a.b.c()'
{
    type = 'simple',
    [1]  = {
        type   = 'name',
        start  = 1,
        finish = 1,
        [1]    = 'a',
    },
    [2]  = {
        type   = 'name',
        start  = 3,
        finish = 3,
        [1]    = 'b',
    },
    [3]  = {
        type   = 'name',
        start  = 5,
        finish = 5,
        [1]    = 'c',
    },
    [4]  = {
        type   = 'call',
    },
}
CHECK'1 or 2'
{
    type = 'binary',
    op   = 'or',
    [1]  = {
        type   = 'number',
        start  = 1,
        finish = 1,
        [1]    = 1,
    },
    [2]  = {
        type   = 'number',
        start  = 6,
        finish = 6,
        [1]    = 2,
    },
}
CHECK'1 and 2'
{
    type = 'binary',
    op   = 'and',
    [1]  = {
        type   = 'number',
        start  = 1,
        finish = 1,
        [1]    = 1,
    },
    [2]  = {
        type   = 'number',
        start  = 7,
        finish = 7,
        [1]    = 2,
    },
}
CHECK'1 < 2'
{
    type = 'binary',
    op   = '<',
    [1]  = {
        type   = 'number',
        start  = 1,
        finish = 1,
        [1]    = 1,
    },
    [2]  = {
        type   = 'number',
        start  = 5,
        finish = 5,
        [1]    = 2,
    },
}
CHECK'1 > 2'
{
    type = 'binary',
    op   = '>',
    [1]  = {
        type   = 'number',
        start  = 1,
        finish = 1,
        [1]    = 1,
    },
    [2]  = {
        type   = 'number',
        start  = 5,
        finish = 5,
        [1]    = 2,
    },
}
CHECK'1 <= 2'
{
    type = 'binary',
    op   = '<=',
    [1]  = {
        type   = 'number',
        start  = 1,
        finish = 1,
        [1]    = 1,
    },
    [2]  = {
        type   = 'number',
        start  = 6,
        finish = 6,
        [1]    = 2,
    },
}
CHECK'1 >= 2'
{
    type = 'binary',
    op   = '>=',
    [1]  = {
        type   = 'number',
        start  = 1,
        finish = 1,
        [1]    = 1,
    },
    [2]  = {
        type   = 'number',
        start  = 6,
        finish = 6,
        [1]    = 2,
    },
}
CHECK'1 ~= 2'
{
    type = 'binary',
    op   = '~=',
    [1]  = {
        type   = 'number',
        start  = 1,
        finish = 1,
        [1]    = 1,
    },
    [2]  = {
        type   = 'number',
        start  = 6,
        finish = 6,
        [1]    = 2,
    },
}
CHECK'1 == 2'
{
    type = 'binary',
    op   = '==',
    [1]  = {
        type   = 'number',
        start  = 1,
        finish = 1,
        [1]    = 1,
    },
    [2]  = {
        type   = 'number',
        start  = 6,
        finish = 6,
        [1]    = 2,
    },
}
CHECK'1 | 2'
{
    type = 'binary',
    op   = '|',
    [1]  = {
        type   = 'number',
        start  = 1,
        finish = 1,
        [1]    = 1,
    },
    [2]  = {
        type   = 'number',
        start  = 5,
        finish = 5,
        [1]    = 2,
    },
}
CHECK'1 ~ 2'
{
    type = 'binary',
    op   = '~',
    [1]  = {
        type   = 'number',
        start  = 1,
        finish = 1,
        [1]    = 1,
    },
    [2]  = {
        type   = 'number',
        start  = 5,
        finish = 5,
        [1]    = 2,
    },
}
CHECK'1 & 2'
{
    type = 'binary',
    op   = '&',
    [1]  = {
        type   = 'number',
        start  = 1,
        finish = 1,
        [1]    = 1,
    },
    [2]  = {
        type   = 'number',
        start  = 5,
        finish = 5,
        [1]    = 2,
    },
}
CHECK'1 << 2'
{
    type = 'binary',
    op   = '<<',
    [1]  = {
        type   = 'number',
        start  = 1,
        finish = 1,
        [1]    = 1,
    },
    [2]  = {
        type   = 'number',
        start  = 6,
        finish = 6,
        [1]    = 2,
    },
}
CHECK'1 >> 2'
{
    type = 'binary',
    op   = '>>',
    [1]  = {
        type   = 'number',
        start  = 1,
        finish = 1,
        [1]    = 1,
    },
    [2]  = {
        type   = 'number',
        start  = 6,
        finish = 6,
        [1]    = 2,
    },
}
CHECK'1 .. 2'
{
    type = 'binary',
    op   = '..',
    [1]  = {
        type   = 'number',
        start  = 1,
        finish = 1,
        [1]    = 1,
    },
    [2]  = {
        type   = 'number',
        start  = 6,
        finish = 6,
        [1]    = 2,
    },
}
CHECK'1 + 2'
{
    type = 'binary',
    op   = '+',
    [1]  = {
        type   = 'number',
        start  = 1,
        finish = 1,
        [1]    = 1,
    },
    [2]  = {
        type   = 'number',
        start  = 5,
        finish = 5,
        [1]    = 2,
    },
}
CHECK'1 - 2'
{
    type = 'binary',
    op   = '-',
    [1]  = {
        type   = 'number',
        start  = 1,
        finish = 1,
        [1]    = 1,
    },
    [2]  = {
        type   = 'number',
        start  = 5,
        finish = 5,
        [1]    = 2,
    },
}
CHECK'1 * 2'
{
    type = 'binary',
    op   = '*',
    [1]  = {
        type   = 'number',
        start  = 1,
        finish = 1,
        [1]    = 1,
    },
    [2]  = {
        type   = 'number',
        start  = 5,
        finish = 5,
        [1]    = 2,
    },
}
CHECK'1 / 2'
{
    type = 'binary',
    op   = '/',
    [1]  = {
        type   = 'number',
        start  = 1,
        finish = 1,
        [1]    = 1,
    },
    [2]  = {
        type   = 'number',
        start  = 5,
        finish = 5,
        [1]    = 2,
    },
}
CHECK'1 // 2'
{
    type = 'binary',
    op   = '//',
    [1]  = {
        type   = 'number',
        start  = 1,
        finish = 1,
        [1]    = 1,
    },
    [2]  = {
        type   = 'number',
        start  = 6,
        finish = 6,
        [1]    = 2,
    },
}
CHECK'1 % 2'
{
    type = 'binary',
    op   = '%',
    [1]  = {
        type   = 'number',
        start  = 1,
        finish = 1,
        [1]    = 1,
    },
    [2]  = {
        type   = 'number',
        start  = 5,
        finish = 5,
        [1]    = 2,
    },
}
CHECK'- 1'
{
    type = 'unary',
    op   = '-',
    [1]  = {
        type   = 'number',
        start  = 3,
        finish = 3,
        [1]    = 1,
    },
}
CHECK'~ 1'
{
    type = 'unary',
    op   = '~',
    [1]  = {
        type   = 'number',
        start  = 3,
        finish = 3,
        [1]    = 1,
    },
}
CHECK'not 1'
{
    type = 'unary',
    op   = 'not',
    [1]  = {
        type   = 'number',
        start  = 5,
        finish = 5,
        [1]    = 1,
    },
}
CHECK'# 1'
{
    type = 'unary',
    op   = '#',
    [1]  = {
        type   = 'number',
        start  = 3,
        finish = 3,
        [1]    = 1,
    },
}
CHECK'1 ^ 2'
{
    type = 'binary',
    op   = '^',
    [1]  = {
        type   = 'number',
        start  = 1,
        finish = 1,
        [1]    = 1,
    },
    [2]  = {
        type   = 'number',
        start  = 5,
        finish = 5,
        [1]    = 2,
    },
}
CHECK'1 ^ -2'
{
    type = 'binary',
    op   = '^',
    [1]  = {
        type   = 'number',
        start  = 1,
        finish = 1,
        [1]    = 1,
    },
    [2]  = {
        type = 'unary',
        op   = '-',
        [1]  = {
            type   = 'number',
            start  = 6,
            finish = 6,
            [1]    = 2,
        },
    },
}
CHECK'...'
{
    type   = '...',
    start  = 1,
    finish = 3,
}
CHECK'1 + 2 + 3'
{
    type = 'binary',
    op   = '+',
    [1]  = {
        type = 'binary',
        op   = '+',
        [1]  = {
            type   = 'number',
            start  = 1,
            finish = 1,
            [1]    = 1,
        },
        [2]  = {
            type   = 'number',
            start  = 5,
            finish = 5,
            [1]    = 2,
        },
    },
    [2]  = {
        type   = 'number',
        start  = 9,
        finish = 9,
        [1]    = 3,
    },
}
CHECK'1 + 2 * 3'
{
    type = 'binary',
    op   = '+',
    [1]  = {
        type   = 'number',
        start  = 1,
        finish = 1,
        [1]    = 1,
    },
    [2]  = {
        type = 'binary',
        op   = '*',
        [1]  = {
            type   = 'number',
            start  = 5,
            finish = 5,
            [1]    = 2,
        },
        [2]  = {
            type   = 'number',
            start  = 9,
            finish = 9,
            [1]    = 3,
        },
    },
}
CHECK'- 1 + 2 * 3'
{
    type = 'binary',
    op   = '+',
    [1]  = {
        type = 'unary',
        op   = '-',
        [1]  = {
            type   = 'number',
            start  = 3,
            finish = 3,
            [1]    = 1,
        }
    },
    [2]  = {
        type = 'binary',
        op   = '*',
        [1]  = {
            type   = 'number',
            start  = 7,
            finish = 7,
            [1]    = 2,
        },
        [2]  = {
            type   = 'number',
            start  = 11,
            finish = 11,
            [1]    = 3,
        },
    },
}
-- 幂运算从右向左连接
CHECK'1 ^ 2 ^ 3'
{
    type = 'binary',
    op   = '^',
    [1]  = {
        type   = 'number',
        start  = 1,
        finish = 1,
        [1]    = 1,
    },
    [2]  = {
        type = 'binary',
        op   = '^',
        [1]  = {
            type   = 'number',
            start  = 5,
            finish = 5,
            [1]    = 2,
        },
        [2]  = {
            type   = 'number',
            start  = 9,
            finish = 9,
            [1]    = 3,
        },
    },
}
-- 连接运算从右向左连接
CHECK'1 .. 2 .. 3'
{
    type = 'binary',
    op   = '..',
    [1]  = {
        type   = 'number',
        start  = 1,
        finish = 1,
        [1]    = 1,
    },
    [2]  = {
        type = 'binary',
        op   = '..',
        [1]  = {
            type   = 'number',
            start  = 6,
            finish = 6,
            [1]    = 2,
        },
        [2]  = {
            type   = 'number',
            start  = 11,
            finish = 11,
            [1]    = 3,
        },
    },
}
CHECK'(1)'
{
    type   = 'number',
    start  = 2,
    finish = 2,
    [1]    = 1,
}
CHECK'(1 + 2)'
{
    type = 'binary',
    op   = '+',
    [1]  = {
        type   = 'number',
        start  = 2,
        finish = 2,
        [1]    = 1,
    },
    [2]  = {
        type   = 'number',
        start  = 6,
        finish = 6,
        [1]    = 2,
    },
}
CHECK'func()'
{
    type = 'simple',
    [1]  = {
        type   = 'name',
        start  = 1,
        finish = 4,
        [1]    = 'func',
    },
    [2]  = {
        type   = 'call',
    },
}
CHECK'func(1)'
{
    type = 'simple',
    [1]  = {
        type   = 'name',
        start  = 1,
        finish = 4,
        [1]    = 'func',
    },
    [2]  = {
        type   = 'call',
        [1]    = {
            type   = 'number',
            start  = 6,
            finish = 6,
            [1]    = 1,
        },
    },
}
CHECK'func(1, 2)'
{
    type = 'simple',
    [1]  = {
        type   = 'name',
        start  = 1,
        finish = 4,
        [1]    = 'func',
    },
    [2]  = {
        type   = 'call',
        [1]    = {
            type   = 'number',
            start  = 6,
            finish = 6,
            [1]    = 1,
        },
        [2]    = {
            type   = 'number',
            start  = 9,
            finish = 9,
            [1]    = 2,
        },
    },
}
CHECK'func(...)'
{
    type = 'simple',
    [1]  = {
        type   = 'name',
        start  = 1,
        finish = 4,
        [1]    = 'func',
    },
    [2]  = {
        type   = 'call',
        [1]    = {
            type   = '...',
            start  = 6,
            finish = 8,
        },
    },
}
CHECK'func(1, ...)'
{
    type = 'simple',
    [1]  = {
        type   = 'name',
        start  = 1,
        finish = 4,
        [1]    = 'func',
    },
    [2]  = {
        type   = 'call',
        [1]    = {
            type   = 'number',
            start  = 6,
            finish = 6,
            [1]    = 1,
        },
        [2]    = {
            type   = '...',
            start  = 9,
            finish = 11,
        },
    },
}
CHECK'func ""'
{
    type = 'simple',
    [1]  = {
        type   = 'name',
        start  = 1,
        finish = 4,
        [1]    = 'func',
    },
    [2]  = {
        type   = 'call',
        [1]    = {
            type   = 'string',
            start  = 6,
            finish = 7,
            [1]    = '',
        }
    }
}
CHECK'func {}'
{
    type = 'simple',
    [1]  = {
        type   = 'name',
        start  = 1,
        finish = 4,
        [1]    = 'func',
    },
    [2]  = {
        type   = 'call',
        [1]    = {
            type   = 'table',
            start  = 6,
            finish = 7,
        }
    }
}
CHECK'table[1]'
{
    type = 'simple',
    [1]  = {
        type   = 'name',
        start  = 1,
        finish = 5,
        [1]    = 'table',
    },
    [2]  = {
        type   = 'number',
        start  = 7,
        finish = 7,
        index  = true,
        [1]    = 1,
    }
}
CHECK'get_point().x'
{
    type = 'simple',
    [1]  = {
        type   = 'name',
        start  = 1,
        finish = 9,
        [1]    = 'get_point',
    },
    [2]  = {
        type   = 'call',
    },
    [3]  = {
        type   = 'name',
        start  = 13,
        finish = 13,
        [1]    = 'x',
    }
}
CHECK'obj:remove()'
{
    type = 'simple',
    [1]  = {
        type   = 'name',
        start  = 1,
        finish = 3,
        [1]    = 'obj'
    },
    [2]  = {
        type   = ':',
        start  = 4,
        finish = 4,
    },
    [3]  = {
        type   = 'name',
        start  = 5,
        finish = 10,
        [1]    = 'remove',
    },
    [4]  = {
        type   = 'call',
    },
}
CHECK'(...)[1]'
{
    type = 'simple',
    [1]  = {
        type   = '...',
        start  = 2,
        finish = 4,
    },
    [2]  = {
        type   = 'number',
        start  = 7,
        finish = 7,
        index  = true,
        [1]    = 1,
    },
}
CHECK'function () end'
{
    type   = 'function',
    start  = 1,
    finish = 15,
}
CHECK'function (...) end'
{
    type   = 'function',
    start  = 1,
    finish = 18,
    arg    = {
        type   = '...',
        start  = 11,
        finish = 13,
    },
}
CHECK'function (a, ...) end'
{
    type   = 'function',
    start  = 1,
    finish = 21,
    arg    = {
        type = 'list',
        [1]  = {
            type   = 'name',
            start  = 11,
            finish = 11,
            [1]    = 'a',
        },
        [2]  = {
            type   = '...',
            start  = 14,
            finish = 16,
        },
    },
}
CHECK'{}'
{
    type   = 'table',
    start  = 1,
    finish = 2,
}
CHECK'{...}'
{
    type   = 'table',
    start  = 1,
    finish = 5,
    [1]    = {
        type   = '...',
        start  = 2,
        finish = 4,
    },
}
CHECK'{1, 2, 3}'
{
    type   = 'table',
    start  = 1,
    finish = 9,
    [1]    = {
        type   = 'number',
        start  = 2,
        finish = 2,
        [1]    = 1,
    },
    [2]    = {
        type   = 'number',
        start  = 5,
        finish = 5,
        [1]    = 2,
    },
    [3]    = {
        type   = 'number',
        start  = 8,
        finish = 8,
        [1]    = 3,
    },
}
CHECK'{x = 1, y = 2}'
{
    type   = 'table',
    start  = 1,
    finish = 14,
    [1]    = {
        type = 'pair',
        [1]  = {
            type   = 'name',
            start  = 2,
            finish = 2,
            [1]    = 'x',
        },
        [2]  = {
            type   = 'number',
            start  = 6,
            finish = 6,
            [1]    = 1,
        },
    },
    [2]    = {
        type = 'pair',
        [1]  = {
            type   = 'name',
            start  = 9,
            finish = 9,
            [1]    = 'y',
        },
        [2]  = {
            type   = 'number',
            start  = 13,
            finish = 13,
            [1]    = 2,
        },
    },
}
CHECK'{["x"] = 1, ["y"] = 2}'
{
    type   = 'table',
    start  = 1,
    finish = 22,
    [1]    = {
        type = 'pair',
        [1]  = {
            type   = 'string',
            start  = 3,
            finish = 5,
            index  = true,
            [1]    = 'x',
        },
        [2]  = {
            type   = 'number',
            start  = 10,
            finish = 10,
            [1]    = 1,
        },
    },
    [2]    = {
        type = 'pair',
        [1]  = {
            type   = 'string',
            start  = 14,
            finish = 16,
            index  = true,
            [1]    = 'y',
        },
        [2]  = {
            type   = 'number',
            start  = 21,
            finish = 21,
            [1]    = 2,
        },
    },
}
CHECK'{[x] = 1, [y] = 2}'
{
    type   = 'table',
    start  = 1,
    finish = 18,
    [1]    = {
        type = 'pair',
        [1]  = {
            type   = 'name',
            start  = 3,
            finish = 3,
            index  = true,
            [1]    = 'x',
        },
        [2]  = {
            type   = 'number',
            start  = 8,
            finish = 8,
            [1]    = 1,
        },
    },
    [2]    = {
        type = 'pair',
        [1]  = {
            type   = 'name',
            start  = 12,
            finish = 12,
            index  = true,
            [1]    = 'y',
        },
        [2]  = {
            type   = 'number',
            start  = 17,
            finish = 17,
            [1]    = 2,
        },
    },
}
CHECK'{{}}'
{
    type   = 'table',
    start  = 1,
    finish = 4,
    [1]    = {
        type   = 'table',
        start  = 2,
        finish = 3,
    }
}
CHECK'{ a = { b = { c = {} } } }'
{
    type   = 'table',
    start  = 1,
    finish = 26,
    [1]    = {
        type = 'pair',
        [1]  = {
            type   = 'name',
            start  = 3,
            finish = 3,
            [1]    = 'a',
        },
        [2]  = {
            type   = 'table',
            start  = 7,
            finish = 24,
            [1]    = {
                type = 'pair',
                [1]  = {
                    type   = 'name',
                    start  = 9,
                    finish = 9,
                    [1]    = 'b'
                },
                [2]  = {
                    type   = 'table',
                    start  = 13,
                    finish = 22,
                    [1]    = {
                        type = 'pair',
                        [1]  = {
                            type   = 'name',
                            start  = 15,
                            finish = 15,
                            [1]    = 'c',
                        },
                        [2]  = {
                            type   = 'table',
                            start  = 19,
                            finish = 20,
                        }
                    }
                }
            }
        }
    }
}
CHECK'{{}, {}, {{}, {}}}'
{
    type   = 'table',
    start  = 1,
    finish = 18,
    [1]    = {
        type   = 'table',
        start  = 2,
        finish = 3,
    },
    [2]    = {
        type   = 'table',
        start  = 6,
        finish = 7,
    },
    [3]    = {
        type   = 'table',
        start  = 10,
        finish = 17,
        [1]    = {
            type   = 'table',
            start  = 11,
            finish = 12,
        },
        [2]    = {
            type   = 'table',
            start  = 15,
            finish = 16,
        }
    }
}
CHECK'{1, 2, 3,}'
{
    type   = 'table',
    start  = 1,
    finish = 10,
    [1]    = {
        type   = 'number',
        start  = 2,
        finish = 2,
        [1]    = 1,
    },
    [2]    = {
        type   = 'number',
        start  = 5,
        finish = 5,
        [1]    = 2,
    },
    [3]    = {
        type   = 'number',
        start  = 8,
        finish = 8,
        [1]    = 3,
    },
}

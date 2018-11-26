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
    type = 'or',
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
    type = 'and',
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
    type = '<',
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
    type = '>',
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
    type = '<=',
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
    type = '>=',
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
    type = '~=',
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
    type = '==',
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
    type = '|',
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
    type = '~',
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
    type = '&',
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
    type = '<<',
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
    type = '>>',
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
    type = '..',
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
    type = '+',
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
    type = '-',
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
    type = '*',
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
    type = '/',
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
    type = '//',
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
    type = '%',
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
    type = '-',
    [1]  = {
        type   = 'number',
        start  = 3,
        finish = 3,
        [1]    = 1,
    },
}
CHECK'~ 1'
{
    type = '~',
    [1]  = {
        type   = 'number',
        start  = 3,
        finish = 3,
        [1]    = 1,
    },
}
CHECK'not 1'
{
    type = 'not',
    [1]  = {
        type   = 'number',
        start  = 5,
        finish = 5,
        [1]    = 1,
    },
}
CHECK'# 1'
{
    type = '#',
    [1]  = {
        type   = 'number',
        start  = 3,
        finish = 3,
        [1]    = 1,
    },
}
CHECK'1 ^ 2'
{
    type = '^',
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
    type = '^',
    [1]  = {
        type   = 'number',
        start  = 1,
        finish = 1,
        [1]    = 1,
    },
    [2]  = {
        type = '-',
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
    type = '+',
    [1]  = {
        type = '+',
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
    type = '+',
    [1]  = {
        type   = 'number',
        start  = 1,
        finish = 1,
        [1]    = 1,
    },
    [2]  = {
        type = '*',
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
    type = '+',
    [1]  = {
        type   = '-',
        [1]    = {
            type   = 'number',
            start  = 3,
            finish = 3,
            [1]    = 1,
        }
    },
    [2]  = {
        type = '*',
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
    type = '^',
    [1]  = {
        type   = 'number',
        start  = 1,
        finish = 1,
        [1]    = 1,
    },
    [2]  = {
        type = '^',
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
    type = '..',
    [1]  = {
        type   = 'number',
        start  = 1,
        finish = 1,
        [1]    = 1,
    },
    [2]  = {
        type = '..',
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
    type = '+',
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
        [1]    = 1,
    },
}

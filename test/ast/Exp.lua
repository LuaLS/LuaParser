CHECK'nil'
{
    [1] = {
        type   = 'nil',
        start  = 1,
        finish = 3,
    }
}
CHECK'a'
{
    [1] = {
        type   = 'name',
        start  = 1,
        finish = 1,
        [1]    = 'a',
    }
}
CHECK'a.b'
{
    [1] = {
        type   = 'name',
        start  = 1,
        finish = 1,
        [1]    = 'a',
    },
    [2] = {
        type   = '.',
        start  = 2,
        finish = 2,
    },
    [3] = {
        type   = 'name',
        start  = 3,
        finish = 3,
        [1]    = 'b',
    },
    [4] = {
        type   = 'getfield',
        start  = 1,
        finish = 3,
        parent = 1,
        dot    = 2,
        field  = 3,
    }
}
CHECK'a.b.c'
{
    [1] = {
        type   = 'name',
        start  = 1,
        finish = 1,
        [1]    = 'a',
    },
    [2] = {
        type   = '.',
        start  = 2,
        finish = 2,
    },
    [3] = {
        type   = 'name',
        start  = 3,
        finish = 3,
        [1]    = 'b',
    },
    [4] = {
        type   = 'getfield',
        start  = 1,
        finish = 3,
        parent = 1,
        dot    = 2,
        field  = 3,
    },
    [5] = {
        type   = '.',
        start  = 4,
        finish = 4,
    },
    [6] = {
        type   = 'name',
        start  = 5,
        finish = 5,
        [1]    = 'c',
    },
    [7] = {
        type   = 'getfield',
        start  = 1,
        finish = 5,
        parent = 4,
        dot    = 5,
        field  = 6,
    }
}
CHECK'func()'
{
    [1] = {
        type   = 'name',
        start  = 1,
        finish = 4,
        [1]    = 'func',
    },
    [2] = {
        type   = 'callargs',
        start  = 5,
        finish = 6,
    },
    [3] = {
        type   = 'call',
        start  = 1,
        finish = 6,
        parent = 1,
        args   = 2,
    },
}
CHECK'a.b.c()'
{
    [1] = {
        type   = 'name',
        start  = 1,
        finish = 1,
        [1]    = 'a',
    },
    [2] = {
        type   = '.',
        start  = 2,
        finish = 2,
    },
    [3] = {
        type   = 'name',
        start  = 3,
        finish = 3,
        [1]    = 'b',
    },
    [4] = {
        type   = 'getfield',
        start  = 1,
        finish = 3,
        parent = 1,
        dot    = 2,
        field  = 3,
    },
    [5] = {
        type   = '.',
        start  = 4,
        finish = 4,
    },
    [6] = {
        type   = 'name',
        start  = 5,
        finish = 5,
        [1]    = 'c',
    },
    [7] = {
        type   = 'getfield',
        start  = 1,
        finish = 5,
        parent = 4,
        dot    = 5,
        field  = 6,
    },
    [8] = {
        type   = 'callargs',
        start  = 6,
        finish = 7,
    },
    [9] = {
        type   = 'call',
        parent = 7,
        start  = 1,
        finish = 7,
        args   = 8,
    }
}
CHECK'1 or 2'
{
    [1] = {
        type   = 'number',
        start  = 1,
        finish = 1,
        [1]    = 1,
    },
    [2] = {
        type   = 'or',
        start  = 3,
        finish = 4,
    },
    [3] = {
        type   = 'number',
        start  = 6,
        finish = 6,
        [1]    = 2,
    },
    [4] = {
        type   = 'binary',
        start  = 1,
        finish = 6,
        op     = 2,
        [1]    = 1,
        [2]    = 3,
    },
}
CHECK'1 and 2'
{
    [1] = {
        type   = 'number',
        start  = 1,
        finish = 1,
        [1]    = 1,
    },
    [2] = {
        type   = 'and',
        start  = 3,
        finish = 5,
    },
    [3] = {
        type   = 'number',
        start  = 7,
        finish = 7,
        [1]    = 2,
    },
    [4] = {
        type   = 'binary',
        start  = 1,
        finish = 7,
        op     = 2,
        [1]    = 1,
        [2]    = 3,
    },
}
CHECK'1 < 2'
{
    [1] = {
        type   = 'number',
        start  = 1,
        finish = 1,
        [1]    = 1,
    },
    [2] = {
        type   = '<',
        start  = 3,
        finish = 3,
    },
    [3] = {
        type   = 'number',
        start  = 5,
        finish = 5,
        [1]    = 2,
    },
    [4] = {
        type   = 'binary',
        start  = 1,
        finish = 5,
        op     = 2,
        [1]    = 1,
        [2]    = 3,
    },
}
CHECK'1 > 2'
{
    [1] = {
        type   = 'number',
        start  = 1,
        finish = 1,
        [1]    = 1,
    },
    [2] = {
        type   = '>',
        start  = 3,
        finish = 3,
    },
    [3] = {
        type   = 'number',
        start  = 5,
        finish = 5,
        [1]    = 2,
    },
    [4] = {
        type   = 'binary',
        start  = 1,
        finish = 5,
        op     = 2,
        [1]    = 1,
        [2]    = 3,
    },
}
CHECK'1 <= 2'
{
    [1] = {
        type   = 'number',
        start  = 1,
        finish = 1,
        [1]    = 1,
    },
    [2] = {
        type   = '<=',
        start  = 3,
        finish = 4,
    },
    [3] = {
        type   = 'number',
        start  = 6,
        finish = 6,
        [1]    = 2,
    },
    [4] = {
        type   = 'binary',
        start  = 1,
        finish = 6,
        op     = 2,
        [1]    = 1,
        [2]    = 3,
    },
}
CHECK'1 >= 2'
{
    [1] = {
        type   = 'number',
        start  = 1,
        finish = 1,
        [1]    = 1,
    },
    [2] = {
        type   = '>=',
        start  = 3,
        finish = 4,
    },
    [3] = {
        type   = 'number',
        start  = 6,
        finish = 6,
        [1]    = 2,
    },
    [4] = {
        type   = 'binary',
        start  = 1,
        finish = 6,
        op     = 2,
        [1]    = 1,
        [2]    = 3,
    },
}
CHECK'1 ~= 2'
{
    [1] = {
        type   = 'number',
        start  = 1,
        finish = 1,
        [1]    = 1,
    },
    [2] = {
        type   = '~=',
        start  = 3,
        finish = 4,
    },
    [3] = {
        type   = 'number',
        start  = 6,
        finish = 6,
        [1]    = 2,
    },
    [4] = {
        type   = 'binary',
        start  = 1,
        finish = 6,
        op     = 2,
        [1]    = 1,
        [2]    = 3,
    },
}
CHECK'1 == 2'
{
    [1] = {
        type   = 'number',
        start  = 1,
        finish = 1,
        [1]    = 1,
    },
    [2] = {
        type   = '==',
        start  = 3,
        finish = 4,
    },
    [3] = {
        type   = 'number',
        start  = 6,
        finish = 6,
        [1]    = 2,
    },
    [4] = {
        type   = 'binary',
        start  = 1,
        finish = 6,
        op     = 2,
        [1]    = 1,
        [2]    = 3,
    },
}
CHECK'1 | 2'
{
    [1] = {
        type   = 'number',
        start  = 1,
        finish = 1,
        [1]    = 1,
    },
    [2] = {
        type   = '|',
        start  = 3,
        finish = 3,
    },
    [3] = {
        type   = 'number',
        start  = 5,
        finish = 5,
        [1]    = 2,
    },
    [4] = {
        type   = 'binary',
        start  = 1,
        finish = 5,
        op     = 2,
        [1]    = 1,
        [2]    = 3,
    },
}
CHECK'1 ~ 2'
{
    [1] = {
        type   = 'number',
        start  = 1,
        finish = 1,
        [1]    = 1,
    },
    [2] = {
        type   = '~',
        start  = 3,
        finish = 3,
    },
    [3] = {
        type   = 'number',
        start  = 5,
        finish = 5,
        [1]    = 2,
    },
    [4] = {
        type   = 'binary',
        start  = 1,
        finish = 5,
        op     = 2,
        [1]    = 1,
        [2]    = 3,
    },
}
CHECK'1 & 2'
{
    [1] = {
        type   = 'number',
        start  = 1,
        finish = 1,
        [1]    = 1,
    },
    [2] = {
        type   = '&',
        start  = 3,
        finish = 3,
    },
    [3] = {
        type   = 'number',
        start  = 5,
        finish = 5,
        [1]    = 2,
    },
    [4] = {
        type   = 'binary',
        start  = 1,
        finish = 5,
        op     = 2,
        [1]    = 1,
        [2]    = 3,
    },
}
CHECK'1 << 2'
{
    [1] = {
        type   = 'number',
        start  = 1,
        finish = 1,
        [1]    = 1,
    },
    [2] = {
        type   = '<<',
        start  = 3,
        finish = 4,
    },
    [3] = {
        type   = 'number',
        start  = 6,
        finish = 6,
        [1]    = 2,
    },
    [4] = {
        type   = 'binary',
        start  = 1,
        finish = 6,
        op     = 2,
        [1]    = 1,
        [2]    = 3,
    },
}
CHECK'1 >> 2'
{
    [1] = {
        type   = 'number',
        start  = 1,
        finish = 1,
        [1]    = 1,
    },
    [2] = {
        type   = '>>',
        start  = 3,
        finish = 4,
    },
    [3] = {
        type   = 'number',
        start  = 6,
        finish = 6,
        [1]    = 2,
    },
    [4] = {
        type   = 'binary',
        start  = 1,
        finish = 6,
        op     = 2,
        [1]    = 1,
        [2]    = 3,
    },
}
CHECK'1 .. 2'
{
    [1] = {
        type   = 'number',
        start  = 1,
        finish = 1,
        [1]    = 1,
    },
    [2] = {
        type   = '..',
        start  = 3,
        finish = 4,
    },
    [3] = {
        type   = 'number',
        start  = 6,
        finish = 6,
        [1]    = 2,
    },
    [4] = {
        type   = 'binary',
        start  = 1,
        finish = 6,
        op     = 2,
        [1]    = 1,
        [2]    = 3,
    },
}
CHECK'a .. b'
{
    [1] = {
        type   = 'name',
        start  = 1,
        finish = 1,
        [1]    = 'a',
    },
    [2] = {
        type   = '..',
        start  = 3,
        finish = 4,
    },
    [3] = {
        type   = 'name',
        start  = 6,
        finish = 6,
        [1]    = 'b',
    },
    [4] = {
        type   = 'binary',
        start  = 1,
        finish = 6,
        op     = 2,
        [1]    = 1,
        [2]    = 3,
    },
}
CHECK'1 + 2'
{
    [1] = {
        type   = 'number',
        start  = 1,
        finish = 1,
        [1]    = 1,
    },
    [2] = {
        type   = '+',
        start  = 3,
        finish = 3,
    },
    [3] = {
        type   = 'number',
        start  = 5,
        finish = 5,
        [1]    = 2,
    },
    [4] = {
        type   = 'binary',
        start  = 1,
        finish = 5,
        op     = 2,
        [1]    = 1,
        [2]    = 3,
    },
}
CHECK'1 - 2'
{
    [1] = {
        type   = 'number',
        start  = 1,
        finish = 1,
        [1]    = 1,
    },
    [2] = {
        type   = '-',
        start  = 3,
        finish = 3,
    },
    [3] = {
        type   = 'number',
        start  = 5,
        finish = 5,
        [1]    = 2,
    },
    [4] = {
        type   = 'binary',
        start  = 1,
        finish = 5,
        op     = 2,
        [1]    = 1,
        [2]    = 3,
    },
}
CHECK'1 * 2'
{
    [1] = {
        type   = 'number',
        start  = 1,
        finish = 1,
        [1]    = 1,
    },
    [2] = {
        type   = '*',
        start  = 3,
        finish = 3,
    },
    [3] = {
        type   = 'number',
        start  = 5,
        finish = 5,
        [1]    = 2,
    },
    [4] = {
        type   = 'binary',
        start  = 1,
        finish = 5,
        op     = 2,
        [1]    = 1,
        [2]    = 3,
    },
}
CHECK'1 / 2'
{
    [1] = {
        type   = 'number',
        start  = 1,
        finish = 1,
        [1]    = 1,
    },
    [2] = {
        type   = '/',
        start  = 3,
        finish = 3,
    },
    [3] = {
        type   = 'number',
        start  = 5,
        finish = 5,
        [1]    = 2,
    },
    [4] = {
        type   = 'binary',
        start  = 1,
        finish = 5,
        op     = 2,
        [1]    = 1,
        [2]    = 3,
    },
}
CHECK'1 // 2'
{
    [1] = {
        type   = 'number',
        start  = 1,
        finish = 1,
        [1]    = 1,
    },
    [2] = {
        type   = '//',
        start  = 3,
        finish = 4,
    },
    [3] = {
        type   = 'number',
        start  = 6,
        finish = 6,
        [1]    = 2,
    },
    [4] = {
        type   = 'binary',
        start  = 1,
        finish = 6,
        op     = 2,
        [1]    = 1,
        [2]    = 3,
    },
}
CHECK'1 % 2'
{
    [1] = {
        type   = 'number',
        start  = 1,
        finish = 1,
        [1]    = 1,
    },
    [2] = {
        type   = '%',
        start  = 3,
        finish = 3,
    },
    [3] = {
        type   = 'number',
        start  = 5,
        finish = 5,
        [1]    = 2,
    },
    [4] = {
        type   = 'binary',
        start  = 1,
        finish = 5,
        op     = 2,
        [1]    = 1,
        [2]    = 3,
    },
}
CHECK'- 1'
{
    [1] = {
        type   = '-',
        start  = 1,
        finish = 1,
    },
    [2] = {
        type   = 'number',
        start  = 3,
        finish = 3,
        [1]    = 1,
    },
    [3] = {
        type   = 'unary',
        start  = 1,
        finish = 3,
        op     = 1,
        [1]    = 2,
    },
}
CHECK'~ 1'
{
    [1] = {
        type   = '~',
        start  = 1,
        finish = 1,
    },
    [2] = {
        type   = 'number',
        start  = 3,
        finish = 3,
        [1]    = 1,
    },
    [3] = {
        type   = 'unary',
        start  = 1,
        finish = 3,
        op     = 1,
        [1]    = 2,
    },
}
CHECK'not 1'
{
    [1] = {
        type   = 'not',
        start  = 1,
        finish = 3,
    },
    [2] = {
        type   = 'number',
        start  = 5,
        finish = 5,
        [1]    = 1,
    },
    [3] = {
        type   = 'unary',
        start  = 1,
        finish = 5,
        op     = 1,
        [1]    = 2,
    },
}
CHECK'# 1'
{
    [1] = {
        type   = '#',
        start  = 1,
        finish = 1,
    },
    [2] = {
        type   = 'number',
        start  = 3,
        finish = 3,
        [1]    = 1,
    },
    [3] = {
        type   = 'unary',
        start  = 1,
        finish = 3,
        op     = 1,
        [1]    = 2,
    },
}
CHECK'not not true'
{
    [1] = {
        type   = 'not',
        start  = 1,
        finish = 3,
    },
    [2] = {
        type   = 'not',
        start  = 5,
        finish = 7,
    },
    [3] = {
        type   = 'boolean',
        start  = 9,
        finish = 12,
        [1]    = true,
    },
    [4] = {
        [1] = 3,
        finish = 12,
        op = 2,
        start = 5,
        type = "unary",
    },
    [5] = {
        [1] = 4,
        finish = 12,
        op = 1,
        start = 1,
        type = "unary",
    },
}
CHECK'1 ^ 2'
{
    [1] = {
        type   = 'number',
        start  = 1,
        finish = 1,
        [1]    = 1,
    },
    [2] = {
        type   = '^',
        start  = 3,
        finish = 3,
    },
    [3] = {
        type   = 'number',
        start  = 5,
        finish = 5,
        [1]    = 2,
    },
    [4] = {
        type   = 'binary',
        start  = 1,
        finish = 5,
        op     = 2,
        [1]    = 1,
        [2]    = 3,
    },
}
CHECK'1 ^ -2'
{
    [1] = {
        type   = 'number',
        start  = 1,
        finish = 1,
        [1]    = 1,
    },
    [2] = {
        type   = '^',
        start  = 3,
        finish = 3,
    },
    [3] = {
        type   = '-',
        start  = 5,
        finish = 5,
    },
    [4] = {
        type   = 'number',
        start  = 6,
        finish = 6,
        [1]    = 2,
    },
    [5] = {
        type   = 'unary',
        start  = 5,
        finish = 6,
        op     = 3,
        [1]    = 4,
    },
    [6] = {
        type   = 'binary',
        start  = 1,
        finish = 6,
        op     = 2,
        [1]    = 1,
        [2]    = 5,
    },
}
CHECK'...'
{
    [1] = {
        type   = '...',
        start  = 1,
        finish = 3,
    }
}
CHECK'1 + 2 + 3'
{
    [1] = {
        type   = 'number',
        start  = 1,
        finish = 1,
        [1]    = 1,
    },
    [2] = {
        type   = '+',
        start  = 3,
        finish = 3,
    },
    [3] = {
        type   = 'number',
        start  = 5,
        finish = 5,
        [1]    = 2,
    },
    [4] = {
        type   = '+',
        start  = 7,
        finish = 7,
    },
    [5] = {
        type   = 'number',
        start  = 9,
        finish = 9,
        [1]    = 3,
    },
    [6] = {
        type   = 'binary',
        start  = 1,
        finish = 5,
        op     = 2,
        [1]    = 1,
        [2]    = 3,
    },
    [7] = {
        type   = 'binary',
        start  = 1,
        finish = 9,
        op     = 4,
        [1]    = 6,
        [2]    = 5,
    },
}
CHECK'1 + 2 * 3'
{
    [1] = {
        type   = 'number',
        start  = 1,
        finish = 1,
        [1]    = 1,
    },
    [2] = {
        type   = '+',
        start  = 3,
        finish = 3,
    },
    [3] = {
        type   = 'number',
        start  = 5,
        finish = 5,
        [1]    = 2,
    },
    [4] = {
        type   = '*',
        start  = 7,
        finish = 7,
    },
    [5] = {
        type   = 'number',
        start  = 9,
        finish = 9,
        [1]    = 3,
    },
    [6] = {
        type   = 'binary',
        start  = 5,
        finish = 9,
        op     = 4,
        [1]    = 3,
        [2]    = 5,
    },
    [7] = {
        type   = 'binary',
        start  = 1,
        finish = 9,
        op     = 2,
        [1]    = 1,
        [2]    = 6,
    },
}
CHECK'- 1 + 2 * 3'
{
    [1] = {
        type   = "-",
        start  = 1,
        finish = 1,
    },
    [2] = {
        type   = "number",
        start  = 3,
        finish = 3,
        [1]    = 1,
    },
    [3] = {
        type   = "+",
        start  = 5,
        finish = 5,
    },
    [4] = {
        type   = "number",
        start  = 7,
        finish = 7,
        [1]    = 2,
    },
    [5] = {
        type   = "*",
        start  = 9,
        finish = 9,
    },
    [6] = {
        type   = "number",
        start  = 11,
        finish = 11,
        [1]    = 3,
    },
    [7] = {
        type   = "unary",
        start  = 1,
        finish = 3,
        op     = 1,
        [1]    = 2,
    },
    [8] = {
        type   = "binary",
        start  = 7,
        finish = 11,
        op     = 5,
        [1]    = 4,
        [2]    = 6,
    },
    [9] = {
        type   = "binary",
        start  = 1,
        finish = 11,
        op     = 3,
        [1]    = 7,
        [2]    = 8,
    },
}
-- 幂运算从右向左连接
CHECK'1 ^ 2 ^ 3'
{
    [1] = {
        type   = 'number',
        start  = 1,
        finish = 1,
        [1]    = 1,
    },
    [2] = {
        type   = '^',
        start  = 3,
        finish = 3,
    },
    [3] = {
        type   = 'number',
        start  = 5,
        finish = 5,
        [1]    = 2,
    },
    [4] = {
        type   = '^',
        start  = 7,
        finish = 7,
    },
    [5] = {
        type   = 'number',
        start  = 9,
        finish = 9,
        [1]    = 3,
    },
    [6] = {
        type   = 'binary',
        start  = 5,
        finish = 9,
        op     = 4,
        [1]    = 3,
        [2]    = 5,
    },
    [7] = {
        type   = 'binary',
        start  = 1,
        finish = 9,
        op     = 2,
        [1]    = 1,
        [2]    = 6,
    },
}
-- 连接运算从右向左连接
CHECK'1 .. 2 .. 3'
{
    [1] = {
        type   = 'number',
        start  = 1,
        finish = 1,
        [1]    = 1,
    },
    [2] = {
        type   = '..',
        start  = 3,
        finish = 4,
    },
    [3] = {
        type   = 'number',
        start  = 6,
        finish = 6,
        [1]    = 2,
    },
    [4] = {
        type   = '..',
        start  = 8,
        finish = 9,
    },
    [5] = {
        type   = 'number',
        start  = 11,
        finish = 11,
        [1]    = 3,
    },
    [6] = {
        type   = 'binary',
        start  = 6,
        finish = 11,
        op     = 4,
        [1]    = 3,
        [2]    = 5,
    },
    [7] = {
        type   = 'binary',
        start  = 1,
        finish = 11,
        op     = 2,
        [1]    = 1,
        [2]    = 6,
    },
}
CHECK'(1)'
{
    [1] = {
        type   = 'number',
        start  = 2,
        finish = 2,
        [1]    = 1,
    }
}
CHECK'(1 + 2)'
{
    [1] = {
        type   = 'number',
        start  = 2,
        finish = 2,
        [1]    = 1,
    },
    [2] = {
        type   = '+',
        start  = 4,
        finish = 4,
    },
    [3] = {
        type   = 'number',
        start  = 6,
        finish = 6,
        [1]    = 2,
    },
    [4] = {
        type   = 'binary',
        start  = 2,
        finish = 6,
        op     = 2,
        [1]    = 1,
        [2]    = 3,
    },
}
CHECK'func()'
{
    [1] = {
        type   = "name",
        start  = 1,
        finish = 4,
        [1]    = "func",
    },
    [2] = {
        type   = "callargs",
        start  = 5,
        finish = 6,
    },
    [3] = {
        type   = "call",
        start  = 1,
        finish = 6,
        parent = 1,
        args   = 2,
    },
}
CHECK'func(1)'
{
    [1] = {
        type   = "name",
        start  = 1,
        finish = 4,
        [1]    = "func",
    },
    [2] = {
        type   = "number",
        start  = 6,
        finish = 6,
        [1]    = 1,
    },
    [3] = {
        type   = "callargs",
        start  = 5,
        finish = 7,
        [1]    = 2,
    },
    [4] = {
        type   = "call",
        start  = 1,
        finish = 7,
        parent = 1,
        args   = 3,
    },
}
CHECK'func(1, 2)'
{
    [1] = {
        type = "name",
        start = 1,
        finish = 4,
        [1] = "func",
    },
    [2] = {
        type   = "number",
        start  = 6,
        finish = 6,
        [1]    = 1,
    },
    [3] = {
        type   = ",",
        start  = 7,
        finish = 7,
    },
    [4] = {
        type   = "number",
        start  = 9,
        finish = 9,
        [1]    = 2,
    },
    [5] = {
        type   = "callargs",
        start  = 5,
        finish = 10,
        [1]    = 2,
        [2]    = 4,
    },
    [6] = {
        type   = "call",
        start  = 1,
        finish = 10,
        parent = 1,
        args   = 5,
    },
}
CHECK'func(...)'
{
    [1] = {
        type   = "name",
        start  = 1,
        finish = 4,
        [1]    = "func",
    },
    [2] = {
        type   = "...",
        start  = 6,
        finish = 8,
    },
    [3] = {
        type   = "callargs",
        start  = 5,
        finish = 9,
        [1]    = 2,
    },
    [4] = {
        type   = "call",
        start  = 1,
        finish = 9,
        parent = 1,
        args   = 3,
    },
}
CHECK'func(1, ...)'
{
    [1] = {
        type   = "name",
        start  = 1,
        finish = 4,
        [1]    = "func",
    },
    [2] = {
        type   = "number",
        start  = 6,
        finish = 6,
        [1]    = 1,
    },
    [3] = {
        type   = ",",
        start  = 7,
        finish = 7,
    },
    [4] = {
        type   = "...",
        start  = 9,
        finish = 11,
    },
    [5] = {
        type   = "callargs",
        start  = 5,
        finish = 12,
        [1]    = 2,
        [2]    = 4,
    },
    [6] = {
        type   = "call",
        start  = 1,
        finish = 12,
        parent = 1,
        args   = 5,
    },
}
CHECK'func ""'
{
    [1] = {
        type   = "name",
        start  = 1,
        finish = 4,
        [1]    = "func",
    },
    [2] = {
        type   = "string",
        start  = 6,
        finish = 7,
        [1]    = "",
        [2]    = "\"",
    },
    [3] = {
        type   = "callargs",
        start  = 6,
        finish = 7,
        [1]    = 2,
    },
    [4] = {
        type   = "call",
        start  = 1,
        parent = 1,
        finish = 7,
        args   = 3,
    },
}
CHECK'func {}'
{
    [1] = {
        type   = "name",
        start  = 1,
        finish = 4,
        [1]    = "func",
    },
    [2] = {
        type   = "table",
        start  = 6,
        finish = 7,
    },
    [3] = {
        type   = "callargs",
        start  = 6,
        finish = 7,
        [1]    = 2,
    },
    [4] = {
        type   = "call",
        start  = 1,
        parent = 1,
        finish = 7,
        args   = 3,
    },
}
CHECK'table[1]'
{
	[1] = {
		type   = "name",
		start  = 1,
		finish = 5,
		[1]    = "table",
	},
	[2] = {
		type   = "number",
		start  = 7,
		finish = 7,
		[1]    = 1,
	},
	[3] = {
		type   = "getindex",
		start  = 1,
		finish = 8,
		parent = 1,
		[1]    = 2,
	},
}
CHECK'get_point().x'
{
	[1] = {
		type   = "name",
		start  = 1,
		finish = 9,
		[1]    = "get_point",
	},
	[2] = {
		type   = "callargs",
		start  = 10,
		finish = 11,
	},
	[3] = {
		type   = "call",
		start  = 1,
		finish = 11,
		parent = 1,
		args   = 2,
	},
	[4] = {
		type   = ".",
		start  = 12,
		finish = 12,
	},
	[5] = {
		type   = "name",
		start  = 13,
		finish = 13,
		[1]    = "x",
	},
	[6] = {
		type   = "getfield",
		start  = 1,
		finish = 13,
		dot    = 4,
		parent = 3,
		field  = 5,
	},
}
CHECK'obj:remove()'
{
    type   = 'simple',
    start  = 1,
    finish = 12,
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
        start  = 11,
        finish = 12,
    },
}
CHECK'(...)[1]'
{
    type   = 'simple',
    start  = 2,
    finish = 8,
    [1]  = {
        type   = '...',
        start  = 2,
        finish = 4,
    },
    [2]  = {
        type   = 'index',
        start  = 6,
        finish = 8,
        [1]    = {
            type   = 'number',
            start  = 7,
            finish = 7,
            [1]    = 1,
        },
    }
}
CHECK'function () end'
{
    type      = 'function',
    start     = 1,
    finish    = 15,
    argStart  = 10,
    argFinish = 11,
}
CHECK'function (...) end'
{
    type      = 'function',
    start     = 1,
    finish    = 18,
    argStart  = 10,
    argFinish = 14,
    arg       = {
        type   = '...',
        start  = 11,
        finish = 13,
    },
}
CHECK'function (a, ...) end'
{
    type      = 'function',
    start     = 1,
    finish    = 21,
    argStart  = 10,
    argFinish = 17,
    arg       = {
        type   = 'list',
        start  = 11,
        finish = 16,
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
        type   = 'pair',
        start  = 2,
        finish = 6,
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
        type   = 'pair',
        start  = 9,
        finish = 13,
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
        type   = 'pair',
        start  = 2,
        finish = 10,
        [1]  = {
            type   = 'index',
            start  = 2,
            finish = 6,
            [1]    = {
                type   = 'string',
                start  = 3,
                finish = 5,
                [1]    = 'x',
                [2]    = [=["]=],
            }
        },
        [2]  = {
            type   = 'number',
            start  = 10,
            finish = 10,
            [1]    = 1,
        },
    },
    [2]    = {
        type   = 'pair',
        start  = 13,
        finish = 21,
        [1]  = {
            type   = 'index',
            start  = 13,
            finish = 17,
            [1]    = {
                type   = 'string',
                start  = 14,
                finish = 16,
                [1]    = 'y',
                [2]    = [=["]=],
            }
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
        type   = 'pair',
        start  = 2,
        finish = 8,
        [1]  = {
            type   = 'index',
            start  = 2,
            finish = 4,
            [1]    = {
                type   = 'name',
                start  = 3,
                finish = 3,
                [1]    = 'x',
            }
        },
        [2]  = {
            type   = 'number',
            start  = 8,
            finish = 8,
            [1]    = 1,
        },
    },
    [2]    = {
        type   = 'pair',
        start  = 11,
        finish = 17,
        [1]  = {
            type   = 'index',
            start  = 11,
            finish = 13,
            [1]    = {
                type   = 'name',
                start  = 12,
                finish = 12,
                [1]    = 'y',
            }
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
        type   = 'pair',
        start  = 3,
        finish = 24,
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
                type   = 'pair',
                start  = 9,
                finish = 22,
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
                        type   = 'pair',
                        start  = 15,
                        finish = 20,
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

CHECK 'notify'
{
    type   = 'name',
    start  = 1,
    finish = 6,
    [1]    = 'notify',
}

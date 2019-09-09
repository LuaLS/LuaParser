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
    },
    [2] = {
        type   = "getname",
        start  = 1,
        finish = 1,
        name   = 1
    },
}
CHECK'a.b'
{
    [1] = {
        type   = "name",
        start  = 1,
        finish = 1,
        [1]    = "a",
    },
    [2] = {
        type   = "getname",
        start  = 1,
        finish = 1,
        name   = 1,
    },
    [3] = {
        type   = ".",
        start  = 2,
        finish = 2,
    },
    [4] = {
        type   = "name",
        start  = 3,
        finish = 3,
        [1]    = "b",
    },
    [5] = {
        type   = "getfield",
        start  = 1,
        finish = 3,
        parent = 2,
        dot    = 3,
        field  = 4,
    },
}
CHECK'a.b.c'
{
    [1] = {
        type   = "name",
        start  = 1,
        finish = 1,
        [1]    = "a",
    },
    [2] = {
        type   = "getname",
        start  = 1,
        finish = 1,
        name   = 1,
    },
    [3] = {
        type   = ".",
        start  = 2,
        finish = 2,
    },
    [4] = {
        type   = "name",
        start  = 3,
        finish = 3,
        [1]    = "b",
    },
    [5] = {
        type   = "getfield",
        start  = 1,
        finish = 3,
        parent = 2,
        dot    = 3,
        field  = 4,
    },
    [6] = {
        type   = ".",
        start  = 4,
        finish = 4,
    },
    [7] = {
        type   = "name",
        start  = 5,
        finish = 5,
        [1]    = "c",
    },
    [8] = {
        type   = "getfield",
        start  = 1,
        finish = 5,
        parent = 5,
        dot    = 6,
        field  = 7,
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
        type   = "getname",
        start  = 1,
        finish = 4,
        name   = 1,
    },
    [3] = {
        type   = "callargs",
        start  = 5,
        finish = 6,
    },
    [4] = {
        type   = "call",
        start  = 1,
        finish = 6,
        parent = 2,
        args   = 3,
    },
}
CHECK'a.b.c()'
{
    [01] = {
        type   = "name",
        start  = 1,
        finish = 1,
        [1]    = "a",
    },
    [02] = {
        type   = "getname",
        start  = 1,
        finish = 1,
        name   = 1,
    },
    [03] = {
        type   = ".",
        start  = 2,
        finish = 2,
    },
    [04] = {
        type   = "name",
        start  = 3,
        finish = 3,
        [1]    = "b",
    },
    [05] = {
        type   = "getfield",
        start  = 1,
        finish = 3,
        parent = 2,
        dot    = 3,
        field  = 4,
    },
    [06] = {
        type   = ".",
        start  = 4,
        finish = 4,
    },
    [07] = {
        type   = "name",
        start  = 5,
        finish = 5,
        [1]    = "c",
    },
    [08] = {
        type   = "getfield",
        start  = 1,
        finish = 5,
        parent = 5,
        dot    = 6,
        field  = 7,
    },
    [09] = {
        type   = "callargs",
        start  = 6,
        finish = 7,
    },
    [10] = {
        type   = "call",
        start  = 1,
        finish = 7,
        parent = 8,
        args   = 9,
    },
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
        type   = "name",
        start  = 1,
        finish = 1,
        [1]    = "a",
    },
    [2] = {
        type   = "getname",
        start  = 1,
        finish = 1,
        name   = 1,
    },
    [3] = {
        type   = "..",
        start  = 3,
        finish = 4,
    },
    [4] = {
        type   = "name",
        start  = 6,
        finish = 6,
        [1]    = "b",
    },
    [5] = {
        type   = "getname",
        start  = 6,
        finish = 6,
        name   = 4,
    },
    [6] = {
        type   = "binary",
        start  = 1,
        finish = 6,
        op     = 3,
        [1]    = 2,
        [2]    = 5,
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
        type   = 'varargs',
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
        type   = "number",
        start  = 2,
        finish = 2,
        [1]    = 1,
    },
    [2] = {
        type   = "paren",
        start  = 1,
        finish = 3,
        exp    = 1,
    },
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
    [5] = {
        type   = "paren",
        start  = 1,
        finish = 7,
        exp    = 4,
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
        type   = "getname",
        start  = 1,
        finish = 4,
        name   = 1,
    },
    [3] = {
        type   = "number",
        start  = 6,
        finish = 6,
        [1]    = 1,
    },
    [4] = {
        type   = "callargs",
        start  = 5,
        finish = 7,
        [1]    = 3,
    },
    [5] = {
        type   = "call",
        start  = 1,
        finish = 7,
        parent = 2,
        args   = 4,
    },
}
CHECK'func(1, 2)'
{
    [1] = {
        type   = "name",
        start  = 1,
        finish = 4,
        [1]    = "func",
    },
    [2] = {
        type   = "getname",
        start  = 1,
        finish = 4,
        name   = 1,
    },
    [3] = {
        type   = "number",
        start  = 6,
        finish = 6,
        [1]    = 1,
    },
    [4] = {
        type   = ",",
        start  = 7,
        finish = 7,
    },
    [5] = {
        type   = "number",
        start  = 9,
        finish = 9,
        [1]    = 2,
    },
    [6] = {
        type   = "callargs",
        start  = 5,
        finish = 10,
        [1]    = 3,
        [2]    = 5,
    },
    [7] = {
        type   = "call",
        start  = 1,
        finish = 10,
        parent = 2,
        args   = 6,
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
        type   = "getname",
        start  = 1,
        finish = 4,
        name   = 1,
    },
    [3] = {
        type   = "varargs",
        start  = 6,
        finish = 8,
    },
    [4] = {
        type   = "callargs",
        start  = 5,
        finish = 9,
        [1]    = 3,
    },
    [5] = {
        type   = "call",
        start  = 1,
        finish = 9,
        parent = 2,
        args   = 4,
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
        type   = "getname",
        start  = 1,
        finish = 4,
        name   = 1,
    },
    [3] = {
        type   = "number",
        start  = 6,
        finish = 6,
        [1]    = 1,
    },
    [4] = {
        type   = ",",
        start  = 7,
        finish = 7,
    },
    [5] = {
        type   = "varargs",
        start  = 9,
        finish = 11,
    },
    [6] = {
        type   = "callargs",
        start  = 5,
        finish = 12,
        [1]    = 3,
        [2]    = 5,
    },
    [7] = {
        type   = "call",
        start  = 1,
        finish = 12,
        parent = 2,
        args   = 6,
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
        type   = "getname",
        start  = 1,
        finish = 4,
        name   = 1,
    },
    [3] = {
        type   = "string",
        start  = 6,
        finish = 7,
        [1]    = "",
        [2]    = "\"",
    },
    [4] = {
        type   = "callargs",
        start  = 6,
        finish = 7,
        [1]    = 3,
    },
    [5] = {
        type   = "call",
        start  = 1,
        finish = 7,
        parent = 2,
        args   = 4,
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
        type   = "getname",
        start  = 1,
        finish = 4,
        name   = 1,
    },
    [3] = {
        type   = "table",
        start  = 6,
        finish = 7,
    },
    [4] = {
        type   = "callargs",
        start  = 6,
        finish = 7,
        [1]    = 3,
    },
    [5] = {
        type   = "call",
        start  = 1,
        finish = 7,
        parent = 2,
        args   = 4,
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
        type   = "getname",
        start  = 1,
        finish = 5,
        name   = 1,
    },
    [3] = {
        type   = "number",
        start  = 7,
        finish = 7,
        [1]    = 1,
    },
    [4] = {
        type   = "getindex",
        start  = 1,
        finish = 8,
        parent = 2,
        index  = 3,
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
        type   = "getname",
        start  = 1,
        finish = 9,
        name   = 1,
    },
    [3] = {
        type   = "callargs",
        start  = 10,
        finish = 11,
    },
    [4] = {
        type   = "call",
        start  = 1,
        finish = 11,
        parent = 2,
        args   = 3,
    },
    [5] = {
        type   = ".",
        start  = 12,
        finish = 12,
    },
    [6] = {
        type   = "name",
        start  = 13,
        finish = 13,
        [1]    = "x",
    },
    [7] = {
        type   = "getfield",
        start  = 1,
        finish = 13,
        parent = 4,
        dot    = 5,
        field  = 6,
    },
}
CHECK'obj:remove()'
{
    [1] = {
        type   = "name",
        start  = 1,
        finish = 3,
        [1]    = "obj",
    },
    [2] = {
        type   = "getname",
        start  = 1,
        finish = 3,
        name   = 1,
    },
    [3] = {
        type   = ":",
        start  = 4,
        finish = 4,
    },
    [4] = {
        type   = "name",
        start  = 5,
        finish = 10,
        [1]    = "remove",
    },
    [5] = {
        type   = "getmethod",
        start  = 1,
        finish = 10,
        parent = 2,
        colon  = 3,
        method = 4,
    },
    [6] = {
        type   = "callargs",
        start  = 11,
        finish = 12,
    },
    [7] = {
        type   = "call",
        start  = 1,
        finish = 12,
        parent = 5,
        args   = 6,
    },
}
CHECK'(...)[1]'
{
    [1] = {
        type   = "varargs",
        start  = 2,
        finish = 4,
    },
    [2] = {
        type   = "paren",
        start  = 1,
        finish = 5,
        exp    = 1,
    },
    [3] = {
        type   = "number",
        start  = 7,
        finish = 7,
        [1]    = 1,
    },
    [4] = {
        type   = "getindex",
        start  = 1,
        finish = 8,
        parent = 2,
        index  = 3,
    },
}
CHECK'function () end'
{
    [1] = {
        type   = "funcargs",
        start  = 10,
        finish = 11,
    },
    [2] = {
        type   = "function",
        start  = 1,
        finish = 15,
        args   = 1,
    },
}
CHECK'function (...) end'
{
    [1] = {
        type   = "...",
        start  = 11,
        finish = 13,
    },
    [2] = {
        type   = "funcargs",
        start  = 10,
        finish = 14,
        [1]    = 1,
    },
    [3] = {
        type   = "function",
        start  = 1,
        finish = 18,
        args   = 2,
    },
}
CHECK'function (a, ...) end'
{
    [1] = {
        type   = "name",
        start  = 11,
        finish = 11,
        [1]    = "a",
    },
    [2] = {
        type   = ",",
        start  = 12,
        finish = 12,
    },
    [3] = {
        type   = "...",
        start  = 14,
        finish = 16,
    },
    [4] = {
        type   = "funcargs",
        start  = 10,
        finish = 17,
        [1]    = 1,
        [2]    = 3,
    },
    [5] = {
        type   = "function",
        start  = 1,
        finish = 21,
        args   = 4,
    },
}
CHECK'{}'
{
    [1] = {
        type   = "table",
        start  = 1,
        finish = 2,
    },
}
CHECK'{...}'
{
    [1] = {
        type   = "varargs",
        start  = 2,
        finish = 4,
    },
    [2] = {
        type   = "table",
        start  = 1,
        finish = 5,
        [1]    = 1,
    },
}
CHECK'{1, 2, 3}'
{
    [1] = {
        type   = "number",
        start  = 2,
        finish = 2,
        [1]    = 1,
    },
    [2] = {
        type   = ",",
        start  = 3,
        finish = 3,
    },
    [3] = {
        type   = "number",
        start  = 5,
        finish = 5,
        [1]    = 2,
    },
    [4] = {
        type   = ",",
        start  = 6,
        finish = 6,
    },
    [5] = {
        type   = "number",
        start  = 8,
        finish = 8,
        [1]    = 3,
    },
    [6] = {
        type   = "table",
        start  = 1,
        finish = 9,
        [1]    = 1,
        [2]    = 3,
        [3]    = 5,
    },
}
CHECK'{x = 1, y = 2}'
{
    [1] = {
        type   = "name",
        start  = 2,
        finish = 2,
        [1]    = "x",
    },
    [2] = {
        type   = "number",
        start  = 6,
        finish = 6,
        [1]    = 1,
    },
    [3] = {
        type   = "tablefield",
        start  = 2,
        finish = 6,
        field  = 1,
        value  = 2,
    },
    [4] = {
        type   = ",",
        start  = 7,
        finish = 7,
    },
    [5] = {
        type   = "name",
        start  = 9,
        finish = 9,
        [1]    = "y",
    },
    [6] = {
        type   = "number",
        start  = 13,
        finish = 13,
        [1]    = 2,
    },
    [7] = {
        type   = "tablefield",
        start  = 9,
        finish = 13,
        field  = 5,
        value  = 6,
    },
    [8] = {
        type   = "table",
        start  = 1,
        finish = 14,
        [1]    = 3,
        [2]    = 7,
    },
}
CHECK'{["x"] = 1, ["y"] = 2}'
{
    [1]  = {
        type   = "string",
        start  = 3,
        finish = 5,
        [1]    = "x",
        [2]    = "\"",
    },
    [2]  = {
        type   = "index",
        start  = 2,
        finish = 6,
        index  = 1,
    },
    [3]  = {
        type   = "number",
        start  = 10,
        finish = 10,
        [1]    = 1,
    },
    [4]  = {
        type   = "tableindex",
        start  = 2,
        finish = 10,
        index  = 2,
        value  = 3,
    },
    [5]  = {
        type   = ",",
        start  = 11,
        finish = 11,
    },
    [6]  = {
        type   = "string",
        start  = 14,
        finish = 16,
        [1]    = "y",
        [2]    = "\"",
    },
    [7]  = {
        type   = "index",
        start  = 13,
        finish = 17,
        index  = 6,
    },
    [8]  = {
        type   = "number",
        start  = 21,
        finish = 21,
        [1]    = 2,
    },
    [9]  = {
        type   = "tableindex",
        start  = 13,
        finish = 21,
        index  = 7,
        value  = 8,
    },
    [10] = {
        type   = "table",
        start  = 1,
        finish = 22,
        [1]    = 4,
        [2]    = 9,
    },
}
CHECK'{[x] = 1, [y] = 2}'
{
    [01] = {
        type   = "name",
        start  = 3,
        finish = 3,
        [1]    = "x",
    },
    [02] = {
        type   = "getname",
        start  = 3,
        finish = 3,
        name   = 1,
    },
    [03] = {
        type   = "index",
        start  = 2,
        finish = 4,
        index  = 2,
    },
    [04] = {
        type   = "number",
        start  = 8,
        finish = 8,
        [1]    = 1,
    },
    [05] = {
        value  = 4,
        type   = "tableindex",
        start  = 2,
        finish = 8,
        index  = 3,
    },
    [06] = {
        type   = ",",
        start  = 9,
        finish = 9,
    },
    [07] = {
        type   = "name",
        start  = 12,
        finish = 12,
        [1]    = "y",
    },
    [08] = {
        type   = "getname",
        start  = 12,
        finish = 12,
        name   = 7,
    },
    [09] = {
        type   = "index",
        start  = 11,
        finish = 13,
        index  = 8,
    },
    [10] = {
        type   = "number",
        start  = 17,
        finish = 17,
        [1]    = 2,
    },
    [11] = {
        type   = "tableindex",
        start  = 11,
        finish = 17,
        index  = 9,
        value  = 10,
    },
    [12] = {
        type   = "table",
        start  = 1,
        finish = 18,
        [2]    = 11,
        [1]    = 5,
    },
}
CHECK'{{}}'
{
    [1] = {
        type   = "table",
        start  = 2,
        finish = 3,
    },
    [2] = {
        type   = "table",
        start  = 1,
        finish = 4,
        [1]    = 1,
    },
}
CHECK'{ a = { b = { c = {} } } }'
{
    [1]  = {
        type   = "name",
        start  = 3,
        finish = 3,
        [1]    = "a",
    },
    [2]  = {
        type   = "name",
        start  = 9,
        finish = 9,
        [1]    = "b",
    },
    [3]  = {
        type   = "name",
        start  = 15,
        finish = 15,
        [1]    = "c",
    },
    [4]  = {
        type   = "table",
        start  = 19,
        finish = 20,
    },
    [5]  = {
        type   = "tablefield",
        start  = 15,
        finish = 20,
        field  = 3,
        value  = 4,
    },
    [6]  = {
        type   = "table",
        start  = 13,
        finish = 22,
        [1]    = 5,
    },
    [7]  = {
        type   = "tablefield",
        start  = 9,
        finish = 22,
        field  = 2,
        value  = 6,
    },
    [8]  = {
        type   = "table",
        start  = 7,
        finish = 24,
        [1]    = 7,
    },
    [9]  = {
        type   = "tablefield",
        start  = 3,
        finish = 24,
        field  = 1,
        value  = 8,
    },
    [10] = {
        type   = "table",
        start  = 1,
        finish = 26,
        [1]    = 9,
    },
}
CHECK'{{}, {}, {{}, {}}}'
{
    [1] = {
        type   = "table",
        start  = 2,
        finish = 3,
    },
    [2] = {
        type   = ",",
        start  = 4,
        finish = 4,
    },
    [3] = {
        type   = "table",
        start  = 6,
        finish = 7,
    },
    [4] = {
        type   = ",",
        start  = 8,
        finish = 8,
    },
    [5] = {
        type   = "table",
        start  = 11,
        finish = 12,
    },
    [6] = {
        type   = ",",
        start  = 13,
        finish = 13,
    },
    [7] = {
        type   = "table",
        start  = 15,
        finish = 16,
    },
    [8] = {
        type   = "table",
        start  = 10,
        finish = 17,
        [1]    = 5,
        [2]    = 7,
    },
    [9] = {
        type   = "table",
        start  = 1,
        finish = 18,
        [1]    = 1,
        [2]    = 3,
        [3]    = 8,
    },
}
CHECK'{1, 2, 3,}'
{
    [1] = {
        type   = "number",
        start  = 2,
        finish = 2,
        [1]    = 1,
    },
    [2] = {
        type   = ",",
        start  = 3,
        finish = 3,
    },
    [3] = {
        type   = "number",
        start  = 5,
        finish = 5,
        [1]    = 2,
    },
    [4] = {
        type   = ",",
        start  = 6,
        finish = 6,
    },
    [5] = {
        type   = "number",
        start  = 8,
        finish = 8,
        [1]    = 3,
    },
    [6] = {
        type   = ",",
        start  = 9,
        finish = 9,
    },
    [7] = {
        type   = "table",
        start  = 1,
        finish = 10,
        [1]    = 1,
        [2]    = 3,
        [3]    = 5,
    },
}

CHECK 'notify'
{
    [1] = {
        type   = "name",
        start  = 1,
        finish = 6,
        [1]    = "notify",
    },
    [2] = {
        type   = "getname",
        start  = 1,
        finish = 6,
        name   = 1,
    },
}

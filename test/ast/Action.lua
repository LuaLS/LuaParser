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
CHECK[[if 1 then
end]]
{
    type   = 'if',
    start  = 1,
    finish = 13,
    [1]    = {
        filter = {
            type   = 'number',
            start  = 4,
            finish = 4,
            [1]    = 1,
        },
    }
}
CHECK[[if 1 then
    return
end]]
{
    type   = 'if',
    start  = 1,
    finish = 24,
    [1]    = {
        filter = {
            type   = 'number',
            start  = 4,
            finish = 4,
            [1]    = 1,
        },
        [1]    = {
            type   = 'return',
        }
    }
}
CHECK[[if 1 then
    return
else
    return
end]]
{
    type   = 'if',
    start  = 1,
    finish = 40,
    [1]    = {
        filter = {
            type   = 'number',
            start  = 4,
            finish = 4,
            [1]    = 1,
        },
        [1]    = {
            type   = 'return',
        }
    },
    [2]    = {
        [1]    = {
            type   = 'return',
        }
    }
}
CHECK[[if 1 then
    return
elseif 1 then
    return
end]]
{
    type   = 'if',
    start  = 1,
    finish = 49,
    [1]    = {
        filter = {
            type   = 'number',
            start  = 4,
            finish = 4,
            [1]    = 1,
        },
        [1]    = {
            type   = 'return',
        }
    },
    [2]    = {
        filter = {
            type   = 'number',
            start  = 29,
            finish = 29,
            [1]    = 1,
        },
        [1]    = {
            type   = 'return',
        }
    }
}
CHECK[[if 1 then
    return
elseif 1 then
    return
else
    return
end]]
{
    type   = 'if',
    start  = 1,
    finish = 65,
    [1]    = {
        filter = {
            type   = 'number',
            start  = 4,
            finish = 4,
            [1]    = 1,
        },
        [1]    = {
            type   = 'return',
        }
    },
    [2]    = {
        filter = {
            type   = 'number',
            start  = 29,
            finish = 29,
            [1]    = 1,
        },
        [1]    = {
            type   = 'return',
        }
    },
    [3]    = {
        [1]    = {
            type   = 'return',
        }
    }
}
CHECK[[
if 1 then
elseif 1 then
elseif 1 then
elseif 1 then
end]]
{
    type   = 'if',
    start  = 1,
    finish = 55,
    [1]    = {
        filter = {
            type   = 'number',
            start  = 4,
            finish = 4,
            [1]    = 1,
        }
    },
    [2]    = {
        filter = {
            type   = 'number',
            start  = 18,
            finish = 18,
            [1]    = 1,
        }
    },
    [3]    = {
        filter = {
            type   = 'number',
            start  = 32,
            finish = 32,
            [1]    = 1,
        }
    },
    [4]    = {
        filter = {
            type   = 'number',
            start  = 46,
            finish = 46,
            [1]    = 1,
        }
    },
}
CHECK[[
if 1 then
    if 2 then
    end
end]]
{
    type   = 'if',
    start  = 1,
    finish = 35,
    [1]    = {
        filter = {
            type   = 'number',
            start  = 4,
            finish = 4,
            [1]    = 1,
        },
        [1]    = {
            type   = 'if',
            start  = 15,
            finish = 31,
            [1]    = {
                filter = {
                    type   = 'number',
                    start  = 18,
                    finish = 18,
                    [1]    = 2,
                }
            }
        }
    }
}
CHECK[[
for i = 1, 10 do
    return
end]]
{
    type   = 'loop',
    start  = 1,
    finish = 31,
    arg    = {
        type   = 'name',
        start  = 5,
        finish = 5,
        [1]    = 'i',
    },
    min    = {
        type   = 'number',
        start  = 9,
        finish = 9,
        [1]    = 1,
    },
    max    = {
        type   = 'number',
        start  = 12,
        finish = 13,
        [1]    = 10,
    },
    [1]    = {
        type   = 'return'
    }
}
CHECK[[
for i = 1, 10, 1 do
    return
end]]
{
    type   = 'loop',
    start  = 1,
    finish = 34,
    arg    = {
        type   = 'name',
        start  = 5,
        finish = 5,
        [1]    = 'i',
    },
    min    = {
        type   = 'number',
        start  = 9,
        finish = 9,
        [1]    = 1,
    },
    max    = {
        type   = 'number',
        start  = 12,
        finish = 13,
        [1]    = 10,
    },
    step   = {
        type   = 'number',
        start  = 16,
        finish = 16,
        [1]    = 1
    },
    [1]    = {
        type   = 'return'
    }
}
CHECK[[
for a in a do
    return
end]]
{
    type   = 'in',
    start  = 1,
    finish = 28,
    arg    = {
        type   = 'name',
        start  = 5,
        finish = 5,
        [1]    = 'a',
    },
    exp    = {
        type   = 'name',
        start  = 10,
        finish = 10,
        [1]    = 'a',
    },
    [1]    = {
        type   = 'return',
    }
}
CHECK[[
for a, b, c in a, b, c do
    return
end]]
{
    type   = 'in',
    start  = 1,
    finish = 40,
    arg    = {
        type   = 'list',
        [1]    = {
            type   = 'name',
            start  = 5,
            finish = 5,
            [1]    = 'a',
        },
        [2]    = {
            type   = 'name',
            start  = 8,
            finish = 8,
            [1]    = 'b',
        },
        [3]    = {
            type   = 'name',
            start  = 11,
            finish = 11,
            [1]    = 'c',
        },
    },
    exp    = {
        type   = 'list',
        [1]    = {
            type   = 'name',
            start  = 16,
            finish = 16,
            [1]    = 'a',
        },
        [2]    = {
            type   = 'name',
            start  = 19,
            finish = 19,
            [1]    = 'b',
        },
        [3]    = {
            type   = 'name',
            start  = 22,
            finish = 22,
            [1]    = 'c',
        },
    },
    [1]    = {
        type   = 'return',
    }
}
CHECK[[
while true do
    return
end]]
{
    type   = 'while',
    start  = 1,
    finish = 28,
    filter = {
        type   = 'boolean',
        start  = 7,
        finish = 10,
        [1]    = true,
    },
    [1]    = {
        type = 'return',
    }
}
CHECK[[
repeat
    return
until 1]]
{
    type   = 'repeat',
    start  = 1,
    finish = 25,
    filter = {
        type   = 'number',
        start  = 25,
        finish = 25,
        [1]    = 1,
    },
    [1]    = {
        type = 'return',
    }
}

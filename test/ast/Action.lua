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
        type   = 'list',
        start  = 1,
        finish = 7,
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
        start = 11,
        finish = 17,
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
        type   = 'list',
        start  = 7,
        finish = 13,
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
        type   = 'list',
        start  = 7,
        finish = 13,
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
        type   = 'list',
        start  = 17,
        finish = 23,
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
CHECK'local x <close> <const> = 1'
{
    type = 'local',
    [1]  = {
        type   = 'name',
        start  = 7,
        finish = 7,
        tags   = {
            [1] = {
                type   = 'name',
                start  = 10,
                finish = 14,
                [1]    = 'close',
            },
            [2] = {
                type   = 'name',
                start  = 18,
                finish = 22,
                [1]    = 'const',
            },
        },
        [1]    = 'x',
    },
    [2]  = {
        type   = 'number',
        start  = 27,
        finish = 27,
        [1]    = 1,
    },
}
CHECK'local x < const > = 1'
{
    type = 'local',
    [1]  = {
        type   = 'name',
        start  = 7,
        finish = 7,
        tags   = {
            [1] = {
                type   = 'name',
                start  = 11,
                finish = 15,
                [1]    = 'const',
            }
        },
        [1]    = 'x',
    },
    [2] = {
        type   = 'number',
        start  = 21,
        finish = 21,
        [1]    = 1,
    },
}
CHECK'local x <const>, y <close> = 1'
{
    type = 'local',
    [1]  = {
        type   = "list",
        start  = 7,
        finish = 18,
        [1]    = {
            type   = 'name',
            start  = 7,
            finish = 7,
            tags   = {
                [1] = {
                    type   = 'name',
                    start  = 10,
                    finish = 14,
                    [1]    = 'const',
                }
            },
            [1]    = 'x',
        },
        [2]    = {
            type   = 'name',
            start  = 18,
            finish = 18,
            tags   = {
                [1] = {
                    type   = 'name',
                    start  = 21,
                    finish = 25,
                    [1]    = 'close',
                }
            },
            [1]    = 'y',
        },
    },
    [2] = {
        type   = 'number',
        start  = 30,
        finish = 30,
        [1]    = 1,
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
        type      = 'function',
        start     = 5,
        finish    = 19,
        argStart  = 14,
        argFinish = 15,
    }
}
CHECK'x.y = function () end'
{
    type = 'set',
    [1]  = {
        type   = 'simple',
        start  = 1,
        finish = 3,
        [1]  = {
            type   = 'name',
            start  = 1,
            finish = 1,
            [1]    = 'x',
        },
        [2]  = {
            type   = '.',
            start  = 2,
            finish = 2,
        },
        [3]  = {
            type   = 'name',
            start  = 3,
            finish = 3,
            [1]    = 'y',
        },
    },
    [2]  = {
        type      = 'function',
        start     = 7,
        finish    = 21,
        argStart  = 16,
        argFinish = 17,
    }
}
CHECK'func.x(1, 2)'
{
    type   = 'simple',
    start  = 1,
    finish = 12,
    [1]  = {
        type   = 'name',
        start  = 1,
        finish = 4,
        [1]    = 'func',
    },
    [2]  = {
        type   = '.',
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
        start  = 7,
        finish = 12,
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
    type   = 'simple',
    start  = 1,
    finish = 12,
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
        start  = 7,
        finish = 12,
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
    type   = 'simple',
    start  = 2,
    finish = 16,
    [1]  = {
        type   = 'string',
        start  = 2,
        finish = 5,
        [1]    = '%s',
        [2]    = [=["]=],
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
        start  = 14,
        finish = 16,
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
CHECK'return'
{
    type   = 'return',
    start  = 1,
    finish = 6,
}
CHECK'return 1'
{
    type   = 'return',
    start  = 1,
    finish = 8,
    [1]  = {
        type   = 'number',
        start  = 8,
        finish = 8,
        [1]    = 1,
    }
}
CHECK'return 1, 2'
{
    type   = 'return',
    start  = 1,
    finish = 11,
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
        start  = 10,
        finish = 10,
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
        start  = 10,
        finish = 21,
        filter = {
            type   = 'number',
            start  = 4,
            finish = 4,
            [1]    = 1,
        },
        [1]    = {
            type   = 'return',
            start  = 15,
            finish = 20,
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
        start  = 10,
        finish = 21,
        filter = {
            type   = 'number',
            start  = 4,
            finish = 4,
            [1]    = 1,
        },
        [1]    = {
            type   = 'return',
            start  = 15,
            finish = 20,
        }
    },
    [2]    = {
        start  = 26,
        finish = 37,
        [1]    = {
            type   = 'return',
            start  = 31,
            finish = 36,
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
        start  = 10,
        finish = 21,
        filter = {
            type   = 'number',
            start  = 4,
            finish = 4,
            [1]    = 1,
        },
        [1]    = {
            type   = 'return',
            start  = 15,
            finish = 20,
        }
    },
    [2]    = {
        start  = 35,
        finish = 46,
        filter = {
            type   = 'number',
            start  = 29,
            finish = 29,
            [1]    = 1,
        },
        [1]    = {
            type   = 'return',
            start  = 40,
            finish = 45,
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
        start  = 10,
        finish = 21,
        filter = {
            type   = 'number',
            start  = 4,
            finish = 4,
            [1]    = 1,
        },
        [1]    = {
            type   = 'return',
            start  = 15,
            finish = 20,
        }
    },
    [2]    = {
        start  = 35,
        finish = 46,
        filter = {
            type   = 'number',
            start  = 29,
            finish = 29,
            [1]    = 1,
        },
        [1]    = {
            type   = 'return',
            start  = 40,
            finish = 45,
        }
    },
    [3]    = {
        start  = 51,
        finish = 62,
        [1]    = {
            type   = 'return',
            start  = 56,
            finish = 61,
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
        start  = 10,
        finish = 10,
        filter = {
            type   = 'number',
            start  = 4,
            finish = 4,
            [1]    = 1,
        }
    },
    [2]    = {
        start  = 24,
        finish = 24,
        filter = {
            type   = 'number',
            start  = 18,
            finish = 18,
            [1]    = 1,
        }
    },
    [3]    = {
        start  = 38,
        finish = 38,
        filter = {
            type   = 'number',
            start  = 32,
            finish = 32,
            [1]    = 1,
        }
    },
    [4]    = {
        start  = 52,
        finish = 52,
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
        start  = 10,
        finish = 32,
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
                start  = 24,
                finish = 24,
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
if a then
elseif b then
else
end]]
{
    type   = 'if',
    start  = 1,
    finish = 32,
    [1]    = {
        start  = 10,
        finish = 10,
        filter = {
            type   = 'name',
            start  = 4,
            finish = 4,
            [1]    = 'a',
        },
    },
    [2]    = {
        start  = 24,
        finish = 24,
        filter = {
            type   = 'name',
            start  = 18,
            finish = 18,
            [1]    = 'b',
        },
    },
    [3]    = {
        start  = 29,
        finish = 29,
    },
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
        type   = 'return',
        start  = 22,
        finish = 27,
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
        type   = 'return',
        start  = 25,
        finish = 30,
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
        start  = 19,
        finish = 24,
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
        start  = 5,
        finish = 11,
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
        start  = 16,
        finish = 22,
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
        start  = 31,
        finish = 36,
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
        type   = 'return',
        start  = 19,
        finish = 24,
    }
}
CHECK[[
repeat
    break
until 1]]
{
    type   = 'repeat',
    start  = 1,
    finish = 24,
    filter = {
        type   = 'number',
        start  = 24,
        finish = 24,
        [1]    = 1,
    },
    [1]    = {
        type = 'break',
    }
}
CHECK[[
function test()
    return
end]]
{
    type      = 'function',
    start     = 1,
    finish    = 30,
    argStart  = 14,
    argFinish = 15,
    name      = {
        type   = 'name',
        start  = 10,
        finish = 13,
        [1]    = 'test',
    },
    [1]       = {
        type   = 'return',
        start  = 21,
        finish = 26,
    }
}
CHECK[[
function test(a)
    return
end]]
{
    type      = 'function',
    start     = 1,
    finish    = 31,
    argStart  = 14,
    argFinish = 16,
    name      = {
        type   = 'name',
        start  = 10,
        finish = 13,
        [1]    = 'test',
    },
    arg       = {
        type   = 'name',
        start  = 15,
        finish = 15,
        [1]    = 'a',
    },
    [1]       = {
        type   = 'return',
        start  = 22,
        finish = 27,
    }
}
CHECK[[
function a.b:c(a, b, c)
    return
end]]
{
    type      = 'function',
    start     = 1,
    finish    = 38,
    argStart  = 15,
    argFinish = 23,
    name      = {
        type   = 'simple',
        start  = 10,
        finish = 14,
        [1]  = {
            type   = 'name',
            start  = 10,
            finish = 10,
            [1]    = 'a',
        },
        [2]  = {
            type   = '.',
            start  = 11,
            finish = 11,
        },
        [3]  = {
            type   = 'name',
            start  = 12,
            finish = 12,
            [1]    = 'b',
        },
        [4]  = {
            type   = ':',
            start  = 13,
            finish = 13,
        },
        [5]  = {
            type   = 'name',
            start  = 14,
            finish = 14,
            [1]    = 'c',
        }
    },
    arg       = {
        type   = 'list',
        start  = 16,
        finish = 22,
        [1]  = {
            type   = 'name',
            start  = 16,
            finish = 16,
            [1]    = 'a',
        },
        [2]  = {
            type   = 'name',
            start  = 19,
            finish = 19,
            [1]    = 'b',
        },
        [3]  = {
            type   = 'name',
            start  = 22,
            finish = 22,
            [1]    = 'c',
        },
    },
    [1]       = {
        type   = 'return',
        start  = 29,
        finish = 34,
    }
}
CHECK[[
local function a()
    return
end]]
{
    type      = 'localfunction',
    start     = 1,
    finish    = 33,
    argStart  = 17,
    argFinish = 18,
    name   = {
        type   = 'name',
        start  = 16,
        finish = 16,
        [1]    = 'a',
    },
    [1]    = {
        type   = 'return',
        start  = 24,
        finish = 29,
    }
}
CHECK[[
local function a(b, c)
    return
end]]
{
    type      = 'localfunction',
    start     = 1,
    finish    = 37,
    argStart  = 17,
    argFinish = 22,
    name   = {
        type   = 'name',
        start  = 16,
        finish = 16,
        [1]    = 'a',
    },
    arg    = {
        type   = 'list',
        start  = 18,
        finish = 21,
        [1]  = {
            type   = 'name',
            start  = 18,
            finish = 18,
            [1]    = 'b',
        },
        [2]  = {
            type   = 'name',
            start  = 21,
            finish = 21,
            [1]    = 'c',
        },
    },
    [1]    = {
        type = 'return',
        start  = 28,
        finish = 33,
    }
}

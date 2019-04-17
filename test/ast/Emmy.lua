CHECK [[
---@class Class
local x = 1
]]
{
    [1] = {
        type = 'emmyClass',
        [1]  = {
            type   = 'emmyName',
            start  = 11,
            finish = 15,
            [1]    = 'Class',
        },
    },
    [2] = {
        type = 'local',
        [1]  = {
            type   = 'name',
            start  = 23,
            finish = 23,
            [1]    = 'x',
        },
        [2]  = {
            type   = 'number',
            start  = 27,
            finish = 27,
            [1]    = 1,
        }
    }
}

CHECK [[
---@class Class : SuperClass
local x = 1
]]
{
    [1] = {
        type = 'emmyClass',
        [1]  = {
            type   = 'emmyName',
            start  = 11,
            finish = 15,
            [1]    = 'Class',
        },
        [2]  = {
            type   = 'emmyName',
            start  = 19,
            finish = 28,
            [1]    = 'SuperClass',
        },
    },
    [2] = {
        type = 'local',
        [1]  = {
            type   = 'name',
            start  = 36,
            finish = 36,
            [1]    = 'x',
        },
        [2]  = {
            type   = 'number',
            start  = 40,
            finish = 40,
            [1]    = 1,
        }
    }
}

CHECK [[
---@class Class
x = 1
]]
{
    [1] = {
        type = 'emmyClass',
        [1]  = {
            type   = 'emmyName',
            start  = 11,
            finish = 15,
            [1]    = 'Class',
        },
    },
    [2] = {
        type = 'set',
        [1]  = {
            type   = 'name',
            start  = 17,
            finish = 17,
            [1]    = 'x',
        },
        [2]  = {
            type   = 'number',
            start  = 21,
            finish = 21,
            [1]    = 1,
        }
    }
}

CHECK [[
---@type Type
x = 1
]]
{
    [1] = {
        type = 'emmyType',
        [1] = {
            type   = 'emmyName',
            start  = 10,
            finish = 13,
            [1]    = 'Type',
        },
    },
    [2] = {
        type = 'set',
        [1]  = {
            type   = 'name',
            start  = 15,
            finish = 15,
            [1]    = 'x',
        },
        [2]  = {
            type   = 'number',
            start  = 19,
            finish = 19,
            [1]    = 1,
        }
    }
}

CHECK [[
---@type Type1|Type2|Type3
x = 1
]]
{
    [1] = {
        type = 'emmyType',
        [1] = {
            type   = 'emmyName',
            start  = 10,
            finish = 14,
            [1]    = 'Type1',
        },
        [2] = {
            type   = 'emmyName',
            start  = 16,
            finish = 20,
            [1]    = 'Type2',
        },
        [3] = {
            type   = 'emmyName',
            start  = 22,
            finish = 26,
            [1]    = 'Type3',
        },
    },
    [2] = {
        type = 'set',
        [1]  = {
            type   = 'name',
            start  = 28,
            finish = 28,
            [1]    = 'x',
        },
        [2]  = {
            type   = 'number',
            start  = 32,
            finish = 32,
            [1]    = 1,
        }
    }
}

CHECK [[
---@alias Handler LongType
x = 1
]]
{
    [1] = {
        type = 'emmyAlias',
        [1]  = {
            type   = 'emmyName',
            start  = 11,
            finish = 17,
            [1]    = 'Handler',
        },
        [2]  = {
            type   = 'emmyType',
            [1]    = {
                type   = 'emmyName',
                start  = 19,
                finish = 26,
                [1]    = 'LongType'
            },
        },
    },
    [2] = {
        type = 'set',
        [1]  = {
            type   = 'name',
            start  = 28,
            finish = 28,
            [1]    = 'x',
        },
        [2]  = {
            type   = 'number',
            start  = 32,
            finish = 32,
            [1]    = 1,
        }
    }
}

CHECK [[
---@param a1 t1
---@param a2 t2
---@param a3 t3
]]
{
    [1]  = {
        type = 'emmyParam',
        [1]  = {
            type   = 'emmyName',
            start  = 11,
            finish = 12,
            [1]    = 'a1',
        },
        [2] = {
            type   = 'emmyType',
            [1]    = {
                type   = 'emmyName',
                start  = 14,
                finish = 15,
                [1]    = 't1',
            }
        }
    },
    [2]  = {
        type = 'emmyParam',
        [1]  = {
            type   = 'emmyName',
            start  = 27,
            finish = 28,
            [1]    = 'a2',
        },
        [2] = {
            type   = 'emmyType',
            [1]    = {
                type   = 'emmyName',
                start  = 30,
                finish = 31,
                [1]    = 't2',
            }
        }
    },
    [3]  = {
        type = 'emmyParam',
        [1]  = {
            type   = 'emmyName',
            start  = 43,
            finish = 44,
            [1]    = 'a3',
        },
        [2] = {
            type   = 'emmyType',
            [1]    = {
                type   = 'emmyName',
                start  = 46,
                finish = 47,
                [1]    = 't3',
            }
        }
    },
}

CHECK [[
---@return Type1|Type2|Type3
]]
{
    [1] = {
        type = 'emmyReturn',
        [1]  = {
            type = 'emmyType',
            [1]  = {
                type   = 'emmyName',
                start  = 12,
                finish = 16,
                [1]    = 'Type1',
            },
            [2]  = {
                type   = 'emmyName',
                start  = 18,
                finish = 22,
                [1]    = 'Type2',
            },
            [3]  = {
                type   = 'emmyName',
                start  = 24,
                finish = 28,
                [1]    = 'Type3',
            },
        }
    },
}

CHECK [[
---@field open function
]]
{
    [1] = {
        type = 'emmyField',
        [1]  = 'public',
        [2]  = {
            type   = 'emmyName',
            start  = 11,
            finish = 14,
            [1]    = 'open',
        },
        [3]  = {
            type = 'emmyType',
            [1]  = {
                type   = 'emmyName',
                start  = 16,
                finish = 23,
                [1]    = 'function',
            }
        }
    },
}

CHECK [[
---@field private open function|string
]]
{
    [1] = {
        type = 'emmyField',
        [1]  = 'private',
        [2]  = {
            type   = 'emmyName',
            start  = 19,
            finish = 22,
            [1]    = 'open',
        },
        [3]  = {
            type = 'emmyType',
            [1]  = {
                type   = 'emmyName',
                start  = 24,
                finish = 31,
                [1]    = 'function',
            },
            [2]  = {
                type   = 'emmyName',
                start  = 33,
                finish = 38,
                [1]    = 'string',
            }
        }
    },
}

CHECK [[
---@generic T
]]
{
    [1] = {
        type = 'emmyGeneric',
        [1]  = {
            [1] = {
                type   = 'emmyName',
                start  = 13,
                finish = 13,
                [1]    = 'T',
            }
        }
    }
}

CHECK [[
---@generic T : handle
]]
{
    [1] = {
        type = 'emmyGeneric',
        [1]  = {
            [1] = {
                type   = 'emmyName',
                start  = 13,
                finish = 13,
                [1]    = 'T',
            },
            [2] = {
                type = 'emmyType',
                [1]  = {
                    type   = 'emmyName',
                    start  = 17,
                    finish = 22,
                    [1]    = 'handle',
                }
            }
        }
    }
}

CHECK [[
---@generic T : handle, K : handle
]]
{
    [1] = {
        type = 'emmyGeneric',
        [1]  = {
            [1] = {
                type   = 'emmyName',
                start  = 13,
                finish = 13,
                [1]    = 'T',
            },
            [2] = {
                type = 'emmyType',
                [1] = {
                    type   = 'emmyName',
                    start  = 17,
                    finish = 22,
                    [1]    = 'handle',
                }
            }
        },
        [2]  = {
            [1] = {
                type   = 'emmyName',
                start  = 25,
                finish = 25,
                [1]    = 'K',
            },
            [2] = {
                type = 'emmyType',
                [1]  = {
                    type   = 'emmyName',
                    start  = 29,
                    finish = 34,
                    [1]    = 'handle',
                }
            }
        },
    }
}

CHECK [[
---@vararg string
]]
{
    [1] = {
        type = 'emmyVararg',
        [1]  = {
            type = 'emmyType',
            [1]  = {
                type   = 'emmyName',
                start  = 12,
                finish = 17,
                [1]    = 'string',
            }
        }
    }
}

CHECK [[
---@language JSON
]]
{
    [1] = {
        type = 'emmyLanguage',
        [1]  = {
            type   = 'emmyName',
            start  = 14,
            finish = 17,
            [1]    = 'JSON',
        }
    }
}

CHECK [[
---@type Type[]
]]
{
    [1] = {
        type = 'emmyArrayType',
        [1]  = {
            type   = 'emmyName',
            start  = 10,
            finish = 13,
            [1]    = 'Type',
        }
    }
}

CHECK [[
---@type table<key, value>
]]
{
    [1] = {
        type = 'emmyTableType',
        [1]  = {
            type   = 'emmyName',
            start  = 10,
            finish = 14,
            [1]    = 'table',
        },
        [2]  = {
            type = 'emmyType',
            [1]  = {
                type   = 'emmyName',
                start  = 16,
                finish = 18,
                [1]    = 'key',
            }
        },
        [3]  = {
            type = 'emmyType',
            [1]  = {
                type   = 'emmyName',
                start  = 21,
                finish = 25,
                [1]    = 'value',
            }
        }
    }
}

CHECK [[
---@class Class
local x = 1
]]
{
    [1] = {
        type   = 'emmyClass',
        start  = 11,
        finish = 15,
        [1]    = {
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
        type   = 'emmyClass',
        start  = 11,
        finish = 28,
        [1]    = {
            type   = 'emmyName',
            start  = 11,
            finish = 15,
            [1]    = 'Class',
        },
        [2]    = {
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
        type   = 'emmyClass',
        start  = 11,
        finish = 15,
        [1]    = {
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
        type   = 'emmyType',
        start  = 10,
        finish = 13,
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
        type   = 'emmyType',
        start  = 10,
        finish = 26,
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
        type   = 'emmyAlias',
        start  = 11,
        finish = 26,
        [1]  = {
            type   = 'emmyName',
            start  = 11,
            finish = 17,
            [1]    = 'Handler',
        },
        [2]  = {
            type   = 'emmyType',
            start  = 19,
            finish = 26,
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
        type   = 'emmyParam',
        start  = 11,
        finish = 15,
        [1]  = {
            type   = 'emmyName',
            start  = 11,
            finish = 12,
            [1]    = 'a1',
        },
        [2] = {
            type   = 'emmyType',
            start  = 14,
            finish = 15,
            [1]    = {
                type   = 'emmyName',
                start  = 14,
                finish = 15,
                [1]    = 't1',
            }
        }
    },
    [2]  = {
        type   = 'emmyParam',
        start  = 27,
        finish = 31,
        [1]  = {
            type   = 'emmyName',
            start  = 27,
            finish = 28,
            [1]    = 'a2',
        },
        [2] = {
            type   = 'emmyType',
            start  = 30,
            finish = 31,
            [1]    = {
                type   = 'emmyName',
                start  = 30,
                finish = 31,
                [1]    = 't2',
            }
        }
    },
    [3]  = {
        type   = 'emmyParam',
        start  = 43,
        finish = 47,
        [1]  = {
            type   = 'emmyName',
            start  = 43,
            finish = 44,
            [1]    = 'a3',
        },
        [2] = {
            type   = 'emmyType',
            start  = 46,
            finish = 47,
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
        start  = 12,
        finish = 28,
        [1]  = {
            type   = 'emmyType',
            start  = 12,
            finish = 28,
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
        type   = 'emmyField',
        start  = 11,
        finish = 23,
        [1]  = 'public',
        [2]  = {
            type   = 'emmyName',
            start  = 11,
            finish = 14,
            [1]    = 'open',
        },
        [3]  = {
            type   = 'emmyType',
            start  = 16,
            finish = 23,
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
        type   = 'emmyField',
        start  = 19,
        finish = 38,
        [1]  = 'private',
        [2]  = {
            type   = 'emmyName',
            start  = 19,
            finish = 22,
            [1]    = 'open',
        },
        [3]  = {
            type   = 'emmyType',
            start  = 24,
            finish = 38,
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
        start  = 13,
        finish = 13,
        [1]  = {
            start  = 13,
            finish = 13,
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
        start  = 13,
        finish = 22,
        [1]  = {
            start  = 13,
            finish = 22,
            [1] = {
                type   = 'emmyName',
                start  = 13,
                finish = 13,
                [1]    = 'T',
            },
            [2] = {
                type   = 'emmyType',
                start  = 17,
                finish = 22,
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
        start  = 13,
        finish = 34,
        [1]  = {
            start  = 13,
            finish = 22,
            [1] = {
                type   = 'emmyName',
                start  = 13,
                finish = 13,
                [1]    = 'T',
            },
            [2] = {
                type   = 'emmyType',
                start  = 17,
                finish = 22,
                [1] = {
                    type   = 'emmyName',
                    start  = 17,
                    finish = 22,
                    [1]    = 'handle',
                }
            }
        },
        [2]  = {
            start  = 25,
            finish = 34,
            [1] = {
                type   = 'emmyName',
                start  = 25,
                finish = 25,
                [1]    = 'K',
            },
            [2] = {
                type   = 'emmyType',
                start  = 29,
                finish = 34,
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
        start  = 12,
        finish = 17,
        [1]  = {
            type   = 'emmyType',
            start  = 12,
            finish = 17,
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
        start  = 14,
        finish = 17,
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
        start  = 10,
        finish = 13,
        [1]    = 'Type',
    }
}

CHECK [[
---@type table<key, value>
]]
{
    [1] = {
        type = 'emmyTableType',
        start  = 10,
        finish = 26,
        [1]    = {
            type   = 'emmyType',
            start  = 16,
            finish = 18,
            [1]  = {
                type   = 'emmyName',
                start  = 16,
                finish = 18,
                [1]    = 'key',
            }
        },
        [2]    = {
            type   = 'emmyType',
            start  = 21,
            finish = 25,
            [1]  = {
                type   = 'emmyName',
                start  = 21,
                finish = 25,
                [1]    = 'value',
            }
        }
    }
}

CHECK [[
---@type fun(key1:t1|t2[], key2:t3):table<t5, t6>
]]
{
    [1] = {
        type   = 'emmyFunctionType',
        start  = 10,
        finish = 49,
        [1]  = {
            type   = 'emmyName',
            start  = 14,
            finish = 17,
            [1]    = 'key1',
        },
        [2]  = {
            type   = 'emmyType',
            start  = 19,
            finish = 23,
            [1]    = {
                type   = 'emmyName',
                start  = 19,
                finish = 20,
                [1]    = 't1',
            },
            [2]    = {
                type   = 'emmyArrayType',
                start  = 22,
                finish = 23,
                [1]    = 't2',
            }
        },
        [3]  = {
            type   = 'emmyName',
            start  = 28,
            finish = 31,
            [1]    = 'key2',
        },
        [4]  = {
            type   = 'emmyType',
            start  = 33,
            finish = 34,
            [1]    = {
                type   = 'emmyName',
                start  = 33,
                finish = 34,
                [1]    = 't3',
            }
        },
        [5]  = {
            type   = 'emmyTableType',
            start  = 37,
            finish = 49,
            [1]    = {
                type   = 'emmyType',
                start  = 43,
                finish = 44,
                [1] = {
                    type   = 'emmyName',
                    start  = 43,
                    finish = 44,
                    [1]    = 't5',
                },
            },
            [2]    = {
                type   = 'emmyType',
                start  = 47,
                finish = 48,
                [1] = {
                    type   = 'emmyName',
                    start  = 47,
                    finish = 48,
                    [1]    = 't6',
                }
            }
        }
    }
}

CHECK [[
---@param event string | "'onClosed'" | "'onData'"
]]
{
    [1]  = {
        type = 'emmyParam',
        start  = 11,
        finish = 50,
        [1]  = {
            type   = 'emmyName',
            start  = 11,
            finish = 15,
            [1]    = 'event',
        },
        [2] = {
            type   = 'emmyType',
            start  = 17,
            finish = 22,
            [1]    = {
                type   = 'emmyName',
                start  = 17,
                finish = 22,
                [1]    = 'string',
            },
        },
        [3] = {
            type   = "string",
            start  = 26,
            finish = 37,
            [1]    = "'onClosed'",
            [2]    = [=["]=],
        },
        [4] = {
            type   = "string",
            start  = 41,
            finish = 50,
            [1]    = "'onData'",
            [2]    = [=["]=],
        },
    },
}

CHECK [[
---@see loli#pants
]]
{
    [1] = {
        type   = 'emmySee',
        start  = 9,
        finish = 18,
        [1]  = {
            type   = 'emmyName',
            start  = 9,
            finish = 12,
            [1]    = 'loli',
        },
        [2]  = {
            type   = 'emmyName',
            start  = 14,
            finish = 18,
            [1]    = 'pants',
        }
    }
}

CHECK [[

---@class Class
]]
{
    [1] = {
        type   = 'emmyClass',
        start  = 12,
        finish = 16,
        [1]    = {
            type   = 'emmyName',
            start  = 12,
            finish = 16,
            [1]    = 'Class',
        },
    },
}

CHECK [[
---@
---@cl
]]
{
    [1] = {
        type   = 'emmyIncomplete',
        start  = 4,
        finish = 4,
        [1]    = '',
    },
    [2] = {
        type   = 'emmyIncomplete',
        start  = 10,
        finish = 11,
        [1]    = 'cl',
    },
}

CHECK [[
local t = {
    ---@type string
    x = 1,
}
]]
{
    [1] = {
        type = "local",
        [1] = {
            type   = "name",
            start  = 7,
            finish = 7,
            [1]    = "t",
        },
        [2] = {
            type   = "table",
            start  = 11,
            finish = 44,
            [1]    = {
                type = "emmyType",
                start  = 26,
                finish = 31,
                [1]  = {
                    type   = "emmyName",
                    start  = 26,
                    finish = 31,
                    [1]    = "string",
                },
            },
            [2]    = {
                type   = "pair",
                start  = 37,
                finish = 41,
                [1] = {
                    type   = "name",
                    start  = 37,
                    finish = 37,
                    [1]    = "x",
                },
                [2] = {
                    type   = "number",
                    start  = 41,
                    finish = 41,
                    [1]    = 1,
                },
            },
        },
    },
}

CHECK [[
local function f()
    ---@
end
]]
{
    [1] = {
        type      = "localfunction",
        start     = 1,
        finish    = 31,
        argStart  = 17,
        argFinish = 18,
        name      = {
            [1]    = "f",
            finish = 16,
            start  = 16,
            type   = "name",
        },
        [1]       = {
            type   = "emmyIncomplete",
            start  = 27,
            finish = 27,
            [1]    = "",
        },
    },
}

CHECK '---@type fun'
{
	[1] = {
		type   = "emmyFunctionType",
		start  = 10,
		finish = 12,
	},
}

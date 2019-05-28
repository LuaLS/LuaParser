CHECK_EMMY [[
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
}

CHECK_EMMY [[
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
}

CHECK_EMMY [[
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
}

CHECK_EMMY [[
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
}

CHECK_EMMY [[
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
}

CHECK_EMMY [[
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
}

CHECK_EMMY [[
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
        type = 'emmyParam',
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
        type = 'emmyParam',
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

CHECK_EMMY [[
---@return Type1|Type2|Type3
]]
{
    [1] = {
        type = 'emmyReturn',
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

CHECK_EMMY [[
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

CHECK_EMMY [[
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

CHECK_EMMY [[
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

CHECK_EMMY [[
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

CHECK_EMMY [[
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

CHECK_EMMY [[
---@vararg string
]]
{
    [1] = {
        type = 'emmyVararg',
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

CHECK_EMMY [[
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

CHECK_EMMY [[
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

CHECK_EMMY [[
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

CHECK_EMMY [[
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

CHECK_EMMY [[
---@param event string | "'onClosed'" | "'onData'"
]]
{
    [1]  = {
        type = 'emmyParam',
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

CHECK_EMMY [[
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

CHECK_EMMY [[

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

CHECK_EMMY [[
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

CHECK_EMMY [[
local t = {
    ---@type string
    x = 1,
}
]]
{
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
}

CHECK_EMMY [[
local function f()
    ---@
end
]]
{
    [1]       = {
        type   = "emmyIncomplete",
        start  = 27,
        finish = 27,
        [1]    = "",
    },
}

CHECK_EMMY '---@type fun'
{
	[1] = {
		type   = "emmyFunctionType",
		start  = 10,
		finish = 12,
	},
}

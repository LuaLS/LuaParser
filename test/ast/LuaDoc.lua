LuaDoc [[
---@class Class
]]
{
    [1] = {
        type   = 'doc.class',
        start  = 11,
        finish = 15,
        class  = {
            type   = 'doc.class.name',
            start  = 11,
            finish = 15,
            parent = "<IGNORE>",
            [1]    = 'Class',
        },
    },
}

LuaDoc [[
---@class Class : SuperClass
local x = 1
]]
{
    [1] = {
        type   = 'doc.class',
        start  = 11,
        finish = 28,
        class  = {
            type   = 'doc.class.name',
            start  = 11,
            finish = 15,
            parent = "<IGNORE>",
            [1]    = 'Class',
        },
        extends= {
            type   = 'doc.extends.name',
            start  = 19,
            finish = 28,
            parent = "<IGNORE>",
            [1]    = 'SuperClass',
        },
    },
}

LuaDoc [[
---@type Type
x = 1
]]
{
    [1] = {
        type   = 'doc.type',
        start  = 10,
        finish = 13,
        types  = {
            {
                type   = 'doc.type.name',
                start  = 10,
                finish = 13,
                parent = "<IGNORE>",
                [1]    = 'Type',
            }
        },
        enums = {},
    },
}

LuaDoc [[
---@type Type1|Type2|Type3
x = 1
]]
{
    [1] = {
        type   = 'doc.type',
        start  = 10,
        finish = 26,
        types  = {
            {
                type   = 'doc.type.name',
                start  = 10,
                finish = 14,
                parent = "<IGNORE>",
                [1]    = 'Type1',
            },
            {
                type   = 'doc.type.name',
                start  = 16,
                finish = 20,
                parent = "<IGNORE>",
                [1]    = 'Type2',
            },
            {
                type   = 'doc.type.name',
                start  = 22,
                finish = 26,
                parent = "<IGNORE>",
                [1]    = 'Type3',
            },
        },
        enums = {},
    },
}

LuaDoc [[
---@type x | "'a'" | "'b'"
]]
{
    [1] = {
        type   = 'doc.type',
        start  = 10,
        finish = 26,
        types  = {
            {
                type   = 'doc.type.name',
                start  = 10,
                finish = 10,
                parent = "<IGNORE>",
                [1]    = 'x',
            }
        },
        enums  = {
            {
                type   = 'doc.type.enum',
                start  = 14,
                finish = 18,
                parent = "<IGNORE>",
                [1]    = [['a']],
            },
            {
                type   = 'doc.type.enum',
                start  = 22,
                finish = 26,
                parent = "<IGNORE>",
                [1]    = [['b']],
            },
        }
    }
}

LuaDoc [[
---@type "'a'" | "'b'" | "'c'"
]]
{
    [1] = {
        type   = 'doc.type',
        start  = 10,
        finish = 30,
        types  = {},
        enums  = {
            {
                type   = 'doc.type.enum',
                start  = 10,
                finish = 14,
                parent = "<IGNORE>",
                [1]    = [['a']],
            },
            {
                type   = 'doc.type.enum',
                start  = 18,
                finish = 22,
                parent = "<IGNORE>",
                [1]    = [['b']],
            },
            {
                type   = 'doc.type.enum',
                start  = 26,
                finish = 30,
                parent = "<IGNORE>",
                [1]    = [['c']],
            },
        }
    }
}

LuaDoc [[
---@alias Handler LongType
x = 1
]]
{
    [1] = {
        type   = 'doc.alias',
        start  = 11,
        finish = 26,
        alias  = {
            type   = 'doc.alias.name',
            start  = 11,
            finish = 17,
            parent = "<IGNORE>",
            [1]    = 'Handler',
        },
        extends = {
            type   = 'doc.type',
            start  = 19,
            finish = 26,
            parent = "<IGNORE>",
            types  = {
                [1] = {
                    type   = 'doc.type.name',
                    start  = 19,
                    finish = 26,
                    parent = "<IGNORE>",
                    [1]    = 'LongType',
                }
            },
            enums = {},
        },
    },
}

LuaDoc [[
---@param a1 t1
]]
{
    [1]  = {
        type   = 'doc.param',
        start  = 11,
        finish = 15,
        param  = {
            type   = 'doc.param.name',
            start  = 11,
            finish = 12,
            parent = "<IGNORE>",
            [1]    = 'a1',
        },
        extends = {
            type   = 'doc.type',
            start  = 14,
            finish = 15,
            parent = "<IGNORE>",
            types  = {
                [1] = {
                    type   = 'doc.type.name',
                    start  = 14,
                    finish = 15,
                    parent = "<IGNORE>",
                    [1]    = 't1',
                },
            },
            enums  = {},
        }
    },
}

LuaDoc [[
---@return Type1|Type2|Type3
]]
{
    [1] = {
        type    = 'doc.return',
        start   = 12,
        finish  = 28,
        returns = {
            [1]  = {
                type   = 'doc.type',
                start  = 12,
                finish = 28,
                parent = "<IGNORE>",
                types  = {
                    [1]  = {
                        type   = 'doc.type.name',
                        start  = 12,
                        finish = 16,
                        parent = "<IGNORE>",
                        [1]    = 'Type1',
                    },
                    [2]  = {
                        type   = 'doc.type.name',
                        start  = 18,
                        finish = 22,
                        parent = "<IGNORE>",
                        [1]    = 'Type2',
                    },
                    [3]  = {
                        type   = 'doc.type.name',
                        start  = 24,
                        finish = 28,
                        parent = "<IGNORE>",
                        [1]    = 'Type3',
                    },
                },
                enums = {},
            }
        }
    },
}

LuaDoc [[
---@return Type1,Type2,Type3
]]
{
    [1] = {
        type = 'doc.return',
        start  = 12,
        finish = 28,
        returns = {
            [1]  = {
                type   = 'doc.type',
                start  = 12,
                finish = 16,
                parent = "<IGNORE>",
                types  = {
                    {
                        type   = 'doc.type.name',
                        start  = 12,
                        finish = 16,
                        parent = "<IGNORE>",
                        [1]    = 'Type1',
                    }
                }
            },
            [2]  = {
                type   = 'doc.type',
                start  = 18,
                finish = 22,
                parent = "<IGNORE>",
                types  = {
                    {
                        type   = 'doc.type.name',
                        start  = 18,
                        finish = 22,
                        parent = "<IGNORE>",
                        [1]    = 'Type2',
                    }
                }
            },
            [3]  = {
                type   = 'doc.type',
                start  = 24,
                finish = 28,
                parent = "<IGNORE>",
                types  = {
                    {
                        type   = 'doc.type.name',
                        start  = 24,
                        finish = 28,
                        parent = "<IGNORE>",
                        [1]    = 'Type3',
                    }
                }
            },
        }
    },
}

LuaDoc [[
---@field open function
]]
{
    [1] = {
        type   = 'doc.field',
        start  = 11,
        finish = 23,
        field  = {
            type   = 'doc.field.name',
            start  = 11,
            finish = 14,
            parent = '<IGNORE>',
            [1]    = 'open',
        },
        extends = {
            type   = 'doc.type',
            start  = 16,
            finish = 23,
            parent = '<IGNORE>',
            types  = {
                {
                    type   = 'doc.type.name',
                    start  = 16,
                    finish = 23,
                    parent = '<IGNORE>',
                    [1]    = 'function',
                }
            },
            enums  = {},
        }
    },
}

LuaDoc [[
---@field private open function|string
]]
{
    [1] = {
        type    = 'doc.field',
        start   = 11,
        finish  = 38,
        visible = 'private',
        field   = {
            type   = 'doc.field.name',
            start  = 19,
            finish = 22,
            parent = '<IGNORE>',
            [1]    = 'open',
        },
        extends = {
            type   = 'doc.type',
            start  = 24,
            finish = 38,
            parent = '<IGNORE>',
            types  = {
                [1]  = {
                    type   = 'doc.type.name',
                    start  = 24,
                    finish = 31,
                    parent = '<IGNORE>',
                    [1]    = 'function',
                },
                [2]  = {
                    type   = 'doc.type.name',
                    start  = 33,
                    finish = 38,
                    parent = '<IGNORE>',
                    [1]    = 'string',
                }
            },
            enums = {},
        },
    },
}

LuaDoc [[
---@generic T
]]
{
    [1] = {
        type = 'doc.generic',
        start  = 13,
        finish = 13,
        generics = {
            {
                type    = 'doc.generic.object',
                start   = 13,
                finish  = 13,
                parent  = '<IGNORE>',
                generic = {
                    type   = 'doc.generic.name',
                    start  = 13,
                    finish = 13,
                    parent = '<IGNORE>',
                    [1]    = 'T',
                }
            },
        }
    }
}

LuaDoc [[
---@generic T : handle
]]
{
    [1] = {
        type     = 'doc.generic',
        start    = 13,
        finish   = 22,
        generics = {
            [1]  = {
                type    = 'doc.generic.object',
                start   = 13,
                finish  = 22,
                parent  = '<IGNORE>',
                generic = {
                    type   = 'doc.generic.name',
                    start  = 13,
                    finish = 13,
                    parent = '<IGNORE>',
                    [1]    = 'T',
                },
                extends = {
                    type   = 'doc.extends.name',
                    start  = 17,
                    finish = 22,
                    parent = '<IGNORE>',
                    [1]    = 'handle',
                }
            }
        }
    }
}

LuaDoc [[
---@generic T : handle, K : handle
]]
{
    [1] = {
        type     = 'doc.generic',
        start    = 13,
        finish   = 34,
        generics = {
            [1]  = {
                type    = 'doc.generic.object',
                start   = 13,
                finish  = 22,
                parent  = '<IGNORE>',
                generic = {
                    type   = 'doc.generic.name',
                    start  = 13,
                    finish = 13,
                    parent = '<IGNORE>',
                    [1]    = 'T',
                },
                extends = {
                    type   = 'doc.extends.name',
                    start  = 17,
                    finish = 22,
                    parent = '<IGNORE>',
                    [1]    = 'handle',
                }
            },
            [2]  = {
                type    = 'doc.generic.object',
                start   = 25,
                finish  = 34,
                parent  = '<IGNORE>',
                generic = {
                    type   = 'doc.generic.name',
                    start  = 25,
                    finish = 25,
                    parent = '<IGNORE>',
                    [1]    = 'K',
                },
                extends = {
                    type   = 'doc.extends.name',
                    start  = 29,
                    finish = 34,
                    parent = '<IGNORE>',
                    [1]    = 'handle',
                }
            },
        }
    }
}

LuaDoc [[
---@vararg string
]]
{
    [1] = {
        type   = 'doc.vararg',
        start  = 12,
        finish = 17,
        vararg = {
            type   = 'doc.type',
            start  = 12,
            finish = 17,
            parent = '<IGNORE>',
            types  = {
                [1]  = {
                    type   = 'doc.type.name',
                    start  = 12,
                    finish = 17,
                    parent = '<IGNORE>',
                    [1]    = 'string',
                }
            },
            enums  = {},
        }
    }
}

LuaDoc [[
---@type Type[]
]]
{
    [1] = {
        type   = 'doc.type',
        start  = 10,
        finish = 15,
        types  = {
            [1]    = {
                type   = 'doc.type.name',
                start  = 10,
                finish = 15,
                array  = true,
                parent = '<IGNORE>',
                [1]    = 'Type'
            },
        },
        enums  = {}
    }
}

do return end
LuaDoc [[
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

LuaDoc [[
---@type fun(key1:t1|t2[], key2:t3):table<t5, t6>
]]
{
    [1] = {
        type   = 'emmyFunctionType',
        start  = 10,
        finish = 49,
        args   = {
            [1]  = {
                type   = 'emmyName',
                start  = 14,
                finish = 17,
                [1]    = 'key1',
            },
            [2]  = {
                type   = 'emmyType',
                start  = 19,
                finish = 25,
                [1]    = {
                    type   = 'emmyName',
                    start  = 19,
                    finish = 20,
                    [1]    = 't1',
                },
                [2]    = {
                    type   = 'emmyArrayType',
                    start  = 22,
                    finish = 25,
                    [1]    = {
                        type   = 'emmyName',
                        start  = 22,
                        finish = 23,
                        [1]    = 't2'
                    },
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
        },
    }
}

LuaDoc [[
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
            type   = 'emmyEnum',
            start  = 26,
            finish = 37,
            [1]    = "'onClosed'",
            [2]    = '"',
        },
        [4] = {
            type   = 'emmyEnum',
            start  = 41,
            finish = 50,
            [1]    = "'onData'",
            [2]    = '"',
        },
    },
}

LuaDoc [[
---@overload fun(a:number):number
]]
{
    [1] = {
        type   = "emmyOverLoad",
        start  = 14,
        finish = 33,
        args   = {
            [1] = {
                type   = "emmyName",
                start  = 18,
                finish = 18,
                [1]    = "a",
            },
            [2] = {
                type   = "emmyType",
                start  = 20,
                finish = 25,
                [1] = {
                    type   = "emmyName",
                    start  = 20,
                    finish = 25,
                    [1]    = "number",
                },
            },
        },
    },
}

LuaDoc [[
---@param x string | "fff"
]]
{
    [1] = {
        type   = "emmyParam",
        start  = 11,
        finish = 58,
        option = {
            xx = 1,
            yy = 'zz',
            zz = false,
        },
        [1] = {
            type   = "emmyName",
            start  = 11,
            finish = 11,
            [1]    = "x",
        },
        [2] = {
            type   = "emmyType",
            start  = 13,
            finish = 18,
            [1] = {
                type   = "emmyName",
                start  = 13,
                finish = 18,
                [1]    = "string",
            },
        },
        [3] = {
            type   = 'emmyEnum',
            start  = 54,
            finish = 58,
            [1]    = "fff",
            [2]    = '"',
        },
    },
}

LuaDoc [[
---@overload fun():number,boolean
]]
{
    [1] = {
        type   = "emmyOverLoad",
        start  = 14,
        finish = 33,
    },
}

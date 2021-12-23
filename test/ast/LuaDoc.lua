LuaDoc [[
---@class Class
]]
{
    type   = "doc",
    parent = "<IGNORE>",
    [1]    = {
        type            = "doc.class",
        start           = 10,
        finish          = 15,
        range           = 16,
        parent          = "<IGNORE>",
        class           = {
            type   = "doc.class.name",
            start  = 10,
            finish = 15,
            parent = "<IGNORE>",
            [1]    = "Class",
        },
        fields          = {
        },
        originalComment = "<IGNORE>",
    },
}

LuaDoc [[
---@class Class : SuperClass
local x = 1
]]
{
    type   = "doc",
    parent = "<IGNORE>",
    [1]    = {
        type            = "doc.class",
        start           = 10,
        finish          = 28,
        range           = 29,
        parent          = "<IGNORE>",
        class           = {
            type   = "doc.class.name",
            start  = 10,
            finish = 15,
            parent = "<IGNORE>",
            [1]    = "Class",
        },
        extends         = {
            [1] = {
                type   = "doc.extends.name",
                start  = 18,
                finish = 28,
                parent = "<IGNORE>",
                [1]    = "SuperClass",
            },
        },
        fields          = {
        },
        originalComment = "<IGNORE>",
    },
}

LuaDoc [[
---@type Type
x = 1
]]
{
    type   = "doc",
    parent = "<IGNORE>",
    [1]    = {
        type            = "doc.type",
        start           = 9,
        finish          = 13,
        range           = 14,
        parent          = "<IGNORE>",
        eachCache       = "<IGNORE>",
        enums           = {
        },
        firstFinish     = 13,
        originalComment = "<IGNORE>",
        resumes         = {
        },
        typeCache       = "<IGNORE>",
        types           = {
            [1] = {
                type   = "doc.type.name",
                start  = 9,
                finish = 13,
                parent = "<IGNORE>",
                [1]    = "Type",
            },
        },
    },
}

LuaDoc [[
---@type Type1|Type2|Type3
x = 1
]]
{
    type   = "doc",
    parent = "<IGNORE>",
    [1]    = {
        type            = "doc.type",
        start           = 9,
        finish          = 26,
        range           = 27,
        parent          = "<IGNORE>",
        eachCache       = "<IGNORE>",
        enums           = {
        },
        firstFinish     = 26,
        originalComment = "<IGNORE>",
        resumes         = {
        },
        typeCache       = "<IGNORE>",
        types           = {
            [1] = {
                type   = "doc.type.name",
                start  = 9,
                finish = 14,
                parent = "<IGNORE>",
                [1]    = "Type1",
            },
            [2] = {
                type   = "doc.type.name",
                start  = 15,
                finish = 20,
                parent = "<IGNORE>",
                [1]    = "Type2",
            },
            [3] = {
                type   = "doc.type.name",
                start  = 21,
                finish = 26,
                parent = "<IGNORE>",
                [1]    = "Type3",
            },
        },
    },
}

LuaDoc [[
---@type x | "'a'" | "'b'"
]]
{
    type   = "doc",
    parent = "<IGNORE>",
    [1]    = {
        type            = "doc.type",
        start           = 9,
        finish          = 26,
        range           = 27,
        parent          = "<IGNORE>",
        eachCache       = "<IGNORE>",
        enums           = {
            [1] = {
                type   = "doc.type.enum",
                start  = 13,
                finish = 18,
                parent = "<IGNORE>",
                [1]    = "'a'",
            },
            [2] = {
                type   = "doc.type.enum",
                start  = 21,
                finish = 26,
                parent = "<IGNORE>",
                [1]    = "'b'",
            },
        },
        firstFinish     = 26,
        originalComment = "<IGNORE>",
        resumes         = {
        },
        typeCache       = "<IGNORE>",
        types           = {
            [1] = {
                type   = "doc.type.name",
                start  = 9,
                finish = 10,
                parent = "<IGNORE>",
                [1]    = "x",
            },
        },
    },
}

LuaDoc [[
---@type "'a'" | "'b'" | "'c'"
]]
{
    type   = "doc",
    parent = "<IGNORE>",
    [1]    = {
        type            = "doc.type",
        start           = 9,
        finish          = 30,
        range           = 31,
        parent          = "<IGNORE>",
        eachCache       = "<IGNORE>",
        enums           = {
            [1] = {
                type   = "doc.type.enum",
                start  = 9,
                finish = 14,
                parent = "<IGNORE>",
                [1]    = "'a'",
            },
            [2] = {
                type   = "doc.type.enum",
                start  = 17,
                finish = 22,
                parent = "<IGNORE>",
                [1]    = "'b'",
            },
            [3] = {
                type   = "doc.type.enum",
                start  = 25,
                finish = 30,
                parent = "<IGNORE>",
                [1]    = "'c'",
            },
        },
        firstFinish     = 30,
        originalComment = "<IGNORE>",
        resumes         = {
        },
        typeCache       = "<IGNORE>",
        types           = {
        },
    },
}

LuaDoc [[
---@alias Handler LongType
x = 1
]]
{
    type   = "doc",
    parent = "<IGNORE>",
    [1]    = {
        type            = "doc.alias",
        start           = 10,
        finish          = 26,
        range           = 27,
        parent          = "<IGNORE>",
        alias           = {
            type   = "doc.alias.name",
            start  = 10,
            finish = 17,
            parent = "<IGNORE>",
            [1]    = "Handler",
        },
        extends         = {
            type        = "doc.type",
            start       = 18,
            finish      = 26,
            parent      = "<IGNORE>",
            enums       = {
            },
            firstFinish = 26,
            resumes     = {
            },
            types       = {
                [1] = {
                    type   = "doc.type.name",
                    start  = 18,
                    finish = 26,
                    parent = "<IGNORE>",
                    [1]    = "LongType",
                },
            },
        },
        originalComment = "<IGNORE>",
    },
}

LuaDoc [[
---@param a1 t1
]]
{
    type   = "doc",
    parent = "<IGNORE>",
    [1]    = {
        type            = "doc.param",
        start           = 10,
        finish          = 15,
        range           = 16,
        parent          = "<IGNORE>",
        eachCache       = "<IGNORE>",
        extends         = {
            type        = "doc.type",
            start       = 13,
            finish      = 15,
            parent      = "<IGNORE>",
            enums       = {
            },
            firstFinish = 15,
            resumes     = {
            },
            types       = {
                [1] = {
                    type   = "doc.type.name",
                    start  = 13,
                    finish = 15,
                    parent = "<IGNORE>",
                    [1]    = "t1",
                },
            },
        },
        firstFinish     = 15,
        originalComment = "<IGNORE>",
        param           = {
            type   = "doc.param.name",
            start  = 10,
            finish = 12,
            parent = "<IGNORE>",
            [1]    = "a1",
        },
        typeCache       = "<IGNORE>",
    },
}

LuaDoc [[
---@return Type1|Type2|Type3
]]
{
    type   = "doc",
    parent = "<IGNORE>",
    [1]    = {
        type            = "doc.return",
        start           = 11,
        finish          = 28,
        range           = 29,
        parent          = "<IGNORE>",
        returns         = "<IGNORE>",
        eachCache       = "<IGNORE>",
        originalComment = "<IGNORE>",
        typeCache       = "<IGNORE>",
    },
}

LuaDoc [[
---@return Type1,Type2,Type3
]]
{
    type   = "doc",
    parent = "<IGNORE>",
    [1]    = {
        type            = "doc.return",
        start           = 11,
        finish          = 28,
        range           = 29,
        parent          = "<IGNORE>",
        returns         = "<IGNORE>",
        eachCache       = "<IGNORE>",
        originalComment = "<IGNORE>",
        typeCache       = "<IGNORE>",
    },
}

LuaDoc [[
---@field open function
]]
{
    type   = "doc",
    parent = "<IGNORE>",
    [1]    = {
        type            = "doc.field",
        start           = 10,
        finish          = 23,
        range           = 24,
        parent          = "<IGNORE>",
        field           = {
            type   = "doc.field.name",
            start  = 10,
            finish = 14,
            parent = "<IGNORE>",
            [1]    = "open",
        },
        extends         = {
            type        = "doc.type",
            start       = 15,
            finish      = 23,
            parent      = "<IGNORE>",
            enums       = {
            },
            firstFinish = 23,
            resumes     = {
            },
            types       = {
                [1] = {
                    type   = "doc.type.name",
                    start  = 15,
                    finish = 23,
                    parent = "<IGNORE>",
                    [1]    = "function",
                },
            },
        },
        originalComment = "<IGNORE>",
    },
}

LuaDoc [[
---@field private open function|string
]]
{
    type   = "doc",
    parent = "<IGNORE>",
    [1]    = {
        type            = "doc.field",
        start           = 10,
        finish          = 38,
        range           = 39,
        parent          = "<IGNORE>",
        field           = {
            type   = "doc.field.name",
            start  = 18,
            finish = 22,
            parent = "<IGNORE>",
            [1]    = "open",
        },
        extends         = {
            type        = "doc.type",
            start       = 23,
            finish      = 38,
            parent      = "<IGNORE>",
            enums       = {
            },
            firstFinish = 38,
            resumes     = {
            },
            types       = {
                [1] = {
                    type   = "doc.type.name",
                    start  = 23,
                    finish = 31,
                    parent = "<IGNORE>",
                    [1]    = "function",
                },
                [2] = {
                    type   = "doc.type.name",
                    start  = 32,
                    finish = 38,
                    parent = "<IGNORE>",
                    [1]    = "string",
                },
            },
        },
        originalComment = "<IGNORE>",
        visible         = "private",
    },
}

LuaDoc [[
---@generic T
]]
{
    type   = "doc",
    parent = "<IGNORE>",
    [1]    = {
        type            = "doc.generic",
        start           = 12,
        finish          = 13,
        range           = 14,
        parent          = "<IGNORE>",
        generics        = {
            [1] = {
                type    = "doc.generic.object",
                start   = 12,
                finish  = 13,
                parent  = "<IGNORE>",
                generic = {
                    type   = "doc.generic.name",
                    start  = 12,
                    finish = 13,
                    parent = "<IGNORE>",
                    [1]    = "T",
                },
            },
        },
        originalComment = "<IGNORE>",
    },
}

LuaDoc [[
---@generic T : handle
]]
{
    type   = "doc",
    parent = "<IGNORE>",
    [1]    = {
        type            = "doc.generic",
        start           = 12,
        finish          = 22,
        range           = 23,
        parent          = "<IGNORE>",
        generics        = {
            [1] = {
                type    = "doc.generic.object",
                start   = 12,
                finish  = 22,
                parent  = "<IGNORE>",
                extends = {
                    type        = "doc.type",
                    start       = 16,
                    finish      = 22,
                    parent      = "<IGNORE>",
                    enums       = {
                    },
                    firstFinish = 22,
                    resumes     = {
                    },
                    types       = {
                        [1] = {
                            type   = "doc.type.name",
                            start  = 16,
                            finish = 22,
                            parent = "<IGNORE>",
                            [1]    = "handle",
                        },
                    },
                },
                generic = {
                    type   = "doc.generic.name",
                    start  = 12,
                    finish = 13,
                    parent = "<IGNORE>",
                    [1]    = "T",
                },
            },
        },
        originalComment = "<IGNORE>",
    },
}

LuaDoc [[
---@generic T : handle, K : handle
]]
{
    type   = "doc",
    parent = "<IGNORE>",
    [1]    = {
        type            = "doc.generic",
        start           = 12,
        finish          = 34,
        range           = 35,
        parent          = "<IGNORE>",
        generics        = {
            [1] = {
                type    = "doc.generic.object",
                start   = 12,
                finish  = 22,
                parent  = "<IGNORE>",
                extends = {
                    type        = "doc.type",
                    start       = 16,
                    finish      = 22,
                    parent      = "<IGNORE>",
                    enums       = {
                    },
                    firstFinish = 22,
                    resumes     = {
                    },
                    types       = {
                        [1] = {
                            type   = "doc.type.name",
                            start  = 16,
                            finish = 22,
                            parent = "<IGNORE>",
                            [1]    = "handle",
                        },
                    },
                },
                generic = {
                    type   = "doc.generic.name",
                    start  = 12,
                    finish = 13,
                    parent = "<IGNORE>",
                    [1]    = "T",
                },
            },
            [2] = {
                type    = "doc.generic.object",
                start   = 24,
                finish  = 34,
                parent  = "<IGNORE>",
                extends = {
                    type        = "doc.type",
                    start       = 28,
                    finish      = 34,
                    parent      = "<IGNORE>",
                    enums       = {
                    },
                    firstFinish = 34,
                    resumes     = {
                    },
                    types       = {
                        [1] = {
                            type   = "doc.type.name",
                            start  = 28,
                            finish = 34,
                            parent = "<IGNORE>",
                            [1]    = "handle",
                        },
                    },
                },
                generic = {
                    type   = "doc.generic.name",
                    start  = 24,
                    finish = 25,
                    parent = "<IGNORE>",
                    [1]    = "K",
                },
            },
        },
        originalComment = "<IGNORE>",
    },
}

LuaDoc [[
---@vararg string
]]
{
    type   = "doc",
    parent = "<IGNORE>",
    [1]    = {
        type            = "doc.vararg",
        start           = 11,
        finish          = 17,
        range           = 18,
        parent          = "<IGNORE>",
        vararg          = "<IGNORE>",
        originalComment = "<IGNORE>",
    },
}

LuaDoc [[
---@type Type[]
]]
{
    type   = "doc",
    parent = "<IGNORE>",
    [1]    = {
        type            = "doc.type",
        start           = 9,
        finish          = 15,
        range           = 16,
        parent          = "<IGNORE>",
        eachCache       = "<IGNORE>",
        enums           = {
        },
        firstFinish     = 15,
        originalComment = "<IGNORE>",
        resumes         = {
        },
        typeCache       = "<IGNORE>",
        types           = {
            [1] = {
                type   = "doc.type.array",
                start  = 9,
                finish = 15,
                parent = "<IGNORE>",
                node   = "<IGNORE>",
            },
        },
    },
}

LuaDoc [[
---@type table<key, value>
]]
{
    type   = "doc",
    parent = "<IGNORE>",
    [1]    = {
        type            = "doc.type",
        start           = 9,
        finish          = 26,
        range           = 27,
        parent          = "<IGNORE>",
        eachCache       = "<IGNORE>",
        enums           = {
        },
        firstFinish     = 26,
        originalComment = "<IGNORE>",
        resumes         = {
        },
        typeCache       = "<IGNORE>",
        types           = {
            [1] = {
                type   = "doc.type.table",
                start  = 9,
                finish = 26,
                parent = "<IGNORE>",
                node   = "<IGNORE>",
                tkey   = {
                    type        = "doc.type",
                    start       = 15,
                    finish      = 18,
                    parent      = "<IGNORE>",
                    enums       = {
                    },
                    firstFinish = 18,
                    resumes     = {
                    },
                    types       = {
                        [1] = {
                            type   = "doc.type.name",
                            start  = 15,
                            finish = 18,
                            parent = "<IGNORE>",
                            [1]    = "key",
                        },
                    },
                },
                tvalue = {
                    type        = "doc.type",
                    start       = 20,
                    finish      = 25,
                    parent      = "<IGNORE>",
                    enums       = {
                    },
                    firstFinish = 25,
                    resumes     = {
                    },
                    types       = {
                        [1] = {
                            type   = "doc.type.name",
                            start  = 20,
                            finish = 25,
                            parent = "<IGNORE>",
                            [1]    = "value",
                        },
                    },
                },
            },
        },
    },
}

OPTION.format['returns'] = nil
OPTION.format['extends'] = function ()
    return '"<IGNORE>"'
end
LuaDoc [[
---@type fun(key1:t1, key2:t2):t3
]]
{
    type   = "doc",
    parent = "<IGNORE>",
    [1]    = {
        type            = "doc.type",
        start           = 9,
        finish          = 33,
        range           = 34,
        parent          = "<IGNORE>",
        eachCache       = "<IGNORE>",
        enums           = {
        },
        firstFinish     = 33,
        originalComment = "<IGNORE>",
        resumes         = {
        },
        typeCache       = "<IGNORE>",
        types           = {
            [1] = {
                type    = "doc.type.function",
                start   = 9,
                finish  = 33,
                parent  = "<IGNORE>",
                args    = {
                    [1] = {
                        type    = "doc.type.arg",
                        start   = 13,
                        finish  = 20,
                        parent  = "<IGNORE>",
                        extends = "<IGNORE>",
                        name    = {
                            type   = "doc.type.name",
                            start  = 13,
                            finish = 17,
                            parent = "<IGNORE>",
                            [1]    = "key1",
                        },
                    },
                    [2] = {
                        type    = "doc.type.arg",
                        start   = 22,
                        finish  = 29,
                        parent  = "<IGNORE>",
                        extends = "<IGNORE>",
                        name    = {
                            type   = "doc.type.name",
                            start  = 22,
                            finish = 26,
                            parent = "<IGNORE>",
                            [1]    = "key2",
                        },
                    },
                },
                returns = {
                    [1] = {
                        type        = "doc.type",
                        start       = 31,
                        finish      = 33,
                        parent      = "<IGNORE>",
                        enums       = {
                        },
                        firstFinish = 33,
                        resumes     = {
                        },
                        types       = {
                            [1] = {
                                type   = "doc.type.name",
                                start  = 31,
                                finish = 33,
                                parent = "<IGNORE>",
                                [1]    = "t3",
                            },
                        },
                    },
                },
            },
        },
    },
}

OPTION.format['returns'] = function ()
    return '"<IGNORE>"'
end
OPTION.format['extends'] = nil
LuaDoc [[
---@param event string | "'onClosed'" | "'onData'"
]]
{
    type   = "doc",
    parent = "<IGNORE>",
    [1]    = {
        type            = "doc.param",
        start           = 10,
        finish          = 50,
        range           = 51,
        parent          = "<IGNORE>",
        eachCache       = "<IGNORE>",
        extends         = {
            type        = "doc.type",
            start       = 16,
            finish      = 50,
            parent      = "<IGNORE>",
            enums       = {
                [1] = {
                    type   = "doc.type.enum",
                    start  = 25,
                    finish = 37,
                    parent = "<IGNORE>",
                    [1]    = "'onClosed'",
                },
                [2] = {
                    type   = "doc.type.enum",
                    start  = 40,
                    finish = 50,
                    parent = "<IGNORE>",
                    [1]    = "'onData'",
                },
            },
            firstFinish = 50,
            resumes     = {
            },
            types       = {
                [1] = {
                    type   = "doc.type.name",
                    start  = 16,
                    finish = 22,
                    parent = "<IGNORE>",
                    [1]    = "string",
                },
            },
        },
        firstFinish     = 50,
        originalComment = "<IGNORE>",
        param           = {
            type   = "doc.param.name",
            start  = 10,
            finish = 15,
            parent = "<IGNORE>",
            [1]    = "event",
        },
        typeCache       = "<IGNORE>",
    },
}

LuaDoc [[
---@overload fun(a:number):number
]]
{
    type   = "doc",
    parent = "<IGNORE>",
    [1]    = {
        type            = "doc.overload",
        start           = 13,
        finish          = 33,
        range           = 34,
        parent          = "<IGNORE>",
        originalComment = "<IGNORE>",
        overload        = {
            type    = "doc.type.function",
            start   = 13,
            finish  = 33,
            parent  = "<IGNORE>",
            args    = {
                [1] = {
                    type    = "doc.type.arg",
                    start   = 17,
                    finish  = 25,
                    parent  = "<IGNORE>",
                    extends = {
                        type        = "doc.type",
                        start       = 19,
                        finish      = 25,
                        parent      = "<IGNORE>",
                        enums       = {
                        },
                        firstFinish = 25,
                        resumes     = {
                        },
                        types       = {
                            [1] = {
                                type   = "doc.type.name",
                                start  = 19,
                                finish = 25,
                                parent = "<IGNORE>",
                                [1]    = "number",
                            },
                        },
                    },
                    name    = {
                        type   = "doc.type.name",
                        start  = 17,
                        finish = 18,
                        parent = "<IGNORE>",
                        [1]    = "a",
                    },
                },
            },
            returns = "<IGNORE>",
        },
    },
}

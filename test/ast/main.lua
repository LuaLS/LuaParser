local class = require 'class'

---@param code string
---@param optional? LuaParser.CompileOptions
---@return fun(table)
local function TEST(code, optional)
    return function (expect)
        local ast = class.new 'LuaParser.Ast' (code, nil, optional)
        local main = ast:parseMain()
        assert(main)
        Match(main, expect)
    end
end

TEST ''
{
    type   = 'Main',
    start  = 0,
    finish = 0,
}

TEST ';;;'
{
    start  = 0,
    finish = 3,
}

TEST ';;;x = 1'
{
    locals = {
        [1] = {
            id = '...',
            dummy = true,
        },
        [2] = {
            id = '_ENV',
            dummy = true,
            envRefs  = {
                [1] = {
                    start = 3
                }
            }
        }
    },
    childs = {
        [1] = {
            type = 'Assign',
            exps = {
                [1] = {
                    id = 'x',
                    env = {
                        id    = '_ENV',
                        start = 0,
                    }
                }
            }
        }
    }
}

TEST ([[
local x = 1 // 2
]], {
    nonestandardSymbols = { '//' }
})
{
    childs = {
        [1] = {
            values = {
                [1] = {
                    type = 'Integer',
                }
            }
        }
    }
}

TEST ([[
local x = 1 // 2
]])
{
    childs = {
        [1] = {
            values = {
                [1] = {
                    type = 'Binary',
                    op   = '//'
                }
            }
        }
    }
}

TEST ([[
local x = {
    1, // BAD
    2, // GOOD
    3, // GOOD
}
]], {
    nonestandardSymbols = { '//' }
})
{
    childs = {
        [1] = {
            values = {
                [1] = {
                    type = 'Table',
                    fields = {
                        [1] = {
                            subtype = 'exp',
                            value  = {
                                value = 1,
                            }
                        },
                        [2] = {
                            subtype = 'exp',
                            value  = {
                                value = 2,
                            }
                        },
                        [3] = {
                            subtype = 'exp',
                            value  = {
                                value = 3,
                            }
                        }
                    }
                }
            }
        }
    }
}

TEST [[
local x
return {
    x = 1,
}
]]
{
    childs = {
        [2] = {
            exps = {
                [1] = {
                    type = 'Table',
                    fields = {
                        [1] = {
                            subtype = 'field',
                            key = {
                                id = 'x',
                                loc = NIL,
                            }
                        }
                    }
                }
            }
        }
    }
}

TEST [[
local x
a = {
    x
}
]]
{
    childs = {
        [2] = {
            values = {
                [1] = {
                    type = 'Table',
                    fields = {
                        [1] = {
                            subtype = 'exp',
                            value  = {
                                id = 'x',
                                loc = {
                                    left = 6
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}

CHECK [[
local x, y
-- comments
]]
{
    type   = "main",
    start  = 0,
    finish = 20000,
    locals = "<IGNORE>",
    [1]    = {
        type   = "local",
        start  = 6,
        finish = 7,
        effect = 10,
        parent = "<IGNORE>",
        locPos = 0,
        [1]    = "x",
    },
    [2]    = {
        type   = "local",
        start  = 9,
        finish = 10,
        effect = 10,
        parent = "<IGNORE>",
        [1]    = "y",
    },
}

CHECK [[
local _ENV = nil
]]
{
    type   = "main",
    start  = 0,
    finish = 10000,
    locals = "<IGNORE>",
    [1]    = {
        type   = "local",
        start  = 6,
        finish = 10,
        effect = 16,
        range  = 16,
        parent = "<IGNORE>",
        locPos = 0,
        value  = {
            type   = "nil",
            start  = 13,
            finish = 16,
            parent = "<IGNORE>",
        },
        [1]    = "_ENV",
    },
}

CHECK [[
_ENV = nil
]]
{
    type   = "main",
    start  = 0,
    finish = 10000,
    locals = "<IGNORE>",
    [1]    = {
        type   = "local",
        start  = 0,
        finish = 4,
        effect = 10,
        range  = 10,
        parent = "<IGNORE>",
        node   = "<IGNORE>",
        locPos = 0,
        value  = {
            type   = "nil",
            start  = 7,
            finish = 10,
            parent = "<IGNORE>",
        },
        [1]    = "_ENV",
    },
}

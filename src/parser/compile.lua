local guide = require 'parser.guide'
local print = print

_ENV = nil

local State, Errs, pushError, Ast

local dual = {
    ['main'] = function (ast, id)
        local funcList = State.ref['function']
        for i = 1, #ast do
            local action = ast[i]
            funcList[action] = id
        end
    end,
    ['function'] = function (ast, id)
        local funcList = State.ref['function']
        for i = 1, #ast do
            local action = ast[i]
            funcList[action] = id
        end
    end,
    ['return'] = function (ast, id)
        local rtnList = State.ref['return']
        for i = 1, #ast do
            local exp = ast[i]
            rtnList[exp] = id
        end
    end,
}

local function markState()
    State.ref = {
        ['function'] = {},
        ['return']   = {},
    }
    for i = 1, #Ast do
        local ast = Ast[i]
        local markMethod = dual[ast.type]
        if markMethod then
            markMethod(ast, i)
        end
    end
end

local function doSyntaxCheck()
end

return function (self, lua, mode, version)
    State, Errs = self:parse(lua, mode, version)
    if not State then
        return Errs
    end
    pushError = State.pushError
    Ast = State.ast
    markState()
    doSyntaxCheck()
    return State, Errs
end

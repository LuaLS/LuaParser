local guide = require 'parser.guide'
local print = print

_ENV = nil

local State, Errs, pushError, Ast

local vmMap = {
    ['varargs'] = function (obj, id)
        local func = guide.getParentFunction(State, id)
        if not func then
            return
        end
        local funcAst = Ast[func]
        local argAst  = Ast[funcAst.args]
    end,
}

local function compileVM()
    for i = 1, #Ast do
        local ast = Ast[i]
        local vmMethod = vmMap[ast.type]
        if vmMethod then
            vmMethod(ast, i)
        end
    end
end

return function (self, lua, mode, version)
    State, Errs = self:parse(lua, mode, version)
    if not State then
        return Errs
    end
    pushError = State.pushError
    Ast = State.ast
    compileVM()
    return State, Errs
end

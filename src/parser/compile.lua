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
        local dots = guide.getFunctionVarArgs(State, func)
        if not dots then
            pushError {
                type   = 'UNEXPECT_DOTS',
                start  = obj.start,
                finish = obj.finish,
            }
        end
    end,
    ['break'] = function (obj, id)
        local block = guide.getParentBlock(State, id)
        if not block then
            pushError {
                type   = 'BREAK_OUTSIDE',
                start  = obj.start,
                finish = obj.finish,
            }
            return
        end
    end
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

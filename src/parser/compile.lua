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
        local block = guide.getParentBreakBlock(State, id)
        if not block then
            pushError {
                type   = 'BREAK_OUTSIDE',
                start  = obj.start,
                finish = obj.finish,
            }
            return
        end
    end,
    ['return'] = function (obj, id)
        local list = State.ref[id]
        local listAst = State.ast[list]
        local last = listAst[#listAst]
        if last ~= id then
            pushError {
                type   = 'ACTION_AFTER_RETURN',
                start  = obj.start,
                finish = obj.finish,
            }
        end
    end,
    ['goto'] = function (obj, id)
        local ast = State.ast
        local name = obj[1]
        local block = id
        for _ = 1, 1000 do
            block = guide.getParentBlock(State, block)
            if not block then
                break
            end
            local blockAst = ast[block]
            if blockAst.type == 'function' then
                break
            end
            for i = 1, #blockAst do
                local actionAst = ast[blockAst[i]]
                if actionAst.type == 'label' and actionAst[1] == name then
                    return
                end
            end
        end
        pushError {
            type   = 'NO_VISIBLE_LABEL',
            start  = obj.start,
            finish = obj.finish,
            info   = {
                label = name,
            }
        }
    end,
    ['getname'] = function (obj, id)
        
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

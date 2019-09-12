local guide = require 'parser.guide'
local print = print

_ENV = nil

local State, Errs, pushError, Ast

local function checkJumpLocal(start, finish, obj)
    if obj.start < start then
        return nil
    end
    if obj.finish > finish then
        return nil
    end
    local refs = obj.ref
    if not refs then
        return nil
    end
    for i = 1, #refs do
        local ast = Ast[refs[i]]
        if ast.start > finish then
            return ast
        end
    end
    return nil
end

local vmMap1 = {
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
        local block = guide.getBreakBlock(State, id)
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
        local list = State.parent[id]
        if not list then
            return
        end
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
    ['getname'] = function (obj, id)
        local loc = guide.lookupLocal(State, guide.getBlock(State, id), obj[1])
        if loc then
            obj.type = 'getlocal'
            obj.loc  = loc
            local locAst = State.ast[loc]
            if not locAst.ref then
                locAst.ref = {}
            end
            locAst.ref[#locAst.ref+1] = id
        else
            obj.type = 'getglobal'
        end
    end,
    ['setname'] = function (obj, id)
        local loc = guide.lookupLocal(State, guide.getBlock(State, id), obj[1])
        if loc then
            obj.type = 'setlocal'
            obj.loc  = loc
            local locAst = State.ast[loc]
            if not locAst.ref then
                locAst.ref = {}
            end
            locAst.ref[#locAst.ref+1] = id
        else
            obj.type = 'setglobal'
        end
    end,
    ['label'] = function (obj, id)
        local block = guide.getBlock(State, id)
        if not block then
            return
        end
        local name = obj[1]
        local label = guide.getLabel(State, block, name, id)
        if label and label ~= id then
            local labelAst = Ast[label]
            pushError {
                type   = 'REDEFINED_LABEL',
                start  = obj.start,
                finish = obj.finish,
                relative = {
                    {
                        labelAst.start,
                        labelAst.finish,
                    }
                }
            }
        end
    end,
}

local vmMap2 = {
    ['goto'] = function (obj, id)
        local name = obj[1]
        local block = guide.getBlock(State, id)
        local label = guide.getLabel(State, block, name)
        if not label then
            pushError {
                type   = 'NO_VISIBLE_LABEL',
                start  = obj.start,
                finish = obj.finish,
                info   = {
                    label = name,
                }
            }
            return
        end

        local labelAst = Ast[label]
        obj.ref = label
        labelAst.ref = id

        if labelAst.start < obj.start then
            return
        end
        -- 检查在 goto 与 label 之间声明的局部变量
        local blockAst = Ast[block]
        for i = 1, #blockAst do
            local action = blockAst[i]
            local actionAst = Ast[action]
            if actionAst == labelAst then
                break
            end
            if actionAst.type == 'local' then
                local locAst = checkJumpLocal(obj.start, labelAst.start, actionAst)
                if locAst then
                    pushError {
                        type   = 'JUMP_LOCAL_SCOPE',
                        start  = obj.start,
                        finish = obj.finish,
                        info   = {
                            loc = locAst[1],
                        },
                        relative = {
                            {
                                start  = labelAst.start,
                                finish = labelAst.finish,
                            },
                            {
                                start  = locAst.start,
                                finish = locAst.finish,
                            }
                        },
                    }
                    break
                end
            end
        end
    end,
}

local function compileVM()
    for i = 1, #Ast do
        local ast = Ast[i]
        local vmMethod = vmMap1[ast.type]
        if vmMethod then
            vmMethod(ast, i)
        end
    end
    for i = 1, #Ast do
        local ast = Ast[i]
        local vmMethod = vmMap2[ast.type]
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

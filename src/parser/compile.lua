local guide = require 'parser.guide'
local print = print

_ENV = nil

local State, Errs, pushError, Root, Compile

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
        local ast = Root[refs[i]]
        if ast.start > finish then
            return ast
        end
    end
    return nil
end

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
        local loc = guide.getLocal(State, guide.getBlock(State, id), obj[1])
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
        local loc = guide.getLocal(State, guide.getBlock(State, id), obj[1])
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
            local labelAst = Root[label]
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

        local labelAst = Root[label]
        obj.ref = label
        labelAst.ref = id

        if labelAst.start < obj.start then
            return
        end
        -- 检查在 goto 与 label 之间声明的局部变量
        local blockAst = Root[block]
        for i = 1, #blockAst do
            local action = blockAst[i]
            local actionAst = Root[action]
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

local vmMap = {
    ['nil'] = function (obj)
        Root[#Root+1] = obj
        return #Root
    end,
    ['boolean'] = function (obj)
        Root[#Root+1] = obj
        return #Root
    end,
    ['string'] = function (obj)
        Root[#Root+1] = obj
        return #Root
    end,
    ['number'] = function (obj)
        Root[#Root+1] = obj
        return #Root
    end,
    ['getname'] = function (obj)
        Root[#Root+1] = obj
        return #Root
    end,
    ['getfield'] = function (obj)
        local node = obj.node
        Root[#Root+1] = obj
        local id = #Root
        obj.node = Compile(node)
        node.parent = id
        return id
    end,
    ['call'] = function (obj)
        local node = obj.node
        local args = obj.args
        Root[#Root+1] = obj
        local id = #Root
        obj.node = Compile(node)
        obj.args = Compile(args)
        node.parent = id
        args.parent = id
        return id
    end,
    ['callargs'] = function (obj)
        Root[#Root+1] = obj
        local id = #Root
        for i = 1, #obj do
            local arg = obj[i]
            obj[i] = Compile(arg)
            arg.parent = id
        end
        return id
    end,
    ['binary'] = function (obj)
        local e1 = obj[1]
        local e2 = obj[2]
        Root[#Root+1] = obj
        local id = #Root
        obj[1] = Compile(e1)
        obj[2] = Compile(e2)
        e1.parent = id
        e2.parent = id
        return id
    end,
    ['unary'] = function (obj)
        local e = obj[1]
        Root[#Root+1] = obj
        local id = #Root
        obj[1] = Compile(e)
        e.parent = id
        return id
    end,
    ['varargs'] = function (obj)
        Root[#Root+1] = obj
        return #Root
    end,
    ['paren'] = function (obj)
        local exp = obj.exp
        Root[#Root+1] = obj
        local id = #Root
        obj.exp = Compile(exp)
        exp.parent = id
        return id
    end,
    ['getindex'] = function (obj)
        local node = obj.node
        local index = obj.index
        Root[#Root+1] = obj
        local id = #Root
        obj.node = Compile(node)
        obj.index = Compile(index)
        node.parent = id
        index.parent = id
        return id
    end,
    ['getmethod'] = function (obj)
        local node = obj.node
        local method = obj.method
        Root[#Root+1] = obj
        local id = #Root
        obj.node = Compile(node)
        obj.method = Compile(method)
        node.parent = id
        method.parent = id
        return id
    end,
    ['function'] = function (obj)
        --local args = obj.args
    end,
}

function Compile(obj)
    if not obj then
        return nil
    end
    local f = vmMap[obj.type]
    if not f then
        return nil
    end
    return f(obj)
end

return function (self, lua, mode, version)
    State, Errs = self:parse(lua, mode, version)
    if not State then
        return Errs
    end
    pushError = State.pushError
    Root = State.root
    Compile(State.ast)
    return State, Errs
end

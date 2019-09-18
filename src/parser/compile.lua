local guide = require 'parser.guide'
local type = type

_ENV = nil

local pushError, Root, Compile, Cache, Block

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
    ['...'] = function (obj)
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
        obj.node = Compile(node, id)
        return id
    end,
    ['call'] = function (obj)
        Root[#Root+1] = obj
        local id = #Root
        local node = obj.node
        local args = obj.args
        if node then
            obj.node = Compile(node, id)
        end
        if args then
            obj.args = Compile(args, id)
        end
        return id
    end,
    ['callargs'] = function (obj)
        Root[#Root+1] = obj
        local id = #Root
        for i = 1, #obj do
            local arg = obj[i]
            obj[i] = Compile(arg, id)
        end
        return id
    end,
    ['binary'] = function (obj)
        local e1 = obj[1]
        local e2 = obj[2]
        Root[#Root+1] = obj
        local id = #Root
        obj[1] = Compile(e1, id)
        obj[2] = Compile(e2, id)
        return id
    end,
    ['unary'] = function (obj)
        local e = obj[1]
        Root[#Root+1] = obj
        local id = #Root
        obj[1] = Compile(e, id)
        return id
    end,
    ['varargs'] = function (obj)
        local func = guide.getParentFunction(Root, obj)
        if func then
            local index = guide.getFunctionVarArgs(Root, func)
            if not index then
                pushError {
                    type   = 'UNEXPECT_DOTS',
                    start  = obj.start,
                    finish = obj.finish,
                }
            end
        end
        Root[#Root+1] = obj
        return #Root
    end,
    ['paren'] = function (obj)
        local exp = obj.exp
        Root[#Root+1] = obj
        local id = #Root
        obj.exp = Compile(exp, id)
        return id
    end,
    ['getindex'] = function (obj)
        Root[#Root+1] = obj
        local id = #Root
        local node = obj.node
        obj.node = Compile(node, id)
        local index = obj.index
        if index then
            obj.index = Compile(index, id)
        end
        return id
    end,
    ['getmethod'] = function (obj)
        Root[#Root+1] = obj
        local id = #Root
        local node = obj.node
        local method = obj.method
        obj.node = Compile(node, id)
        if method then
            obj.method = Compile(method, id)
        end
        return id
    end,
    ['setmethod'] = function (obj)
        Root[#Root+1] = obj
        local id = #Root
        local node = obj.node
        local method = obj.method
        local value = obj.value
        obj.node = Compile(node, id)
        if method then
            obj.method = Compile(method, id)
        end
        obj.value = Compile(value, id)
        return id
    end,
    ['method'] = function (obj)
        Root[#Root+1] = obj
        return #Root
    end,
    ['function'] = function (obj)
        Root[#Root+1] = obj
        local id = #Root
        local args = obj.args
        if args then
            obj.args = Compile(args, id)
        end
        for i = 1, #obj do
            local act = obj[i]
            obj[i] = Compile(act, id)
        end
        return id
    end,
    ['funcargs'] = function (obj)
        Root[#Root+1] = obj
        local id = #Root
        for i = 1, #obj do
            local arg = obj[i]
            obj[i] = Compile(arg, id)
        end
        return id
    end,
    ['table'] = function (obj)
        Root[#Root+1] = obj
        local id = #Root
        for i = 1, #obj do
            local v = obj[i]
            obj[i] = Compile(v, id)
        end
        return id
    end,
    ['tablefield'] = function (obj)
        Root[#Root+1] = obj
        local id = #Root
        local value = obj.value
        if value then
            obj.value = Compile(value, id)
        end
        return id
    end,
    ['tableindex'] = function (obj)
        Root[#Root+1] = obj
        local id = #Root
        local index = obj.index
        local value = obj.value
        obj.index = Compile(index, id)
        obj.value = Compile(value, id)
        return id
    end,
    ['index'] = function (obj)
        Root[#Root+1] = obj
        local id = #Root
        local index = obj.index
        obj.index = Compile(index, id)
        return id
    end,
    ['select'] = function (obj)
        Root[#Root+1] = obj
        local id = #Root
        local vararg = obj.vararg
        if not Cache[vararg] then
            obj.vararg = Compile(vararg, id)
            Cache[vararg] = obj.vararg
        else
            obj.vararg = Cache[vararg]
            if not vararg.extParent then
                vararg.extParent = {}
            end
            vararg.extParent[#vararg.extParent+1] = id
        end
        return id
    end,
    ['setname'] = function (obj)
        Root[#Root+1] = obj
        local id = #Root
        local value = obj.value
        if value then
            obj.value = Compile(value, id)
        end
        return id
    end,
    ['local'] = function (obj)
        Root[#Root+1] = obj
        local id = #Root
        local attrs = obj.attrs
        if attrs then
            for i = 1, #attrs do
                local attr = attrs[i]
                attrs[i] = Compile(attr, id)
            end
        end
        local value = obj.value
        if value then
            obj.value = Compile(value, id)
        end
        return id
    end,
    ['localattr'] = function (obj)
        Root[#Root+1] = obj
        return #Root
    end,
    ['setfield'] = function (obj)
        Root[#Root+1] = obj
        local id = #Root
        local node  = obj.node
        local field = obj.field
        local value = obj.value
        obj.node  = Compile(node, id)
        obj.field = Compile(field, id)
        obj.value = Compile(value, id)
        return id
    end,
    ['do'] = function (obj)
        Root[#Root+1] = obj
        local id = #Root
        for i = 1, #obj do
            local act = obj[i]
            obj[i] = Compile(act, id)
        end
        return id
    end,
    ['return'] = function (obj)
        Root[#Root+1] = obj
        local id = #Root
        for i = 1, #obj do
            local act = obj[i]
            obj[i] = Compile(act, id)
        end
        return id
    end,
    ['label'] = function (obj)
        Root[#Root+1] = obj
        return #Root
    end,
    ['goto'] = function (obj)
        Root[#Root+1] = obj
        return #Root
    end,
    ['if'] = function (obj)
        Root[#Root+1] = obj
        local id = #Root
        for i = 1, #obj do
            local block = obj[i]
            obj[i] = Compile(block, id)
        end
        return id
    end,
    ['ifblock'] = function (obj)
        local lastBlock = Block
        Block = obj
        Root[#Root+1] = obj
        local id = #Root
        local filter = obj.filter
        obj.filter = Compile(filter, id)
        for i = 1, #obj do
            local act = obj[i]
            obj[i] = Compile(act, id)
        end
        Block = lastBlock
        return id
    end,
    ['elseifblock'] = function (obj)
        local lastBlock = Block
        Block = obj
        Root[#Root+1] = obj
        local id = #Root
        local filter = obj.filter
        if filter then
            obj.filter = Compile(filter, id)
        end
        for i = 1, #obj do
            local act = obj[i]
            obj[i] = Compile(act, id)
        end
        Block = lastBlock
        return id
    end,
    ['elseblock'] = function (obj)
        local lastBlock = Block
        Block = obj
        Root[#Root+1] = obj
        local id = #Root
        for i = 1, #obj do
            local act = obj[i]
            obj[i] = Compile(act, id)
        end
        Block = lastBlock
        return id
    end,
    ['loop'] = function (obj)
        local lastBlock = Block
        Block = obj
        Root[#Root+1] = obj
        local id = #Root
        local loc = obj.loc
        local max = obj.max
        local step = obj.step
        if loc then
            obj.loc = Compile(loc, id)
        end
        if max then
            obj.max = Compile(max, id)
        end
        if step then
            obj.step = Compile(step, id)
        end
        for i = 1, #obj do
            local act = obj[i]
            obj[i] = Compile(act, id)
        end
        Block = lastBlock
        return id
    end,
    ['in'] = function (obj)
        local lastBlock = Block
        Block = obj
        Root[#Root+1] = obj
        local id = #Root
        local locs = obj.locs
        for i = 1, #locs do
            local loc = locs[i]
            locs[i] = Compile(loc, id)
        end
        for i = 1, #obj do
            local act = obj[i]
            obj[i] = Compile(act, id)
        end
        Block = lastBlock
        return id
    end,
    ['while'] = function (obj)
        local lastBlock = Block
        Block = obj
        Root[#Root+1] = obj
        local id = #Root
        local filter = obj.filter
        obj.filter = Compile(filter, id)
        for i = 1, #obj do
            local act = obj[i]
            obj[i] = Compile(act, id)
        end
        Block = lastBlock
        return id
    end,
    ['repeat'] = function (obj)
        local lastBlock = Block
        Block = obj
        Root[#Root+1] = obj
        local id = #Root
        for i = 1, #obj do
            local act = obj[i]
            obj[i] = Compile(act, id)
        end
        local filter = obj.filter
        obj.filter = Compile(filter, id)
        Block = lastBlock
        return id
    end,
    ['break'] = function (obj)
        if not guide.getBreakBlock(Root, obj) then
            pushError {
                type   = 'BREAK_OUTSIDE',
                start  = obj.start,
                finish = obj.finish,
            }
        end
        Root[#Root+1] = obj
        return #Root
    end,
    ['main'] = function (obj)
        Block = obj
        Root[#Root+1] = obj
        local id = #Root
        for i = 1, #obj do
            local act = obj[i]
            obj[i] = Compile(act, id)
        end
        Block = nil
        return id
    end,
}

function Compile(obj, parent)
    if not obj then
        return nil
    end
    local f = vmMap[obj.type]
    if not f then
        return nil
    end
    obj.parent = parent
    return f(obj)
end

return function (self, lua, mode, version)
    local state, errs = self:parse(lua, mode, version)
    if not state then
        return errs
    end
    pushError = state.pushError
    Root = state.root
    Cache = {}
    if type(state.ast) == 'table' then
        Compile(state.ast)
    end
    state.ast = nil
    Cache = nil
    return state, errs
end

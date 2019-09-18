_ENV = nil

local m = {}

local blockTypes = {
    ['while']       = true,
    ['in']          = true,
    ['loop']        = true,
    ['repeat']      = true,
    ['do']          = true,
    ['function']    = true,
    ['ifblock']     = true,
    ['elseblock']   = true,
    ['elseifblock'] = true,
    ['main']        = true,
}

local breakBlockTypes = {
    ['while']       = true,
    ['in']          = true,
    ['loop']        = true,
    ['repeat']      = true,
}

--- 寻找所在函数
function m.getParentFunction(root, obj)
    for _ = 1, 1000 do
        obj = root[obj.parent]
        if not obj then
            break
        end
        local tp = obj.type
        if tp == 'function' then
            return obj
        end
    end
    return nil
end

--- 寻找所在父区块
function m.getBlock(state, id)
    local parent = state.parent
    local ast = state.ast
    for _ = 1, 1000 do
        id = parent[id]
        if not id then
            break
        end
        local tp = ast[id].type
        if blockTypes[tp] then
            return id
        end
    end
    return nil
end

--- 寻找所在可break的父区块
function m.getBreakBlock(root, obj)
    for _ = 1, 1000 do
        obj = root[obj.parent]
        if not obj then
            break
        end
        local tp = obj.type
        if breakBlockTypes[tp] then
            return obj
        end
        if tp == 'function' then
            return nil
        end
    end
    return nil
end

--- 寻找函数的不定参数，返回不定参在第几个参数上，以及该参数对象。
--- 如果函数是主函数，则返回`0, nil`。
---@return table
---@return integer
function m.getFunctionVarArgs(root, func)
    if func.type == 'main' then
        return 0, nil
    end
    if func.type ~= 'function' then
        return nil, nil
    end
    local args = root[func.args]
    if not args then
        return nil, nil
    end
    for i = 1, #args do
        local arg = root[args[i]]
        if arg.type == '...' then
            return i, arg
        end
    end
    return nil, nil
end

function m.getLocal(state, block, name)
    local astMap = state.ast
    local locals = state.loc[name]
    if not locals then
        return nil
    end
    for _ = 1, 1000 do
        local result
        for i = 1, #locals do
            local loc = locals[i]
            if m.getBlock(state, loc) == block then
                if result then
                    local lastLocAst = astMap[result]
                    local newLocAst  = astMap[loc]
                    if lastLocAst.start < newLocAst.start then
                        result = loc
                    end
                else
                    result = loc
                end
            end
        end
        if result then
            return result
        end
        block = m.getBlock(state, block)
        if not block then
            return nil
        end
    end
    return nil
end

function m.getLabel(state, block, name, exclude)
    local astMap = state.ast
    for _ = 1, 1000 do
        local blockAst = astMap[block]
        for i = 1, #blockAst do
            local action = blockAst[i]
            if action == exclude then
                goto CONTINUE
            end
            local actionAst = astMap[action]
            if actionAst.type == 'label' and actionAst[1] == name then
                return action
            end
            ::CONTINUE::
        end
        if blockAst.type == 'function' then
            return nil
        end
        block = m.getBlock(state, block)
        if not block then
            return nil
        end
    end
end

return m

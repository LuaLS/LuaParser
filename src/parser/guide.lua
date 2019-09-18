local error = error

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

--- 寻找所在区块
function m.getBlock(root, obj)
    for _ = 1, 1000 do
        if not obj then
            return nil
        end
        local tp = obj.type
        if blockTypes[tp] then
            return obj
        end
        obj = root[obj.parent]
    end
    error('guide.getBlock overstack')
end

--- 寻找所在父区块
function m.getParentBlock(root, obj)
    for _ = 1, 1000 do
        obj = root[obj.parent]
        if not obj then
            return nil
        end
        local tp = obj.type
        if blockTypes[tp] then
            return obj
        end
    end
    error('guide.getParentBlock overstack')
end

--- 寻找所在可break的父区块
function m.getBreakBlock(root, obj)
    for _ = 1, 1000 do
        obj = root[obj.parent]
        if not obj then
            return nil
        end
        local tp = obj.type
        if breakBlockTypes[tp] then
            return obj
        end
        if tp == 'function' then
            return nil
        end
    end
    error('guide.getBreakBlock overstack')
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

--- 寻找指定区块中的局部变量
---@param root table
---@param block table
---@param name string {comment = '变量名'}
---@param pos integer {comment = '可见位置'}
function m.getLocal(root, block, name, pos)
    block = m.getBlock(root, block)
    for _ = 1, 1000 do
        if not block then
            return nil
        end
        local locs = block.locs
        local res
        if not locs then
            goto CONTINUE
        end
        for i = 1, #locs do
            local loc = root[locs[i]]
            if loc.start > pos then
                break
            end
            if loc[1] == name then
                if not res or res.start < loc.start then
                    res = loc
                end
            end
        end
        if res then
            return res
        end
        ::CONTINUE::
        block = m.getParentBlock(root, block)
    end
    error('guide.getLocal overstack')
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

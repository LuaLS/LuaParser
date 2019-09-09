local m = {}

--- 寻找所在函数
function m.getParentFunction(state, id)
    local ref = state.ref
    for _ = 1, 1000 do
        local func = ref['function'][id]
        if func then
            return func
        end
        id = ref['return'][id]
        if not id then
            break
        end
    end
    return nil
end

--- 寻找函数的不定参数，返回不定参数的`id`以及它是第`n`个参数。
--- 如果函数时主函数，则返回`0, 0`。
---@return integer
---@return integer
function m.getFunctionVarArgs(state, id)
    local astMap  = state.ast
    local funcAst = astMap[id]
    if funcAst.type == 'main' then
        return 0, 0
    end
    if funcAst.type ~= 'function' then
        return nil
    end
    local argsAst = astMap[funcAst.args]
    if not argsAst then
        return nil
    end
    for i = 1, #argsAst do
        local arg = argsAst[i]
        local argAst = astMap[arg]
        if argAst.type == '...' then
            return arg, i
        end
    end
    return nil
end

return m

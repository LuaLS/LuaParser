local m = {}

function m.getParentFunction(state, id)
    local ref = state.ref
    for _ = 1, 1000 do
        local func = ref['function'][id]
        if func then
            return func
        end
        id = ref['return'][id]
    end
    return nil
end

return m

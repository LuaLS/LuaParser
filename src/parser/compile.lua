local State, Errs, pushError

local dual = {

}

local function markState()
end

local function doFunction(func)
    
end

local function doVM()
    State.funcs = {}
    local main = #State.ast
    doFunction(main)
end

return function (self, lua, mode, version)
    State, Errs = self:parse(lua, mode, version)
    if not State then
        return Errs
    end
    pushError = State.pushError
    markState()
    doVM()
    return State, Errs
end

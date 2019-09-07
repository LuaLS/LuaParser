return function (self, lua, mode, version)
    local State, Errs = self:parse(lua, mode, version)
    if not State then
        return Errs
    end
    return State, Errs
end

local defs = {
    NIL = function (pos)
        return {
            type = 'nil',
            start = pos,
            finish = pos + 2,
        }
    end
}

return function (self, lua, mode)
    local gram, err = self.grammar(lua, mode, defs)
    if not gram then
        return nil, err
    end
    return gram
end

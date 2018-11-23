local defs = {
    NIL = function (pos)
        return {
            type   = 'nil',
            start  = pos,
            finish = pos + 2,
        }
    end,
    TRUE = function (pos)
        return {
            type   = 'boolean',
            start  = pos,
            finish = pos + 3,
            [1]    = true,
        }
    end,
    FALSE = function (pos)
        return {
            type   = 'boolean',
            start  = pos,
            finish = pos + 4,
            [1]    = false,
        }
    end,
    String = function (start, str, finish)
        return {
            type   = 'string',
            start  = start,
            finish = finish - 1,
            [1]    = str,
        }
    end,
}

return function (self, lua, mode)
    local gram, err = self.grammar(lua, mode, defs)
    if not gram then
        return nil, err
    end
    return gram
end

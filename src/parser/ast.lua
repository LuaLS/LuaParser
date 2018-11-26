local tonumber = tonumber
local string_char = string.char
local utf8_char = utf8.char

local NIL = {}

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
    Char10 = function (char)
        char = tonumber(char)
        if not char or char < 0 or char > 255 then
            -- TODO 记录错误
            return ''
        end
        return string_char(char)
    end,
    Char16 = function (char)
        return string_char(tonumber(char, 16))
    end,
    CharUtf8 = function (char)
        char = tonumber(char, 16)
        if not char or char < 0 or char > 0x10ffff then
            -- TODO 记录错误
            return ''
        end
        return utf8_char(char)
    end,
    Number = function (start, number, finish)
        return {
            type   = 'number',
            start  = start,
            finish = finish - 1,
            [1]    = tonumber(number),
        }
    end,
    Name = function (start, str, finish)
        return {
            type   = 'name',
            start  = start,
            finish = finish - 1,
            [1]    = str,
        }
    end,
    Simple = function (first, ...)
        if ... then
            return {
                type = 'simple',
                first, ...,
            }
        else
            return first
        end
    end,
    Call = function (...)
        if ... == '' then
            return {
                type = 'call',
            }
        else
            return {
                type = 'call',
                ...,
            }
        end
    end,
    Binary = function (...)
        local e1, op = ...
        if not op then
            return e1
        end
        local args = {...}
        local e1 = args[1]
        local e2
        for i = 2, #args, 2 do
            op, e2 = args[i], args[i+1]
            e1 = {
                type = op,
                [1]  = e1,
                [2]  = e2,
            }
        end
        return e1
    end,
    Unary = function (...)
        local e1, op = ...
        if not op then
            return e1
        end
        local args = {...}
        local e1 = args[#args]
        for i = #args - 1, 1, -1 do
            op = args[i]
            e1 = {
                type = op,
                [1]  = e1,
            }
        end
        return e1
    end,
    DOTS = function (start)
        return {
            type   = '...',
            start  = start,
            finish = start + 2,
        }
    end,
    COLON = function (start)
        return {
            type   = ':',
            start  = start,
            finish = start,
        }
    end,
    FuncName = function (...)
        if ... == '' then
            return NIL
        else
            return ...
        end
    end,
    FunctionDef = function (name, ...)
        if ... then
            return name, {...}
        else
            return name, NIL
        end
    end,
    FunctionBody = function (...)
        if ... == '' then
            return NIL
        else
            return {
                type   = 'function',
                ...
            }
        end
    end,
    Function = function (start, name, arg, action, finish)
        if name == NIL then
            name = nil
        end
        if arg == NIL then
            arg = nil
        end
        if action == NIL then
            action = {
                type   = 'function',
                name   = name,
                arg    = arg,
                start  = start,
                finish = finish - 1,
            }
        else
            action.name   = name
            action.arg    = arg
            action.start  = start
            action.finish = finish - 1
        end
        return action
    end
}

return function (self, lua, mode)
    local gram, err = self.grammar(lua, mode, defs)
    if not gram then
        return nil, err
    end
    return gram
end

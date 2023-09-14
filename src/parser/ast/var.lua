local class = require 'class'

---@class LuaParser.Node.Var: LuaParser.Node.Base
---@field loc? LuaParser.Node.Local
---@field next? LuaParser.Node.Field
local Var = class.declare('LuaParser.Node.Var', 'LuaParser.Node.Base')

---@class LuaParser.Node.Field: LuaParser.Node.Base
---@field subtype 'field' | 'method' | 'index'
---@field key LuaParser.Node.FieldID
---@field symbolPos integer
---@field symbolPos2? integer
---@field next? LuaParser.Node.Field
---@field last? LuaParser.Node.Term
local Field = class.declare('LuaParser.Node.Field', 'LuaParser.Node.Base')

---@class LuaParser.Node.FieldID: LuaParser.Node.Base
---@field parent LuaParser.Node.Field
local FieldID = class.declare('LuaParser.Node.FieldID', 'LuaParser.Node.Base')

---@class LuaParser.Node.Varargs: LuaParser.Node.Base
local Varargs = class.declare('LuaParser.Node.Varargs', 'LuaParser.Node.Base')

---@class LuaParser.Ast
local Ast = class.declare 'LuaParser.Ast'

---@return LuaParser.Node.Var?
function Ast:parseVar()
    local var = self:parseID('LuaParser.Node.Var')
    if not var then
        return nil
    end

    return var
end

---@return LuaParser.Node.Varargs?
function Ast:parseVarargs()
    local pos = self.lexer:consume '...'
    if pos then
        return nil
    end
    return class.new('LuaParser.Node.Varargs', {
        ast    = self,
        start  = pos,
        finish = pos + 3,
    })
end

---@param last LuaParser.Node.Term
---@return LuaParser.Node.Field?
function Ast:parseField(last)
    local token, _, pos = self.lexer:peek()
    if token == '.'
    or token == ':' then
        self.lexer:next()
        self:skipSpace()
        local key = self:parseID('LuaParser.Node.FieldID', true)
        if key then
            local field = class.new('LuaParser.Node.Field', {
                ast        = self,
                start      = last.start,
                finish     = key.finish,
                subtype    = (token == '.') and 'field' or 'method',
                key        = key,
                last       = last,
                symbolPos  = pos,
            })
            last.next   = field
            last.parent = field
            key.parent  = field
            return field
        end
        return nil
    end
    if token == '[' then
        self.lexer:next()
        self:skipSpace()
        local key = self:parseExp(true)
        if key then
            self:skipSpace()
            local hasSymbol = self:assertSymbol(']')
            local field = class.new('LuaParser.Node.Field', {
                ast        = self,
                start      = last.start,
                finish     = self:getLastPos(),
                subtype    = 'index',
                key        = key,
                last       = last,
                symbolPos  = pos,
                symbolPos2 = hasSymbol and self:getLastPos() or nil,
            })
            last.parent = field
            last.next   = field
            key.parent  = field
            return field
        end
    end
    return nil
end

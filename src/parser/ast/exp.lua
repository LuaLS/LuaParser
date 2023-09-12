local class = require 'class'

---@class LuaParser.Ast
local Ast = class.declare 'LuaParser.Ast'

---@alias LuaParser.Node.Exp
---| LuaParser.Node.Nil
---| LuaParser.Node.Boolean
---| LuaParser.Node.Number
---| LuaParser.Node.String

---@param required? true
---@return LuaParser.Node.Exp?
function Ast:parseExp(required)
    -- TODO
    local exp = self:parseNumber()

    if not exp and required then
        self:throw('MISS_EXP', self:getLastPos(), self:getLastPos())
    end

    return exp
end

---@param atLeastOne? true
---@return LuaParser.Node.Exp[]
function Ast:parseExpList(atLeastOne)
    ---@type LuaParser.Node.Exp[]
    local list = {}
    local first = self:parseExp(atLeastOne)
    list[#list+1] = first
    while true do
        self:skipSpace()
        local token, tp = self.lexer:peek()
        if not token then
            break
        end
        if tp == 'Symbol' then
            if token == ',' then
                self.lexer:next()
                self:skipSpace()
            else
                break
            end
        else
            if tp == 'Word' and self:isKeyWord(token) then
                break
            end
            self:throwMissSymbol(self:getLastPos(), ',')
        end
        local exp = self:parseExp(true)
        if exp then
            list[#list+1] = exp
        end
    end
    return list
end

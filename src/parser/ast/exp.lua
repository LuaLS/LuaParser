local class = require 'class'

---@class LuaParser.Node.Paren: LuaParser.Node.Base
---@field exp LuaParser.Node.Exp
---@field next? LuaParser.Node.Field
local Paren = class.declare('LuaParser.Node.Paren', 'LuaParser.Node.Base')

---@class LuaParser.Ast
local Ast = class.declare 'LuaParser.Ast'

---@alias LuaParser.Node.Exp
---| LuaParser.Node.Term

-- 解析表达式
---@param required? true
---@return LuaParser.Node.Exp?
function Ast:parseExp(required)
    -- TODO
    local exp = self:parseTerm()

    if not exp and required then
        self:throw('MISS_EXP', self:getLastPos(), self:getLastPos())
    end

    return exp
end

-- 解析表达式列表，以逗号分隔
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

---@alias LuaParser.Node.Term
---| LuaParser.Node.TermHead
---| LuaParser.Node.TermChain

---@alias LuaParser.Node.TermHead
---| LuaParser.Node.Nil
---| LuaParser.Node.Boolean
---| LuaParser.Node.Number
---| LuaParser.Node.String
---| LuaParser.Node.Var
---| LuaParser.Node.Paren
---| LuaParser.Node.Varargs

---@alias LuaParser.Node.TermChain
---| LuaParser.Node.Field
---| LuaParser.Node.Call

-- 解析表达式中的一项
---@return LuaParser.Node.Term?
function Ast:parseTerm()
    ---@type LuaParser.Node.TermHead?
    local head = self:parseNil()
            or   self:parseBoolean()
            or   self:parseNumber()
            or   self:parseString()
            or   self:parseVarargs()
            or   self:parseVar()
            or   self:parseParen()

    if not head then
        return nil
    end

    ---@type LuaParser.Node.Term
    local current = head

    while true do
        self:skipSpace()

        local chain = self:parseField(current)
                or    self:parseCall(current)

        if chain then
            current = chain
        else
            break
        end
    end

    return current
end

---@return LuaParser.Node.Paren?
function Ast:parseParen()
    local pos = self.lexer:consume '('
    if not pos then
        return nil
    end
    local exp = self:parseExp(true)
    if not exp then
        return nil
    end
    local paren = class.new('LuaParser.Node.Paren', {
        ast    = self,
        start  = pos,
        exp    = exp,
    })
    exp.parent = paren
    paren.finish = self:assertSymbol ')' or exp.finish

    return paren
end

local class = require 'class'

---@class LuaParser.Node.Call: LuaParser.Node.Base
---@field node LuaParser.Node.Term
---@field args LuaParser.Node.Exp[]
local Call = class.declare('LuaParser.Node.Call', 'LuaParser.Node.Base')

---@class LuaParser.Ast
local Ast = class.declare 'LuaParser.Ast'

---@param last LuaParser.Node.Term
---@return LuaParser.Node.Call?
function Ast:parseCall(last)
    local token, _, pos = self.lexer:peek()
    if token == '(' then
        self.lexer:next()
        local exps = self:parseExpList()
        self:assertSymbol ')'
        local call = class.new('LuaParser.Node.Call', {
            ast     = self,
            start   = pos,
            finish  = self:getLastPos(),
            node    = last,
            args    = exps,
        })
        last.parent = call
        for i = 1, #exps do
            exps[i].parent = call
        end
        return call
    end

    local literalArg = self:parseString()
                    or self:parseTable()
    if literalArg then
        local call = class.new('LuaParser.Node.Call', {
            ast     = self,
            start   = pos,
            finish  = self:getLastPos(),
            node    = last,
            args    = { literalArg },
        })
        last.parent = call
        literalArg.parent = call
        return call
    end

    return nil
end

local class = require 'class'

---@class LuaParser.Node.Call: LuaParser.Node.Base
---@field node LuaParser.Node.Term
---@field argPos integer
---@field args LuaParser.Node.Exp[]
local Call = class.declare('LuaParser.Node.Call', 'LuaParser.Node.Base')

---@class LuaParser.Ast
local Ast = class.declare 'LuaParser.Ast'

---@private
---@param last LuaParser.Node.Term
---@return LuaParser.Node.Call?
function Ast:parseCall(last)
    local pos = self.lexer:consume '('
    if pos then
        local exps = self:parseExpList(false, true)
        self:assertSymbol ')'
        local call = self:createNode('LuaParser.Node.Call', {
            start   = last.start,
            finish  = self:getLastPos(),
            node    = last,
            args    = exps,
            argPos  = pos,
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
        local call = self:createNode('LuaParser.Node.Call', {
            start   = last.start,
            finish  = self:getLastPos(),
            node    = last,
            args    = { literalArg },
            argPos  = literalArg.start,
        })
        last.parent = call
        literalArg.parent = call
        return call
    end

    return nil
end

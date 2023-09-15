local class = require 'class'

---@class LuaParser.Node.Table: LuaParser.Node.Base
---@field fields LuaParser.Node.Field[]
local Table = class.declare('LuaParser.Node.Table', 'LuaParser.Node.Base')

---@class LuaParser.Ast
local Ast = class.declare 'LuaParser.Ast'

---@return LuaParser.Node.Table?
function Ast:parseTable()
    local pos = self.lexer:consume '{'
    if not pos then
        return nil
    end

    self:assertSymbol '}'
    local table = class.new('LuaParser.Node.Table', {
        ast     = self,
        start   = pos,
        finish  = self:getLastPos(),
    })
    return table
end

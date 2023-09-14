local class = require 'class'

---@class LuaParser.Ast.Table: LuaParser.Node.Base
local Table = class.declare('LuaParser.Ast.Table', 'LuaParser.Node.Base')

---@class LuaParser.Ast
local Ast = class.declare 'LuaParser.Ast'

---@return LuaParser.Ast.Table?
function Ast:parseTable()
    local pos = self.lexer:consume '{'
    if pos then
        return nil
    end
end

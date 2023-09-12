local class = require 'class'

---@class LuaParser.Ast
local M = class.declare 'LuaParser.Ast'

---@alias LuaParser.Node.Exp
---| LuaParser.Node.Nil
---| LuaParser.Node.Boolean
---| LuaParser.Node.Number
---| LuaParser.Node.String

---@return LuaParser.Node.Exp?
function M:parseExp()
    -- TODO
    return self:parseNumber()
end

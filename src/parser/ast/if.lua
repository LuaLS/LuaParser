local class = require 'class'

---@class LuaParser.Node.If: LuaParser.Node.Base
local If = class.declare('LuaParser.Node.If', 'LuaParser.Node.Base')

---@class LuaParser.Ast
local Ast = class.declare 'LuaParser.Ast'

---@return LuaParser.Node.If?
function Ast:parseIf()
end

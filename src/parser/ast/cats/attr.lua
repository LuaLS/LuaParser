local class = require 'class'

---@class LuaParser.Node.CatsAttr: LuaParser.Node.Base
local CatsAttr = class.declare('LuaParser.Node.CatsAttr', 'LuaParser.Node.Base')

---@class LuaParser.Ast
local Ast = class.declare 'LuaParser.Ast'

---@return LuaParser.Node.CatsAttr[]?
function Ast:parseCatsAttrs()
    
end

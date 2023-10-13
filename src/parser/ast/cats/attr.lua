local class = require 'class'

---@class LuaParser.Node.CatAttr: LuaParser.Node.Base
local CatAttr = class.declare('LuaParser.Node.CatAttr', 'LuaParser.Node.Base')

---@class LuaParser.Ast
local Ast = class.declare 'LuaParser.Ast'

---@return LuaParser.Node.CatAttr[]?
function Ast:parseCatAttrs()
    
end

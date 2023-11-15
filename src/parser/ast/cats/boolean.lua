local class = require 'class'

---@class LuaParser.Node.CatBoolean: LuaParser.Node.Base
---@field value boolean
local CatBoolean = class.declare('LuaParser.Node.CatBoolean', 'LuaParser.Node.Base')

---@class LuaParser.Ast
local Ast = class.get 'LuaParser.Ast'

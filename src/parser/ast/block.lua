local class = require 'class'

---@class LuaParser.Node.Block: LuaParser.Node.Base
---@field childs LuaParser.Node.State[]
local Block = class.declare('LuaParser.Node.Block', 'LuaParser.Node.Base')

---@class LuaParser.Ast
local Ast = class.declare 'LuaParser.Ast'

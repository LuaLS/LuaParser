local class = require 'class'

---@class LuaParser.Node.Chunk: LuaParser.Node.Base
local Chunk = class.declare('LuaParser.Node.Chunk', 'LuaParser.Node.Base')

---@class LuaParser.Ast
local Ast = class.declare 'LuaParser.Ast'

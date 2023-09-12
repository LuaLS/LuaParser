local class = require 'class'

---@class LuaParser.Ast
local M = class.declare 'LuaParser.Ast'

---@class LuaParser.Node.Chunk: LuaParser.Node.Base
local Chunk = class.declare('LuaParser.Node.Chunk', 'LuaParser.Node.Base')

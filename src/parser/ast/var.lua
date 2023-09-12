local class = require 'class'

---@alias LuaParser.Node.ID LuaParser.Node.Var

---@class LuaParser.Node.Var: LuaParser.Node.Base
---@field loc? LuaParser.Node.Local
local Var = class.declare('LuaParser.Node.Var', 'LuaParser.Node.Base')

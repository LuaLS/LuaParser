local class = require 'class'

---@class LuaParser.Node.Var: LuaParser.Node.Base
---@field loc? LuaParser.Node.Local
local Var = class.declare('LuaParser.Node.Var', 'LuaParser.Node.Base')

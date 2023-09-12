local class = require 'class'

---@class LuaParser.Ast
local M = class.declare 'LuaParser.Ast'

---@alias LuaParser.Node.State
---| LuaParser.Node.LocalDef

function M:parseState()
    return self:parseLocal()
end

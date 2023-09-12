local class = require 'class'

---@class LuaParser.Ast
local Ast = class.declare 'LuaParser.Ast'

---@alias LuaParser.Node.State
---| LuaParser.Node.LocalDef

function Ast:parseState()
    return self:parseLocal()
end

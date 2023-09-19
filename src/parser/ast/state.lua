local class = require 'class'

---@class LuaParser.Node.Assign: LuaParser.Node.Base
---@field exps LuaParser.Node.Exp[]
---@field vars LuaParser.Node.Var[]
local Assign = class.declare('LuaParser.Node.Assign', 'LuaParser.Node.Base')

---@class LuaParser.Node.SingleExp
---@field exp LuaParser.Node.Exp

---@class LuaParser.Ast
local Ast = class.declare 'LuaParser.Ast'

---@alias LuaParser.Node.State
---| LuaParser.Node.LocalDef
---| LuaParser.Node.ExpAsState

---@return LuaParser.Node.State?
function Ast:parseState()
    return self:parseLocal()
        or self:parseExpAsState()
end

---@alias LuaParser.Node.ExpAsState
---| LuaParser.Node.Call
---| LuaParser.Node.Assign
---| LuaParser.Node.SingleExp

---@return LuaParser.Node.ExpAsState?
function Ast:parseExpAsState()
    local exp = self:parseExp()
    if not exp then
        return nil
    end

    if class.type(exp) == 'LuaParser.Node.Call' then
        ---@cast exp LuaParser.Node.Call
        return exp
    end
end

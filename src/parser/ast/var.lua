local class = require 'class'

---@class LuaParser.Node.Var: LuaParser.Node.Base
---@field loc? LuaParser.Node.Local
local Var = class.declare('LuaParser.Node.Var', 'LuaParser.Node.Base')

---@class LuaParser.Ast
local Ast = class.declare 'LuaParser.Ast'

---@return LuaParser.Node.Var?
function Ast:parseVar()
    local var = self:parseID('LuaParser.Node.Var')
    if not var then
        return nil
    end

    return var
end

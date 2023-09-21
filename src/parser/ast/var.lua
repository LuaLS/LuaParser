local class = require 'class'

---@class LuaParser.Node.Var: LuaParser.Node.Base
---@field subtype 'global' | 'local'
---@field id string
---@field loc? LuaParser.Node.Local
---@field next? LuaParser.Node.Field
---@field value? LuaParser.Node.Exp
local Var = class.declare('LuaParser.Node.Var', 'LuaParser.Node.Base')

---@class LuaParser.Node.Varargs: LuaParser.Node.Base
local Varargs = class.declare('LuaParser.Node.Varargs', 'LuaParser.Node.Base')

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

---@return LuaParser.Node.Varargs?
function Ast:parseVarargs()
    local pos = self.lexer:consume '...'
    if not pos then
        return nil
    end
    return self:createNode('LuaParser.Node.Varargs', {
        start  = pos,
        finish = pos + 3,
    })
end

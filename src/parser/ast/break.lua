local class = require 'class'

---@class LuaParser.Node.Break: LuaParser.Node.Base
local Break = class.declare('LuaParser.Node.Break', 'LuaParser.Node.Base')

---@class LuaParser.Node.Continue: LuaParser.Node.Base
local Continue = class.declare('LuaParser.Node.Continue', 'LuaParser.Node.Base')

---@class LuaParser.Ast
local Ast = class.declare 'LuaParser.Ast'

---@return LuaParser.Node.Break?
function Ast:parseBreak()
    local pos = self.lexer:consume 'break'
    if not pos then
        return
    end

    return class.new('LuaParser.Node.Break', {
        ast    = self,
        start  = pos,
        finish = self:getLastPos(),
    })
end

---@return LuaParser.Node.Continue?
function Ast:parseContinue()
    if not self.nssymbolMap['continue'] then
        return nil
    end
    local pos = self.lexer:consume 'continue'
    if not pos then
        return
    end

    return class.new('LuaParser.Node.Continue', {
        ast    = self,
        start  = pos,
        finish = self:getLastPos(),
    })
end

local class = require 'class'

---@class LuaParser.Node.Break: LuaParser.Node.Base
local Break = class.declare('LuaParser.Node.Break', 'LuaParser.Node.Base')

---@class LuaParser.Node.Continue: LuaParser.Node.Base
local Continue = class.declare('LuaParser.Node.Continue', 'LuaParser.Node.Base')

---@class LuaParser.Ast
local Ast = class.declare 'LuaParser.Ast'

---@private
---@return LuaParser.Node.Break?
function Ast:parseBreak()
    local pos = self.lexer:consume 'break'
    if not pos then
        return
    end

    return self:createNode('LuaParser.Node.Break', {
        start  = pos,
        finish = self:getLastPos(),
    })
end

---@private
---@return LuaParser.Node.Continue?
function Ast:parseContinue()
    if not self.nssymbolMap['continue'] then
        return nil
    end
    local pos = self.lexer:consume 'continue'
    if not pos then
        return
    end

    return self:createNode('LuaParser.Node.Continue', {
        start  = pos,
        finish = self:getLastPos(),
    })
end

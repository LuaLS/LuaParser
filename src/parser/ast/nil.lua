local class = require 'class'

---@alias LuaParser.Node.Type 'nil'

---@class LuaParser.Node.Nil
local Nil = class.declare('LuaParser.Node.Nil', 'LuaParser.Node.Base')

Nil.type = 'nil'

---@class LuaParser.Ast
local M = class.declare 'LuaParser.Ast'

---@return LuaParser.Node.Nil?
function M:parseNil()
    local token = self.lexer:peek()
    if token ~= 'nil' then
        return nil
    end
    local start, finish = self.lexer:getPos()
    self.lexer:next()
    return class.new('LuaParser.Node.Nil', {
        ast     = self,
        start   = start,
        finish  = finish,
    })
end

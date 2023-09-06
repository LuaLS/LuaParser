local class = require 'class'

---@alias LuaParser.Node.Type 'boolean'

---@class LuaParser.Ast
local M = class.declare 'LuaParser.Ast'

---@return LuaParser.Node.Boolean?
function M:parseBoolean()
    local token = self.lexer:peek()
    if token == 'true' then
        local start, finish = self.lexer:getPos()
        self.lexer:next()
        return class.new('LuaParser.Node.Boolean', {
            ast     = self,
            start   = start,
            finish  = finish,
            value   = true,
        })
    end
    if token == 'false' then
        local start, finish = self.lexer:getPos()
        self.lexer:next()
        return class.new('LuaParser.Node.Boolean', {
            ast     = self,
            start   = start,
            finish  = finish,
            value   = false,
        })
    end
end

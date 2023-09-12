local class = require 'class'

---@class LuaParser.Node.Nil: LuaParser.Node.Base
local Nil = class.declare('LuaParser.Node.Nil', 'LuaParser.Node.Base')

Nil.view = 'nil'

---@class LuaParser.Ast
local Ast = class.declare 'LuaParser.Ast'

-- 解析 nil
---@return LuaParser.Node.Nil?
function Ast:parseNil()
    local token = self.lexer:peek()
    if token ~= 'nil' then
        return nil
    end
    local start, finish = self.lexer:range()
    self.lexer:next()
    return class.new('LuaParser.Node.Nil', {
        ast     = self,
        start   = start,
        finish  = finish,
    })
end

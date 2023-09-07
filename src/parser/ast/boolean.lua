local class = require 'class'

---@alias LuaParser.Node.Type 'boolean'

---@class LuaParser.Node.Boolean: LuaParser.Node.Base
---@field value boolean
---@field view string
local Boolean = class.declare('LuaParser.Node.Boolean', 'LuaParser.Node.Base')

Boolean.type = 'boolean'

Boolean.__getter.view = function (self)
    return tostring(self.value), true
end

---@class LuaParser.Ast
local M = class.declare 'LuaParser.Ast'

-- 解析布尔值
---@return LuaParser.Node.Boolean?
function M:parseBoolean()
    local token = self.lexer:peek()
    if token == 'true' then
        local start, finish = self.lexer:range()
        self.lexer:next()
        return class.new('LuaParser.Node.Boolean', {
            ast     = self,
            start   = start,
            finish  = finish,
            value   = true,
        })
    end
    if token == 'false' then
        local start, finish = self.lexer:range()
        self.lexer:next()
        return class.new('LuaParser.Node.Boolean', {
            ast     = self,
            start   = start,
            finish  = finish,
            value   = false,
        })
    end
end

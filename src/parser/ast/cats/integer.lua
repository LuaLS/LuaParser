local class = require 'class'

---@class LuaParser.Node.CatInteger: LuaParser.Node.Literal
---@field value integer
local CatInteger = class.declare('LuaParser.Node.CatInteger', 'LuaParser.Node.Base')

---@class LuaParser.Ast
local Ast = class.get 'LuaParser.Ast'

---@private
---@return LuaParser.Node.CatInteger?
function Ast:parseCatInteger()
    local token, tp, pos = self.lexer:peek()
    if tp ~= 'Num' and token ~= '-' then
        return nil
    end

    local value
    if token == '-' then
        self:skipSpace()
        local num, numPos = self.lexer:consumeType 'Num'
    end
end
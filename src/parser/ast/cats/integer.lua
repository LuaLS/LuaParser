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

    self.lexer:next()
    local int = self:createNode('LuaParser.Node.CatInteger', {
        start = pos,
    })

    if token == '-' then
        self:skipSpace()
        token, pos = self.lexer:consumeType 'Num'
        if token then
            int.value = - tonumber(token) --[[@as integer]]
        else
            int.value = 0
        end
    else
        int.value = tonumber(token) --[[@as integer]]
    end

    int.finish = pos + #token
    return int
end

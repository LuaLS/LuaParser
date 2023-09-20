local class = require 'class'

---@class LuaParser.Node.Repeat: LuaParser.Node.Block
---@field condition? LuaParser.Node.Exp
---@field symbolPos? integer # until 的位置
local Repeat = class.declare('LuaParser.Node.Repeat', 'LuaParser.Node.Block')

---@class LuaParser.Ast
local Ast = class.declare 'LuaParser.Ast'

---@return LuaParser.Node.Repeat?
function Ast:parseRepeat()
    local pos = self.lexer:consume 'repeat'
    if not pos then
        return nil
    end

    local repeatNode = class.new('LuaParser.Node.Repeat', {
        ast       = self,
        start     = pos,
    })

    self:skipSpace()
    self:parseBlockChilds(repeatNode)

    self:skipSpace()
    local symbolPos = self:assertSymbol 'until'
    if symbolPos then
        repeatNode.symbolPos = symbolPos

        self:skipSpace()
        local condition = self:parseExp(true)
        if condition then
            repeatNode.condition = condition
            condition.parent = repeatNode
        end
    end

    repeatNode.finish = self:getLastPos()

    return repeatNode
end

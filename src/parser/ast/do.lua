local class = require 'class'

---@class LuaParser.Node.Do: LuaParser.Node.Block
local Do = class.declare('LuaParser.Node.Do', 'LuaParser.Node.Block')

---@class LuaParser.Ast
local Ast = class.declare 'LuaParser.Ast'

---@return LuaParser.Node.Do?
function Ast:parseDo()
    local pos = self.lexer:consume 'do'
    if not pos then
        return nil
    end

    local doNode = class.new('LuaParser.Node.Do', {
        ast    = self,
        start  = pos,
    })

    self:skipSpace()
    self:parseBlockChilds(doNode)

    self:skipSpace()
    self:assertSymbol 'end'

    doNode.finish = self:getLastPos()

    return doNode
end

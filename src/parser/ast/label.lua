local class = require 'class'

---@class LuaParser.Node.Label: LuaParser.Node.Base
---@field label LuaParser.Node.LabelName
---@field symbolPos? integer # 右边标签符号的位置
local Label = class.declare('LuaParser.Node.Label', 'LuaParser.Node.Base')

---@class LuaParser.Node.LabelName: LuaParser.Node.Base
---@field parent LuaParser.Node.Label | LuaParser.Node.Goto
---@field id string
local LabelName = class.declare('LuaParser.Node.LabelName', 'LuaParser.Node.Base')

---@class LuaParser.Node.Goto: LuaParser.Node.Base
---@field label LuaParser.Node.LabelName
local Goto = class.declare('LuaParser.Node.Goto', 'LuaParser.Node.Base')

---@class LuaParser.Ast
local Ast = class.declare 'LuaParser.Ast'

---@private
---@return LuaParser.Node.Label?
function Ast:parseLabel()
    local pos = self.lexer:consume '::'
    if not pos then
        return nil
    end

    self:skipSpace()
    local labelName = self:parseID('LuaParser.Node.LabelName', true)
    if not labelName then
        return nil
    end

    self:skipSpace()
    local symbolPos = self:assertSymbol '::'

    local label = self:createNode('LuaParser.Node.Label', {
        start      = pos,
        finish     = self:getLastPos(),
        symbolPos  = symbolPos,
    })

    label.label = labelName
    labelName.parent = label

    return label
end

---@private
---@return LuaParser.Node.Goto?
function Ast:parseGoto()
    if not self:isKeyWord 'goto' then
        return nil
    end
    local pos = self.lexer:consume 'goto'
    if not pos then
        return nil
    end

    self:skipSpace()
    local labelName = self:parseID('LuaParser.Node.LabelName', true)
    if not labelName then
        return nil
    end

    local gotoNode = self:createNode('LuaParser.Node.Goto', {
        start      = pos,
        finish     = self:getLastPos(),
    })

    gotoNode.label = labelName
    labelName.parent = gotoNode

    return gotoNode
end
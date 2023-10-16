local class = require 'class'

---@alias LuaParser.Node.CatType
---| LuaParser.Node.CatID
---| LuaParser.Node.CatParen
---| LuaParser.Node.CatArray

---@class LuaParser.Node.CatParen: LuaParser.Node.Base
---@field value? LuaParser.Node.CatType
---@field symbolPos? integer # 右括号的位置
local CatParen = class.declare('LuaParser.Node.CatParen', 'LuaParser.Node.Base')

---@class LuaParser.Node.CatArray: LuaParser.Node.Base
---@field node? LuaParser.Node.CatType
---@field symbolPos1 integer # 左括号的位置
---@field symbolPos2? integer # 右括号的位置
local CatArray = class.declare('LuaParser.Node.CatArray', 'LuaParser.Node.Base')

---@class LuaParser.Ast
local Ast = class.declare('LuaParser.Ast')

---@private
---@param required? boolean
---@return LuaParser.Node.CatType?
function Ast:parseCatType(required)
    local head = self:parseCatParen()
            or   self:parseCatID()

    if not head then
        if required then
            self:throw('MISS_CAT_NAME', self:getLastPos())
        end
        return nil
    end

    ---@type LuaParser.Node.CatType
    local current = head
    while true do
        self:skipSpace()

        local chain = self:parseCatArray(current)

        if chain then
            current = chain
        else
            break
        end
    end

    return current
end

---@private
---@return LuaParser.Node.CatParen?
function Ast:parseCatParen()
    local plPos = self.lexer:consume '('
    if not plPos then
        return nil
    end

    local value = self:parseCatType(true)
    local paren = self:createNode('LuaParser.Node.CatParen', {
        start = plPos,
        value = value,
    })

    if value then
        value.parent = paren
    end

    paren.symbolPos = self:assertSymbol ')'
    paren.finish    = self:getLastPos()

    return paren
end

---@private
---@param head LuaParser.Node.CatType
---@return LuaParser.Node.CatArray?
function Ast:parseCatArray(head)
    local pos1 = self.lexer:consume '['
    if not pos1 then
        return nil
    end
    local array = self:createNode('LuaParser.Node.CatArray', {
        start = head.start,
        node = head,
        symbolPos1 = pos1,
    })

    head.parent = array

    array.symbolPos2 = self:assertSymbol ']'
    array.finish = self:getLastPos()

    return array
end

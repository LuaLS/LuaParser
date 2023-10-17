local class = require'class'

---@class LuaParser.Node.CatUnion: LuaParser.Node.Base
---@field poses integer[] # 所有 | 的位置
---@field exps LuaParser.Node.CatType[] # 所有的子表达式
local Union = class.declare('LuaParser.Node.CatUnion', 'LuaParser.Node.Base')

---@class LuaParser.Ast
local Ast = class.declare 'LuaParser.Ast'

---@private
---@param required? boolean
---@return LuaParser.Node.CatType?
function Ast:parseCatUnion(required)
    local first = self:parseCatCross(required)
    if not first then
        return nil
    end

    local pos = self.lexer:consume '|'
    if not pos then
        return first
    end

    ---@type LuaParser.Node.CatUnion
    local union = self:createNode('LuaParser.Node.CatUnion', {
        start = first.start,
        poses = { pos },
        exps  = { first },
    })


    while true do
        self:skipSpace()
        local nextNode = self:parseCatCross(true)
        union.exps[#union.exps+1] = nextNode

        self:skipSpace()
        local nextPos = self.lexer:consume '|'
        if not nextPos then
            break
        end

        union.poses[#union.poses+1] = nextPos
    end

    union.finish = self:getLastPos()

    return union
end

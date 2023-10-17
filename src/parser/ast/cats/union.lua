local class = require'class'

---@class LuaParser.Node.CatUnion: LuaParser.Node.Base
---@field poses integer[] # 所有 | 的位置
---@field exps LuaParser.Node.CatType[] # 所有的子表达式
local Union = class.declare('LuaParser.Node.CatUnion', 'LuaParser.Node.Base')

---@class LuaParser.Ast
local Ast = class.declare 'LuaParser.Ast'

---@private
---@param exp LuaParser.Node.CatType
---@return LuaParser.Node.CatUnion?
function Ast:parseCatUnion(exp)
    local pos = self.lexer:consume '|'
    if not pos then
        return nil
    end

    ---@type LuaParser.Node.CatUnion
    local union

    if exp.type == 'CatUnion' then
        ---@cast exp LuaParser.Node.CatUnion
        union = exp
        union.poses[#union.poses+1] = pos
    else
        union = self:createNode('LuaParser.Node.CatUnion', {
            start = exp.start,
            poses = { pos },
            exps  = { exp },
        })
    end

    local nextNode = self:parseCatTerm(true)
    union.exps[#union.exps+1] = nextNode

    union.finish = self:getLastPos()

    return union
end

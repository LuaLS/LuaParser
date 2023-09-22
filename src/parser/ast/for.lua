local class = require 'class'

---@class LuaParser.Node.For: LuaParser.Node.Block
---@field subtype 'loop' | 'in' | 'incomplete'
---@field vars LuaParser.Node.Local[]
---@field exps LuaParser.Node.Exp[]
---@field symbolPos1? integer # in 或 = 的位置
---@field symbolPos2? integer # do 的位置
---@field symbolPos3? integer # end 的位置
local For = class.declare('LuaParser.Node.For', 'LuaParser.Node.Block')

For.subtype = 'incomplete'
For.vars = {}
For.exps = {}

---@class LuaParser.Ast
local Ast = class.declare 'LuaParser.Ast'

---@private
---@return LuaParser.Node.For?
function Ast:parseFor()
    local pos = self.lexer:consume 'for'
    if not pos then
        return nil
    end

    local forNode = self:createNode('LuaParser.Node.For', {
        start  = pos,
    })

    self:skipSpace()
    local vars = self:parseLocalList()
    forNode.vars = vars
    for i = 1, #vars do
        local var = vars[i]
        var.parent = forNode
        var.index  = i
    end

    self:skipSpace()
    local token, _, symbolPos = self.lexer:peek()

    forNode.symbolPos1 = symbolPos
    if token == '=' then
        forNode.subtype = 'loop'
    elseif token == 'in' then
        forNode.subtype = 'in'
    else
        return forNode
    end
    self.lexer:next()

    self:skipSpace()
    local exps = self:parseExpList(true, true)
    forNode.exps = exps
    for i = 1, #exps do
        local exp = exps[i]
        exp.parent = forNode
        exp.index  = i
    end

    self:skipSpace()
    local symbolPos2 = self:assertSymbol 'do'

    if symbolPos2 then
        forNode.symbolPos2 = symbolPos2

        self:skipSpace()
        self:blockStart(forNode)
        self:initLocals(vars)
        self:blockParseChilds(forNode)
        self:blockFinish(forNode)

        self:skipSpace()
        local symbolPos3 = self:assertSymbol 'end'
        forNode.symbolPos3 = symbolPos3
    end

    forNode.finish = self:getLastPos()

    return forNode
end

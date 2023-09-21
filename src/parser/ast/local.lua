local class = require 'class'

---@class LuaParser.Node.LocalDef: LuaParser.Node.Base
---@field vars LuaParser.Node.Local[]
---@field symbolPos? integer # 等号的位置
---@field values? LuaParser.Node.Exp[]
local LocalDef = class.declare('LuaParser.Node.LocalDef', 'LuaParser.Node.Base')

---@class LuaParser.Node.Local: LuaParser.Node.Base
---@field id string
---@field parent LuaParser.Node.LocalDef | LuaParser.Node.For | LuaParser.Node.Function
---@field index integer
---@field value? LuaParser.Node.Exp
---@field refs? LuaParser.Node.Var[]
local Local = class.declare('LuaParser.Node.Local', 'LuaParser.Node.Base')

---@class LuaParser.Ast
local Ast = class.declare 'LuaParser.Ast'

---@return (LuaParser.Node.LocalDef | LuaParser.Node.Function)?
function Ast:parseLocal()
    local pos = self.lexer:consume 'local'
    if not pos then
        return nil
    end
    self:skipSpace()

    if self.lexer:peek() == 'function' then
        return self:parseFunction(true)
    end

    local localdef = class.new('LuaParser.Node.LocalDef', {
        ast    = self,
        start  = pos,
        refs   = {},
    })

    local vars = self:parseIDList('LuaParser.Node.Local', true)
    localdef.vars = vars
    for i = 1, #vars do
        local var = vars[i]
        var.parent = localdef
        var.index  = i
    end

    self:skipSpace()
    local symbolPos = self:assertSymbol '='
    if symbolPos then
        localdef.symbolPos = symbolPos
        self:skipSpace()
        local values = self:parseExpList(true)
        localdef.values = values
        for i = 1, #values do
            local value = values[i]
            value.parent = localdef

            local var = vars[i]
            if var then
                var.value = value
            end
        end
    end

    localdef.finish = self:getLastPos()

    return localdef
end

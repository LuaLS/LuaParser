local class = require 'class'

---@class LuaParser.Ast
local M = class.declare 'LuaParser.Ast'

---@class LuaParser.Node.LocalDef: LuaParser.Node.Base
---@field vars LuaParser.Node.Local[]
---@field values? LuaParser.Node.Exp[]
local LocalDef = class.declare('LuaParser.Node.LocalDef', 'LuaParser.Node.Base')

LocalDef.type = 'localdef'

---@alias LuaParser.Node.ID LuaParser.Node.Local

---@class LuaParser.Node.Local: LuaParser.Node.Base
---@field parent LuaParser.Node.LocalDef
---@field index integer
---@field value? LuaParser.Node.Exp
local Local = class.declare('LuaParser.Node.Local', 'LuaParser.Node.Base')

Local.type = 'local'

---@return LuaParser.Node.LocalDef?
function M:parseLocal()
    local token, _, pos = self.lexer:peek()
    if token ~= 'local' then
        return nil
    end
    self.lexer:next()

    local localdef = class.new('LuaParser.Node.LocalDef', {
        ast    = self,
        start  = pos,
    })

    self:skipSpace()
    local vars = self:parseIDList('LuaParser.Node.Local', true)
    localdef.vars = vars
    for i = 1, #vars do
        local var = vars[i]
        var.parent = localdef
        var.index  = i
    end

    self:skipSpace()
    if self.lexer:consume '=' then
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

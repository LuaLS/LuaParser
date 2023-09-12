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

    self:skipSpace()
    local vars = self:parseIDList('LuaParser.Node.Local', true)
    local localdef = class.new('LuaParser.Node.LocalDef', {
        ast    = self,
        vars   = vars,
        start  = pos,
        finish = #vars > 0 and vars[#vars].finish or pos + 5,
    })

    for i = 1, #vars do
        local var = vars[i]
        var.parent = localdef
    end

    return localdef
end

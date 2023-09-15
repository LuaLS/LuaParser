local class = require 'class'

---@class LuaParser.Node.Table: LuaParser.Node.Base
---@field fields LuaParser.Node.Field[]
local Table = class.declare('LuaParser.Node.Table', 'LuaParser.Node.Base')

---@class LuaParser.Ast
local Ast = class.declare 'LuaParser.Ast'

---@return LuaParser.Node.Table?
function Ast:parseTable()
    local pos = self.lexer:consume '{'
    if not pos then
        return nil
    end

    self:skipSpace()
    self:parseTableFields()
    self:skipSpace()

    self:assertSymbol '}'
    local table = class.new('LuaParser.Node.Table', {
        ast     = self,
        start   = pos,
        finish  = self:getLastPos(),
    })
    return table
end

---@return LuaParser.Node.TableField[]
function Ast:parseTableFields()
    local fields = {}
    local wantSep = false
    while true do
        local token = self.lexer:peek()
        if not token or token == '}' then
            break
        end
        if token == ',' then
            if not wantSep then
                self:throwMissExp(self:getLastPos())
            end
            wantSep = false
        else
            if wantSep then
                self:throwMissSymbol(self:getLastPos(), ',')
            end
            wantSep = true
            local field = self:parseTableField()
            if field then
                fields[#fields+1] = field
            else
                self:throwMissExp(self:getLastPos())
            end
        end
        self:skipSpace()
    end
    return fields
end

---@return LuaParser.Node.TableField?
function Ast:parseTableField()
    local exp = self:parseExp()
    if exp then
        return class.new('LuaParser.Node.TableField', {
            ast     = self,
            subtype = 'exp',
            value   = exp,
        })
    end
end

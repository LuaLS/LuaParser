local class = require 'class'

---@alias LuaParser.Node.CatType
---| LuaParser.Node.CatID

---@class LuaParser.Ast
local Ast = class.declare('LuaParser.Ast')

---@param require? boolean
---@return LuaParser.Node.CatType?
function Ast:parseCatType(require)
    local name = self:parseCatID()
    if not name then
        if require then
            self:throw('MISS_CAT_NAME', self:getLastPos())
        end
        return nil
    end

    return name
end

local class = require 'class'

---@class LuaParser.Node.CatClass: LuaParser.Node.Base
---@field classID LuaParser.Node.CatID
local CatClass = class.declare('LuaParser.Node.CatClass', 'LuaParser.Node.Base')

---@class LuaParser.Ast
local Ast = class.declare('LuaParser.Ast')

---@return LuaParser.Node.CatClass?
function Ast:parseCatClass()
    local classID = self:parseCatID()
    if not classID then
        return nil
    end

    local catClass = self:createNode('LuaParser.Node.CatClass', {
        classID = classID,
        start = classID.start,
    })

    catClass.finish = self:getLastPos()

    return catClass
end

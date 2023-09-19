local class = require 'class'

---@class LuaParser.Node.Block: LuaParser.Node.Base
---@field childs LuaParser.Node.State[]
local Block = class.declare('LuaParser.Node.Block', 'LuaParser.Node.Base')

---@class LuaParser.Ast
local Ast = class.declare 'LuaParser.Ast'

---@return LuaParser.Node.Block
function Ast:parseBlock()
    local childs = {}

    local block = class.new('LuaParser.Node.Block', {
        ast    = self,
        start  = self:getLastPos(),
        finish = self:getLastPos(),
        childs = childs,
    })

    for i = 1, #childs do
        local child = childs[i]
        child.parent = block
    end

    return block
end

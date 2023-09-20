local class = require 'class'

---@class LuaParser.Node.Block: LuaParser.Node.Base
---@field childs LuaParser.Node.State[]
local Block = class.declare('LuaParser.Node.Block', 'LuaParser.Node.Base')
Block.isBlock = true

Block.__getter.childs = function ()
    return {}, true
end

---@class LuaParser.Ast
local Ast = class.declare 'LuaParser.Ast'

---@param block LuaParser.Node.Block
function Ast:parseBlockChilds(block)
    
end

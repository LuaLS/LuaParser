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

local FinishMap = {
    ['end']    = true,
    ['elseif'] = true,
    ['else']   = true,
    ['until']  = true,
    ['}']      = true,
    [')']      = true,
}

---@param block LuaParser.Node.Block
function Ast:parseBlockChilds(block)
    while true do
        local token = self.lexer:peek()
        if FinishMap[token] then
            break
        end
        local state = self:parseState()
        if not state then
            break
        end
        state.parent = block
        block.childs[#block.childs+1] = state
        self:skipSpace()
    end
end

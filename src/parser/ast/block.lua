local class = require 'class'

---@class LuaParser.Node.Block: LuaParser.Node.Base
---@field childs LuaParser.Node.State[]
---@field locals LuaParser.Node.Local[]
---@field localMap table<string, LuaParser.Node.Local>
local Block = class.declare('LuaParser.Node.Block', 'LuaParser.Node.Base')
Block.isBlock = true

Block.__getter.childs = function ()
    return {}, true
end

Block.__getter.locals = function ()
    return {}, true
end

Block.__getter.localMap = function ()
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

---@private
---@param block LuaParser.Node.Block
function Ast:blockStart(block)
    self.blocks[#self.blocks+1] = block
    self.curBlock = block
end

---@private
---@param block LuaParser.Node.Block
function Ast:blockFinish(block)
    assert(self.curBlock == block)
    self.blocks[#self.blocks] = nil
    self.curBlock = self.blocks[#self.blocks]
end

---@private
---@param block LuaParser.Node.Block
function Ast:blockParseChilds(block)
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

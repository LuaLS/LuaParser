local class = require 'class'

---@class LuaParser.Node.Block: LuaParser.Node.Base
---@field childs LuaParser.Node.State[]
---@field locals LuaParser.Node.Local[]
---@field isMain boolean
---@field private localMap table<string, LuaParser.Node.Local>
local Block = class.declare('LuaParser.Node.Block', 'LuaParser.Node.Base')

Block.isBlock = true
Block.isMain = false

Block.__getter.childs = function ()
    return {}, true
end

Block.__getter.locals = function ()
    return {}, true
end

Block.__getter.referBlock = function (self)
    return self, true
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
    local parentBlock = self.blocks[#self.blocks]
    self.blocks[#self.blocks+1] = block
    self.curBlock = block

    ---@diagnostic disable: invisible
    if parentBlock then
        local parentLocalMap = parentBlock.localMap
        block.localMap = setmetatable({}, {
            __index = function (t, k)
                local v = parentLocalMap[k] or false
                t[k] = v
                return v
            end
        })
    else
        block.localMap = {}
    end
    ---@diagnostic enable: invisible
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
    local lastState
    while true do
        while self.lexer:consume ';' do
            self:skipSpace()
        end
        local token, _, pos = self.lexer:peek()
        if not token then
            break
        end
        ---@cast pos -?
        if FinishMap[token] and not block.isMain then
            break
        end
        local state = self:parseState()
        if state then
            state.parent = block
            block.childs[#block.childs+1] = state
            if lastState and lastState.type == 'Return' then
                ---@cast lastState LuaParser.Node.Return
                self:throw('ACTION_AFTER_RETURN', lastState.start, lastState.start + #'return')
            end
            lastState = state
            self:skipSpace()
        else
            if block.isMain then
                self.lexer:next()
                self:throw('UNKNOWN_SYMBOL', pos, pos + #token)
            else
                break
            end
        end
    end
end

---@package
Ast.needSortBlock = true

-- 获取最近的block
---@public
---@param pos integer
---@return LuaParser.Node.Block?
function Ast:getRecentBlock(pos)
    if self.needSortBlock then
        self.needSortBlock = false
        table.sort(self.blocks, function (a, b)
            return a.start < b.start
        end)
    end

    local blocks = self.blockList
    -- 使用二分法找到最近的block
    local low = 1
    local high = #blocks
    while low <= high do
        local mid = (low + high) // 2
        if pos < blocks[mid].start then
            high = mid - 1
        elseif not blocks[mid+1] then
            return blocks[mid]
        elseif pos >= blocks[mid+1].start then
            low = mid + 1
        else
            return blocks[mid]
        end
    end

    return nil
end

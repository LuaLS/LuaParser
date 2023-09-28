local class = require 'class'

---@class LuaParser.Ast
local Ast = class.declare 'LuaParser.Ast'

---@alias LuaParser.Node.ID
---| LuaParser.Node.Local
---| LuaParser.Node.Var
---| LuaParser.Node.FieldID
---| LuaParser.Node.TableFieldID
---| LuaParser.Node.Param
---| LuaParser.Node.LabelName
---| LuaParser.Node.AttrName

---@private
---@generic T: LuaParser.Node.ID
---@param nodeType `T`
---@param required? true
---@param canBeKeyword? true
---@return T?
function Ast:parseID(nodeType, required, canBeKeyword)
    local token, tp, pos = self.lexer:peek()
    if tp ~= 'Word' then
        if required then
            self:throw('MISS_NAME', self:getLastPos())
        end
        return nil
    end
    ---@cast token -?
    ---@cast pos -?
    if self:isKeyWord(token) then
        if canBeKeyword then
            self:throw('KEYWORD', pos, pos + #token)
        else
            if required then
                self:throw('MISS_NAME', self:getLastPos())
            end
            return nil
        end
    end
    if not self.unicodeName and token:find '[\x80-\xff]' then
        self:throw('UNICODE_NAME', pos, pos + #token)
    end
    self.lexer:next()
    return self:createNode(nodeType or 'LuaParser.Node.Var', {
        id     = token,
        start  = pos,
        finish = pos + #token,
    })
end

---@private
---@generic T: LuaParser.Node.ID
---@param nodeType `T`
---@param atLeastOne? boolean
---@param greedy? boolean
---@return T[]
function Ast:parseIDList(nodeType, atLeastOne, greedy)
    ---@type LuaParser.Node.ID[]
    local list = {}
    local first = self:parseID(nodeType, atLeastOne)
    list[#list+1] = first
    while true do
        self:skipSpace()
        local token, tp = self.lexer:peek()
        if not token then
            break
        end
        if tp == 'Symbol' then
            if token == ',' then
                self.lexer:next()
                self:skipSpace()
            else
                break
            end
        else
            if not greedy then
                break
            end
            if tp == 'Word' and self:isKeyWord(token) then
                break
            end
            self:throwMissSymbol(self:getLastPos(), ',')
        end
        local id = self:parseID(nodeType, true)
        if id then
            list[#list+1] = id
        end
    end
    return list
end

-- goto 单独处理
Ast.keyWordMap = {
    ['and']      = true,
    ['break']    = true,
    ['do']       = true,
    ['else']     = true,
    ['elseif']   = true,
    ['end']      = true,
    ['false']    = true,
    ['for']      = true,
    ['function'] = true,
    ['if']       = true,
    ['in']       = true,
    ['local']    = true,
    ['nil']      = true,
    ['not']      = true,
    ['or']       = true,
    ['repeat']   = true,
    ['return']   = true,
    ['then']     = true,
    ['true']     = true,
    ['until']    = true,
    ['while']    = true,
}

---@private
---@param word string
---@return boolean
function Ast:isKeyWord(word)
    if self.keyWordMap[word] then
        return true
    end
    if word == 'goto' then
        if self.jit then
            -- LuaJIT 中只有 `goto Word` 才认为 goto 是关键字
            local _, nextType = self.lexer:peek(1)
            return nextType == 'Word'
        end
        -- Lua 5.2 开始 goto 是关键字
        return self.versionNum >= 52
    end
    return false
end

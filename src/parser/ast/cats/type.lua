local class = require 'class'

---@alias LuaParser.Node.CatType
---| LuaParser.Node.CatID
---| LuaParser.Node.CatParen
---| LuaParser.Node.CatArray
---| LuaParser.Node.CatCall
---| LuaParser.Node.CatUnion

---@class LuaParser.Node.CatParen: LuaParser.Node.ParenBase
---@field value? LuaParser.Node.CatType
---@field symbolPos? integer # 右括号的位置
local CatParen = class.declare('LuaParser.Node.CatParen', 'LuaParser.Node.ParenBase')

---@class LuaParser.Node.CatArray: LuaParser.Node.Base
---@field node LuaParser.Node.CatType
---@field symbolPos1 integer # 左括号的位置
---@field symbolPos2? integer # 右括号的位置
local CatArray = class.declare('LuaParser.Node.CatArray', 'LuaParser.Node.Base')

---@class LuaParser.Node.CatCall: LuaParser.Node.Base
---@field node LuaParser.Node.CatID
---@field args LuaParser.Node.CatType[]
---@field symbolPos1 integer # 左括号的位置
---@field symbolPos2? integer # 右括号的位置
local CatCall = class.declare('LuaParser.Node.CatCall', 'LuaParser.Node.Base')

---@class LuaParser.Ast
local Ast = class.declare('LuaParser.Ast')

---@private
---@param required? boolean
---@return LuaParser.Node.CatType?
function Ast:parseCatType(required)
    local curExp = self:parseCatTerm(required)
    if not curExp then
        return nil
    end
    self:skipSpace()

    while true do
        local union = self:parseCatUnion(curExp)
        if not union then
            break
        end
        self:skipSpace()
        curExp = union
    end
    return curExp
end

---@private
---@param required? boolean
---@return LuaParser.Node.CatType?
function Ast:parseCatTerm(required)
    local head = self:parseCatParen()
            or   self:parseCatID()

    if not head then
        if required then
            self:throw('MISS_CAT_NAME', self:getLastPos())
        end
        return nil
    end

    ---@type LuaParser.Node.CatType
    local current = head
    while true do
        self:skipSpace()

        local chain = self:parseCatArray(current)
                or    self:parseCatCall(current)

        if chain then
            current = chain
        else
            break
        end
    end

    return current
end

---@private
---@param atLeastOne? boolean
---@return LuaParser.Node.CatType[]
function Ast:parseCatTypeList(atLeastOne)
    ---@type LuaParser.Node.CatType[]
    local list = {}
    local first = self:parseCatType(atLeastOne)
    list[#list+1] = first
    local wantSep = first ~= nil
    while true do
        self:skipSpace()
        local token, tp, pos = self.lexer:peek()
        if not token then
            break
        end
        ---@cast pos -?
        if tp == 'Symbol' then
            if token == ',' then
                if not wantSep then
                    self:throw('UNEXPECT_SYMBOL', pos, pos + 1, {
                        symbol = ',',
                    })
                end
                self.lexer:next()
                self:skipSpace()
                wantSep = false
            else
                break
            end
        else
            break
        end
        local catType = self:parseCatType(true)
        if catType then
            list[#list+1] = catType
        end
        wantSep = true
    end
    return list
end

---@private
---@return LuaParser.Node.CatParen?
function Ast:parseCatParen()
    local plPos = self.lexer:consume '('
    if not plPos then
        return nil
    end

    self:skipSpace()
    local value = self:parseCatType(true)
    local paren = self:createNode('LuaParser.Node.CatParen', {
        start = plPos,
        value = value,
    })

    if value then
        value.parent = paren
    end

    self:skipSpace()
    paren.symbolPos = self:assertSymbol ')'
    paren.finish    = self:getLastPos()

    return paren
end

---@private
---@param head LuaParser.Node.CatType
---@return LuaParser.Node.CatArray?
function Ast:parseCatArray(head)
    local pos1 = self.lexer:consume '['
    if not pos1 then
        return nil
    end
    local array = self:createNode('LuaParser.Node.CatArray', {
        start = head.start,
        node = head,
        symbolPos1 = pos1,
    })

    head.parent = array

    self:skipSpace()
    array.symbolPos2 = self:assertSymbol ']'
    array.finish = self:getLastPos()

    return array
end

---@private
---@param head LuaParser.Node.CatType
---@return LuaParser.Node.CatCall?
function Ast:parseCatCall(head)
    local pos1 = self.lexer:consume '<'
    if not pos1 then
        return nil
    end

    local call = self:createNode('LuaParser.Node.CatCall', {
        start = head.start,
        node  = head,
        symbolPos1 = pos1,
    })
    head.parent = call

    self:skipSpace()
    local args = self:parseCatTypeList(true)
    call.args = args

    for i = 1, #args do
        local arg = args[i]
        arg.parent = call
    end

    self:skipSpace()
    call.symbolPos2 = self:assertSymbol '>'
    call.finish = self:getLastPos()

    if head.type ~= 'CatID' then
        self:throw('UNEXPECT_CAT_CALL', pos1, call.finish)
    end

    return call
end

local class = require 'class'

---@alias LuaParser.Node.Type 'Number' | 'Integer'

---@class LuaParser.Node.Number: LuaParser.Node.Base
---@field value number
---@field numBase 2 | 10 | 16
local Number = class.declare('LuaParser.Node.Number', 'LuaParser.Node.Base')

Number.type = 'number'

---@param self LuaParser.Node.Number
---@return number
---@return true
Number.__getter.value = function (self)
    local value = tonumber(self.code) or 0.0
    return value, true
end

---@param self LuaParser.Node.Number
---@return 2 | 10 | 16
---@return true
Number.__getter.numBase = function (self)
    local mark = self.code:sub(1, 2)
    if mark == '0b' or mark == '0B' then
        return 2, true
    elseif mark == '0x' or mark == '0X' then
        return 16, true
    else
        return 10, true
    end
end

---@class LuaParser.Node.Integer: LuaParser.Node.Base
---@field value integer
---@field numBase 2 | 10 | 16
local Integer = class.declare('LuaParser.Node.Integer', 'LuaParser.Node.Base')

Integer.type = 'integer'

---@param self LuaParser.Node.Integer
---@return integer
---@return true
Integer.__getter.value = function (self)
    local value = tonumber(self.code) or 0 --[[@as integer]]
    return value, true
end

---@param self LuaParser.Node.Integer
---@return 2 | 10 | 16
---@return true
Integer.__getter.numBase = function (self)
    local mark = self.code:sub(1, 2)
    if mark == '0b' or mark == '0B' then
        return 2, true
    elseif mark == '0x' or mark == '0X' then
        return 16, true
    else
        return 10, true
    end
end

---@class LuaParser.Ast
local M = class.declare 'LuaParser.Ast'

-- 解析数字（可以带负号）
---@return LuaParser.Node.Number | LuaParser.Node.Integer | nil
function M:parseNumber()
    local start = self.lexer:range()
    self.lexer:skipToken '-'

    local node = self:parseNumber16()
            or   self:parseNumber2()
            or   self:parseNumber10()
    if not node then
        return nil
    end

    ---@cast start -?

    node.start = start

    return node
end

-- 解析十六进制数字（不支持负号）
---@return LuaParser.Node.Number | LuaParser.Node.Integer | nil
function M:parseNumber16()
    local token, _, pos = self.lexer:peek()

    if token ~= '0' then
        return nil
    end
    ---@cast pos -?

    local nextToken, _, nextPos = self.lexer:peek(1)
    if nextToken ~= 'x' and nextToken ~= 'X' then
        return nil
    end
    ---@cast nextPos -?

    -- 0x 必须连在一起
    if pos + 1 ~= nextPos then
        return nil
    end

    local curOffset = nextPos + 2

    local intPart, intOffset = self.code:match('^([%da-fA-F]+)()', curOffset)
    if intOffset then
        curOffset = intOffset
    end

    local numPart, numOffset = self.code:match('^%.([%da-fA-F]*)()', curOffset)
    if numOffset then
        curOffset = numOffset
    end

    local expPart, expOffset = self.code:match('^[pP][+-]?(%d+)()')
    if expOffset then
        curOffset = expOffset
    end

    if not intPart then
        if not numPart then
            self:pushError('MUST_X16', nextPos + 1, nextPos + 1)
        end
        if numPart == '' then
            self:pushError('MUST_X16', numOffset - 1, numOffset - 1)
        end
    end

    if numPart or expPart then
        return class.new('LuaParser.Node.Number', {
            ast     = self,
            start   = pos,
            finish  = curOffset - 1,
        })
    end
end

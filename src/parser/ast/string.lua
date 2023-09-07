local class = require 'class'
local util  = require 'utility'

---@alias LuaParser.Node.Type 'String'

---@class LuaParser.Node.String: LuaParser.Node.Base
---@field value string
---@field view string
---@field quo string
---@field escs table|false
---@field missQuo? true
local String = class.declare('LuaParser.Node.String', 'LuaParser.Node.Base')

String.type = 'string'

---@param self LuaParser.Node.String
---@return string
---@return true
String.__getter.value = function (self)
    if self.quo == "'"
    or self.quo == '"' then
        local value
        if self.missQuo then
            value = self.ast.code:sub(self.start + 2, self.finish)
        else
            value = self.ast.code:sub(self.start + 2, self.finish - 1)
        end
        if not value:find '\\' then
            return value, true
        end
        local pieces = {}
        
        return value, true
    else
        local value
        if self.missQuo then
            value = self.ast.code:sub(self.start + #self.quo + 1, self.finish - 1)
        else
            value = self.ast.code:sub(self.start + #self.quo + 1, self.finish - #self.quo)
        end
        value = self.code
            : gsub('\r\n', '\n')
            : gsub('\r', '\n')
            : gsub('^\n', '')
        return value, true
    end
end

---@param self LuaParser.Node.String
---@return string
---@return true
String.__getter.view = function (self)
    return util.viewString(self.value, self.quo), true
end

---@class LuaParser.Ast
local M = class.declare 'LuaParser.Ast'

-- 解析字符串
---@return LuaParser.Node.String?
function M:parseString()
    local token = self.lexer:peek()
    if token == '"'
    or token == "'" then
        return self:parseShortString()
    end
    if token == '[' then
        return self:parseLongString()
    end
    return nil
end

-- 解析短字符串
---@return LuaParser.Node.String?
function M:parseShortString()
    local quo, _, pos = self.lexer:peek()
    if quo ~= '"' and quo ~= "'" and quo ~= '`' then
        return nil
    end
    ---@cast quo -?
    ---@cast pos -?

    if quo == '`' and not self.nssymbolMap['`'] then
        self:pushError('ERR_NONSTANDARD_SYMBOL', pos, pos + 1)
    end

    local curOffset = pos + 2
    local missQuo
    while true do
        local char, offset = self.code:match([[([\\\r\n'"`])()]], curOffset)
        if char == quo then
            curOffset = offset
            break
        end
        if not char then
            curOffset = #self.code + 1
            missQuo = true
            self:pushErrorMissSymbol(curOffset - 1, quo)
            break
        end
        if char == '\r'
        or char == '\n' then
            curOffset = offset
            missQuo = true
            self:pushErrorMissSymbol(curOffset - 1, quo)
            break
        end
        if char == '\\' then
            self.lexer:fastForward(offset - 1)
            local curToken, curType, curPos = self.lexer:peek()
            if curType == 'NL' then
                curOffset = curPos + #curToken + 1
                goto continue
            end
            if curToken == 'z' then
                repeat until not self.lexer:skipType 'NL'
                local _, _, afterPos = self.lexer:peek()
                curOffset = afterPos and (afterPos + 1) or (#self.code + 1)
                goto continue
            end
        end
        curOffset = offset
        ::continue::
    end

    local finishPos = curOffset - 1
    if quo == '`' then
        quo = '"'
    end

    return class.new('LuaParser.Node.String', {
        ast     = self,
        start   = pos,
        finish  = finishPos,
        quo     = quo,
        missQuo = missQuo,
    })
end

-- 解析长字符串
---@return LuaParser.Node.String?
function M:parseLongString()
    local _, _, pos = self.lexer:peek()
    local quo = self.code:match('^(%[=*%[)', pos + 1)
    if not quo then
        return nil
    end

    local missQuo
    local finishQuo = quo:gsub('%[', ']')
    local finishPos
    local finishOffset = self.code:find(finishQuo, pos + #quo + 1, true)
    if finishOffset then
        finishPos = finishOffset + #finishQuo - 1
    else
        finishPos = #self.code
        missQuo = true
        self:pushErrorMissSymbol(finishPos, finishQuo)
    end

    if quo == '[[' and self.version == 'Lua 5.1' then
        local nestOffset = self.code:find('[[', pos + #quo + 1, true)
        if nestOffset and nestOffset < finishOffset then
            self:pushError('NESTING_LONG_MARK', nestOffset - 1, nestOffset + 1)
        end
    end

    self.lexer:fastForward(finishPos)

    return class.new('LuaParser.Node.String', {
        ast     = self,
        start   = pos,
        finish  = finishPos,
        quo     = quo,
        missQuo = missQuo,
    })
end

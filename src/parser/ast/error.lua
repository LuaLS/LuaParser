local class = require 'class'

---@alias LuaParser.Node.Type 'error'

---@class LuaParser.Node.Error
local Error = class.declare('LuaParser.Node.Error', 'LuaParser.Node.Base')

Error.type = 'error'
Error.code = 'UNKNOWN'

---@class LuaParser.Ast
---@field extra? table
local M = class.declare 'LuaParser.Ast'

-- 添加错误信息
---@param errorCode string
---@param start integer
---@param finish integer
---@param extra table?
function M:throw(errorCode, start, finish, extra)
    self.errors[#self.errors+1] = class.new('LuaParser.Node.Error', {
        code   = errorCode,
        ast    = self,
        start  = start,
        finish = finish,
        extra  = extra,
    })
end

-- 添加错误“缺少符号”
---@param start integer
---@param symbol string
function M:throwMissSymbol(start, symbol)
    self:throw('MISS_SYMBOL', start, start, {
        symbol = symbol,
    })
end

-- 断言下个符号，如果成功则消耗，否则报错
---@param symbol string
function M:assertSymbol(symbol)
    if not self.lexer:consume(symbol) then
        self:throwMissSymbol(self:getLastPos(), symbol)
    end
end

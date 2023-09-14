local class = require 'class'

---@class LuaParser.Node.Error
local Error = class.declare('LuaParser.Node.Error', 'LuaParser.Node.Base')

Error.code = 'UNKNOWN'

---@class LuaParser.Ast
---@field extra? table
local Ast = class.declare 'LuaParser.Ast'

-- 添加错误信息
---@param errorCode string
---@param start integer
---@param finish integer
---@param extra table?
function Ast:throw(errorCode, start, finish, extra)
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
function Ast:throwMissSymbol(start, symbol)
    self:throw('MISS_SYMBOL', start, start, {
        symbol = symbol,
    })
end

-- 断言下个符号，如果成功则消耗，否则报错
---@param symbol string
---@return integer? pos
function Ast:assertSymbol(symbol)
    local pos = self.lexer:consume(symbol)
    if not pos then
        self:throwMissSymbol(self:getLastPos(), symbol)
    end
    return pos
end

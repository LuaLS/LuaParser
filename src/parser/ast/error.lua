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
function M:pushError(errorCode, start, finish, extra)
    self.errors[#self.errors+1] = class.new('LuaParser.Node.Error', {
        code   = errorCode,
        ast    = self,
        start  = start,
        finish = finish,
        extra  = extra,
    })
end

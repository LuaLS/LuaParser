local class = require 'class'

---@class LuaParser.Node.Base: Class.Base
---@field ast LuaParser.Ast
---@field start integer # 开始位置（偏移）
---@field finish integer # 结束位置（偏移）
---@field left integer # 开始位置（行号与列号合并）
---@field right integer # 结束位置（行号与列号合并）
---@field startRow integer # 开始行号
---@field startCol integer # 开始列号
---@field finishRow integer # 结束行号
---@field finishCol integer # 结束列号
---@field code string # 对应的代码
---@field parent LuaParser.Node.Base
local Base = class.declare 'LuaParser.Node.Base'

local rowcolMulti = 10000

---@param self LuaParser.Node.Base
---@return integer
---@return true
Base.__getter.left = function (self)
    local row, col = self.ast.lexer:rowcol(self.start)
    local start = row * rowcolMulti + col
    return start, true
end

---@param self LuaParser.Node.Base
---@return integer
---@return true
Base.__getter.right = function (self)
    local row, col = self.ast.lexer:rowcol(self.finish)
    local finish = row * rowcolMulti + col
    return finish, true
end

---@param self LuaParser.Node.Base
---@return integer
---@return true
Base.__getter.startRow = function (self)
    local startRow = self.left // rowcolMulti
    return startRow, true
end

---@param self LuaParser.Node.Base
---@return integer
---@return true
Base.__getter.startCol = function (self)
    local startCol = self.left % rowcolMulti
    return startCol, true
end

---@param self LuaParser.Node.Base
---@return integer
---@return true
Base.__getter.finishRow = function (self)
    local finishRow = self.right // rowcolMulti
    return finishRow, true
end

---@param self LuaParser.Node.Base
---@return integer
---@return true
Base.__getter.finishCol = function (self)
    local finishCol = self.right % rowcolMulti
    return finishCol, true
end

---@param self LuaParser.Node.Base
---@return string
---@return true
Base.__getter.code = function (self)
    local code = self.ast.code:sub(self.start + 1, self.finish)
    return code, true
end

---@param self LuaParser.Node.Base
---@return string
---@return true
Base.__getter.parent = function (self)
    error('未设置父节点：' .. class.type(self))
end

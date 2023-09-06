local class = require 'class'

---@class LuaParser.Node.Base: Class.Base
---@field ast LuaParser.Ast
---@field type LuaParser.Node.Type
---@field start integer # 开始位置（偏移）
---@field finish integer # 结束位置（偏移）
---@field left integer # 开始位置（行号与列号合并）
---@field right integer # 结束位置（行号与列号合并）
---@field startRow integer # 开始行号
---@field startCol integer # 开始列号
---@field finishRow integer # 结束行号
---@field finishCol integer # 结束列号
local Base = class.declare 'LuaParser.Node.Base'

Base.rowcolMulti = 10000

Base.__getter.type = function ()
    error('No type')
end

---@param self LuaParser.Node.Base
---@return integer
Base.__getter.left = function (self)
    local row, col = self.ast.lexer:rowcol(self.start)
    local start = row * self.rowcolMulti + col
    self.left = start
    return start
end

---@param self LuaParser.Node.Base
---@return integer
Base.__getter.right = function (self)
    local row, col = self.ast.lexer:rowcol(self.finish)
    local finish = row * self.rowcolMulti + col
    self.right = finish
    return finish
end

---@param self LuaParser.Node.Base
---@return integer
Base.__getter.startRow = function (self)
    local startRow = self.left // self.rowcolMulti
    self.startRow = startRow
    return startRow
end

---@param self LuaParser.Node.Base
---@return integer
Base.__getter.startCol = function (self)
    local startCol = self.left % self.rowcolMulti
    self.startCol = startCol
    return startCol
end

---@param self LuaParser.Node.Base
---@return integer
Base.__getter.finishRow = function (self)
    local finishRow = self.right // self.rowcolMulti
    self.finishRow = finishRow
    return finishRow
end

---@param self LuaParser.Node.Base
---@return integer
Base.__getter.finishCol = function (self)
    local finishCol = self.right % self.rowcolMulti
    self.finishCol = finishCol
    return finishCol
end

---@class LuaParser.Node.Boolean
---@field value boolean
local Boolean = class.declare('LuaParser.Node.Boolean', 'LuaParser.Node.Base')

Boolean.type = 'boolean'

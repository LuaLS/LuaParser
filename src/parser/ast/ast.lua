local class = require 'class'
local lexer = require 'parser.lexer'

require 'parser.ast.base'
require 'parser.ast.error'
require 'parser.ast.nil'
require 'parser.ast.boolean'
require 'parser.ast.number'
require 'parser.ast.string'
require 'parser.ast.comment'
require 'parser.ast.exp'
require 'parser.ast.state'
require 'parser.ast.id'
require 'parser.ast.local'
require 'parser.ast.var'

---@class LuaParser.Ast
---@overload fun(code: string, version: LuaParser.LuaVersion, options: LuaParser.CompileOptions): LuaParser.Ast
local M = class.declare 'LuaParser.Ast'

---@param code string # lua代码
---@param version? LuaParser.LuaVersion
---@param options? LuaParser.CompileOptions
function M:__init(code, version, options)
    -- 代码内容
    self.code        = code
    -- Lua版本
    ---@type LuaParser.LuaVersion
    self.version     = version or 'Lua 5.4'
    -- 非标准符号的映射表
    ---@type table<string, true>
    self.nssymbolMap = {}
    -- 词法分析结果
    self.lexer       = lexer.parseLua(code)
    self.index       = 1
    -- 错误信息
    ---@type LuaParser.Node.Error[]
    self.errors      = {}
    -- 注释
    ---@type LuaParser.Node.Comment[]
    self.comments    = {}

    local major, minor = self.version:match 'Lua (%d+)%.(%d+)'
    ---@type integer
    self.versionNum = major * 10 + minor

    if options then
        if options.nonestandardSymbols then
            for _, s in ipairs(options.nonestandardSymbols) do
                self.nssymbolMap[s] = true
            end
        end
        -- 是否为LuaJIT
        self.jit = options.jit
        -- 是否支持Unicode标识符
        self.unicodeName = options.unicodeName
    end
end

-- 跳过换行符
---@private
---@return boolean # 是否成功跳过换行符
function M:skipNL()
    local _, tp = self.lexer:peek()
    if tp == 'NL' then
        self.lexer:next()
        return true
    end
    return false
end

-- 跳过注释
---@private
---@param inState? boolean # 是否是语句
---@return boolean # 是否成功跳过注释
function M:skipComment(inState)
    local comment = self:parseComment(inState)
    if comment then
        self.comments[#self.comments+1] = comment
        return true
    end
    return false
end

-- 跳过空白符
---@private
---@param inState? boolean # 是否是语句
function M:skipSpace(inState)
    self.lastRightCI = self.lexer.ci - 1
    repeat until not self:skipNL()
            and  not self:skipComment(inState)
end

-- 获取上个词的右侧位置（不包括换行符和注释）
---@return integer
function M:getLastPos()
    if not self.lastRightCI then
        return 0
    end
    local token = self.lexer.tokens[self.lastRightCI]
    local pos   = self.lexer.poses[self.lastRightCI]
    return pos + #token
end

-- 编译Lua代码
function M:parseMain()
    self:skipSpace()
end

return M

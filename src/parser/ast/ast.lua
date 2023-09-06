local class = require 'class'
local lexer = require 'parser.lexer'

require 'parser.ast.nil'
require 'parser.ast.boolean'
require 'parser.ast.number'
require 'parser.ast.string'

---@class LuaParser.Ast
---@overload fun(code: string, version: LuaParser.LuaVersion, options: LuaParser.CompileOptions): LuaParser.Ast
local M = class.declare 'LuaParser.Ast'

-- Lua版本
---@type LuaParser.LuaVersion
M.version = '5.4'
-- 是否为LuaJIT
M.jit     = false
-- 是否支持Unicode标识符
M.unicodeName = false

---@param code string # lua代码
---@param version? LuaParser.LuaVersion
---@param options? LuaParser.CompileOptions
function M:__init(code, version, options)
    -- 代码内容
    self.code        = code
    self.version     = version or '5.4'
    -- 非标准符号的映射表
    self.nssymbolMap = {}
    -- 词法分析结果
    self.lexer       = lexer.parseLua(code)
    self.index       = 1

    if options then
        if options.nonestandardSymbols then
            for _, s in ipairs(options.nonestandardSymbols) do
                self.nssymbolMap[s] = true
            end
        end
        self.jit = options.jit
        self.unicodeName = options.unicodeName
    end
end

-- 跳过换行符
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
---@param inState? boolean # 是否是语句
---@return boolean # 是否成功跳过注释
function M:skipComment(inState)
    local token, tp = self.lexer:peek()
    if token == '--'
    or (token == '//' and (inState or self.nssymbolMap['//'])) then

    end
end

-- 跳过注释

-- 跳过空白符
---@param inState? boolean # 是否是语句
function M:skipSpace(inState)
    repeat until not self:skipNL()
            and  not self:skipComment(inState)
end

-- 编译Lua代码
function M:compile()
    self:skipSpace()
end

return M

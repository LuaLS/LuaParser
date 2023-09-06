local class = require 'class'
local lexer = require 'parser.lexer'

---@class LuaParser
local M = class.get 'LuaParser'

---@alias LuaParser.LuaVersion
---| '5.1'
---| '5.2'
---| '5.3'
---| '5.4'

---@alias LuaParser.NonestandardSymbol
---|'//' | '/**/'
---|'`'
---|'+=' | '-=' | '*=' | '/=' | '%=' | '^=' | '//='
---|'|=' | '&=' | '<<=' | '>>='
---|'||' | '&&' | '!' | '!='
---|'continue',

---@class LuaParser.CompileOptions
---@field jit? boolean # 是否为LuaJIT，默认为 false
---@field nonestandardSymbols? LuaParser.NonestandardSymbol[] # 支持的非标准符号
---@field unicodeName? boolean # 是否支持Unicode标识符，默认为 false

---@class LuaParser.Status
---@overload fun(code: string, version: LuaParser.LuaVersion, options: LuaParser.CompileOptions): LuaParser.Status
local S = class.declare 'LuaParser.Status'

-- Lua版本
---@type LuaParser.LuaVersion
S.version = '5.4'
-- 是否为LuaJIT
S.jit     = false
-- 是否支持Unicode标识符
S.unicodeName = false

---@param code string # lua代码
---@param version? LuaParser.LuaVersion
---@param options? LuaParser.CompileOptions
function S:__init(code, version, options)
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
function S:skipNL()
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
function S:skipComment(inState)
    local token, tp = self.lexer:peek()
    if token == '--'
    or (token == '//' and (inState or self.nssymbolMap['//'])) then

    end
end

-- 跳过注释

-- 跳过空白符
---@param inState? boolean # 是否是语句
function S:skipSpace(inState)
    repeat until not self:skipNL()
            and  not self:skipComment(inState)
end

---@return LuaParser.Node.Nil?
function S:parseNil()
    local token = self.lexer:peek()
    if token ~= 'nil' then
        return nil
    end
    local start, finish = self.lexer:getPos()
    self.lexer:next()
    return class.new('LuaParser.Node.Nil', {
        status  = self,
        start   = start,
        finish  = finish,
    })
end

-- 编译Lua代码
function S:compile()
    self:skipSpace()
end

-- 编译lua代码
---@param code string # lua代码
---@param version? LuaParser.LuaVersion # 默认为 '5.4'
---@param options? LuaParser.CompileOptions
---@return LuaParser.Status
function M.compile(code, version, options)
    local status = class.new 'LuaParser.Status' (code, version, options)
    status:compile()
    return status
end

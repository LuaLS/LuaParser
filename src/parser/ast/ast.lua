local class = require 'class'
local lexer = require 'parser.lexer'
local util  = require 'utility'

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
require 'parser.ast.call'
require 'parser.ast.table'
require 'parser.ast.block'
require 'parser.ast.function'
require 'parser.ast.field'
require 'parser.ast.unary'
require 'parser.ast.binary'
require 'parser.ast.label'
require 'parser.ast.do'
require 'parser.ast.if'
require 'parser.ast.break'
require 'parser.ast.return'
require 'parser.ast.for'
require 'parser.ast.while'
require 'parser.ast.repeat'
require 'parser.ast.main'

---@class LuaParser.Ast
---@field envMode 'fenv' | '_ENV'
---@field main LuaParser.Node.Main
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
    -- 代码块
    ---@private
    ---@type LuaParser.Node.Block[]
    self.blocks      = {}
    -- 当前代码块
    ---@private
    ---@type LuaParser.Node.Block?
    self.curBlock    = nil
    -- 按类型存放的节点
    ---@private
    ---@type table<string, LuaParser.Node.Base[]>
    self.nodesMap = util.multiTable(2)
    -- 存放所有的block
    ---@private
    ---@type LuaParser.Node.Block[]
    self.blockList = {}

    local major, minor = self.version:match 'Lua (%d+)%.(%d+)'
    ---@type integer
    self.versionNum = major * 10 + minor

    local envMode = 'auto'
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

        envMode = options.envMode
    end

    if envMode == '_ENV'
    or envMode == 'fenv' then
        ---@cast envMode '_ENV' | 'fenv'
        self.envMode = envMode
    else
        if self.versionNum >= 52 then
            self.envMode = '_ENV'
        else
            self.envMode = 'fenv'
        end
    end
end

-- 跳过换行符
---@private
---@return boolean # 是否成功跳过换行符
function M:skipNL()
    return self.lexer:consumeType 'NL' ~= nil
end

-- 跳过注释
---@private
---@param inExp? boolean # 在表达式中
---@return boolean # 是否成功跳过注释
function M:skipComment(inExp)
    local comment = self:parseComment(inExp)
    if comment then
        self.comments[#self.comments+1] = comment
        return true
    end
    return false
end

-- 跳过未知符号
---@private
---@return boolean
function M:skipUnknown()
    local token, pos = self.lexer:consumeType 'Unknown'
    if not token then
        return false
    end

    ---@cast pos -?
    self:throw('UNKNOWN_SYMBOL', pos, pos + #token)

    return true
end

-- 跳过空白符
---@private
---@param inExp? boolean # 在表达式中
function M:skipSpace(inExp)
    if self.lexer.ci ~= self.lastSpaceCI then
        self.lastRightCI = self.lexer.ci
    end
    repeat until not self:skipNL()
            and  not self:skipComment(inExp)
            and  not self:skipUnknown()
    self.lastSpaceCI = self.lexer.ci
end

-- 获取上个词的右侧位置（不包括换行符和注释）
---@private
---@return integer
function M:getLastPos()
    local ci = self.lexer.ci
    if ci == self.lastSpaceCI then
        ci = self.lastRightCI
    end
    local token = self.lexer.tokens[ci - 1]
    local pos   = self.lexer.poses[ci - 1]
    return pos + #token
end

-- 创建一个节点
---@private
---@generic T: string
---@param type `T`
---@param data table
---@return T
function M:createNode(type, data)
    data.ast = self
    local node = class.new(type, data)

    local nodeMap = self.nodesMap[node.type]
    nodeMap[#nodeMap+1] = node

    if node.isBlock then
        self.blockList[#self.blockList+1] = node
    end

    return node
end

-- 获取当前函数
---@private
---@return LuaParser.Node.Function | LuaParser.Node.Main | nil
function M:getCurrentFunction()
    local blocks = self.blocks
    for i = #blocks, 1, -1 do
        local block = blocks[i]
        if block.type == 'Function'
        or block.type == 'Main' then
            ---@cast block LuaParser.Node.Function | LuaParser.Node.Main
            return block
        end
    end
    return nil
end

return M

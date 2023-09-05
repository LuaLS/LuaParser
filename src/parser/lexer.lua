local l     = require 'lpeglabel'
local class = require 'class'

local Sp     = l.S' \t\v\f'
local Nl     = l.P'\r\n' + l.S'\r\n'
local Number = l.R'09'^1
local Word   = l.R('AZ', 'az', '__', '\x80\xff') * l.R('AZ', 'az', '09', '__', '\x80\xff')^0
local Symbol = l.P'=='
            +  l.P'~='
            +  l.P'--'
            -- non-standard:
            +  l.P'<<='
            +  l.P'>>='
            +  l.P'//='
            -- end non-standard
            +  l.P'<<'
            +  l.P'>>'
            +  l.P'<='
            +  l.P'>='
            +  l.P'//'
            +  l.P'...'
            +  l.P'..'
            +  l.P'::'
            -- non-standard:
            +  l.P'!='
            +  l.P'&&'
            +  l.P'||'
            +  l.P'/*'
            +  l.P'*/'
            +  l.P'+='
            +  l.P'-='
            +  l.P'*='
            +  l.P'%='
            +  l.P'&='
            +  l.P'|='
            +  l.P'^='
            +  l.P'/='
            -- end non-standard
            -- singles
            +  l.S'+-*/!#%^&()={}[]|\\\'":;<>,.?~`'
local Unknown = (1 - Number - Word - Symbol - Sp - Nl)^1
local Token   = l.Cp() * l.C(
      Nl      * l.Cc 'NL'
    + Number  * l.Cc 'Num'
    + Word    * l.Cc 'Word'
    + Symbol  * l.Cc 'Symbol'
    + Unknown * l.Cc 'Unknown'
)

local Parser  = l.Ct((Sp^1 + Token)^0)

---@alias LuaParser.Lexer.Type
---| 'NL'
---| 'Num'
---| 'Word'
---| 'Symbol'
---| 'Unknown'

---@class Lexer
---@overload fun(code: string, mode: 'Lua' | 'Cat'): Lexer
local M = class.declare 'Lexer'

---@param code string
---@param mode 'Lua' | 'Cat'
function M:__init(code, mode)
    local results = Parser:match(code)
    self.tokens = {} -- 分离出来的词
    self.poses  = {} -- 每个词的开始位置（偏移）
    self.types  = {} -- 每个词的类型
    self.nls    = {} -- 每个换行符的开始位置（偏移）
    self.ci     = 1  -- 当前词的索引
    for i, res in ipairs(results) do
        if i % 3 == 1 then
            self.poses[#self.poses+1] = res
        elseif i % 3 == 2 then
            self.tokens[#self.tokens+1] = res
        elseif i % 3 == 0 then
            self.types[#self.types+1] = res
            if res == 'NL' then
                self.nls[#self.nls+1] = results[i-2]
            end
        end
    end
end

-- 看看当前的词
---@param next? integer # 默认为0表示当前的词，1表示下一个词，以此类推
---@return string
---@return LuaParser.Lexer.Type
function M:peek(next)
    local i = self.ci + (next or 0)
    local token = self.tokens[i]
    local tp    = self.types[i]
    return token, tp
end

-- 消耗一个词，返回这个词
---@param count? integer # 默认为1表示消耗一个词，2表示消耗两个词，以此类推
function M:next(count)
    local i = self.ci + (count or 1)
    local token = self.tokens[i]
    local tp    = self.types[i]
    self.ci = i
    return token, tp
end

local API = {}

-- 对Lua代码进行分词
---@param code string
---@return Lexer
function API.parseLua(code)
    local lexer = class.new 'Lexer' (code, 'Lua')
    return lexer
end

return API

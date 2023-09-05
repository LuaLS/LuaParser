local class = require 'class'

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
---@field nonstandardSymbols? LuaParser.NonestandardSymbol[] # 支持的非标准符号
---@field unicodeName? boolean # 是否支持Unicode标识符，默认为 false

-- 编译lua代码
---@param lua string # lua代码
---@param version? LuaParser.LuaVersion # 默认为 '5.4'
---@param options? any
function M.compile(lua, version, options)
    
end

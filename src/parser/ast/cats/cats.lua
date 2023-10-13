local class = require 'class'

---@class LuaParser.Node.Cats: LuaParser.Node.Base
---@field tailComments? string
---@field catType string
---@field symbolPos1 integer # @的位置
---@field attrs? LuaParser.Node.CatsAttr[]
local CatsBase = class.declare('LuaParser.Node.Cats', 'LuaParser.Node.Base')

---@class LuaParser.Ast
local Ast = class.declare 'LuaParser.Ast'

---@return boolean
function Ast:skipCats()
    if self:parseCats()
    or self:parseCatsBlock() then
        return true
    else
        return false
    end
end

-- 会将解析结果存放到 `Ast.cats` 中
---@private
---@return LuaParser.Node.Cats?
function Ast:parseCats()
    local token, _, pos = self.lexer:peek()
    ---@cast pos -?
    if token ~= '--' then
        return nil
    end

    -- 检查 `---@` 开头
    local symbolPos1, catType = self.code:match('%-[ \t]*()@(%a+)')
    if not symbolPos1 then
        return nil
    end

    local cat = self:createNode('LuaParser.Node.Cats', {
        start = pos,
        catType = catType,
        symbolPos1 = symbolPos1,
    })

    local attrs = self
    if attrs then
        cat.attrs = attrs
        for _, attr in ipairs(attrs) do
            attr.parent = cat
        end
    end
end

-- 会将解析结果存放到 `Ast.cats` 中
function Ast:parseCatsBlock()
    
end

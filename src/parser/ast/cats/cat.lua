local class = require 'class'

require 'parser.ast.cats.id'
require 'parser.ast.cats.attr'
require 'parser.ast.cats.class'

---@class LuaParser.Node.Cat: LuaParser.Node.Base
---@field subtype string
---@field symbolPos integer # @的位置
---@field attrs? LuaParser.Node.CatAttr[]
---@field value? LuaParser.Node.CatValue
---@field tail? string
local Cat = class.declare('LuaParser.Node.Cat', 'LuaParser.Node.Base')

---@alias LuaParser.Node.CatValue
---| LuaParser.Node.CatClass

---@class LuaParser.Ast
local Ast = class.declare 'LuaParser.Ast'

---@private
Ast.catParserMap = {}

---@private
---@param catType string
---@param parser fun(self: LuaParser.Ast, cat: LuaParser.Node.Cat)
function Ast:registerCatParser(catType, parser)
    Ast.catParserMap[catType] = parser
end

Ast:registerCatParser('class', Ast.parseCatClass)

---@private
---@return boolean
function Ast:skipCat()
    if self:parseCat()
    or self:parseCatBlock() then
        return true
    else
        return false
    end
end

-- 会将解析结果存放到 `Ast.cats` 中
---@private
---@return LuaParser.Node.Cat?
function Ast:parseCat()
    local token, _, pos = self.lexer:peek()
    ---@cast pos -?
    if token ~= '--' then
        return nil
    end

    -- 检查 `---@` 开头
    local symbolPos, subtype = self.code:match('%-[ \t]*()@(%a+)', pos + 3)
    if not symbolPos then
        return nil
    end

    self.lexer:fastForward(symbolPos + #subtype)

    local cat = self:createNode('LuaParser.Node.Cat', {
        start = pos,
        subtype = subtype,
        symbolPos = symbolPos - 1,
    })

    local attrs = self:parseCatAttrs()
    if attrs then
        cat.attrs = attrs
        for _, attr in ipairs(attrs) do
            attr.parent = cat
        end
    end

    local parser = Ast.catParserMap[cat.subtype]
    if parser then
        local value = parser(self, cat)
        if value then
            cat.value = value
            value.parent = cat
        end
    end

    cat.finish = self:getLastPos()

    cat.tail = self:parseTail()

    return cat
end

-- 会将解析结果存放到 `Ast.cats` 中
function Ast:parseCatBlock()
    
end

---@return string?
function Ast:parseTail()
    local startOffset = self:getLastPos() + 1
    local tail = self.code:match('[^\r\n]+', startOffset)
    if not tail then
        return nil
    end

    self.lexer:fastForward(startOffset + #tail)

    tail = tail:gsub('^%s*[@#]?%s*', '')

    if tail == '' then
        return nil
    end

    return tail
end

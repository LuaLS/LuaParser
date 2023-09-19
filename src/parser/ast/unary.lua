local class = require 'class'

---@enum(key) LuaParser.UnarySymbol
local UnarySymbol = {
    ['not'] = 11,
    ['#']   = 11,
    ['~']   = 11,
    ['-']   = 11,
    -- unstandard
    ['!']   = 11,
}

local UnaryAlias = {
    ['!'] = 'not',
}

---@class LuaParser.Node.Unary: LuaParser.Node.Base
---@field op LuaParser.UnarySymbol
---@field exp? LuaParser.Node.Exp
local Unary = class.declare('LuaParser.Node.Unary', 'LuaParser.Node.Base')

---@class LuaParser.Ast
local Ast = class.declare 'LuaParser.Ast'

---@return LuaParser.Node.Unary?
---@return integer? opLevel
function Ast:parseUnary()
    local token, _, pos = self.lexer:peek()
    if not UnarySymbol[token] then
        return nil
    end
    ---@cast pos -?

    if token == '-' then
        local savePoint = self.lexer:savePoint()
        self.lexer:next()
        self:skipSpace()
        local nextToken, nextType = self.lexer:peek()
        if nextToken == '.'
        or nextType == 'Num' then
            -- 负数？
            savePoint()
            return nil
        end
    else
        self.lexer:next()
        self:skipSpace()
    end

    local op = token
    if UnaryAlias[op] then
        if not self.nssymbolMap[op] then
            self:throw('ERR_NONSTANDARD_SYMBOL', pos, pos + #op)
        end
        op = UnaryAlias[op]
    end

    if op == '~' then
        if self.versionNum < 53 then
            self:throw('UNSUPPORT_SYMBOL', pos, pos + #op)
        end
    end

    local myLevel = UnarySymbol[token]
    local exp = self:parseExp(true, false, myLevel)
    local unary = class.new('LuaParser.Node.Unary', {
        ast     = self,
        start   = pos,
        finish  = self:getLastPos(),
        op      = token,
        exp     = exp,
    })
    exp.parent = unary

    return unary
end

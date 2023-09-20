local class = require 'class'

---@class LuaParser.Node.Param: LuaParser.Node.Base
---@field parent LuaParser.Node.Function
---@field index integer
---@field id string
local Param = class.declare('LuaParser.Node.Param', 'LuaParser.Node.Base')

---@alias LuaParser.Node.FuncName
---| LuaParser.Node.Var
---| LuaParser.Node.Field

---@class LuaParser.Node.Function: LuaParser.Node.Block
---@field name? LuaParser.Node.FuncName
---@field params? LuaParser.Node.Local[]
---@field symbolPos1? integer # 左括号
---@field symbolPos2? integer # 右括号
---@field symbolPos3? integer # `end`
local Function = class.declare('LuaParser.Node.Function', 'LuaParser.Node.Block')

---@class LuaParser.Ast
local Ast = class.declare 'LuaParser.Ast'

---@return LuaParser.Node.Function?
function Ast:parseFunction()
    local pos = self.lexer:consume 'function'
    if not pos then
        return nil
    end

    self:skipSpace()
    local name = self:parseFunctionName()

    self:skipSpace()
    local symbolPos1 = self.lexer:consume '('
    if not name and not symbolPos1 then
        return nil
    end

    local params
    if symbolPos1 then
        self:skipSpace()
        params = self:parseParamList()
    else
        self:throwMissSymbol(self:getLastPos(), '(')
    end

    self:skipSpace()
    local symbolPos2 = self:assertSymbol ')'

    local func = class.new('LuaParser.Node.Function', {
        ast        = self,
        start      = pos,
        name       = name,
        params     = params,
        symbolPos1 = symbolPos1,
        symbolPos2 = symbolPos2,
    })

    if symbolPos2 then
        self:skipSpace()
        self:parseBlockChilds(func)
    end

    self:skipSpace()
    local symbolPos3 = self:assertSymbol 'end'

    func.symbolPos3 = symbolPos3
    func.finish     = self:getLastPos()

    if name then
        name.parent = func
    end

    if params then
        for i = 1, #params do
            local param = params[i]
            param.parent = func
            param.index  = i
        end
    end

    return func
end

---@return LuaParser.Node.FuncName?
function Ast:parseFunctionName()
    local head = self:parseVar()

    if not head then
        return nil
    end

    ---@type LuaParser.Node.FuncName
    local current = head

    while true do
        self:skipSpace()

        local chain = self:parseField(current)

        if chain then
            current = chain
        else
            break
        end
    end

    return current
end

---@return LuaParser.Node.Param[]
function Ast:parseParamList()
    ---@type LuaParser.Node.Param[]
    local list = {}

    local first = self:parseParam()
    list[#list+1] = first
    while true do
        self:skipSpace()
        local token, tp = self.lexer:peek()
        if not token then
            break
        end
        if tp == 'Symbol' then
            if token == ',' then
                self.lexer:next()
                self:skipSpace()
            else
                break
            end
        else
            self:throwMissSymbol(self:getLastPos(), ',')
        end
        local param = self:parseParam()
        if param then
            list[#list+1] = param
        end
    end

    return list
end

---@return LuaParser.Node.Param?
function Ast:parseParam()
    local param = self:parseID('LuaParser.Node.Param')
    if param then
        return param
    end
    local pos = self.lexer:consume '...'
    if pos then
        return class.new('LuaParser.Node.Param', {
            ast    = self,
            start  = pos,
            finish = pos,
            id     = '...',
        })
    end
    return nil
end

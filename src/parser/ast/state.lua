local class = require 'class'

---@class LuaParser.Node.Assign: LuaParser.Node.Base
---@field symbolPos? integer # 等号的位置
---@field exps LuaParser.Node.Exp[]
---@field values LuaParser.Node.Var[]
local Assign = class.declare('LuaParser.Node.Assign', 'LuaParser.Node.Base')

---@class LuaParser.Node.SingleExp
---@field exp LuaParser.Node.Exp
local SingleExp = class.declare('LuaParser.Node.SingleExp', 'LuaParser.Node.Base')

---@class LuaParser.Ast
local Ast = class.declare 'LuaParser.Ast'

---@alias LuaParser.Node.State
---| LuaParser.Node.LocalDef
---| LuaParser.Node.StateStartWithExp
---| LuaParser.Node.Label
---| LuaParser.Node.Goto
---| LuaParser.Node.If
---| LuaParser.Node.Do
---| LuaParser.Node.Break
---| LuaParser.Node.Continue
---| LuaParser.Node.Return
---| LuaParser.Node.For
---| LuaParser.Node.While
---| LuaParser.Node.Repeat
---| LuaParser.Node.Function

---@private
---@return LuaParser.Node.State?
function Ast:parseState()
    local token = self.lexer:peek()

    if token == 'local' then
        return self:parseLocal()
    end

    if token == 'if'
    or token == 'elseif'
    or token == 'else' then
        return self:parseIf()
    end

    if token == 'do' then
        return self:parseDo()
    end

    if token == 'break' then
        return self:parseBreak()
    end

    if token == 'return' then
        return self:parseReturn()
    end

    if token == 'for' then
        return self:parseFor()
    end

    if token == 'while' then
        return self:parseWhile()
    end

    if token == 'function' then
        return self:parseFunction()
    end

    if token == 'continue' then
        return self:parseContinue()
    end

    if token == '::' then
        return self:parseLabel()
    end

    if token == 'goto' then
        return self:parseGoto()
    end

    if token == 'repeat' then
        return self:parseRepeat()
    end

    return self:parseStateStartWithExp()
end

---@alias LuaParser.Node.StateStartWithExp
---| LuaParser.Node.Call
---| LuaParser.Node.Assign
---| LuaParser.Node.SingleExp

---@private
---@return LuaParser.Node.StateStartWithExp?
function Ast:parseStateStartWithExp()
    local exp = self:parseExp(false, true)
    if not exp then
        return nil
    end

    if exp.type == 'Call' then
        ---@cast exp LuaParser.Node.Call
        return exp
    end

    if exp.type == 'Var'
    or exp.type == 'Field' then
        ---@cast exp LuaParser.Node.Field
        self:skipSpace()
        local assign = self:parseAssign(exp)
        if assign then
            return assign
        end
    end

    local state = self:createNode('LuaParser.Node.SingleExp', {
        start  = exp.start,
        finish = exp.finish,
        exp    = exp,
    })
    exp.parent = state

    return state
end

---@private
---@param first LuaParser.Node.Field
---@return LuaParser.Node.Assign?
function Ast:parseAssign(first)
    local token = self.lexer:peek()
    if token ~= '=' and token ~= ',' then
        return nil
    end

    local assign = self:createNode('LuaParser.Node.Assign', {
        start  = first.start,
        exps   = {},
    })

    assign.exps[1] = first
    first.parent = assign
    while true do
        local comma = self.lexer:consume ','
        if not comma then
            break
        end
        self:skipSpace()
        local exp = self:parseExp(true, true)
        if not exp then
            break
        end
        assign.exps[#assign.exps+1] = exp
        self:skipSpace()
    end

    local eqPos = self:assertSymbol '='

    if eqPos then
        assign.symbolPos = eqPos
        self:skipSpace()
        local values = self:parseExpList(true)
        assign.values = values

        for i = 1, #values do
            local value = values[i]
            value.parent = assign

            local exp = assign.exps[i]
            if exp then
                exp.value = value
            end
        end
    end

    assign.finish = self:getLastPos()

    return assign
end
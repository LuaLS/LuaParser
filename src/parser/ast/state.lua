local class = require 'class'

---@class LuaParser.Node.Assign: LuaParser.Node.Base
---@field symbolPos? integer # 等号的位置
---@field exps LuaParser.Node.Exp[]
---@field values LuaParser.Node.Var[]
local Assign = class.declare('LuaParser.Node.Assign', 'LuaParser.Node.Base')

---@class LuaParser.Node.SingleExp: LuaParser.Node.Base
---@field exp LuaParser.Node.Exp
local SingleExp = class.declare('LuaParser.Node.SingleExp', 'LuaParser.Node.Base')

---@class LuaParser.Node.Select
---@field index integer
local Select = class.declare('LuaParser.Node.Select', 'LuaParser.Node.Base')

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
    local token, _, pos = self.lexer:peek()

    if token == 'local' then
        return self:parseLocal()
    end

    if token == 'if' then
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
        local func = self:parseFunction()
        if not func then
            self:throw('MISS_NAME', pos + #token)
            return nil
        end
        if not func.name then
            self:throw('MISS_NAME', func.symbolPos1)
        end
        return func
    end

    if token == 'continue' then
        return self:parseContinue()
    end

    if token == '::' then
        return self:parseLabel()
    end

    if token == 'goto' then
        local state = self:parseGoto()
        if state then
            return state
        end
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

    if exp.type == 'Field' and exp.subtype == 'method' then
        -- 已经throw过"缺少 `(`""
    else
        self:throw('EXP_IN_ACTION', state.start, state.finish)
    end

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

    local exps = {}
    local assign = self:createNode('LuaParser.Node.Assign', {
        start  = first.start,
        exps   = exps,
    })

    exps[1] = first
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
        exps[#exps+1] = exp
        self:skipSpace()
    end

    local eqPos = self:assertSymbol '='

    if eqPos then
        assign.symbolPos = eqPos
        self:skipSpace()
        local values = self:parseExpList(true)
        self:extendsAssignValues(values, #exps)
        assign.values = values

        for i = 1, #values do
            local value = values[i]
            value.parent = assign
            value.index  = i

            local exp = exps[i]
            if exp then
                exp.value = value
            end
        end
    end

    assign.finish = self:getLastPos()

    return assign
end

---@param values LuaParser.Node.Exp[]
---@param varCount integer
function Ast:extendsAssignValues(values, varCount)
    if #values >= varCount then
        return
    end
    local lastValue = values[#values]
    if not lastValue then
        return
    end
    if lastValue.type ~= 'Call' and lastValue.type ~= 'Varargs' then
        return
    end
    for i = #values + 1, varCount do
        local sel = self:createNode('LuaParser.Node.Select', {
            start  = lastValue.start,
            finish = lastValue.finish,
            value  = lastValue,
        })
        values[i] = sel
    end
end

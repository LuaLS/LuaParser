local class = require 'class'

---@class LuaParser.Node.Assign: LuaParser.Node.Base
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
---| LuaParser.Node.ExpAsState

---@return LuaParser.Node.State?
function Ast:parseState()
    return self:parseLocal()
        or self:parseStateStartWithExp()
end

---@alias LuaParser.Node.ExpAsState
---| LuaParser.Node.Call
---| LuaParser.Node.Assign
---| LuaParser.Node.SingleExp

---@return LuaParser.Node.ExpAsState?
function Ast:parseStateStartWithExp()
    local exp = self:parseExp(false, true)
    if not exp then
        return nil
    end

    if class.type(exp) == 'LuaParser.Node.Call' then
        ---@cast exp LuaParser.Node.Call
        return exp
    end

    if class.type(exp) == 'LuaParser.Node.Var'
    or class.type(exp) == 'LuaParser.Node.Field' then
        ---@cast exp LuaParser.Node.Field
        self:skipSpace()
        local assign = self:parseAssign(exp)
        if assign then
            return assign
        end
    end

    local state = class.new('LuaParser.Node.SingleExp', {
        start  = exp.start,
        finish = exp.finish,
        exp    = exp,
    })
    exp.parent = state

    return state
end

---@param first LuaParser.Node.Field
---@return LuaParser.Node.Assign?
function Ast:parseAssign(first)
    local token = self.lexer:peek()
    if token ~= '=' and token ~= ',' then
        return nil
    end

    local assign = class.new('LuaParser.Node.Assign', {
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

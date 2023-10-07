local class = require 'class'

---@class LuaParser.Node.Param: LuaParser.Node.Local
---@field parent LuaParser.Node.Function
---@field index integer
---@field id string
local Param = class.declare('LuaParser.Node.Param', 'LuaParser.Node.Local')

---@alias LuaParser.Node.FuncName
---| LuaParser.Node.Var
---| LuaParser.Node.Field
---| LuaParser.Node.Local

---@class LuaParser.Node.Function: LuaParser.Node.Block
---@field name? LuaParser.Node.FuncName
---@field params? LuaParser.Node.Local[]
---@field symbolPos1? integer # 左括号
---@field symbolPos2? integer # 右括号
---@field symbolPos3? integer # `end`
local Function = class.declare('LuaParser.Node.Function', 'LuaParser.Node.Block')

Function.isFunction = true

---@class LuaParser.Ast
local Ast = class.declare 'LuaParser.Ast'

---@private
---@param isLocal? boolean
---@return LuaParser.Node.Function?
function Ast:parseFunction(isLocal)
    local pos = self.lexer:consume 'function'
    if not pos then
        return nil
    end

    self:skipSpace()
    local name
    if isLocal then
        name = self:parseID('LuaParser.Node.Local', true)
        local nextToken, _, nextPos = self.lexer:peek()
        if nextToken == '.' or nextToken == ':' then
            ---@cast nextPos -?
            local endPos = self.code:match('[%s%w_%.%:]+()', pos + 1)
            self.lexer:fastForward(endPos - 1)
            self:throw('UNEXPECT_LFUNC_NAME', nextPos, endPos - 1)
        end
    else
        name = self:parseFunctionName()
    end

    self:skipSpace()
    local symbolPos1 = self.lexer:consume '('

    local params, symbolPos2
    if symbolPos1 then
        self:skipSpace()
        params = self:parseParamList()
        self:skipSpace()
        symbolPos2 = self:assertSymbol ')'
    else
        self:throwMissSymbol(self:getLastPos(), '(')
    end

    local func = self:createNode('LuaParser.Node.Function', {
        start      = pos,
        name       = name,
        params     = params,
        symbolPos1 = symbolPos1,
        symbolPos2 = symbolPos2,
    })

    if name then
        name.parent = func
        name.value  = func
    end

    if params then
        for i = 1, #params do
            local param = params[i]
            param.parent = func
            param.index  = i
        end
    end

    if symbolPos2 then
        self:skipSpace()
        self:blockStart(func)
        if isLocal and name then
            ---@cast name LuaParser.Node.Local
            self:initLocal(name)
        end
        if params then
            self:initLocals(params)
        end
        self:blockParseChilds(func)
        self:blockFinish(func)
    end

    self:skipSpace()
    local symbolPos3 = self:assertSymbolEnd(pos, pos + #'function')

    func.symbolPos3 = symbolPos3
    func.finish     = self:getLastPos()

    return func
end

---@private
---@return LuaParser.Node.FuncName?
function Ast:parseFunctionName()
    local head = self:parseVar()

    if not head then
        return nil
    end

    ---@type LuaParser.Node.Var|LuaParser.Node.Field
    local current = head

    while true do
        self:skipSpace()

        local chain = self:parseField(current)

        if  current.type == 'Field'
        and current.subtype == 'method' then
            if chain then
                self:throwMissSymbol(current.finish, '(')
            end
        end

        if chain then
            current = chain
        else
            break
        end
    end

    return current
end

---@private
---@return LuaParser.Node.Param[]
function Ast:parseParamList()
    ---@type LuaParser.Node.Param[]
    local list = {}

    local wantExp = true
    while true do
        self:skipSpace()

        local param = self:parseParam()
        if param then
            list[#list+1] = param
            if not wantExp then
                self:throwMissSymbol(self:getLastPos(), ',')
            end
            wantExp = false
            goto continue
        end

        local token, tp, pos = self.lexer:peek()
        if not token then
            break
        end
        ---@cast pos -?
        if tp == 'Symbol' then
            if token == ',' then
                if wantExp then
                    self:throw('MISS_NAME', self:getLastPos())
                end
                self.lexer:next()
                wantExp = true
            else
                break
            end
        else
            self:throw('UNKNOWN_SYMBOL', pos, pos + #token)
            self.lexer:next()
        end
        ::continue::
    end

    if wantExp and #list > 0 then
        self:throw('MISS_NAME', self:getLastPos())
    end

    for i = 1, #list do
        local param = list[i]
        if param.id == '...' then
            for j = i + 1, #list do
                param = list[j]
                self:throw('ARGS_AFTER_DOTS', param.start, param.finish)
            end
            break
        end
    end

    return list
end

---@private
---@return LuaParser.Node.Param?
function Ast:parseParam()
    local param = self:parseID('LuaParser.Node.Param', false, true)
    if param then
        return param
    end
    local pos = self.lexer:consume '...'
    if pos then
        return self:createNode('LuaParser.Node.Param', {
            start  = pos,
            finish = pos,
            id     = '...',
        })
    end
    return nil
end

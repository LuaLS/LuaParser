local class = require 'class'

---@class LuaParser.Node.CatFunction: LuaParser.Node.Base
---@field params LuaParser.Node.CatParam[]
---@field returns LuaParser.Node.CatType[]
---@field symbolPos1? integer # 左括号的位置
---@field symbolPos2? integer # 右括号的位置
---@field symbolPos3? integer # 冒号的位置
---@field async? boolean # 是否异步
local CatFunction = class.declare('LuaParser.Node.CatFunction', 'LuaParser.Node.Base')

CatFunction.__getter.params = function ()
    return {}
end

CatFunction.__getter.returns = function ()
    return {}
end

---@class LuaParser.Node.CatParam: LuaParser.Node.Base
---@field parent LuaParser.Node.CatFunction
---@field name LuaParser.Node.CatParamName
---@field symbolPos? integer # 冒号的位置
---@field value? LuaParser.Node.CatType
local CatParam = class.declare('LuaParser.Node.CatParam', 'LuaParser.Node.Base')

---@class LuaParser.Node.CatParamName: LuaParser.Node.Base
---@field parent LuaParser.Node.CatParam
---@field index integer
---@field id string
local CatParamName = class.declare('LuaParser.Node.CatParamName', 'LuaParser.Node.Base')

---@class LuaParser.Ast
local Ast = class.declare('LuaParser.Ast')

function Ast:parseCatFunction()
    local syncPos = self.lexer:consume 'async'
    if syncPos then
        self:skipSpace()
    end

    local funPos = self.lexer:consume 'fun'
    if not funPos then
        return nil
    end

    local funNode = self:createNode('LuaParser.Node.CatFunction', {
        start   = syncPos or funPos,
    })

    self:skipSpace()
    funNode.symbolPos1 = self.lexer:consume '('
    if funNode.symbolPos1 then

        self:skipSpace()
        self.params = self:parseCatFunParamList()
        for _, param in ipairs(self.params) do
            param.parent = funNode
        end

        self:skipSpace()
        funNode.symbolPos2 = self:assertSymbol ')'
    end

    self:skipSpace()
    self.symbolPos3 = self.lexer:consume ':'
    if self.symbolPos3 then

        self:skipSpace()
        self.returns = self:parseCatTypeList(true)
        for _, ret in ipairs(self.returns) do
            ret.parent = funNode
        end
    end

    funNode.finish = self:getLastPos()

    return funNode
end

---@return LuaParser.Node.CatParam?
function Ast:parseCatFunParam()
    local name = self:parseID('LuaParser.Node.CatParamName', false, true)
    if not name then
        return nil
    end

    local param = self:createNode('LuaParser.Node.CatParam', {
        start = name.start,
        name  = name,
    })
    name.parent = param

    self:skipSpace()
    param.symbolPos = self.lexer:consume ':'
    if param.symbolPos then

        self:skipSpace()
        param.value = self:parseCatType()
        if param.value then
            param.value.parent = param
        end
    end

    param.finish = self:getLastPos()

    return param
end

---@return LuaParser.Node.CatParam[]
function Ast:parseCatFunParamList()
    ---@type LuaParser.Node.CatParam[]
    local list = {}

    return list
end

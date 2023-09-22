local class = require 'class'

---@class LuaParser.Node.LocalDef: LuaParser.Node.Base
---@field vars LuaParser.Node.Local[]
---@field symbolPos? integer # 等号的位置
---@field values? LuaParser.Node.Exp[]
local LocalDef = class.declare('LuaParser.Node.LocalDef', 'LuaParser.Node.Base')

---@class LuaParser.Node.Local: LuaParser.Node.Base
---@field id string
---@field parent LuaParser.Node.LocalDef | LuaParser.Node.For | LuaParser.Node.Function
---@field index integer
---@field value? LuaParser.Node.Exp
---@field refs? LuaParser.Node.Var[]
---@field gets? LuaParser.Node.Var[]
---@field sets? LuaParser.Node.Var[]
---@field attr? LuaParser.Node.Attr
local Local = class.declare('LuaParser.Node.Local', 'LuaParser.Node.Base')

-- 所有的引用对象
Local.__getter.refs = function ()
    return {}, true
end

-- 所有的赋值对象
---@param self LuaParser.Node.Local
---@return LuaParser.Node.Var[]
---@return true
Local.__getter.sets = function (self)
    local sets = {}
    for _, ref in ipairs(self.refs) do
        local parent = ref.parent
        if parent.type == 'Assign' then
            sets[#sets+1] = ref
        end
    end
    return sets, true
end

-- 所有的获取对象
---@param self LuaParser.Node.Local
---@return LuaParser.Node.Var[]
---@return true
Local.__getter.gets = function (self)
    local gets = {}
    for _, ref in ipairs(self.refs) do
        local parent = ref.parent
        if parent.type ~= 'Assign' then
            gets[#gets+1] = ref
        end
    end
    return gets, true
end

---@class LuaParser.Node.Attr: LuaParser.Node.Base
---@field name LuaParser.Node.AttrName
---@field symbolPos? integer # > 的位置
local Attr = class.declare('LuaParser.Node.Attr', 'LuaParser.Node.Base')

---@class LuaParser.Node.AttrName: LuaParser.Node.Base
---@field parent LuaParser.Node.Attr
---@field id string
local AttrName = class.declare('LuaParser.Node.AttrName', 'LuaParser.Node.Base')

---@class LuaParser.Ast
local Ast = class.declare 'LuaParser.Ast'

---@private
---@return (LuaParser.Node.LocalDef | LuaParser.Node.Function)?
function Ast:parseLocal()
    local pos = self.lexer:consume 'local'
    if not pos then
        return nil
    end
    self:skipSpace()

    if self.lexer:peek() == 'function' then
        return self:parseFunction(true)
    end

    local localdef = self:createNode('LuaParser.Node.LocalDef', {
        start  = pos,
    })

    local vars = self:parseLocalList(true)
    localdef.vars = vars

    self:skipSpace()
    local symbolPos = self:assertSymbol '='
    if symbolPos then
        localdef.symbolPos = symbolPos
        self:skipSpace()
        local values = self:parseExpList(true)
        localdef.values = values
        for i = 1, #values do
            local value = values[i]
            value.parent = localdef

            local var = vars[i]
            if var then
                var.value = value
            end
        end
    end

    localdef.finish = self:getLastPos()

    for i = 1, #vars do
        local var = vars[i]
        var.parent = localdef
        var.index  = i
        self:initLocal(var)
    end

    return localdef
end

---@private
---@param loc LuaParser.Node.Local
function Ast:initLocal(loc)
    ---@class LuaParser.Node.Block
    local block = self.curBlock
    if not block then
        return
    end

    block.locals[#block.locals+1] = loc

    local name = loc.id
    block.localMap[name] = loc
end

---@private
---@param name string
---@return LuaParser.Node.Local?
function Ast:getLocal(name)
    ---@class LuaParser.Node.Block
    local block = self.curBlock
    if not block then
        return nil
    end
    return block.localMap[name] or nil
end

---@private
---@param parseAttr? boolean
---@return LuaParser.Node.Local[]
function Ast:parseLocalList(parseAttr)
    ---@type LuaParser.Node.ID[]
    local list = {}
    local first = self:parseID('LuaParser.Node.Local', true)
    list[#list+1] = first
    if parseAttr then
        self:skipSpace()
        local attr = self:parseLocalAttr()
        if attr then
            first.attr = attr
            first.finish = attr.finish
        end
    end
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
            break
        end
        local loc = self:parseID('LuaParser.Node.Local', true)
        if loc then
            list[#list+1] = loc
            if parseAttr then
                self:skipSpace()
                local attr = self:parseLocalAttr()
                if attr then
                    loc.attr = attr
                    loc.finish = attr.finish
                end
            end
        end
    end
    return list
end

---@private
---@return LuaParser.Node.Attr?
function Ast:parseLocalAttr()
    local pos = self.lexer:consume '<'
    if not pos then
        return nil
    end

    self:skipSpace()
    local attrName = self:parseID('LuaParser.Node.AttrName', true)
    if not attrName then
        return nil
    end

    local attrNode = self:createNode('LuaParser.Node.Attr', {
        start = pos,
        name  = attrName,
    })
    attrName.parent = attrNode

    if  attrName.id ~= 'const'
    and attrName.id ~= 'close' then
        self:throw('UNKNOWN_ATTRIBUTE', attrName.start, attrName.finish)
    end

    self:skipSpace()
    local symbolPos = self.lexer:consume '>'
    attrNode.symbolPos = symbolPos

    attrNode.finish = self:getLastPos()

    if not symbolPos and self.lexer:peek() == '>=' then
        local _, _, ltPos = self.lexer:peek()
        ---@cast ltPos integer
        self:throw('MISS_SPACE_BETWEEN', ltPos, ltPos + 2)
    end

    return attrNode
end

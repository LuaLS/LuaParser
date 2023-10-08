local class = require 'class'

---@class LuaParser.Node.Main: LuaParser.Node.Function
---@field parent LuaParser.Ast
local Main = class.declare('LuaParser.Node.Main', 'LuaParser.Node.Function')

Main.isMain = true

function Main.__getter.parent()
    return false, true
end

function Main.__getter.parentBlock()
    return false, true
end

---@class LuaParser.Ast
local Ast = class.declare 'LuaParser.Ast'

---@private
function Ast:skipShebang()
    if self.code:sub(1, 1) == '#' then
        local pos = self.code:find('\n', 2, true)
        if pos then
            self.lexer:fastForward(pos)
        else
            self.lexer:fastForward(#self.code)
        end
    end
end

function Ast:parseMain()
    self:skipShebang()

    local main = self:createNode('LuaParser.Node.Main', {
        start  = 0,
        finish = #self.code,
    })

    self:blockStart(main)

    local vararg = self:createNode('LuaParser.Node.Param', {
        start  = 0,
        finish = 0,
        dummy  = true,
        id     = '...',
        parent = main,
    })
    self:initLocal(vararg)
    if self.envMode == '_ENV' then
        local env = self:createNode('LuaParser.Node.Local', {
            start  = 0,
            finish = 0,
            dummy  = true,
            id     = '_ENV',
            parent = main,
        })
        self:initLocal(env)
        -- 虽然 _ENV 是上值，但是不计入200个的数量限制
        self.localCount = 0
    end

    self:skipSpace()
    self:blockParseChilds(main)
    self:blockFinish(main)

    return main
end

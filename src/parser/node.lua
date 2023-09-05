local class = require 'class'

---@class LuaParser.Ast.Node: Class.Base
local Node = class.declare 'LuaParser.Ast.Node'

Node.rowcolMulti = 10000

Node.__getter.type = function ()
    error('No type')
end

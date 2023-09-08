local class = require 'class'

---@alias LuaParser.LuaParser.Node.Type 'comment'

---@class LuaParser.Node.Comment: LuaParser.Node.Base
---@field subtype 'short' | 'long'
---@field nonStandard? true
local Comment = class.declare('LuaParser.Node.Comment', 'LuaParser.Node.Base')

Comment.type = 'comment'

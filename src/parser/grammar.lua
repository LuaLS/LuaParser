local re = require 'parser.relabel'
local m = require 'lpeglabel'
local calcline = require 'parser.calcline'

local scriptBuf = ''
local compiled = {}
local parser

local defs = setmetatable({}, {__index = function (self, key)
    self[key] = function (...)
        if parser[key] then
            return parser[key](...)
        end
    end
    return self[key]
end})

defs.nl = (m.P'\r\n' + m.S'\r\n') / function ()
    if parser.nl then
        return parser.nl()
    end
end
local eof = re.compile '!. / %{SYNTAX_ERROR}'

local function grammar(tag)
    return function (script)
        scriptBuf = script .. '\r\n' .. scriptBuf
        compiled[tag] = re.compile(scriptBuf, defs) * eof
    end
end

local labels = {

}

local function errorpos(lua, file, pos, err)
    local row, col = calcline.rowcol(lua, pos)
    local str = calcline.line(lua, row)
    return {
        lua = lua,
        file = file,
        line = row,
        pos = col,
        err = err,
        code = str,
        level = 'error',
    }
end

grammar 'Comment' [[
    Comment         <-  '--' (CommentMulti / CommentSingle)
    CommentMulti    <-  '[' {:eq: '='* :} '[' CommentClose
    CommentClose    <-  ']' =eq ']' / . CommentClose
    CommentSingle   <-  (!%nl .)*
]]

return function (lua, mode, parser_)
    parser = parser_ or {}
    mode = mode or 'lua'
    local r, e, pos = compiled[mode]:match(lua)
    if not r then
        local err = errorpos(lua, file, pos, labels[e])
        return nil, err
    end

    return r
end

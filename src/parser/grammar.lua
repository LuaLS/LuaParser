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
defs.s  = m.S' \t'
defs.S  = - defs.s
defs.ea = '\a'
defs.eb = '\b'
defs.ef = '\f'
defs.en = '\n'
defs.er = '\r'
defs.et = '\t'
defs.ev = '\v'
local eof = re.compile '!. / %{SYNTAX_ERROR}'

local function grammar(tag)
    return function (script)
        scriptBuf = script .. '\r\n' .. scriptBuf
        compiled[tag] = re.compile(scriptBuf, defs) * eof
    end
end

local labels = {

}

local function errorpos(lua, pos, err)
    local row, col = calcline.rowcol(lua, pos)
    local str = calcline.line(lua, row)
    return {
        lua = lua,
        line = row,
        pos = col,
        err = err,
        code = str,
        level = 'error',
    }
end

grammar 'Comment' [[
Comment         <-  '--' (LongComment / ShortComment)
LongComment     <-  '[' {:eq: '='* :} '[' CommentClose
CommentClose    <-  ']' =eq ']' / . CommentClose
ShortComment    <-  (!%nl .)*
]]

grammar 'Sp' [[
Sp  <-  (Comment / %nl / %s)*
]]

grammar 'Common' [[
Cut         <-  ![a-zA-Z0-9_]
X16         <-  [a-fA-F0-9]
AND         <-  Sp 'and'        Cut
BREAK       <-  Sp 'break'      Cut
DO          <-  Sp 'do'         Cut
ELSE        <-  Sp 'else'       Cut
ELSEIF      <-  Sp 'elseif'     Cut
END         <-  Sp 'end'        Cut
FALSE       <-  Sp 'false'      Cut
FOR         <-  Sp 'for'        Cut
FUNCTION    <-  Sp 'function'   Cut
GOTO        <-  Sp 'goto'       Cut
IF          <-  Sp 'if'         Cut
IN          <-  Sp 'in'         Cut
LOCAL       <-  Sp 'local'      Cut
NIL         <-  Sp 'nil'        Cut
NOT         <-  Sp 'not'        Cut
OR          <-  Sp 'or'         Cut
REPEAT      <-  Sp 'repeat'     Cut
RETURN      <-  Sp 'return'     Cut
THEN        <-  Sp 'then'       Cut
TRUE        <-  Sp 'true'       Cut
UNTIL       <-  Sp 'until'      Cut
WHILE       <-  Sp 'while'      Cut
]]

grammar 'Esc' [[
Esc         <-  '\' EChar
EChar       <-  'a' -> ea
            /   'b' -> eb
            /   'f' -> ef
            /   'n' -> en
            /   'r' -> er
            /   't' -> et
            /   'v' -> ev
            /   '\'
            /   '"'
            /   "'"
            /   %nl
            /   'z' (%nl / %s)* -> ''
            /   'x' X16 X16
            /   [0-9] [0-9]? [0-9]?
            /   'u{' X16^+1^-6 '}'
]]

grammar 'Nil' [[
Nil         <-  NIL
]]

grammar 'Boolean' [[
Boolean     <-  TRUE
            /   FALSE
]]

grammar 'String' [[
String      <-  '"' (Esc / !%nl !'"' .)* '"'
            /   "'" (Esc / !%nl !"'" .)* "'"
            /   '[' {:eq: '='* :} '[' StringClose
StringClose <-  ']' =eq ']' / . StringClose
]]

grammar 'Number' [[
Number      <-  Number16 / Number10

Number10    <-  Integer10 Float10
Integer10   <-  '0' / [1-9] [0-9]*
Float10     <-  ('.' [0-9]*)? ([eE] [+-]? [1-9]? [0-9]*)?

Number16    <-  Integer16 Float16
Integer16   <-  '0' [xX] X16*
Float16     <-  ('.' X16*)? ([pP] [+-]? [1-9]? [0-9]*)?
]]

return function (lua, mode, parser_)
    parser = parser_ or {}
    mode = mode or 'lua'
    local r, e, pos = compiled[mode]:match(lua)
    if not r then
        local err = errorpos(lua, pos, e)
        return nil, err
    end

    return r
end

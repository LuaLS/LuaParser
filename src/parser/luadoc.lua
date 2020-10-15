local m          = require 'lpeglabel'
local re         = require 'parser.relabel'

local TokenTypes, TokenStarts, TokenFinishs, TokenContents
local Ci, Offset, pushError
local Parser = re.compile([[
Main                <-  (Token / Sp)*
Sp                  <-  %s+
X16                 <-  [a-fA-F0-9]
Word                <-  [a-zA-Z0-9_]
Token               <-  Name / String / Symbol
Name                <-  ({} {[a-zA-Z_] [a-zA-Z0-9_]*} {})
                    ->  Name
String              <-  ({} StringDef {})
                    ->  String
StringDef           <-  '"'
                        {~(Esc / !'"' .)*~} -> 1
                        ('"'?)
                    /   "'"
                        {~(Esc / !"'" .)*~} -> 1
                        ("'"?)
                    /   ('[' {:eq: '='* :} '['
                        {(!StringClose .)*} -> 1
                        (StringClose?))
StringClose         <-  ']' =eq ']'
Esc                 <-  '\' -> ''
                        EChar
EChar               <-  'a' -> ea
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
                    /   ('z' (%nl / %s)*)     -> ''
                    /   ('x' {X16 X16})       -> Char16
                    /   ([0-9] [0-9]? [0-9]?) -> Char10
                    /   ('u{' {Word*} '}')    -> CharUtf8
Symbol              <-  ({} {'.' / '|' / ':'} {})
                    ->  Symbol
]], {
    s  = m.S' \t',
    ea = '\a',
    eb = '\b',
    ef = '\f',
    en = '\n',
    er = '\r',
    et = '\t',
    ev = '\v',
    Char10 = function (char)
        char = tonumber(char)
        if not char or char < 0 or char > 255 then
            return ''
        end
        return string.char(char)
    end,
    Char16 = function (char)
        return string.char(tonumber(char, 16))
    end,
    CharUtf8 = function (char)
        if #char == 0 then
            return ''
        end
        local v = tonumber(char, 16)
        if not v then
            return ''
        end
        if v >= 0 and v <= 0x10FFFF then
            return utf8.char(v)
        end
        return ''
    end,
    Name = function (start, content, finish)
        Ci = Ci + 1
        TokenTypes[Ci]    = 'name'
        TokenStarts[Ci]   = start
        TokenFinishs[Ci]  = finish - 1
        TokenContents[Ci] = content
    end,
    String = function (start, content, finish)
        Ci = Ci + 1
        TokenTypes[Ci]    = 'string'
        TokenStarts[Ci]   = start
        TokenFinishs[Ci]  = finish - 1
        TokenContents[Ci] = content
    end,
    Symbol = function (start, content, finish)
        Ci = Ci + 1
        TokenTypes[Ci]    = 'symbol'
        TokenStarts[Ci]   = start
        TokenFinishs[Ci]  = finish - 1
        TokenContents[Ci] = content
    end,
})

local function parseTokens(text)
    Ci = 0
    TokenTypes    = {}
    TokenStarts   = {}
    TokenFinishs  = {}
    TokenContents = {}
    Parser:match(text)
    Ci = 0
end

local function peekToken()
    return TokenTypes[Ci+1], TokenContents[Ci+1]
end

local function nextToken()
    Ci = Ci + 1
    return TokenTypes[Ci], TokenContents[Ci]
end

local function checkToken(tp, content, offset)
    offset = offset or 0
    return  TokenTypes[Ci + offset] == tp
        and TokenContents[Ci + offset] == content
end

local function getStart()
    return TokenStarts[Ci] + Offset
end

local function getFinish()
    return TokenFinishs[Ci] + Offset
end

local function convertTokensOfClass()
    local result = {
        type   = 'class',
        start  = getStart(),
        finish = getFinish(),
    }
    local nameTp, nameText = nextToken()
    if nameTp ~= 'name' then
        pushError {
            type   = 'LUADOC_MISS_CLASS_NAME',
            start  = result.finish,
            finish = result.finish,
        }
        return nil
    end
    local class = {
        type   = 'name',
        start  = getStart(),
        finish = getFinish(),
        [1]    = nameText,
    }
    result.finish = class.finish
    result.class  = class
    if not peekToken() then
        return result
    end
    if not checkToken('symbol', ':', 1) then
        pushError {
            type   = 'LUADOC_MISS_EXTENSION_SYMBOL',
            start  = result.finish,
            finish = result.finish,
        }
        return result
    end
    nextToken()
    result.finish = getFinish()
    local tp, text = nextToken()
    if tp ~= 'name' then
        pushError {
            type   = 'LUADOC_MISS_EXTENDS_NAME',
            start  = result.finish,
            finish = result.finish,
        }
        return result
    end
    local extends = {
        type   = 'name',
        start  = getStart(),
        finish = getFinish(),
        [1]    = text
    }
    result.finish  = extends.finish
    result.extends = extends
    return result
end

local function convertTokens()
    local tp, text = nextToken()
    if not tp then
        return
    end
    if tp ~= 'name' then
        pushError {
            type  = 'LUADOC_MISS_CATE_NAME',
            start  = getStart(),
            finish = getFinish(),
        }
        return nil
    end
    if text == 'class' then
        return convertTokensOfClass()
    end
end

local function buildLuaDoc(comment)
    Offset = comment.start + 1
    local text = comment.text
    if text:sub(1, 2) ~= '-@' then
        return
    end
    local finishPos = text:find('@', 3)
    local doc, lastComment
    if finishPos then
        doc = text:sub(3, finishPos - 1)
        lastComment = text:sub(finishPos)
    else
        doc = text:sub(3)
    end
    parseTokens(doc)
    local result = convertTokens()
    if result then
        result.comment = lastComment
    end
    return result
end

return function (_, state)
    local ast = state.ast
    local comments = state.comms
    table.sort(comments, function (a, b)
        return a.start < b.start
    end)
    ast.docs = {}

    pushError = state.pushError

    for _, comment in ipairs(comments) do
        local doc = buildLuaDoc(comment)
        if doc then
            ast.docs[#ast.docs+1] = doc
        end
    end
end

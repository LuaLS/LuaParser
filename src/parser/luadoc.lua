local m = require 'lpeglabel'
local re = require 'parser.relabel'

local TokenTypes, TokenStarts, TokenFinishs, TokenContents
local Parser = re.compile([[
Main                <-  (Token / Sp)*
Sp                  <-  %s*
Token               <-  Name / String / Symbol
Name                <-  ({} {[a-zA-Z_] [a-zA-Z0-9_]*} {})
                    ->  Name
]], {
    s = m.S' \t',
    Name = function (start, content, finish)
        TokenTypes[#TokenTypes+1]       = 'name'
        TokenStarts[#TokenStarts+1]     = start
        TokenFinishs[#TokenFinishs+1]   = finish
        TokenContents[#TokenContents+1] = content
    end,
})

local function parseTokens(text)
    TokenTypes    = {}
    TokenStarts   = {}
    TokenFinishs  = {}
    TokenContents = {}
end

local function buildLuaDoc(comment)
    local text = comment.text
    if text:sub(1, 4) ~= '---@' then
        return
    end
    local finishPos = text:find('@', 5)
    local ann, lastComment
    if finishPos then
        ann = text:sub(5, finishPos - 1)
        lastComment = text:sub(finishPos)
    else
        ann = text:sub(5)
    end
    local tokens = parseTokens(ann)
end

return function (_, state)
    local ast = state.ast
    local comments = state.comms
    table.sort(comments, function (a, b)
        return a.start < b.start
    end)
    ast.annotations = {}

    for _, comment in ipairs(comments) do
        ast.annotations[#ast.annotations+1] = buildLuaDoc(comment)
    end
end

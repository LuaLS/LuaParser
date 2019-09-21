local m = require 'lpeglabel'
local utf8Len = utf8.len

_ENV = nil

local function safeUtf8Len(str, start, finish)
    local len, pos = utf8Len(str, start, finish)
    if len then
        return len
    end
    return 1 + safeUtf8Len(str, start, pos-1) + safeUtf8Len(str, pos+1, finish)
end

local function Line(start, line, finish)
    line.start  = start
    line.finish = finish - 1
    return line
end

local function Space(...)
    local line = {...}
    local sp = 0
    local tab = 0
    for i = 1, #line do
        if line[i] == ' ' then
            sp = sp + 1
        elseif line[i] == '\t' then
            tab = tab + 1
        end
        line[i] = nil
    end
    line.sp  = sp
    line.tab = tab
    return line
end

local parser = m.P{
'Lines',
Lines   = m.Ct(m.V'Line'^0 * m.V'LastLine'),
Line    = m.Cp() * m.V'Indent' * (1 - m.V'Nl')^0 * m.Cp() / Line * m.V'Nl',
LastLine= m.Cp() * m.V'Indent' * (1 - m.V'Nl')^0 * m.Cp() / Line,
Nl      = m.P'\r\n' + m.S'\r\n',
Indent  = m.C(m.S' \t')^0 / Space,
}

local function convertCode(lines, text, code)
    if code ~= 'utf8' then
        return
    end
    local delta = 0
    for i = 1, #lines do
        local line   = lines[i]
        local len    = safeUtf8Len(text, line.start, line.finish)

        line.ustart  = line.start - delta
        line.ufinish = line.utart + len - 1

        delta = line.finish - line.ufinish
    end
end

return function (self, text)
    local lines, err = parser:match(text)
    if not lines then
        return nil, err
    end

    convertCode(lines, text)

    return lines
end

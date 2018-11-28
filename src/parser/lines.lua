local m = require 'lpeglabel'

local function Line(pos, ...)
    local line = {...}
    local sp = 0
    local tab = 0
    for i = 1, #line do
        if line[i] == ' ' then
            sp = sp + 1
        else
            tab = tab + 1
        end
        line[i] = nil
    end
    line[1] = pos
    line[2] = sp
    line[3] = tab
    return line
end

local parser = m.P{
'Lines',
Lines   = m.Ct((m.V'Line' * m.V'Nl')^0 * m.V'Line'),
Line    = m.Cp() * m.V'Indent' * (1 - m.V'Nl')^0 / Line,
Nl      = m.P'\r\n' + m.S'\r\n',
Indent  = m.C(m.S' \t')^0,
}

local mt = {}
mt.__index = mt



return function (self, buf)
    local lines, err = parser:match(buf)
    if not lines then
        return nil, err
    end

    return setmetatable(lines, mt)
end

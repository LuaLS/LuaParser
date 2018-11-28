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

function mt:position(row, col)
    if row < 1 then
        return 1
    end
    if row > #self then
        return self.len + 1
    end
    local line = self[row]
    local next_line = self[row+1]
    local start = line[1]
    local finish
    if next_line then
        finish = next_line[1] - 1
    else
        finish = self.len + 1
    end
    local pos = start + col - 1
    if pos < start then
        pos = start
    elseif pos > finish then
        pos = finish
    end
    return pos
end

function mt:rowcol(pos)
    if pos < 1 then
        return 1, 1
    end
    if pos > self.len + 1 then
        return #self, math.max(1, self.len - self[#self][1] + 2)
    end
    local min = 1
    local max = #self
    for _ = 1, 100 do
        local row = (max - min) // 2 + min
        local start = self[row][1]
        if pos < start then
            max = row
        elseif pos > start then
            local next_start = self[row + 1][1]
            if pos < next_start then
                return row, pos - start + 1
            elseif pos > next_start then
                min = row
            else
                return row + 1, 1
            end
        else
            return row, 1
        end
    end
    error('rowcol failed!')
end

return function (self, buf)
    local lines, err = parser:match(buf)
    if not lines then
        return nil, err
    end
    lines.len = #buf

    return setmetatable(lines, mt)
end

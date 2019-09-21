local utility = require 'utility'

local parser = require 'parser'
local buf = utility.loadFile((ROOT / 'test' / 'perform' / 'lines.txt'):string())
assert(buf)
buf = buf:gsub('\r\n', '\n'):gsub('[\r\n]', '\r\n')

do
    local lines = parser:lines(buf)
    local row, col = parser.guide.positionOf(lines, 0)
    assert(row == 0)
    assert(col == 0)

    local row, col = parser.guide.positionOf(lines, 1)
    assert(row == 0)
    assert(col == 1)

    local row, col = parser.guide.positionOf(lines, 55)
    assert(row == 0)
    assert(col == 55)

    local row, col = parser.guide.positionOf(lines, 56)
    assert(row == 0)
    assert(col == 56)

    local row, col = parser.guide.positionOf(lines, 57)
    assert(row == 1)
    assert(col == 0)

    local row, col = parser.guide.positionOf(lines, 58)
    assert(row == 1)
    assert(col == 1)

    local row, col = parser.guide.positionOf(lines, 59)
    assert(row == 2)
    assert(col == 0)

    local row, col = parser.guide.positionOf(lines, 60)
    assert(row == 2)
    assert(col == 1)
end

do
    local lines = parser:lines(buf)
    local offset = parser.guide.offsetOf(lines, 0, 0)
    assert(offset == 0)

    local offset = parser.guide.offsetOf(lines, 0, 1)
    assert(offset == 1)

    local offset = parser.guide.offsetOf(lines, 0, 55)
    assert(offset == 55)

    local offset = parser.guide.offsetOf(lines, 0, 56)
    assert(offset == 56)

    local offset = parser.guide.offsetOf(lines, 0, 57)
    assert(offset == 57)

    local offset = parser.guide.offsetOf(lines, 1, 0)
    assert(offset == 57)

    local offset = parser.guide.offsetOf(lines, 1, 1)
    assert(offset == 58)

    local offset = parser.guide.offsetOf(lines, 2, 0)
    assert(offset == 59)

    local offset = parser.guide.offsetOf(lines, 2, 1)
    assert(offset == 60)
end

do
    local lines = parser:lines 'abc\r\nabc\r\n' -- len = 10

    local pos = parser.guide.offsetOf(lines, 9999, 1)
    assert(pos == 10)

    local pos = parser.guide.offsetOf(lines, 2, 9999)
    assert(pos == 10)

    local pos = parser.guide.offsetOf(lines, 2, 2)
    assert(pos == 10)

    local pos = parser.guide.offsetOf(lines, 2, 1)
    assert(pos == 10)

    local pos = parser.guide.offsetOf(lines, 2, 0)
    assert(pos == 10)

    local pos = parser.guide.offsetOf(lines, 1, 9999)
    assert(pos == 10)

    local pos = parser.guide.offsetOf(lines, 1, 5)
    assert(pos == 10)

    local pos = parser.guide.offsetOf(lines, 1, 4)
    assert(pos == 9)

    local row, col = parser.guide.positionOf(lines, 9999)
    assert(row == 2)
    assert(col == 0)

    local row, col = parser.guide.positionOf(lines, 11)
    assert(row == 2)
    assert(col == 0)

    local row, col = parser.guide.positionOf(lines, 10)
    assert(row == 2)
    assert(col == 0)

    local row, col = parser.guide.positionOf(lines, 9)
    assert(row == 1)
    assert(col == 4)
end

local utility = require 'utility'

local parser = require 'parser'
local guide  = require 'parser.guide'
local buf = utility.loadFile((ROOT / 'test' / 'perform' / 'lines.txt'):string())
assert(buf)
buf = buf:gsub('\r\n', '\n'):gsub('[\r\n]', '\r\n')

do
    local lines = parser.lines(buf)
    local row, col = guide.positionOf(lines, 0)
    assert(row == 1)
    assert(col == 0)

    local row, col = guide.positionOf(lines, 1)
    assert(row == 1)
    assert(col == 1)

    local row, col = guide.positionOf(lines, 55)
    assert(row == 1)
    assert(col == 55)

    local row, col = guide.positionOf(lines, 56)
    assert(row == 1)
    assert(col == 56)

    local row, col = guide.positionOf(lines, 57)
    assert(row == 2)
    assert(col == 0)

    local row, col = guide.positionOf(lines, 58)
    assert(row == 2)
    assert(col == 1)

    local row, col = guide.positionOf(lines, 59)
    assert(row == 3)
    assert(col == 0)

    local row, col = guide.positionOf(lines, 60)
    assert(row == 3)
    assert(col == 1)
end

do
    local lines = parser.lines(buf)
    local offset = guide.offsetOf(lines, 1, 1)
    assert(offset == 1)

    local offset = guide.offsetOf(lines, 1, 2)
    assert(offset == 2)

    local offset = guide.offsetOf(lines, 1, 56)
    assert(offset == 55)

    local offset = guide.offsetOf(lines, 1, 57)
    assert(offset == 55)

    local offset = guide.offsetOf(lines, 1, 58)
    assert(offset == 55)

    local offset = guide.offsetOf(lines, 2, 0)
    assert(offset == 57)

    local offset = guide.offsetOf(lines, 2, 1)
    assert(offset == 57)

    local offset = guide.offsetOf(lines, 2, 2)
    assert(offset == 57)

    local offset = guide.offsetOf(lines, 3, 0)
    assert(offset == 59)

    local offset = guide.offsetOf(lines, 3, 1)
    assert(offset == 60)

    local offset = guide.offsetOf(lines, 3, 2)
    assert(offset == 61)
end

do
    local lines = parser.lines 'abc\r\nabc\r\n' -- len = 10

    local pos = guide.offsetOf(lines, 9999, 1)
    assert(pos == 10)

    local pos = guide.offsetOf(lines, 2, 9999)
    assert(pos == 8)

    local pos = guide.offsetOf(lines, 3, 3)
    assert(pos == 10)

    local pos = guide.offsetOf(lines, 3, 2)
    assert(pos == 10)

    local pos = guide.offsetOf(lines, 3, 1)
    assert(pos == 10)

    local pos = guide.offsetOf(lines, 2, 6)
    assert(pos == 8)

    local pos = guide.offsetOf(lines, 2, 5)
    assert(pos == 8)

    local row, col = guide.positionOf(lines, 9999)
    assert(row == 3)
    assert(col == 0)

    local row, col = guide.positionOf(lines, 11)
    assert(row == 3)
    assert(col == 0)

    local row, col = guide.positionOf(lines, 10)
    assert(row == 3)
    assert(col == 0)

    local row, col = guide.positionOf(lines, 9)
    assert(row == 2)
    assert(col == 4)
end

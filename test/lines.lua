
local parser = require 'parser'
local buf = io.load(ROOT / 'src' / 'parser' / 'relabel.lua')
assert(buf)

local lines = parser:lines(buf)

assert(#lines        == 365)
assert(lines[2][1]   == 58)
assert(lines[3][1]   == 60)
assert(lines[358][2] == 2)
assert(lines[358][3] == 0)
assert(lines[359][2] == 0)
assert(lines[359][3] == 1)

assert(lines.len     == #buf)

local row, col = lines:rowcol(618)
assert(row == 22)
assert(col == 19)

local pos = lines:position(22, 19)
assert(pos == 618)

local row, col = lines:rowcol(9999999)
assert(row == 365)
assert(col == 1)

local row, col = lines:rowcol(-100)
assert(row == 1)
assert(col == 1)

local pos = lines:position(8, 999)
assert(pos == 293)

local pos = lines:position(8, -100)
assert(pos == 270)

local pos = lines:position(-100, 1)
assert(pos == 1)

local pos = lines:position(9999, 1)
assert(pos == 10373)

local pos = lines:position(365, 1)
assert(pos == 10373)

local row, col = lines:rowcol(10373)
assert(row == 365)
assert(col == 1)

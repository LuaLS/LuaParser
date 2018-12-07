
local parser = require 'parser'
local buf = io.load(ROOT / 'src' / 'parser' / 'relabel.lua')
assert(buf)

local lines = parser:lines(buf)

assert(#lines          == 365)
assert(lines[2].start  == 58)
assert(lines[3].start  == 60)
assert(lines[358].sp   == 2)
assert(lines[358].tab == 0)
assert(lines[359].sp == 0)
assert(lines[359].tab == 1)

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

local pos = lines:position(9999, 1, 'utf8')
assert(pos == 10337)

local pos = lines:position(191, 16, 'utf8')
assert(pos == 4863)

local row, col = lines:rowcol(4863, 'utf8')
assert(row == 191)
assert(col == 16)

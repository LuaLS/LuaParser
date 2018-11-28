
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

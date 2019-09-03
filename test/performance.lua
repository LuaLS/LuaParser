local function test(lpeg, buf)
    local P = lpeg.P
    local V = lpeg.V
    local S = lpeg.S
    local R = lpeg.R
    local paser = P
    {
        V'Value',
        Nl          = P'\r\n' + S'\r\n',
        Sp          = S' \t',
        Spnl        = (V'Sp' + V'Nl')^0,
        Bool        = P'true' + P'false',
        Int         = '0' + (P'-'^-1 * R'09'^1),
        Float       = P'-'^-1 * ('0' + R'09'^1) * '.' * R'09'^0 * V'FloatSuffix'^-1,
        Bad         = (R'09' + R'az' + R'AZ')^1,
        FloatSuffix = S'eE' * P'-'^-1 * R'09'^1,
        Null        = P'null',
        String      = '"'
                    * ('\\' * P(1) + (P(1) - '"'))^0
                    * '"',
        Table       = V'Spnl'
                    * S'[{' * V'Spnl'
                        * (
                              V'Object'
                            + V'Value'
                            + P','    * V'Spnl'
                        )^0 * V'Spnl'
                    * S']}' * V'Spnl',
        Object      = V'Spnl' * V'Key' * V'Spnl' * V'Value' * V'Spnl',
        Key         = V'String' * V'Spnl' * ':',
        Value       = V'Table'
                    + V'Bool'
                    + V'Null'
                    + V'String'
                    + V'Float'
                    + V'Int'
                    + V'Bad'
    }
    local clock = os.clock()
    local res
    for _ = 1, 1000 do
        res = paser:match(buf)
    end
    local passed = os.clock() - clock
    assert(res == #buf + 1)
    print(passed)
end

local f = io.open [[test\perform\test.json]]
local buf = f:read 'a'
f:close()

collectgarbage 'stop'

print('===========test lpeg-1.0.1-DEBUG====================')
test(package.loadlib('bin/lpeg-1.0.1-DEBUG.dll', 'luaopen_lpeg')(), buf)

print('===========test lpeg-1.0.2-DEBUG====================')
test(package.loadlib('bin/lpeg-1.0.2-DEBUG.dll', 'luaopen_lpeg')(), buf)

print('===========test lpeg-1.0.1-NDEBUG====================')
test(package.loadlib('bin/lpeg-1.0.1-NDEBUG.dll', 'luaopen_lpeg')(), buf)

print('===========test lpeg-1.0.2-NDEBUG====================')
test(package.loadlib('bin/lpeg-1.0.2-NDEBUG.dll', 'luaopen_lpeg')(), buf)

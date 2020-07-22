TEST [[
function f()
    local x
    return x
end
local <!y!> = f()
print(<?y?>)
]]

TEST [[
function f()
end

local y = f()
print(y.<?z?>)
]]

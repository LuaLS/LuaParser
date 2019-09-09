CHECK [[
a = 1
b = 2
c = 3
]]
{
    [2] = 10,
    [5] = 10,
    [8] = 10,
}

CHECK [[
function f()
    a = 1
    b = 2
    c = 3
end
]]
{
    [2]  = 14,
    [5]  = 13,
    [8]  = 13,
    [11] = 13,
}

CHECK [[
return function ()
    a = 1
    b = 2
    c = 3
end
]]
{
    [3]  = 11,
    [6]  = 11,
    [9]  = 11,
    [12] = 13,
}

CHECK [[
local function f()
    a = 1
    b = 2
    c = 3
end
]]
{
    [2]  = 15,
    [5]  = 13,
    [8]  = 13,
    [11] = 13,
    [14] = 15,
}

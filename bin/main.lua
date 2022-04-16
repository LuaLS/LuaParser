local main, exec
local i = 1
while arg[i] do
    if     arg[i] == '-E' then
    elseif arg[i] == '-e' then
        i = i + 1
        local expr = assert(arg[i], "'-e' needs argument")
        assert(load(expr, "=(command line)"))()
        -- exit after the executing
        exec = true
    elseif not main and arg[i]:sub(1, 1) ~= '-' then
        main = i
    elseif arg[i]:sub(1, 2) == '--' then
        break
    end
    i = i + 1
end

if exec and not main then
    return
end

if main then
    for i = -1, -999, -1 do
        if not arg[i] then
            for j = i + 1, -1 do
                arg[j - main + 1] = arg[j]
            end
            break
        end
    end
    for j = 1, #arg do
        arg[j - main] = arg[j]
    end
    for j = #arg - main + 1, #arg do
        arg[j] = nil
    end
end

local root
do
    if main then
        local fs = require 'bee.filesystem'
        local mainPath = fs.path(arg[0])
        root = mainPath:parent_path():string()
        if root == '' then
            root = '.'
        end
    else
        local sep = package.config:sub(1, 1)
        if sep == '\\' then
            sep = '/\\'
        end
        local pattern = "[" .. sep .. "]+[^" .. sep .. "]+"
        root = package.cpath:match("([^;]+)" .. pattern .. pattern .. "$")
        arg[0] = root .. package.config:sub(1, 1) .. 'main.lua'
    end
    root = root:gsub('[/\\]', package.config:sub(1, 1))
end

package.path = table.concat({
    root .. "/?.lua",
    root .. "/?/init.lua",
}, ";"):gsub('/', package.config:sub(1, 1))

assert(loadfile(arg[0]))(table.unpack(arg))

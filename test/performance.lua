local function test(l)
    for k in pairs(package.loaded) do
        package.loaded[k] = nil
    end
    package.loaded['lpeglabel'] = l
    dofile [[test/main.lua]]
end

print('===========test lpeglabel-1.01====================')
test(package.loadlib('bin/lpeglabel-1.01.dll', 'luaopen_lpeglabel')())

print('===========test lpeglabel-1.02====================')
test(package.loadlib('bin/lpeglabel-1.02.dll', 'luaopen_lpeglabel')())

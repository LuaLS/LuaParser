root = arg[0] .. '\\..\\..'
package.path = package.path .. ';' .. root .. '\\src\\?.lua'
                            .. ';' .. root .. '\\src\\?\\init.lua'
                            .. ';' .. root .. '\\test\\?.lua'
                            .. ';' .. root .. '\\test\\?\\init.lua'

require 'utility'
require 'global_protect'
local parser = require 'parser'
local fs = require 'bee.filesystem'

rawset(_G, 'ROOT', fs.path(root))

local function unitTest(name)
    local clock = os.clock()
    print(('测试[%s]...'):format(name))
    require(name)
    print(('测试[%s]用时[%.3f]'):format(name, os.clock() - clock))
end

local function performTest()
    local targetPath = ROOT
    local files = {}
    local size = 0
    for path in io.scan(targetPath) do
        if path:extension():string() == '.lua' then
            local buf = io.load(path)
            files[path] = buf
            size = size + #buf
        end
    end
    collectgarbage 'stop'
    local clock = os.clock()
    for path, buf in pairs(files) do
        local suc, err = parser:ast(buf)
        if not suc then
            error(('文件解析失败：%s'):format(path:string()))
        end
        local lines, err = parser:lines(buf)
        if not suc then
            error(('行号解析失败：%s'):format(path:string()))
        end
    end
    local passed = os.clock() - clock
    print(('解析完成，总大小[%.3f]kb，速度[%.3f]mb/s，用时[%.3f]秒'):format(size / 1000, size / passed / 1000 / 1000, passed))
end

local function main()

    unitTest 'grammar'
    unitTest 'ast'
    unitTest 'lines'
    unitTest 'syntax_check'

    performTest()

    print('测试完成')
end

main()

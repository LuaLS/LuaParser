local fs = require 'bee.filesystem'
local parser = require 'parser'

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
    print(('综合性能测试完成，总大小[%.3f]kb，速度[%.3f]mb/s，用时[%.3f]秒'):format(size / 1000, size / passed / 1000 / 1000, passed))
end

local function test(path)
    local buf = io.load(fs.path(path))
    if not buf then
        return
    end
    local clock = os.clock()
    local suc, err = parser:ast(buf)
    if not suc then
        error(('文件解析失败：%s'):format(path:string()))
    end
    local passed = os.clock() - clock
    local size = #buf
    print(('[%s]测试完成，大小[%.3f]kb，速度[%.3f]mb/s，用时[%.3f]秒'):format(path, size / 1000, size / passed / 1000 / 1000, passed))
end

collectgarbage 'stop'
test[[test\perform\1.lua]]
performTest()
collectgarbage 'restart'

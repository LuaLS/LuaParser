local root = arg[0] .. '\\..\\..'
package.path = package.path .. ';' .. root .. '\\src\\?.lua'
                            .. ';' .. root .. '\\src\\?\\init.lua'
                            .. ';' .. root .. '\\test\\?.lua'
                            .. ';' .. root .. '\\test\\?\\init.lua'

local fs = require 'bee.filesystem'

rawset(_G, 'ROOT', fs.path(root))

local function unitTest(name)
    local clock = os.clock()
    print(('测试[%s]...'):format(name))
    require(name)
    print(('测试[%s]用时[%.3f]'):format(name, os.clock() - clock))
end

local function main()
    --collectgarbage 'stop'
    unitTest 'ast'
    unitTest 'grammar'
    --unitTest 'lines'
    unitTest 'grammar_check'
    unitTest 'syntax_check'
    --unitTest 'guide'
    unitTest 'perform'

    print('测试完成')
end

main()

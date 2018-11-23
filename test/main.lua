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

local function main()
    local function test(name)
        local clock = os.clock()
        print(('测试[%s]...'):format(name))
        require(name)
        print(('测试[%s]用时[%.3f]'):format(name, os.clock() - clock))
    end

    test 'grammar'
    test 'ast'

    print('测试完成')
end

main()

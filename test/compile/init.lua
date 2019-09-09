local parser = require 'parser'
local fs = require 'bee.filesystem'

local function eq(a, b)
    local tp1, tp2 = type(a), type(b)
    if tp1 ~= tp2 then
        return false
    end
    if tp1 == 'table' then
        local checked = {}
        for k in pairs(a) do
            if not eq(a[k], b[k]) then
                return false
            end
            checked[k] = true
        end
        for k in pairs(b) do
            if not checked[k] then
                return false
            end
        end
        return true
    end
    if tp1 == 'number' then
        return ('%q'):format(a) == ('%q'):format(b)
    end
    return a == b
end

local function test(type)
    CHECK = function (buf)
        return function (target_ast)
            local state, err = parser:compile(buf, 'lua', 'Lua 5.4')
            if not state then
                error(('语法树生成失败：%s'):format(err))
            end
            if not eq(state.ref[type], target_ast) then
                fs.create_directory(ROOT / 'test' / 'log')
                io.save(ROOT / 'test' / 'log' / 'my_compile.ast', table.dump(state.ref[type]))
                io.save(ROOT / 'test' / 'log' / 'target_compile.ast', table.dump(target_ast))
                error(('编译结果不相等：%s\n%s'):format(type, buf))
            end
        end
    end
    require('compile.' .. type)
end

test 'function'
test 'return'

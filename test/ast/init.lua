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
            local my_ast, err = parser:parse(buf, type, 'Lua 5.4')
            if not my_ast then
                error(('语法树生成失败：%s'):format(err))
            end
            if not eq(my_ast, target_ast) then
                fs.create_directory(ROOT / 'test' / 'log')
                io.save(ROOT / 'test' / 'log' / 'my_ast.ast', table.dump(my_ast))
                io.save(ROOT / 'test' / 'log' / 'target_ast.ast', table.dump(target_ast))
                error(('语法树不相等：%s\n%s'):format(type, buf))
            end
        end
    end
    EMMY = function (buf)
        return function (target_ast)
            local _, err, emmy = parser:parse(buf, type, 'Lua 5.4')
            if not emmy then
                error(('语法树生成失败：%s'):format(err))
            end
            if not eq(emmy, target_ast) then
                fs.create_directory(ROOT / 'test' / 'log')
                io.save(ROOT / 'test' / 'log' / 'my_emmy.ast', table.dump(emmy))
                io.save(ROOT / 'test' / 'log' / 'target_emmy.ast', table.dump(target_ast))
                error(('语法树不相等：%s\n%s'):format(type, buf))
            end
        end
    end
    require('ast.' .. type)
end

test 'Nil'
test 'Boolean'
test 'String'
test 'Number'
test 'Name'
test 'Exp'
test 'Action'
test 'Lua'
test 'Dirty'
test 'Emmy'

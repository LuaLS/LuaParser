local parser = require 'parser'
local fs = require 'bee.filesystem'
local utility = require 'utility'

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

local sortList = {
    'type', 'start', 'finish',
    'parent', 'extParent', 'child',
    'filter',
    'node',
    'op', 'args',
    'loc', 'max', 'step', 'keys',
    'dot', 'colon',
    'vararg',
    'field', 'index', 'method',
    'exp', 'value',
    'attrs',
    'locs',
}
for i, v in ipairs(sortList) do
    sortList[v] = i
end

local option = {
    alignment = true,
    sorter = function (keys, keymap)
        table.sort(keys, function (a, b)
            local tp1 = type(a)
            local tp2 = type(b)
            if tp1 == 'number' and tp2 ~= 'number' then
                return false
            end
            if tp1 ~= 'number' and tp2 == 'number' then
                return true
            end
            if tp1 == 'number' and tp2 == 'number' then
                return a < b
            end
            local s1 = sortList[a]
            local s2 = sortList[b]
            if s1 and not s2 then
                return false
            end
            if s2 and not s1 then
                return true
            end
            if s1 and s2 then
                return s1 < s2
            end
            return a < b
        end)
    end,
}

local function test(type)
    CHECK = function (buf)
        return function (target_ast)
            local state, err = parser:compile(buf, type, 'Lua 5.4')
            if not state then
                error(('语法树生成失败：%s'):format(err))
            end
            if not eq(state.root, target_ast) then
                fs.create_directory(ROOT / 'test' / 'log')
                utility.saveFile((ROOT / 'test' / 'log' / 'my_ast.ast'):string(), utility.dump(state.root, option))
                utility.saveFile((ROOT / 'test' / 'log' / 'target_ast.ast'):string(), utility.dump(target_ast, option))
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
test 'Exp'
test 'Action'
test 'Lua'
test 'Dirty'
do return end
test 'Emmy'

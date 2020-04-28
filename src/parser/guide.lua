local util       = require 'utility'
local error      = error
local type       = type
local next       = next
local tostring   = tostring
local print      = print
local ipairs     = ipairs

_ENV = nil

local m = {}

local blockTypes = {
    ['while']       = true,
    ['in']          = true,
    ['loop']        = true,
    ['repeat']      = true,
    ['do']          = true,
    ['function']    = true,
    ['ifblock']     = true,
    ['elseblock']   = true,
    ['elseifblock'] = true,
    ['main']        = true,
}

local breakBlockTypes = {
    ['while']       = true,
    ['in']          = true,
    ['loop']        = true,
    ['repeat']      = true,
}

m.childMap = {
    ['main']        = {'#'},
    ['repeat']      = {'#', 'filter'},
    ['while']       = {'filter', '#'},
    ['in']          = {'keys', '#'},
    ['loop']        = {'loc', 'max', 'step', '#'},
    ['if']          = {'#'},
    ['ifblock']     = {'filter', '#'},
    ['elseifblock'] = {'filter', '#'},
    ['elseblock']   = {'#'},
    ['setfield']    = {'node', 'field', 'value'},
    ['setglobal']   = {'value'},
    ['local']       = {'attrs', 'value'},
    ['setlocal']    = {'value'},
    ['return']      = {'#'},
    ['do']          = {'#'},
    ['select']      = {'vararg'},
    ['table']       = {'#'},
    ['tableindex']  = {'index', 'value'},
    ['tablefield']  = {'field', 'value'},
    ['function']    = {'args', '#'},
    ['funcargs']    = {'#'},
    ['setmethod']   = {'node', 'method', 'value'},
    ['getmethod']   = {'node', 'method'},
    ['setindex']    = {'node', 'index', 'value'},
    ['getindex']    = {'node', 'index'},
    ['paren']       = {'exp'},
    ['call']        = {'node', 'args'},
    ['callargs']    = {'#'},
    ['getfield']    = {'node', 'field'},
    ['list']        = {'#'},
    ['binary']      = {1, 2},
    ['unary']       = {1}
}

m.actionMap = {
    ['main']        = {'#'},
    ['repeat']      = {'#'},
    ['while']       = {'#'},
    ['in']          = {'#'},
    ['loop']        = {'#'},
    ['if']          = {'#'},
    ['ifblock']     = {'#'},
    ['elseifblock'] = {'#'},
    ['elseblock']   = {'#'},
    ['do']          = {'#'},
    ['function']    = {'#'},
    ['funcargs']    = {'#'},
}

--- 是否是字面量
function m.isLiteral(obj)
    local tp = obj.type
    return tp == 'nil'
        or tp == 'boolean'
        or tp == 'string'
        or tp == 'number'
        or tp == 'table'
end

--- 获取字面量
function m.getLiteral(obj)
    local tp = obj.type
    if     tp == 'boolean' then
        return obj[1]
    elseif tp == 'string' then
        return obj[1]
    elseif tp == 'number' then
        return obj[1]
    end
    return nil
end

--- 寻找父函数
function m.getParentFunction(obj)
    for _ = 1, 1000 do
        obj = obj.parent
        if not obj then
            break
        end
        local tp = obj.type
        if tp == 'function' or tp == 'main' then
            return obj
        end
    end
    return nil
end

--- 寻找所在区块
function m.getBlock(obj)
    for _ = 1, 1000 do
        if not obj then
            return nil
        end
        local tp = obj.type
        if blockTypes[tp] then
            return obj
        end
        obj = obj.parent
    end
    error('guide.getBlock overstack')
end

--- 寻找所在父区块
function m.getParentBlock(obj)
    for _ = 1, 1000 do
        obj = obj.parent
        if not obj then
            return nil
        end
        local tp = obj.type
        if blockTypes[tp] then
            return obj
        end
    end
    error('guide.getParentBlock overstack')
end

--- 寻找所在可break的父区块
function m.getBreakBlock(obj)
    for _ = 1, 1000 do
        obj = obj.parent
        if not obj then
            return nil
        end
        local tp = obj.type
        if breakBlockTypes[tp] then
            return obj
        end
        if tp == 'function' then
            return nil
        end
    end
    error('guide.getBreakBlock overstack')
end

--- 寻找根区块
function m.getRoot(obj)
    for _ = 1, 1000 do
        local parent = obj.parent
        if not parent then
            return obj
        end
        obj = parent
    end
    error('guide.getRoot overstack')
end

--- 寻找函数的不定参数，返回不定参在第几个参数上，以及该参数对象。
--- 如果函数是主函数，则返回`0, nil`。
---@return table
---@return integer
function m.getFunctionVarArgs(func)
    if func.type == 'main' then
        return 0, nil
    end
    if func.type ~= 'function' then
        return nil, nil
    end
    local args = func.args
    if not args then
        return nil, nil
    end
    for i = 1, #args do
        local arg = args[i]
        if arg.type == '...' then
            return i, arg
        end
    end
    return nil, nil
end

--- 获取指定区块中可见的局部变量
---@param block table
---@param name string {comment = '变量名'}
---@param pos integer {comment = '可见位置'}
function m.getLocal(block, name, pos)
    block = m.getBlock(block)
    for _ = 1, 1000 do
        if not block then
            return nil
        end
        local locals = block.locals
        local res
        if not locals then
            goto CONTINUE
        end
        for i = 1, #locals do
            local loc = locals[i]
            if loc.effect > pos then
                break
            end
            if loc[1] == name then
                if not res or res.effect < loc.effect then
                    res = loc
                end
            end
        end
        if res then
            return res, res
        end
        ::CONTINUE::
        block = m.getParentBlock(block)
    end
    error('guide.getLocal overstack')
end

--- 获取指定区块中所有的可见局部变量名称
function m.getVisibleLocals(block, pos)
    local result = {}
    m.eachSourceContain(m.getRoot(block), pos, function (source)
        local locals = source.locals
        if locals then
            for i = 1, #locals do
                local loc = locals[i]
                local name = loc[1]
                if loc.effect <= pos then
                    result[name] = loc
                end
            end
        end
    end)
    return result
end

--- 获取指定区块中可见的标签
---@param block table
---@param name string {comment = '标签名'}
function m.getLabel(block, name)
    block = m.getBlock(block)
    for _ = 1, 1000 do
        if not block then
            return nil
        end
        local labels = block.labels
        if labels then
            local label = labels[name]
            if label then
                return label
            end
        end
        if block.type == 'function' then
            return nil
        end
        block = m.getParentBlock(block)
    end
    error('guide.getLocal overstack')
end

--- 判断source是否包含offset
function m.isContain(source, offset)
    return source.start <= offset and source.finish >= offset - 1
end

--- 判断offset在source的影响范围内
---
--- 主要针对赋值等语句时，key包含value
function m.isInRange(source, offset)
    return (source.vstart or source.start) <= offset and (source.range or source.finish) >= offset - 1
end

--- 添加child
function m.addChilds(list, obj, map)
    local keys = map[obj.type]
    if keys then
        for i = 1, #keys do
            local key = keys[i]
            if key == '#' then
                for i = 1, #obj do
                    list[#list+1] = obj[i]
                end
            else
                list[#list+1] = obj[key]
            end
        end
    end
end

--- 遍历所有包含offset的source
function m.eachSourceContain(ast, offset, callback)
    local list = { ast }
    while true do
        local len = #list
        if len == 0 then
            return
        end
        local obj = list[len]
        list[len] = nil
        if m.isInRange(obj, offset) then
            if m.isContain(obj, offset) then
                local res = callback(obj)
                if res ~= nil then
                    return res
                end
            end
            m.addChilds(list, obj, m.childMap)
        end
    end
end

--- 遍历所有指定类型的source
function m.eachSourceType(ast, type, callback)
    local cache = ast.typeCache
    if not cache then
        local mark = {}
        cache = {}
        ast.typeCache = cache
        m.eachSource(ast, function (source)
            if mark[source] then
                return
            end
            mark[source] = true
            local tp = source.type
            if not tp then
                return
            end
            local myCache = cache[tp]
            if not myCache then
                myCache = {}
                cache[tp] = myCache
            end
            myCache[#myCache+1] = source
        end)
    end
    local myCache = cache[type]
    if not myCache then
        return
    end
    for i = 1, #myCache do
        callback(myCache[i])
    end
end

--- 遍历所有的source
function m.eachSource(ast, callback)
    local list = { ast }
    local index = 1
    while true do
        local obj = list[index]
        if not obj then
            return
        end
        list[index] = false
        index = index + 1
        callback(obj)
        m.addChilds(list, obj, m.childMap)
    end
end

--- 获取指定的 special
function m.eachSpecialOf(ast, name, callback)
    local root = m.getRoot(ast)
    if not root.specials then
        return
    end
    local specials = root.specials[name]
    if not specials then
        return
    end
    for i = 1, #specials do
        callback(specials[i])
    end
end

--- 获取偏移对应的坐标
---@param lines table
---@return integer {name = 'row'}
---@return integer {name = 'col'}
function m.positionOf(lines, offset)
    if offset < 1 then
        return 0, 0
    end
    local lastLine = lines[#lines]
    if offset > lastLine.finish then
        return #lines, lastLine.finish - lastLine.start + 1
    end
    local min = 1
    local max = #lines
    for _ = 1, 100 do
        if max <= min then
            local line = lines[min]
            return min, offset - line.start + 1
        end
        local row = (max - min) // 2 + min
        local line = lines[row]
        if offset < line.start then
            max = row - 1
        elseif offset > line.finish then
            min = row + 1
        else
            return row, offset - line.start + 1
        end
    end
    error('Stack overflow!')
end

--- 获取坐标对应的偏移
---@param lines table
---@param row integer
---@param col integer
---@return integer {name = 'offset'}
function m.offsetOf(lines, row, col)
    if row < 1 then
        return 0
    end
    if row > #lines then
        local lastLine = lines[#lines]
        return lastLine.finish
    end
    local line = lines[row]
    local len = line.finish - line.start + 1
    if col < 0 then
        return line.start
    elseif col > len then
        return line.finish
    else
        return line.start + col - 1
    end
end

function m.lineContent(lines, text, row)
    local line = lines[row]
    if not line then
        return ''
    end
    return text:sub(line.start, line.finish)
end

function m.lineRange(lines, row)
    local line = lines[row]
    if not line then
        return 0, 0
    end
    return line.start, line.finish
end

function m.getNameOfLiteral(obj)
    if not obj then
        return nil
    end
    local tp = obj.type
    if tp == 'string' then
        return obj[1]
    end
    return nil
end

function m.getName(obj)
    local tp = obj.type
    if tp == 'getglobal'
    or tp == 'setglobal' then
        return obj[1]
    elseif tp == 'local'
    or     tp == 'getlocal'
    or     tp == 'setlocal' then
        return obj[1]
    elseif tp == 'getfield'
    or     tp == 'setfield'
    or     tp == 'tablefield' then
        return obj.field[1]
    elseif tp == 'getmethod'
    or     tp == 'setmethod' then
        return obj.method[1]
    elseif tp == 'getindex'
    or     tp == 'setindex'
    or     tp == 'tableindex' then
        return m.getNameOfLiteral(obj.index)
    elseif tp == 'field'
    or     tp == 'method' then
        return obj[1]
    end
    return m.getNameOfLiteral(obj)
end

function m.getKeyNameOfLiteral(obj)
    if not obj then
        return nil
    end
    local tp = obj.type
    if tp == 'field'
    or     tp == 'method' then
        return 's|' .. obj[1]
    elseif tp == 'string' then
        local s = obj[1]
        if s then
            return 's|' .. s
        else
            return s
        end
    elseif tp == 'number' then
        local n = obj[1]
        if n then
            return ('n|%s'):format(util.viewLiteral(obj[1]))
        else
            return 'n'
        end
    elseif tp == 'boolean' then
        local b = obj[1]
        if b then
            return 'b|' .. tostring(b)
        else
            return 'b'
        end
    end
    return nil
end

function m.getKeyName(obj)
    local tp = obj.type
    if tp == 'getglobal'
    or tp == 'setglobal' then
        return 's|' .. obj[1]
    elseif tp == 'local'
    or     tp == 'getlocal'
    or     tp == 'setlocal' then
        return 'l|' .. obj[1]
    elseif tp == 'getfield'
    or     tp == 'setfield'
    or     tp == 'tablefield' then
        if obj.field then
            return 's|' .. obj.field[1]
        end
    elseif tp == 'getmethod'
    or     tp == 'setmethod' then
        if obj.method then
            return 's|' .. obj.method[1]
        end
    elseif tp == 'getindex'
    or     tp == 'setindex'
    or     tp == 'tableindex' then
        return m.getKeyNameOfLiteral(obj.index)
    elseif tp == 'field'
    or     tp == 'method' then
        return 's|' .. obj[1]
    end
    return m.getKeyNameOfLiteral(obj)
end

function m.getENV(ast)
    if ast.type ~= 'main' then
        return nil
    end
    return ast.locals[1]
end

--- 测试 a 到 b 的路径（不经过函数，不考虑 goto），
--- 每个路径是一个 block 。
---
--- 如果 a 在 b 的前面，返回 `"before"` 加上 2个`list<block>`
---
--- 如果 a 在 b 的后面，返回 `"after"` 加上 2个`list<block>`
---
--- 否则返回 `false`
---
--- 返回的2个 `list` 分别为基准block到达 a 与 b 的路径。
---@param a table
---@param b table
---@return string|boolean mode
---@return table|nil pathA
---@return table|nil pathB
function m.getPath(a, b, sameFunction)
    --- 首先测试双方在同一个函数内
    if not sameFunction and m.getParentFunction(a) ~= m.getParentFunction(b) then
        return false
    end
    local mode
    local objA
    local objB
    if a.finish < b.start then
        mode = 'before'
        objA = a
        objB = b
    elseif a.start > b.finish then
        mode = 'after'
        objA = b
        objB = a
    else
        return 'equal', {}, {}
    end
    local pathA = {}
    local pathB = {}
    for _ = 1, 1000 do
        objA = m.getParentBlock(objA)
        pathA[#pathA+1] = objA
        if (not sameFunction and objA.type == 'function') or objA.type == 'main' then
            break
        end
    end
    for _ = 1, 1000 do
        objB = m.getParentBlock(objB)
        pathB[#pathB+1] = objB
        if (not sameFunction and objA.type == 'function') or objB.type == 'main' then
            break
        end
    end
    -- pathA: {1, 2, 3, 4, 5}
    -- pathB: {5, 6, 2, 3}
    local top = #pathB
    local start
    for i = #pathA, 1, -1 do
        local currentBlock = pathA[i]
        if currentBlock == pathB[top] then
            start = i
            break
        end
    end
    if not start then
        return nil
    end
    -- pathA: {   1, 2, 3}
    -- pathB: {5, 6, 2, 3}
    local extra = 0
    local align = top - start
    for i = start, 1, -1 do
        local currentA = pathA[i]
        local currentB = pathB[i+align]
        if currentA ~= currentB then
            extra = i
            break
        end
    end
    -- pathA: {1}
    local resultA = {}
    for i = extra, 1, -1 do
        resultA[#resultA+1] = pathA[i]
    end
    -- pathB: {5, 6}
    local resultB = {}
    for i = extra + align, 1, -1 do
        resultB[#resultB+1] = pathB[i]
    end
    return mode, resultA, resultB
end

-- 根据语法，单步搜索定义
local function stepRefOfLocal(loc)
    local results = { loc }
    local refs = loc.ref
    if not refs then
        return results
    end
    for i = 1, #refs do
        local ref = refs[i]
        results[#results+1] = ref
    end
    return results
end
local function stepRefOfLabel(label)
    local results = { label }
    local refs = label.ref
    for i = 1, #refs do
        local ref = refs[i]
        results[#results+1] = ref
    end
    return results
end
local function stepRefOfGlobal(obj)
    local results = {}
    local name = m.getKeyName(obj)
    local refs = obj.node.ref
    for i = 1, #refs do
        local ref = refs[i]
        if m.getKeyName(ref) == name then
            results[#results+1] = ref
        end
    end
    return results
end
function m.getStepRef(obj)
    if obj.type == 'getlocal'
    or obj.type == 'setlocal' then
        return stepRefOfLocal(obj.node)
    end
    if obj.type == 'local' then
        return stepRefOfLocal(obj)
    end
    if obj.type == 'label' then
        return stepRefOfLabel(obj)
    end
    if obj.type == 'goto' then
        return stepRefOfLabel(obj.node)
    end
    if obj.type == 'getglobal'
    or obj.type == 'setglobal' then
        return stepRefOfGlobal(obj)
    end
end

-- 根据语法，单步搜索field
local function stepFieldOfLocal(loc)
    local results = {}
    local refs = loc.ref
    for i = 1, #refs do
        local ref = refs[i]
        if ref.type == 'setglobal'
        or ref.type == 'getglobal' then
            results[#results+1] = ref
        elseif ref.type == 'getlocal' then
            local nxt = ref.next
            if nxt then
                if nxt.type == 'setfield'
                or nxt.type == 'getfield'
                or nxt.type == 'setmethod'
                or nxt.type == 'getmethod'
                or nxt.type == 'setindex'
                or nxt.type == 'getindex' then
                    results[#results+1] = nxt
                end
            end
        end
    end
    return results
end
local function stepFieldOfTable(tbl)
    local result = {}
    for i = 1, #tbl do
        result[i] = tbl[i]
    end
    return result
end
function m.getStepField(obj)
    if obj.type == 'getlocal'
    or obj.type == 'setlocal' then
        return stepFieldOfLocal(obj.node)
    end
    if obj.type == 'local' then
        return stepFieldOfLocal(obj)
    end
    if obj.type == 'table' then
        return stepFieldOfTable(obj)
    end
end

-- 搜索 `a.b.c` 的等价表达式
local function buildSimpleList(obj)
    local list = {}
    local cur = obj
    for i = 1, 11 do
        if i == 11 then
            return nil
        end
        if cur.type == 'setfield'
        or cur.type == 'getfield'
        or cur.type == 'setmethod'
        or cur.type == 'getmethod'
        or cur.type == 'setindex'
        or cur.type == 'getindex' then
            list[i] = cur
            cur = cur.node
        elseif cur.type == 'tablefield'
        or     cur.type == 'tableindex' then
            list[i] = cur
            cur = cur.parent.parent
        elseif cur.type == 'getglobal'
        or     cur.type == 'setglobal'
        or     cur.type == 'getlocal'
        or     cur.type == 'setlocal'
        or     cur.type == 'local' then
            list[i] = cur
            break
        elseif cur.type == 'function'
        or     cur.type == 'main' then
            break
        else
            return nil
        end
    end
    return util.revertTable(list)
end
function m.getSimple(obj)
    local simpleList
    if obj.type == 'getfield'
    or obj.type == 'setfield'
    or obj.type == 'getmethod'
    or obj.type == 'setmethod'
    or obj.type == 'getindex'
    or obj.type == 'setindex'
    or obj.type == 'tableindex' then
        simpleList = buildSimpleList(obj)
    elseif obj.type == 'field'
    or     obj.type == 'method' then
        simpleList = buildSimpleList(obj.parent)
    end
    return simpleList
end

function m.frame(parentFrame)
    local frame = {
        cache = parentFrame and parentFrame.cache or {},
        depth = parentFrame and parentFrame.depth or 0,
        results = {},
    }
    return frame
end

function m.isSameField(a, b)
    return m.getKeyName(a) == m.getKeyName(b)
end

function m.checkAsNextRef(sim, ref)
    local nextRef = ref.next
    if not nextRef then
        return nil
    end
    if nextRef.type == 'setfield'
    or nextRef.type == 'getfield'
    or nextRef.type == 'setmethod'
    or nextRef.type == 'getmethod'
    or nextRef.type == 'setindex'
    or nextRef.type == 'getindex' then
        if m.isSameField(sim, nextRef) then
            return nextRef
        end
    end
    return nil
end

function m.checkAsTableField(sim, ref)
    local value = ref.value
    if not value then
        return nil
    end
    if value.type == 'table' then
        for i = 1, #value do
            local field = value[i]
            if m.isSameField(sim, field) then
                return field
            end
        end
    end
    return nil
end

function m.searchSameFields(frame, simple)
    local fristFrame = m.frame(frame)
    m.searchRefOfFields(fristFrame, simple[1])
    for _, ref in ipairs(fristFrame.results) do
        for x = 2, #simple do
            ref =  m.checkAsNextRef(simple[x], ref)
                or m.checkAsTableField(simple[x], ref)
            if not ref then
                goto NEXT_REF
            end
        end
        if     ref.type == 'setfield'
        or     ref.type == 'getfield'
        or     ref.type == 'tablefield' then
            frame.results[#frame.results+1] = ref.field
        elseif ref.type == 'setmethod'
        or     ref.type == 'getmethod' then
            frame.results[#frame.results+1] = ref.method
        elseif ref.type == 'setindex'
        or     ref.type == 'getindex'
        or     ref.type == 'tableindex' then
            frame.results[#frame.results+1] = ref.index
        else
            frame.results[#frame.results+1] = ref
        end
        ::NEXT_REF::
    end
end

function m.searchRefOfFunctionReturn(frame, obj)
    -- 只有 function 才搜索返回值引用
    if obj.type ~= 'function' then
        return
    end
    frame.results[#frame.results+1] = obj
    -- 搜索所在函数
    local currentFunc = m.getParentFunction(obj)
    local returns = currentFunc.returns
    if not returns then
        return
    end
    -- 看看他是第几个返回值
    local index
    for i = 1, #returns do
        local rtn = returns[i]
        if m.isContain(rtn, obj.start) then
            for j = 1, #rtn do
                if obj == rtn[j] then
                    index = j
                    goto BREAK
                end
            end
        end
    end
    ::BREAK::
    if not index then
        return
    end
    -- 搜索所有所在函数的调用者
    local funcRefs = m.frame(frame)
    m.searchRefOfValue(funcRefs, currentFunc)

    if #funcRefs.results == 0 then
        return
    end
    local calls = {}
    for _, res in ipairs(funcRefs.results) do
        local call = res.parent
        if call.type == 'call' then
            calls[#calls+1] = call
        end
    end
    -- 搜索调用者的返回值
    if #calls == 0 then
        return
    end
    local selects = {}
    for i = 1, #calls do
        local parent = calls[i].parent
        if parent.type == 'select' and parent.index == index then
            selects[#selects+1] = parent.parent
        end
        local extParent = calls[i].extParent
        if extParent then
            for j = 1, #extParent do
                local ext = extParent[j]
                if ext.type == 'select' and ext.index == index then
                    selects[#selects+1] = ext.parent
                end
            end
        end
    end
    -- 搜索调用者的引用
    for i = 1, #selects do
        m.searchRefOfFields(frame, selects[i])
    end
end

function m.getIndexOfLiteral(obj)
    if obj.type == 'nil'
    or obj.type == 'number'
    or obj.type == 'integer'
    or obj.type == 'boolean'
    or obj.type == 'string' then
        local parent = obj.parent
        if parent.type == 'tableindex'
        or parent.type == 'setindex'
        or parent.type == 'getindex' then
            return parent
        end
    end
    return obj
end

function m.searchRefOfFields(frame, obj)
    frame.depth = frame.depth + 1

    obj = m.getIndexOfLiteral(obj)

    -- 1. 检查单步引用
    local res = m.getStepRef(obj)
    if res then
        for i = 1, #res do
            frame.results[#frame.results+1] = res[i]
        end
    end
    -- 2. 检查simple
    if frame.depth <= 5 then
        local simple = m.getSimple(obj)
        if simple then
            m.searchSameFields(frame, simple)
        end
    end

    frame.depth = frame.depth - 1
end

function m.searchRefOfValue(frame, obj, results)
    local var = obj.parent
    if var.type == 'local'
    or var.type == 'set' then
        return m.searchRefOfFields(frame, var)
    end
end

function m.requestReference(obj)
    local frame = m.frame()
    -- 根据 field 搜索引用
    m.searchRefOfFields(frame, obj)

    -- 搜索函数返回值的引用
    m.searchRefOfFunctionReturn(frame, obj)

    return frame.results
end

return m

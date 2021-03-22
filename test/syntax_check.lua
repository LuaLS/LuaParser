local parser = require 'parser'

local EXISTS = {}

local function eq(a, b)
    if a == EXISTS and b ~= nil then
        return true
    end
    local tp1, tp2 = type(a), type(b)
    if tp1 ~= tp2 then
        return false
    end
    if tp1 == 'table' then
        local mark = {}
        for k in pairs(a) do
            if not eq(a[k], b[k]) then
                return false
            end
            mark[k] = true
        end
        for k in pairs(b) do
            if not mark[k] then
                return false
            end
        end
        return true
    end
    return a == b
end

local function catchTarget(script, sep)
    local list = {}
    local cur = 1
    local cut = 0
    while true do
        local start, finish  = script:find(('<%%%s.-%%%s>'):format(sep, sep), cur)
        if not start then
            break
        end
        list[#list+1] = { start - cut, math.max(start - cut, finish - 4 - cut) }
        cur = finish + 1
        cut = cut + 4
    end
    local new_script = script:gsub(('<%%%s(.-)%%%s>'):format(sep, sep), '%1')
    return new_script, list
end

local Version

local function TEST(script)
    return function (expect)
        local newScript, list = catchTarget(script, '!')
        local ast, err = parser:compile(newScript, 'lua', Version)
        assert(ast)
        local errs = ast.errs
        local first = errs[1]
        local target = list[1]
        if not expect then
            assert(#errs == 0)
            return
        end
        if expect.multi then
            assert(#errs > 1)
            first = errs[expect.multi]
        else
            assert(#errs == 1)
        end
        assert(first)
        assert(first.type == expect.type)
        assert(first.start == target[1])
        assert(first.finish == target[2])
        assert(eq(first.version, expect.version))
        assert(eq(first.info, expect.info))
    end
end

TEST[[
function f()
    return <!...!>
end
]]
{
    type = 'UNEXPECT_DOTS',
}

TEST[[
function f(...)
    return function ()
        return <!...!>
    end
end
]]
{
    type = 'UNEXPECT_DOTS',
}

TEST[[
function f(...)
    return ...
end
]]
(nil)

TEST[[
for i = 1, 10 do
    break
end
]]
(nil)

TEST[[
for k, v in pairs(t) do
    break
end
]]
(nil)

TEST[[
while true do
    break
end
]]
(nil)

TEST[[
repeat
    break
until true
]]
(nil)

TEST[[
<!break!>
]]
{
    type = 'BREAK_OUTSIDE',
}

TEST[[
function f (x)
    if 1 then <!break!> end
end
]]
{
    type = 'BREAK_OUTSIDE',
}

TEST[[
while 1 do
end
<!break!>
]]
{
    type = 'BREAK_OUTSIDE',
}

TEST[[
while 1 do
    local function f()
        <!break!>
    end
end
]]
{
    type = 'BREAK_OUTSIDE',
}

TEST[[
:: label :: <!return
goto!> label
]]
{
    type = 'ACTION_AFTER_RETURN',
    multi = 3,
}

TEST[[
::label::
goto label
]]
(nil)

TEST[[
goto label
::label::
]]
(nil)

TEST[[
do
    goto label
end
::label::
]]
(nil)

TEST[[
::label::
do
    goto label
end
]]
(nil)

TEST[[
goto label
local x = 1
x = 2
::label::
]]
(nil)

TEST[[
local x = 1
goto label
x = 2
::label::
print(x)
]]
(nil)

TEST[[
local x = 1
::label::
print(x)
local x
goto label
]]
(nil)

TEST[[
goto <!label!>
]]
{
    type = 'NO_VISIBLE_LABEL',
    info = {
        label = 'label',
    }
}

TEST[[
::other_label::
do do do goto <!label!> end end end
]]
{
    type = 'NO_VISIBLE_LABEL',
    info = {
        label = 'label',
    }
}

TEST[[
goto <!label!>
do
    ::label::
end
]]
{
    type = 'NO_VISIBLE_LABEL',
    info = {
        label = 'label',
    }
}

TEST[[
goto <!label!>
local x = 1
::label::
x = 2
]]
{
    type = 'JUMP_LOCAL_SCOPE',
    info = {
        loc = 'x',
    },
    relative = {
        {
            start = 26,
            finish = 30,
        },
        {
            start = 18,
            finish = 18,
        },
    }
}

TEST[[
goto <!label!>
local x = 1
::label::
return x
]]
{
    type = 'JUMP_LOCAL_SCOPE',
    info = {
        loc = 'x',
    },
    relative = {
        {
            start = 26,
            finish = 30,
        },
        {
            start = 18,
            finish = 18,
        },
    }
}

TEST[[
::label::
::other_label::
::<!label!>::
]]
{
    type = 'REDEFINED_LABEL',
    related = {
        {
            start  = 3,
            finish = 7,
        },
    }
}

Version = 'Lua 5.4'
TEST[[
::label::
::other_label::
if true then
    ::<!label!>::
end
]]
{
    type = 'REDEFINED_LABEL',
    related = {
        {
            start  = 3,
            finish = 7,
        },
    }
}

TEST[[
if true then
    ::label::
end
::label::
]]
(nil)

Version = 'Lua 5.3'
TEST[[
::label::
::other_label::
if true then
    ::label::
end
]]
(nil)

TEST[[
if true then
    ::label::
end
::label::
]]
(nil)

Version = 'Lua 5.4'
TEST[[
local x <const> = 1
<!x!> = 2
]]
{
    type = 'SET_CONST',
}

TEST[[
local x <close> = 1
<!x!> = 2
]]
{
    type = 'SET_CONST',
}

TEST [[
return function () local l1, l2, l3, l4, l5, l6, l7, l8, l9, l10, l11, l12, l13, l14, l15, l16, l17, l18, l19, l20, l21, l22, l23, l24, l25, l26, l27, l28, l29, l30, l31, l32, l33, l34, l35, l36, l37, l38, l39, l40, l41, l42, l43, l44, l45, l46, l47, l48, l49, l50, l51, l52, l53, l54, l55, l56, l57, l58, l59, l60, l61, l62, l63, l64, l65, l66, l67, l68, l69, l70, l71, l72, l73, l74, l75, l76, l77, l78, l79, l80, l81, l82, l83, l84, l85, l86, l87, l88, l89, l90, l91, l92, l93, l94, l95, l96, l97, l98, l99, l100, l101, l102, l103, l104, l105, l106, l107, l108, l109, l110, l111, l112, l113, l114, l115, l116, l117, l118, l119, l120, l121, l122, l123, l124, l125, l126, l127, l128, l129, l130, l131, l132, l133, l134, l135, l136, l137, l138, l139, l140, l141, l142, l143, l144, l145, l146, l147, l148, l149, l150, l151, l152, l153, l154, l155, l156, l157, l158, l159, l160, l161, l162, l163, l164, l165, l166, l167, l168, l169, l170, l171, l172, l173, l174, l175, l176, l177, l178, l179, l180, l181, l182, l183, l184, l185, l186, l187, l188, l189, l190, l191, l192, l193, l194, l195, l196, l197, l198, l199, l200, <!l201!>, <!l202!> end
]]
{
    multi = 1,
    type = 'LOCAL_LIMIT',
}

TEST [[
local l1, l2, l3, l4, l5, l6, l7, l8, l9, l10, l11, l12, l13, l14, l15, l16, l17, l18, l19, l20, l21, l22, l23, l24, l25, l26, l27, l28, l29, l30, l31, l32, l33, l34, l35, l36, l37, l38, l39, l40, l41, l42, l43, l44, l45, l46, l47, l48, l49, l50, l51, l52, l53, l54, l55, l56, l57, l58, l59, l60, l61, l62, l63, l64, l65, l66, l67, l68, l69, l70, l71, l72, l73, l74, l75, l76, l77, l78, l79, l80, l81, l82, l83, l84, l85, l86, l87, l88, l89, l90, l91, l92, l93, l94, l95, l96, l97, l98, l99, l100, l101, l102, l103, l104, l105, l106, l107, l108, l109, l110, l111, l112, l113, l114, l115, l116, l117, l118, l119, l120, l121, l122, l123, l124, l125, l126, l127, l128, l129, l130, l131, l132, l133, l134, l135, l136, l137, l138, l139, l140, l141, l142, l143, l144, l145, l146, l147, l148, l149, l150, l151, l152, l153, l154, l155, l156, l157, l158, l159, l160, l161, l162, l163, l164, l165, l166, l167, l168, l169, l170, l171, l172, l173, l174, l175, l176, l177, l178, l179, l180, l181, l182, l183, l184, l185, l186, l187, l188, l189, l190, l191, l192, l193, l194, l195, l196, l197, l198, l199, l200, <!l201!>, <!l202!>
]]
{
    multi = 1,
    type = 'LOCAL_LIMIT',
}

TEST [[
return function (l1, l2, l3, l4, l5, l6, l7, l8, l9, l10, l11, l12, l13, l14, l15, l16, l17, l18, l19, l20, l21, l22, l23, l24, l25, l26, l27, l28, l29, l30, l31, l32, l33, l34, l35, l36, l37, l38, l39, l40, l41, l42, l43, l44, l45, l46, l47, l48, l49, l50, l51, l52, l53, l54, l55, l56, l57, l58, l59, l60, l61, l62, l63, l64, l65, l66, l67, l68, l69, l70, l71, l72, l73, l74, l75, l76, l77, l78, l79, l80, l81, l82, l83, l84, l85, l86, l87, l88, l89, l90, l91, l92, l93, l94, l95, l96, l97, l98, l99, l100, l101, l102, l103, l104, l105, l106, l107, l108, l109, l110, l111, l112, l113, l114, l115, l116, l117, l118, l119, l120, l121, l122, l123, l124, l125, l126, l127, l128, l129, l130, l131, l132, l133, l134, l135, l136, l137, l138, l139, l140, l141, l142, l143, l144, l145, l146, l147, l148, l149, l150, l151, l152, l153, l154, l155, l156, l157, l158, l159, l160, l161, l162, l163, l164, l165, l166, l167, l168, l169, l170, l171, l172, l173, l174, l175, l176, l177, l178, l179, l180, l181, l182, l183, l184, l185, l186, l187, l188, l189, l190, l191, l192, l193, l194, l195, l196, l197, l198, l199, l200, <!l201!>, <!l202!>) end
]]
{
    multi = 1,
    type = 'LOCAL_LIMIT',
}

TEST [[
return function (l1, l2, l3, l4, l5, l6, l7, l8, l9, l10, l11, l12, l13, l14, l15, l16, l17, l18, l19, l20, l21, l22, l23, l24, l25, l26, l27, l28, l29, l30, l31, l32, l33, l34, l35, l36, l37, l38, l39, l40, l41, l42, l43, l44, l45, l46, l47, l48, l49, l50, l51, l52, l53, l54, l55, l56, l57, l58, l59, l60, l61, l62, l63, l64, l65, l66, l67, l68, l69, l70, l71, l72, l73, l74, l75, l76, l77, l78, l79, l80, l81, l82, l83, l84, l85, l86, l87, l88, l89, l90, l91, l92, l93, l94, l95, l96, l97, l98, l99, l100, l101, l102, l103, l104, l105, l106, l107, l108, l109, l110, l111, l112, l113, l114, l115, l116, l117, l118, l119, l120, l121, l122, l123, l124, l125, l126, l127, l128, l129, l130, l131, l132, l133, l134, l135, l136, l137, l138, l139, l140, l141, l142, l143, l144, l145, l146, l147, l148, l149, l150, l151, l152, l153, l154, l155, l156, l157, l158, l159, l160, l161, l162, l163, l164, l165, l166, l167, l168, l169, l170, l171, l172, l173, l174, l175, l176, l177, l178, l179, l180, l181, l182, l183, l184, l185, l186, l187, l188, l189, l190, l191, l192, l193, l194, l195, l196, l197, l198, l199)
    do
        local x
    end
    local x
    do
        local <!x!>
    end
end
]]
{
    type = 'LOCAL_LIMIT',
}

TEST [[
local x <const<!>=!> 1
]]
{
    type = 'MISS_SPACE_BETWEEN',
}

TEST [[
function mt<!['']!>() end
]]
{
    type = 'INDEX_IN_FUNC_NAME'
}

TEST [[
function mt<![]!>() end
]]
{
    multi = 2,
    type  = 'INDEX_IN_FUNC_NAME'
}

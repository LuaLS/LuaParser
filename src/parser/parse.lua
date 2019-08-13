local ast = require 'parser.ast'

local Errs
local State
local Asts

local function pushError(err)
    if err.finish < err.start then
        err.finish = err.start
    end
    local last = Errs[#Errs]
    if last then
        if last.start <= err.start and last.finish >= err.finish then
            return
        end
    end
    err.level = err.level or 'error'
    Errs[#Errs+1] = err
    return err
end

local function pushAst(ast)
    local n = #Asts + 1
    Asts[n] = ast
    return n
end

local function getAst(n)
    return Asts[n]
end

return function (self, lua, mode, version)
    Errs  = {}
    Asts  = {}
    State = {
        Break = 0,
        Label = {{}},
        Dots = {true},
        Version = version,
        Lua = lua,
        Emmy = {},
        Ast = Asts,
        pushError = pushError,
        pushAst = pushAst,
        getAst = getAst,
    }
    ast.init(State)
    local suc, res, err = xpcall(self.grammar, debug.traceback, self, lua, mode)
    if not suc then
        return nil, res
    end
    if not res then
        pushError(err)
        return nil, Errs
    end
    return State, Errs
end

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

return function (self, lua, mode, version)
    Errs  = {}
    Asts  = {}
    State = {
        version = version,
        lua = lua,
        emmy = {},
        ast = Asts,
        pushError = pushError,
        ref = {},
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

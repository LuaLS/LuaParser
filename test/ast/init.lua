---@param result any
---@param expect any
function Match(result, expect)
    for k, v in pairs(expect) do
        if type(v) == 'table' then
            Match(result[k], v)
        else
            assert(result[k] == v)
        end
    end
end

require 'parser'

require 'test.ast.nil'
require 'test.ast.boolean'
require 'test.ast.string'
require 'test.ast.number'
require 'test.ast.comment'
require 'test.ast.local'

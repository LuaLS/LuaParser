local fs = require 'bee.filesystem'

function io.load(file_path)
	local f, e = io.open(file_path:string(), 'rb')
	if not f then
		return nil, e
	end
	local buf = f:read 'a'
	f:close()
	return buf
end

function io.save(file_path, content)
	local f, e = io.open(file_path:string(), "wb")

	if f then
		f:write(content)
		f:close()
		return true
	else
		return false, e
	end
end

function io.scan(path)
	local result = {path}
	local i = 0
	return function ()
		i = i + 1
		local current = result[i]
		if not current then
			return nil
		end
		if fs.is_directory(current) then
			for path in current:list_directory() do
				result[#result+1] = path
			end
		end
		return current
	end
end

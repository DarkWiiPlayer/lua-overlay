--- Recursive table overlaying
-- @module overlay

local overlay = {}

--- Deep-indexes a single table/object with a list of keys
-- @param target Table or indexable object
-- @param ... List of keys to recursively index with
local function deep(target, key, ...)
	local value = target[key]
	if value then
		if (...) then
			return deep(value, ...)
		else
			return value
		end
	end
end

--- Deep-indexes into the overlay stack and returns the first value it finds
-- @param ... List of keys
function overlay:get(...)
	for _, value in ipairs(self) do
		local result = deep(value, ...)
		if result then
			return result
		end
	end
end

function overlay:pget(...)
	return self:xpget(nil, ...)
end

function overlay:xpget(handler, ...)
	for _, value in ipairs(self) do
		local success, result = pcall(deep, value, ...)
		if success and result then
			return result
		elseif not success and handler then
			handler(result)
		end
	end
end

--- Creates a new overlay proxy
-- @param ... List of tables to try in order
function overlay:new(...)
	return setmetatable({...}, self)
end

overlay.__index = overlay
return setmetatable(overlay, { __call = overlay.new })

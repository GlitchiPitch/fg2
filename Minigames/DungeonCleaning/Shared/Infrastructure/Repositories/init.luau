---@class SharedDungeonCleaningRepositories
local Repositories = {}
Repositories.__index = Repositories

---@return SharedDungeonCleaningRepositories
function Repositories.new()
	local self = setmetatable({}, Repositories)
	return self
end

return Repositories
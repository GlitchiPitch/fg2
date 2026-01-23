---@class ServerUseCases
---@field diContainer DIContainer
local UseCases = {}
UseCases.__index = UseCases

---@return ServerUseCases
function UseCases.new(diContainer)
	local self = setmetatable({}, UseCases)
	self.diContainer = diContainer
	return self
end

function UseCases:init()
end

return UseCases

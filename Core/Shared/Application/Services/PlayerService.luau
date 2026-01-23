local Players = game:GetService("Players")

---@class SharedPlayerService
---@field diContainer DIContainer
---@field playerRepository SharedPlayerRepository
local PlayerService = {}
PlayerService.__index = PlayerService

---@param diContainer DIContainer
---@return SharedPlayerService
function PlayerService.new(diContainer)
	local self = setmetatable({}, PlayerService)
	self.diContainer = diContainer
	return self
end

function PlayerService:init()
	---@type ServerInfrastructure : ClientInfrastructure
	local infrastructure = self.diContainer:resolve("Infrastructure")
	self.playerRepository = infrastructure.repositories.playerRepository

	Players.PlayerAdded:Connect(function(player)
		self:onPlayerAdded({ player = player })
	end)

	Players.PlayerRemoving:Connect(function(player)
		self:onPlayerRemoving({ player = player })
	end)
end

---@param data table
function PlayerService:onPlayerAdded(data)
	error("Not implemented")
end

---@param data table
function PlayerService:onPlayerRemoving(data)
	error("Not implemented")
end

---@param data table
function PlayerService:updatePlayer(data)
	error("Not implemented")
end

---@param data table
function PlayerService:onCharacterAdded(data)
	error("Not implemented")
end

---@param data table
function PlayerService:onCharacterRemoving(data)
	error("Not implemented")
end

return PlayerService
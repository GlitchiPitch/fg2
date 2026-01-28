local Players = game:GetService("Players")
---@class ServerFoodEatingChairService
---@field diContainer DIContainer
---@field chairRepository ServerFoodEatingChairRepository
---@field eventBus EventBus
---@field constants SharedFoodEatingConstants
---@field application ServerFoodEatingApp
local ChairService = {}
ChairService.__index = ChairService

---@param diContainer DIContainer
---@return ServerFoodEatingChairService
function ChairService.new(diContainer)
	local self = setmetatable({}, ChairService)
	self.diContainer = diContainer
	self.chairs = {}
	return self
end

function ChairService:init()
	---@type ServerFoodEatingInfrastructure
	local infrastructure = self.diContainer:resolve("Infrastructure")
	self.chairRepository = infrastructure.repositories.chairRepository
	---@type SharedFoodEating
	local shared = self.diContainer:resolve("Shared")
	self.constants = shared.constants
	self.eventBus = shared.eventBus

	self.application = self.diContainer:resolve("Application")

	self.chairs = workspace.Workspace.Maps.FoodEating.Chairs:GetChildren()
	self:_setup()
end

function ChairService:_setup()
	for _, chair in self.chairs do
		local chairEntity = self.chairRepository:createChairEntity(chair)
		chairEntity:setup({
			occupiedCallback = function(humanoid)
				local player = Players:GetPlayerFromCharacter(humanoid.Parent)
				if not player then
					return
				end
				
				chairEntity.occupant = player
				chairEntity.occupantId = player.UserId
				self:_onChairOccupied(player, chairEntity.cameraPart.CFrame)
				self.application:start()
			end,
			unoccupiedCallback = function()
				local player = chairEntity.occupant or Players:GetPlayerByUserId(chairEntity.occupantId)
				
				chairEntity.occupant = nil
				chairEntity.occupantId = nil
				self:_onChairUnoccupied(player)
				self.application:stop()
			end,
		})
	end
end

---@param player Player
function ChairService:_onChairOccupied(player, cameraCFrame)
	self.eventBus:fire(
		self.constants.SERVER_EVENTS.PLAYER_JOINED_FOOD_EATING,
		{ player = player, cameraCFrame = cameraCFrame }
	)
end

---@param player Player
function ChairService:_onChairUnoccupied(player)
	if not player then
		return
	end

	self.eventBus:fire(self.constants.SERVER_EVENTS.PLAYER_LEFT_FOOD_EATING, { player = player })
end

return ChairService

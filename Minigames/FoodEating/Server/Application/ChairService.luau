local Players = game:GetService("Players")
---@class ServerFoodEatingChairService
---@field diContainer DIContainer
---@field chairRepository ServerFoodEatingChairRepository
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

	self.chairs = workspace.Workspace.Maps.FoodEating.Chairs:GetChildren()
	self:_setup()
end

function ChairService:_setup()
	for _, chair in self.chairs do
		self.chairs[chair.Name] = self.chairRepository:createChairEntity(chair)
		self.chairs[chair.Name]:setup({
			occupiedCallback = function(occupantId)
				local player = Players:GetPlayerByUserId(occupantId)
				if not player then
					return
				end

				self:_onChairOccupied(player)
			end,
			unoccupiedCallback = function(occupantId)
				local player = Players:GetPlayerByUserId(occupantId)
				if not player then
					return
				end
				self:_onChairUnoccupied(player)
			end,
		})
	end
end

---@param player Player
function ChairService:_onChairOccupied(player)
	self.eventBus:fire(self.constants.SERVER_EVENTS.PLAYER_JOINED_FOOD_EATING, { player = player })
end

---@param player Player
function ChairService:_onChairUnoccupied(player)
	if not player then
		return
	end

	self.eventBus:fire(self.constants.SERVER_EVENTS.PLAYER_LEFT_FOOD_EATING, { player = player })
end
return ChairService

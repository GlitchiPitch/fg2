local Players = game:GetService("Players")
---@class ServerFoodEatingChairService
---@field diContainer DIContainer
---@field chairRepository ServerFoodEatingChairRepository
---@field playerRepository ServerFoodEatingPlayerRepository
---@field eventBus EventBus
---@field constants SharedFoodEatingConstants
---@field application ServerFoodEatingApp
---@field coreConstants SharedConstants
---@field coreEventBus EventBus
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
	self.playerRepository = infrastructure.repositories.playerRepository
	---@type SharedFoodEating
	local shared = self.diContainer:resolve("Shared")
	self.constants = shared.constants
	self.eventBus = shared.eventBus

	---@type Shared
	local coreShared = self.diContainer:resolve("CoreShared")
	self.coreConstants = coreShared.constants
	self.coreEventBus = coreShared.eventBus

	self.application = self.diContainer:resolve("Application")

	self.chairs = workspace.Workspace.Maps.FoodEating.Chairs:GetChildren()

	self:_setup()
	self:_setupEventListeners()
end

function ChairService:_setupEventListeners()
	self.eventBus:connectToEvents({
		[self.constants.SERVER_EVENTS.GAME_FINISHED] = function()
			self:_onGameFinished()
		end,
	})
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

function ChairService:_onGameFinished()
	local chairEntities = self.chairRepository:getChairs()
	local playerResults = {}
	---@param chair ChairEntity
	for _, chair in chairEntities do
		local player = chair.occupant
		if player then
			local playerEntity = self.playerRepository:getPlayerEntity(player)
			table.insert(playerResults, {
				player = player,
				score = playerEntity.score and playerEntity.score.value or 0,
			})
		end

		chair:clear()
	end

	table.sort(playerResults, function(a, b)
		return a.score > b.score
	end)

	self.coreEventBus:fire(self.coreConstants.SERVER_EVENTS.SHOW_GAME_RESULT, {
		gameName = self.coreConstants.MINIGAMES.FOOD_EATING,
		playerResults = playerResults,
	})
end

return ChairService

local RunService = game:GetService("RunService")
local Players = game:GetService("Players")

---@class ServerDungeonCleaningEnemyService
local EnemyService = {}
EnemyService.__index = EnemyService

---@param diContainer DIContainer
---@return ServerDungeonCleaningEnemyService
function EnemyService.new(diContainer)
	local self = setmetatable({}, EnemyService)
	self.diContainer = diContainer
	self.config = {
		enemyCount = 10,
	}
	self.spawnedEnemies = {}
	self.aiUpdateConnection = nil
	return self
end

function EnemyService:init()
	---@type ServerDungeonCleaningInfrastructure
	local infrastructure = self.diContainer:resolve("Infrastructure")
	self.enemyRepository = infrastructure.repositories.enemyRepository
	---@type SharedDungeonCleaning
	local shared = self.diContainer:resolve("Shared")
	self.eventBus = shared.eventBus
	self.constants = shared.constants
	---@type DungeonCleaningServerApp
	local application = self.diContainer:resolve("Application")
	self.playerService = application.services.playerService

	self.lootService = application.services.lootService

	self.dungeonMap = workspace.Workspace.Maps.DungeonCleaning
	self.enemiesFolder = self.dungeonMap.Enemies

	self:_setupEventListeners()
end

function EnemyService:_setupEventListeners()
	self.eventBus:connectToEvents({
		[self.constants.SERVER_EVENTS.ENEMY_ATTACKED] = function(data)
			self:onEnemyAttacked(data)
		end,
	})
end

function EnemyService:onEnemyAttacked(data)
	warn("onEnemyAttacked", data)
	local enemyEntity = self.enemyRepository:getEnemyEntity(data.enemyId)
	if enemyEntity then
		self.lootService:_dropFromCharacter(enemyEntity.model)
		enemyEntity:destroy()
	end
	
end

function EnemyService:start()
	self:spawnEnemy()
	self:startAIUpdateLoop()
end

function EnemyService:spawnEnemy()
	for _, spawnPoint in self.enemiesFolder.SpawnPoints:GetChildren() do
		for _ = 1, self.config.enemyCount do
			local enemyEntity = self.enemyRepository:createEnemyEntity("Alien")
			enemyEntity:spawn(self.enemiesFolder.Cache, self:_getSpawnPosition(spawnPoint))
			table.insert(self.spawnedEnemies, enemyEntity)
		end
	end
end

---@param spawnPoint Part
---@return Vector3
function EnemyService:_getSpawnPosition(spawnPoint) 
	local size = spawnPoint.Size
	local position = spawnPoint.Position

	local x = position.X + (math.random() - 0.5) * size.X
	local y = position.Y
	local z = position.Z + (math.random() - 0.5) * size.Z

	return Vector3.new(x, y, z)
end

---@param enemyEntity EnemyEntity
---@return Model?
function EnemyService:_findNearestPlayer(enemyEntity)
	local enemyRoot = enemyEntity.model:FindFirstChild("HumanoidRootPart")
	if not enemyRoot then
		return nil
	end
	
	if not self.playerService or not self.playerService.playerRepository then
		return nil
	end
	
	local players = self.playerService.playerRepository:getPlayers()
	local nearestPlayer = nil
	local nearestDistance = math.huge
	
	for _, playerEntity in pairs(players) do
		local player = playerEntity.player
		if player and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
			local humanoid = player.Character:FindFirstChildOfClass("Humanoid")
			if humanoid and humanoid.Health > 0 then
				local distance = (player.Character.HumanoidRootPart.Position - enemyRoot.Position).Magnitude
				if distance < nearestDistance then
					nearestDistance = distance
					nearestPlayer = player.Character
				end
			end
		end
	end
	
	return nearestPlayer
end

function EnemyService:startAIUpdateLoop()
	if self.aiUpdateConnection then
		return
	end
	
	self.aiUpdateConnection = RunService.Heartbeat:Connect(function()
		-- Clean up destroyed enemies
		for i = #self.spawnedEnemies, 1, -1 do
			local enemyEntity = self.spawnedEnemies[i]
			if not enemyEntity.model or not enemyEntity.model.Parent then
				table.remove(self.spawnedEnemies, i)
				self.enemyRepository:removeEnemyEntity(enemyEntity.id)
			end
		end
		
		-- Update AI for each enemy
		for _, enemyEntity in ipairs(self.spawnedEnemies) do
			local nearestPlayer = self:_findNearestPlayer(enemyEntity)
			enemyEntity:updateAI(nearestPlayer)
		end
	end)
end

function EnemyService:stopAIUpdateLoop()
	if self.aiUpdateConnection then
		self.aiUpdateConnection:Disconnect()
		self.aiUpdateConnection = nil
	end
end

function EnemyService:destroy()
	self:stopAIUpdateLoop()
	
	for _, enemyEntity in ipairs(self.spawnedEnemies) do
		enemyEntity:destroy()
	end
	
	self.spawnedEnemies = {}
end

return EnemyService

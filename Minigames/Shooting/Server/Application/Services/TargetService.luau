---@class ServerShootingTargetService
---@field diContainer DIContainer
---@field itemsRepository SharedShootingItemsRepository
---@field constants SharedConstants
---@field eventBus EventBus
---@field _spawners table<string, Part[]>

local TargetService = {}
TargetService.__index = TargetService

---@param diContainer DIContainer
---@return ServerShootingTargetService
function TargetService.new(diContainer)
	local self = setmetatable({}, TargetService)
	self.diContainer = diContainer
	self._spawnedTargets = 0
	self._maxSpawnedTargets = 10
	return self
end

function TargetService:init()
	---@type SharedShooting
	local shared = self.diContainer:resolve("Shared")
	---@type ServerShootingInfrastructure
	local infrastructure = self.diContainer:resolve("Infrastructure")
	self.targetRepository = infrastructure.repositories.targetRepository
	self.constants = shared.constants
	self.eventBus = shared.eventBus

	local spawners = workspace.Workspace.Maps.Shooting.Spawners
	self._spawners = {
		flying = spawners.Flying:GetChildren(),
		ground = spawners.Ground:GetChildren(),
	}

	self.eventBus:connectToEvents({
		[self.constants.SERVER_EVENTS.SPAWN_TARGET] = function()
			if self._spawnedTargets >= self._maxSpawnedTargets then
				return
			end
			self._spawnedTargets += 1

			self:_spawnTarget()
		end,
		[self.constants.SERVER_EVENTS.TARGET_HIT] = function(data)
			self:_onTargetHit(data)
		end,
	})
end

function TargetService:_spawnTarget()
	local targetType = math.random(1, 2) == 1 and "flying" or "ground"
	local spawnerIndex = math.random(1, #self._spawners[targetType])
	local finishSpawnerIndex = if spawnerIndex == 1 then 2 else 1

	local target = self:_getRandomTarget(targetType)
	local spawner = self._spawners[targetType][spawnerIndex].Attachment
	local finishSpawner = self._spawners[targetType][finishSpawnerIndex].Attachment
	target:spawn({
		startAttachment = spawner,
		finishAttachment = finishSpawner,
	})
end

function TargetService:_getRandomTarget(targetType)
	local target = self.targetRepository:getRandomTarget(targetType)
	return target
end

---@class onTargetHitData
---@field targetId string
---@field shootedPlayer Player

---@param data onTargetHitData
function TargetService:_onTargetHit(data)
	local targetId = data.targetId
	local shootedPlayer = data.shootedPlayer
	local targetEntity = self.targetRepository:getTargetEntity(targetId)
	if not targetEntity then
		return
	end
	self.eventBus:fire(self.constants.SERVER_EVENTS.ADD_SCORE, {
		player = shootedPlayer,
		score = targetEntity.score,
	})
	targetEntity:destroy()
	self._spawnedTargets -= 1
end

return TargetService

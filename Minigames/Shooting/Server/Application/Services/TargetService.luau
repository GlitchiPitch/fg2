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
	return self
end

function TargetService:init()
	---@type ShootingShared
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

	local s = 0

	self.eventBus:connectToEvents({
		[self.constants.SERVER_EVENTS.SPAWN_TARGET] = function()
			if s > 10 then
				return
			end
			s += 1

			self:_spawnTarget()
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

return TargetService

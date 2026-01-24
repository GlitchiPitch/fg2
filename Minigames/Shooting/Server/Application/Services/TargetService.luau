---@class TargetService
---@field diContainer DIContainer
---@field itemsRepository SharedShootingItemsRepository
---@field constants SharedConstants
---@field eventBus EventBus
---@field _spawners table<string, Part[]>
local TargetService = {}
TargetService.__index = TargetService

---@param diContainer DIContainer
---@return TargetService
function TargetService.new(diContainer)
	local self = setmetatable({}, TargetService)
	self.diContainer = diContainer
	return self
end

function TargetService:init()
	---@type ShootingShared
	local shared = self.diContainer:resolve("Shared")
	self.itemsRepository = shared.infrastructure.repositories.itemsRepository
	self.constants = shared.constants
	self.eventBus = shared.eventBus

	local spawners = workspace.Workspace.Maps.Shooting.Spawners
	self._spawners = {
		flying = spawners.Flying:GetChildren(),
		ground = spawners.Ground:GetChildren(),
	}

	self.targets = {
		flying = {
			self.itemsRepository:getItemAsset("Starship"),
			self.itemsRepository:getItemAsset("BigStarship"),
		},
		ground = {
			self.itemsRepository:getItemAsset("Tank"),
			self.itemsRepository:getItemAsset("LightTank"),
		},
	}

	self.eventBus:connectToEvents({
		[self.constants.SERVER_EVENTS.SPAWN_TARGET] = function()
			self:_spawnTarget()
		end,
	})
end

function TargetService:_spawnTarget()
	local targetType = math.random(1, 2) == 1 and "flying" or "ground"
	local target = self:_getRandomTarget(targetType)
	local spawner = self._spawners[targetType]:GetChildren()[math.random(1, #self._spawners[targetType]:GetChildren())]
	target.Parent = workspace
    target:PivotTo(spawner.CFrame)
    -- self.eventBus:fire(self.constants.SERVER_EVENTS.TARGET_SPAWNED, {
    --     target = target,
    -- })
end

function TargetService:_getRandomTarget(targetType)
	return self.targets[targetType][math.random(1, #self.targets[targetType])]:Clone()
end

return TargetService

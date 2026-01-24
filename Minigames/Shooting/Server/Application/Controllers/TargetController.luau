---@class TargetController
---@field diContainer DIContainer
---@field constants SharedConstants
---@field eventBus EventBus
---@field _isActive boolean
---@field _deltaTime number
---@field _spawnInterval number
local TargetController = {}
TargetController.__index = TargetController

---@param diContainer DIContainer
---@return TargetController
function TargetController.new(diContainer)
	local self = setmetatable({}, TargetController)
	self.diContainer = diContainer
	self._isActive = false
	self._deltaTime = 0
	self._spawnInterval = 1
	return self
end

function TargetController:init()
	---@type ShootingShared
	local shared = self.diContainer:resolve("Shared")
	self.constants = shared.constants
	self.eventBus = shared.eventBus

	-- self.eventBus:connectToEvents({
	-- 	[self.constants.SERVER_EVENTS.TARGET_SPAWNED] = function(event)
	-- 		self:spawnTarget(event.target)
	-- 	end,
	-- })
end

function TargetController:update(deltaTime)
	self._deltaTime += deltaTime
	if self._deltaTime >= self._spawnInterval then
		self._deltaTime = 0
		self:_spawnTarget()
	end
end

function TargetController:start()
	self._isActive = true
end

function TargetController:_spawnTarget()
	self.eventBus:fire(self.constants.SERVER_EVENTS.SPAWN_TARGET)
end

-- function TargetController:onTargetSpawned(target)

	
-- end

return TargetController

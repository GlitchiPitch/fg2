---@class ServerShootingTargetController
---@field diContainer DIContainer
---@field constants SharedConstants
---@field eventBus EventBus
---@field _deltaTime number
---@field _spawnInterval number
local TargetController = {}
TargetController.__index = TargetController

---@param diContainer DIContainer
---@return ServerShootingTargetController
function TargetController.new(diContainer)
	local self = setmetatable({}, TargetController)
	self.diContainer = diContainer
	self._deltaTime = 0
	self._spawnInterval = 1
	return self
end

function TargetController:init()
	---@type SharedShooting
	local shared = self.diContainer:resolve("Shared")
	self.constants = shared.constants
	self.eventBus = shared.eventBus
end

function TargetController:update(deltaTime)
	self._deltaTime += deltaTime
	if self._deltaTime >= self._spawnInterval then
		self._deltaTime = 0
		self:_spawnTarget()
	end
end

function TargetController:_spawnTarget()
	self.eventBus:fire(self.constants.SERVER_EVENTS.SPAWN_TARGET)
end

return TargetController

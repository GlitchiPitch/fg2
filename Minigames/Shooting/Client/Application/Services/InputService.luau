local ContextActionService = game:GetService("ContextActionService")

---@class ShootingInputService
---@field diContainer DIContainer
---@field eventBus EventBus
---@field constants SharedConstants
local InputService = {}
InputService.__index = InputService

---@param diContainer DIContainer
---@return ShootingInputService
function InputService.new(diContainer)
	local self = setmetatable({}, InputService)
	self.diContainer = diContainer
	return self
end

function InputService:init()
	---@type SharedShooting
	local shared = self.diContainer:resolve("Shared")
	self.eventBus = shared.eventBus
	self.constants = shared.constants
	self.remoteEventService = shared.remoteEventService

	self:_setupEventListeners()
end

function InputService:_setupEventListeners()
	self.eventBus:connectToEvents({
		[self.constants.CLIENT_EVENTS.PLAYER_JOINED_BALISTA] = function()
			self:onPlayerJoinedBalista()
		end,
		[self.constants.CLIENT_EVENTS.PLAYER_LEFT_BALISTA] = function()
			self:onPlayerLeftBalista()
		end,
	})
end

function InputService:onPlayerJoinedBalista()
	ContextActionService:BindAction("Shooting:Shoot", function(_, inputState, _)
		if inputState ~= Enum.UserInputState.Begin then
			return
		end

		self.remoteEventService:fireServer({
			eventName = self.constants.REMOTE_EVENTS.SHOOT,
			data = {},
		})
	end, false, Enum.UserInputType.MouseButton1)
end

function InputService:onPlayerLeftBalista()
	ContextActionService:UnbindAction("Shooting:Shoot")
end

return InputService

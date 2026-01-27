local ContextActionService = game:GetService("ContextActionService")

---@class FoodEatingInputService
---@field diContainer DIContainer
---@field eventBus EventBus
---@field constants SharedConstants
local InputService = {}
InputService.__index = InputService

---@param diContainer DIContainer
---@return FoodEatingInputService
function InputService.new(diContainer)
	local self = setmetatable({}, InputService)
	self.diContainer = diContainer
	return self
end

function InputService:init()
	---@type SharedFoodEating
	local shared = self.diContainer:resolve("Shared")
	self.eventBus = shared.eventBus
	self.constants = shared.constants
	self.remoteEventService = shared.remoteEventService

	self:_setupEventListeners()
end

function InputService:_setupEventListeners()
	warn("setupEventListeners")
	self.eventBus:connectToEvents({
		[self.constants.CLIENT_EVENTS.PLAYER_JOINED_FOOD_EATING] = function()
			warn("playerJoinedFoodEating")
			self:onPlayerJoinedFoodEating()
		end,
		[self.constants.CLIENT_EVENTS.PLAYER_LEFT_FOOD_EATING] = function()
			self:onPlayerLeftFoodEating()
		end,
	})
end

function InputService:onPlayerJoinedFoodEating()
	ContextActionService:BindAction("FoodEating", function(_, inputState, _)
		if inputState ~= Enum.UserInputState.Begin then
			return
		end
		warn("eating food")
		self.remoteEventService:fireServer({
			eventName = self.constants.REMOTE_EVENTS.EAT_FOOD,
			data = {},
		})
	end, false, Enum.UserInputType.MouseButton1)
end

function InputService:onPlayerLeftFoodEating()
	ContextActionService:UnbindAction("FoodEating")
end

return InputService

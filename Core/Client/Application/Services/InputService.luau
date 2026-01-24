local UserInputService = game:GetService("UserInputService")
local ContextActionService = game:GetService("ContextActionService")

---@class InputService
---@field diContainer DIContainer
---@field eventBus EventBus
---@field constants SharedConstants
local InputService = {}
InputService.__index = InputService

---@param diContainer DIContainer
---@return InputService
function InputService.new(diContainer)
	local self = setmetatable({}, InputService)
	self.diContainer = diContainer
	return self
end

function InputService:init()
	---@type Shared
	local shared = self.diContainer:resolve("Shared")
	self.eventBus = shared.eventBus
	self.constants = shared.constants
    
	UserInputService.InputChanged:Connect(function(input, gameProcessed)
		self:_inputChanged(input, gameProcessed)
	end)
end

---@param input InputObject
---@param gameProcessed boolean
function InputService:_inputChanged(input, gameProcessed)
	if gameProcessed then
		return
	end

	if input.UserInputType == Enum.UserInputType.MouseMovement then
		self.eventBus:fire(self.constants.CLIENT_EVENTS.MOUSE_MOVEMENT, {
			input = input,
		})
	end
end

return InputService

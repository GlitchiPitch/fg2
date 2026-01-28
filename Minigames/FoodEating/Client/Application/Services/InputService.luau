local ContextActionService = game:GetService("ContextActionService")
local UserInputService = game:GetService("UserInputService")

---@class FoodEatingInputService
---@field diContainer DIContainer
---@field eventBus EventBus
---@field constants SharedFoodEatingConstants
---@field remoteEventService RemoteEventService
---@field _connections table<string, RBXScriptConnection>
local InputService = {}
InputService.__index = InputService

---@param diContainer DIContainer
---@return FoodEatingInputService
function InputService.new(diContainer)
	local self = setmetatable({}, InputService)
	self.diContainer = diContainer
	self._connections = {}
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
	self.eventBus:connectToEvents({
		[self.constants.CLIENT_EVENTS.TOGGLE_CLICKER_MINIGAME] = function(data)
			self:onClickerMinigameToggle(data)
		end,
		[self.constants.CLIENT_EVENTS.TOGGLE_COMBO_MINIGAME] = function(data)
			self:onComboMinigameToggle(data)
		end,
	})
end

---@class minigameToggleData
---@field isEnabled boolean

---@param data minigameToggleData
function InputService:onClickerMinigameToggle(data)
	if data.isEnabled then
		warn("onClickerMinigameToggle")
		ContextActionService:BindAction("ClickerMinigame", function(_, inputState, _)
			if inputState ~= Enum.UserInputState.Begin then
				return
			end

			warn("onClickerMinigameInput")
			self:_onClickerMinigameInput()
		end, false, Enum.UserInputType.MouseButton1)
	else
		ContextActionService:UnbindAction("ClickerMinigame")
	end
end

function InputService:onComboMinigameToggle(data)
	if data.isEnabled then
		self._connections["ComboMinigame"] = UserInputService.InputBegan:Connect(function(input, gameProcessedEvent)
			if gameProcessedEvent then
				return
			end
			if input.UserInputType == Enum.UserInputType.Keyboard then
				self:_onComboMinigameInput(input)
			end
		end)
	else
		if self._connections["ComboMinigame"] then
			self._connections["ComboMinigame"]:Disconnect()
			self._connections["ComboMinigame"] = nil
		end
	end
end

function InputService:_onComboMinigameInput(input)
	self.eventBus:fire(self.constants.CLIENT_EVENTS.COMBO_MINIGAME_INPUT, {
		input = input,
	})
end

function InputService:_onClickerMinigameInput()
	self.eventBus:fire(self.constants.CLIENT_EVENTS.CLICKER_MINIGAME_INPUT, {})
end

return InputService

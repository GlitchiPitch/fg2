local ContextActionService = game:GetService("ContextActionService")
---@class ClientDungeonCleaningInputService
local InputService = {}
InputService.__index = InputService

---@param diContainer DIContainer
---@return ClientDungeonCleaningInputService
function InputService.new(diContainer)
	local self = setmetatable({}, InputService)
    self.diContainer = diContainer
	return self
end

function InputService:init()
    ---@type SharedDungeonCleaning
	local shared = self.diContainer:resolve("Shared")
	self.constants = shared.constants
	self.eventBus = shared.eventBus
    

	self:_setupEventListeners()
end

function InputService:_setupEventListeners()

	self.eventBus:connectToEvents({
		[self.constants.SERVER_EVENTS.PLAYER_JOINED_DUNGEON_CLEANING] = function()
			self:onPlayerJoined()
		end,
		[self.constants.SERVER_EVENTS.PLAYER_LEFT_DUNGEON_CLEANING] = function()
			self:onPlayerLeft()
		end,
	})
end

function InputService:onPlayerJoined()
warn("onPlayerJoined")
    ContextActionService:BindAction("UseWeapon", function(_, inputState)
		if inputState == Enum.UserInputState.Begin then
			self.eventBus:fire(self.constants.CLIENT_EVENTS.USE_WEAPON)
		end
	end, false, Enum.UserInputType.MouseButton1)
end

function InputService:onPlayerLeft()
warn("onPlayerLeft")
    ContextActionService:UnbindAction("UseWeapon")
end

return InputService
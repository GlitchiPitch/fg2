local PlayerService = require(script.PlayerService)
local AnimationService = require(script.AnimationService)
local ToolService = require(script.ToolService)
local InputService = require(script.InputService)
---@class ClientDungeonCleaningAppServices
---@field playerService ClientDungeonCleaningPlayerService
---@field animationService ClientAnimationService
---@field toolService ClientToolService
---@field inputService ClientDungeonCleaningInputService
local Services = {}
Services.__index = Services

---@param diContainer DIContainer
---@return ClientDungeonCleaningAppServices
function Services.new(diContainer)
	local self = setmetatable({}, Services)
    self.playerService = PlayerService.new(diContainer)
    self.animationService = AnimationService.new(diContainer)
    self.toolService = ToolService.new(diContainer)
    self.inputService = InputService.new(diContainer)
	return self
end

function Services:init()
    self.playerService:init()
	self.animationService:init()
    self.toolService:init()
    self.inputService:init()
end

return Services
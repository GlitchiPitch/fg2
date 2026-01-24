local BalistasService = require(script.BalistasService)
local PlayerService = require(script.PlayerService)

---@class CrossbowShootingServerApp
---@field balistasService CrossbowShootingServerBalistasService
---@field playerService CrossbowShootingServerPlayerService
local Application = {}
Application.__index = Application

---@param diContainer DIContainer
---@return CrossbowShootingServerApp
function Application.new(diContainer)
	local self = setmetatable({}, Application)
    self.diContainer = diContainer
    self.balistasService = BalistasService.new(self.diContainer)
    self.playerService = PlayerService.new(self.diContainer)
	return self
end

function Application:init()
	self.balistasService:init()
	self.playerService:init()
end

return Application
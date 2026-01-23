local BalistasService = require(script.BalistasService)

---@class CrossbowShootingServerApp
---@field balistasService CrossbowShootingServerBalistasService
local Application = {}
Application.__index = Application

---@param diContainer DIContainer
---@return CrossbowShootingServerApp
function Application.new(diContainer)
	local self = setmetatable({}, Application)
    self.diContainer = diContainer
    self.balistasService = BalistasService.new(self.diContainer)
	return self
end

function Application:init()
	self.balistasService:init()
end

return Application
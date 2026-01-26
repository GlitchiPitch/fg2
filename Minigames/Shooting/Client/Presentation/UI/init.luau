---@class ShootingClientUI
---@field diContainer DIContainer
---@field shootingUI ScreenGui
---@field playerService ClientPlayerService
local UI = {}
UI.__index = UI

---@param diContainer DIContainer
---@return ShootingClientUI
function UI.new(diContainer)
	local self = setmetatable({}, UI)
    self.diContainer = diContainer
    self.shootingUI = script.ShootingUI
	return self
end

function UI:init()
    ---@type ClientApp
    local application = self.diContainer:resolve("CoreApplication")
    self.playerService = application.services.playerService
    self.shootingUI = self:createShootingUI()
end

function UI:createShootingUI()
	local shootingUI = self.shootingUI:Clone()
	shootingUI.Parent = self.playerService.player.PlayerGui
	shootingUI.Enabled = false
end

return UI
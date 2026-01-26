local TweenService = game:GetService("TweenService")
---@class ShootingClientUI
---@field diContainer DIContainer
---@field shootingUI ScreenGui
---@field ammoFrame Frame
---@field ammoImageTemplate ImageLabel
---@field playerService ClientPlayerService
---@field itemsRepository SharedShootingItemsRepository
local UI = {}
UI.__index = UI

---@param diContainer DIContainer
---@return ShootingClientUI
function UI.new(diContainer)
	local self = setmetatable({}, UI)
	self.diContainer = diContainer
	self.shootingUI = script.ShootingUI:Clone()
	self.ammoFrame = self.shootingUI.Ammo
	self.ammoImageTemplate = self.ammoFrame.AmmoImage
	return self
end

function UI:init()
	---@type SharedShooting
	local shared = self.diContainer:resolve("Shared")
	self.itemsRepository = shared.infrastructure.repositories.itemsRepository
	---@type ClientApp
	local application = self.diContainer:resolve("CoreApplication")
	self.playerService = application.services.playerService
	self:_setup()
end

function UI:_setup()
	self.shootingUI.Parent = self.playerService.player.PlayerGui
	self.shootingUI.Enabled = false
end

---@param state boolean
function UI:toggle(state)
	self.shootingUI.Enabled = state
end

function UI:onShoot(data)
	self:updateAmmo(data)
end

function UI:updateAmmo(data)
	self:_clearAmmo()
	self:_fillAmmo(data)
end

function UI:_fillAmmo(data)
	for i, ammo in data.ammo do
		local ammoImage = self.ammoImageTemplate:Clone()
        local item = self.itemsRepository:getItemData(ammo)
		ammoImage.Parent = self.ammoFrame
		ammoImage.LayoutOrder = i
		ammoImage.Visible = true
		ammoImage.Image = item.image
	end
end

function UI:_clearAmmo()
	for _, child in self.ammoFrame:GetChildren() do
		if child:IsA("ImageLabel") and child ~= self.ammoImageTemplate then
			child:Destroy()
		end
	end
end

function UI:updateScore(data)
    self:_animateScore(data.score)
	self.scoreLabel.Text = data.score
end

---@param score number
function UI:_animateScore(score)
    local tweenInfo = TweenInfo.new(1, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut)
    local tween = TweenService:Create(self.scoreLabel, tweenInfo, {Text = score})
    tween:Play()
end
return UI

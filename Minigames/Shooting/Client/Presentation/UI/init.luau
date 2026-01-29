local TweenService = game:GetService("TweenService")
---@class ShootingClientUI
---@field diContainer DIContainer
---@field shootingUI ScreenGui
---@field ammoFrame Frame
---@field timerLabel TextLabel
---@field scoreLabel TextLabel
---@field ammoImageTemplate ImageLabel
---@field corePlayerService ClientPlayerService
---@field itemsRepository SharedShootingItemsRepository
---@field playerService ShootingClientPlayerService
local UI = {}
UI.__index = UI

---@param diContainer DIContainer
---@return ShootingClientUI
function UI.new(diContainer)
	local self = setmetatable({}, UI)
	self.diContainer = diContainer
	self.shootingUI = script.ShootingUI:Clone()
	self.scoreFrame = self.shootingUI.Score
	self.scoreLabel = self.scoreFrame.TextLabel

	self.ammoFrame = self.shootingUI.Ammo
	self.ammoImageTemplate = self.ammoFrame.AmmoImage

	self.timerLabel = self.shootingUI.Timer.TextLabel
	return self
end

function UI:init()
	---@type SharedShooting
	local shared = self.diContainer:resolve("Shared")
	self.itemsRepository = shared.infrastructure.repositories.itemsRepository
	---@type ClientApp
	local coreApplication = self.diContainer:resolve("CoreApplication")
	self.corePlayerService = coreApplication.services.playerService
	---@type ShootingClientApp
	local application = self.diContainer:resolve("Application")
	self.playerService = application.services.playerService
	self:_setup()
end

function UI:_setup()
	self.shootingUI.Parent = self.corePlayerService.player.PlayerGui
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
	local playerEntity = self.playerService:getPlayerEntity()
	local _scoreValue = Instance.new("IntValue")
	local tween = TweenService:Create(_scoreValue, TweenInfo.new(1), { Value = playerEntity.score.Value })
	local _scoreChangedConnection = nil

	_scoreValue.Value = playerEntity.score.Value - data.addedScore

	_scoreChangedConnection = _scoreValue.Changed:Connect(function(score)
		self.scoreLabel.Text = score
	end)

	tween.Completed:Connect(function()
		_scoreValue:Destroy()
		_scoreChangedConnection:Disconnect()
	end)

	tween:Play()
end

---@param score number
function UI:_animateScore(score)
	local animatedScore = self.scoreLabel:Clone()
	local tweenInfo = TweenInfo.new(1, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut)
	local tween = TweenService:Create(animatedScore, tweenInfo, { Position = self.scoreLabel.Position })

	local function onCompleted()
		animatedScore:Destroy()
	end

	animatedScore.Parent = self.scoreFrame
	animatedScore.Position = UDim2.fromScale(0.5, 2.5)
	animatedScore.Text = score

	tween.Completed:Connect(onCompleted)
	tween:Play()
end

---@param data table
function UI:updateTimer(data)
	local timer = data.time
	local minutes = math.floor(timer / 60)
	local seconds = timer % 60
	self.timerLabel.Text = string.format("%02d:%02d", minutes, seconds)
end

return UI

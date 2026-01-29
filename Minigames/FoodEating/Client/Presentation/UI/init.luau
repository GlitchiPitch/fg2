local TweenService = game:GetService("TweenService")
local TaperMinigame = require(script.Modules.TaperMinigame)
local ClickerMinigame = require(script.Modules.ClickerMinigame)
local ComboMinigame = require(script.Modules.ComboMinigame)

---@class minigames
---@field taper TaperMinigameUIModule
---@field clicker ClickerMinigameUIModule
---@field combo ComboMinigameUIModule

---@class FoodEatingClientUI
---@field minigames minigames
---@field foodUI ScreenGui
local UI = {}
UI.__index = UI

---@param diContainer DIContainer
---@return FoodEatingClientUI
function UI.new(diContainer)
	local self = setmetatable({}, UI)
	self.diContainer = diContainer
	self.foodUI = script.FoodUI:Clone()
	self.scoreFrame = self.foodUI.Score
	self.scoreLabel = self.scoreFrame.TextLabel
	self.timerLabel = self.foodUI.Timer.TextLabel

	self.minigames = {
		taper = TaperMinigame.new(self.diContainer, self.foodUI.Taper),
		clicker = ClickerMinigame.new(self.diContainer, self.foodUI.Clicker),
		combo = ComboMinigame.new(self.diContainer, self.foodUI.Combo),
	}
	return self
end

function UI:init()
	---@type ClientApp
	local coreApplication = self.diContainer:resolve("CoreApplication")
	---@type ClientFoodEatingApp
	local application = self.diContainer:resolve("Application")

	self.foodUI.Parent = coreApplication.services.playerService.player.PlayerGui
	self.playerService = application.services.playerService
	for _, minigame in self.minigames do
		minigame:init()
	end

    self.foodUI.Enabled = false
end

function UI:toggle(state)
	self.foodUI.Enabled = state
end

---@class foodMinigameData
---@field eatingType eatingType
---@field combo table<number, Enum.KeyCode>?

---@param data foodMinigameData
function UI:showFoodMinigame(data)
	for _, minigame in self.minigames do
		minigame:stop()
	end

	local minigame = self.minigames[data.eatingType]
	minigame:start(data.combo)
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
	self:_animateScore(data.addedScore)
end
function UI:updateTimer(data)
	self.timerLabel.Text = data.time
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


return UI

local TweenService = game:GetService("TweenService")
---@class DungeonCleaningUI
local UI = {}
UI.__index = UI

---@param diContainer DIContainer
---@return DungeonCleaningUI
function UI.new(diContainer)
	local self = setmetatable({}, UI)
    self.diContainer = diContainer
    self.dungeonCleaningUI = script.DungeonCleaningUI:Clone()
	return self
end

function UI:init()
	---@type ClientApp
	local coreApplication = self.diContainer:resolve("CoreApplication")
	self.corePlayerService = coreApplication.services.playerService
	---@type DungeonCleaningClientApp
	local application = self.diContainer:resolve("Application")
	self.playerService = application.services.playerService
	self:_setup()
end

function UI:_setup()
	self.dungeonCleaningUI.Parent = self.corePlayerService.player.PlayerGui
	self.dungeonCleaningUI.Enabled = false
end

---@param state boolean
function UI:toggle(state)
	self.dungeonCleaningUI.Enabled = state
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
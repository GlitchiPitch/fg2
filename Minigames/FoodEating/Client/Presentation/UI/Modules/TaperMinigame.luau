local TweenService = game:GetService("TweenService")
---@class TaperMinigameUIModule
---@field diContainer DIContainer
---@field minigameFrame Frame
---@field taperButtonTemplate TextButton
local TaperMinigame = {}
TaperMinigame.__index = TaperMinigame

---@param diContainer DIContainer
---@param minigameFrame Frame
---@return TaperMinigameUIModule
function TaperMinigame.new(diContainer, minigameFrame)
	local self = setmetatable({}, TaperMinigame)
	self.diContainer = diContainer
	self.minigameFrame = minigameFrame
	self.taperButtonTemplate = self.minigameFrame.Template
	return self
end

function TaperMinigame:init()
	---@type SharedFoodEating
	local shared = self.diContainer:resolve("Shared")
	self.constants = shared.constants
	self.eventBus = shared.eventBus

	self:_setupEventListeners()
end

function TaperMinigame:_setupEventListeners()
	self.eventBus:connectToEvents({
		[self.constants.CLIENT_EVENTS.CREATE_TAPER] = function()
			self:onCreateTaper()
		end,
	})
end

function TaperMinigame:start()
	self.minigameFrame.Visible = true
end

function TaperMinigame:stop()
	self.minigameFrame.Visible = false
end

function TaperMinigame:onCreateTaper()
	local taperButton = self.taperButtonTemplate:Clone()
	local tween = TweenService:Create(taperButton.UIStroke, TweenInfo.new(2), {
		BorderOffset = UDim.new(0, 0),
	})
	local _connection = nil
	local _isTap = false
	taperButton.Parent = self.minigameFrame
	taperButton.Visible = true
	taperButton.Position = UDim2.fromScale(math.random() * 0.8 + 0.1, math.random() * 0.8 + 0.1)

	_connection = taperButton.MouseButton1Click:Connect(function()
		_connection:Disconnect()
		tween:Cancel()
		_isTap = true
	end)

	tween.Completed:Connect(function()
		taperButton:Destroy()
		self.eventBus:fire(self.constants.CLIENT_EVENTS.TAPER_CLICKED, {
			isTap = _isTap,
		})
		_connection:Disconnect()
	end)

	tween:Play()
end

return TaperMinigame

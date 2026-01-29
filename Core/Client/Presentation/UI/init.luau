---@class UI
---@field resultUI ScreenGui
---@field closeResultButton TextButton
---@field gameNameLabel TextLabel
---@field resultContainer ScrollingFrame
---@field playerResultTemplate Frame
local UI = {}
UI.__index = UI

---@param diContainer DIContainer
---@return UI
function UI.new(diContainer)
	local self = setmetatable({}, UI)
	self.diContainer = diContainer
	self.resultUI = script.ResultUI:Clone()
	self.closeResultButton = self.resultUI.Body.CloseButton
	self.gameNameLabel = self.resultUI.Body.GameNameLabel
	self.resultContainer = self.resultUI.Body.ScrollingFrame
	self.playerResultTemplate = self.resultContainer.Template
	return self
end

function UI:init()
	---@type ClientApp
	local application = self.diContainer:resolve("Application")
	self.resultUI.Parent = application.services.playerService.player.PlayerGui

	self:_setup()
end

function UI:_setup()
	self.closeResultButton.MouseButton1Click:Connect(function()
		self:onCloseResultButtonClicked()
	end)
end

function UI:openResultUI(data)
	warn("onResultUIOpened", data)

	self:_clearResult()
	self:_fillResult(data)
	self.resultUI.Enabled = true
end

function UI:onCloseResultButtonClicked()
	self.resultUI.Enabled = false
end

function UI:_clearResult()
	for _, child in self.resultContainer:GetChildren() do
		if child:IsA("Frame") and child ~= self.playerResultTemplate then
			child:Destroy()
		end
	end
end

function UI:_fillResult(data)
	self.gameNameLabel.Text = data.gameName
	for i, playerResult in data.playerResults do
		local playerResultFrame = self.playerResultTemplate:Clone()
		playerResultFrame.Parent = self.resultContainer
		playerResultFrame.ImageLabel.Image = playerResult.image
		playerResultFrame.Name = playerResult.player.Name
		playerResultFrame.Score.Text = playerResult.score
		playerResultFrame.Rank.Text = i
		playerResultFrame.LayoutOrder = i
		playerResultFrame.Visible = true
	end
end

return UI

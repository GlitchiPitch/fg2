---@class MinigameMaster
local Master = {}
Master.__index = Master

---@class MinigameLayers
---@field Shared table
---@field Infrastructure table
---@field Application table
---@field Presentation table

---@param globalDIContainer DIContainer
---@param layers table<string, table>
---@return MinigameMaster
function Master.new(globalDIContainer, layers)
	local self = setmetatable({}, Master)

	self.shared = layers.Shared and layers.Shared.new(globalDIContainer) or nil
	self.infrastructure = layers.Infrastructure and layers.Infrastructure.new(self.shared.diContainer) or nil
	self.application = layers.Application and layers.Application.new(self.shared.diContainer) or nil
	self.presentation = layers.Presentation and layers.Presentation.new(self.shared.diContainer) or nil

	return self
end

function Master:init()
	for layerKey, layerName in
		{
			CoreInfrastructure = "Infrastructure",
			CoreApplication = "Application",
			CorePresentation = "Presentation",
			CoreShared = "Shared",
		}
	do
		local layer = self.shared.globalDIContainer:resolve(layerName)
		if layer then
			self.shared.diContainer:singleton(layerKey, function()
				return self.shared.globalDIContainer:resolve(layerName)
			end)
		end
	end

	for layerKey, layerName in
		{
			Infrastructure = "infrastructure",
			Application = "application",
			Presentation = "presentation",
			Shared = "shared",
		}
	do
		if self[layerName] then
			self.shared.diContainer:singleton(layerKey, function()
				return self[layerName]
			end)
		end
	end

	if self.shared then
		self.shared:init()
	end
	if self.infrastructure then
		self.infrastructure:init()
	end
	if self.application then
		self.application:init()
	end
	if self.presentation then
		self.presentation:init()
	end
end

function Master:startSession()
	error("startSession not implemented")
end

function Master:endSession()
	error("endSession not implemented")
end

return Master

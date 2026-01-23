---@class MinigameMaster
local Master = {}

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

	self.diContainer = globalDIContainer.new()
	self.globalDIContainer = globalDIContainer

	self.shared = layers.Shared and layers.Shared.new() or nil
	self.infrastructure = layers.Infrastructure and layers.Infrastructure.new() or nil
	self.application = layers.Application and layers.Application.new() or nil
	self.presentation = layers.Presentation and layers.Presentation.new() or nil

	return self
end

function Master:init()
	-- self.diContainer:singleton("Infrastructure", function()
	-- 	return self.infrastructure
	-- end)

	-- self.diContainer:singleton("Application", function()
	-- 	return self.application
	-- end)

	self.diContainer:singleton("Shared", function()
		return self.shared
	end)

	-- self.diContainer:singleton("Domain", function()
	-- 	return self.shared.domain
	-- end)

	-- if self.presentation then
	-- 	self.diContainer:singleton("Presentation", function()
	-- 		return self.presentation
	-- 	end)
	-- end

	-- self.infrastructure:init()
	-- self.application:init()

	-- if self.presentation then
	-- 	self.presentation:init()
	-- end
	print(self)
end

return Master

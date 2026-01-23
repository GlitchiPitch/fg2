local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Shared = require(ReplicatedStorage.Shared)

---@class Master
local Master = {}
Master.__index = Master

---@return Master
function Master.new(Infrastructure, Application, Presentation)
	local self = setmetatable({}, Master)
    self.shared = Shared.new()
    
	self.diContainer = self.shared.diContainer
    
    self.infrastructure = Infrastructure.new(self.diContainer)
    self.application = Application.new(self.diContainer)
    self.presentation = Presentation and Presentation.new(self.diContainer) or nil

	return self
end

function Master:init()
	self.diContainer:singleton("Infrastructure", function()
		return self.infrastructure
	end)

	self.diContainer:singleton("Application", function()
		return self.application
	end)

	self.diContainer:singleton("Shared", function()
		return self.shared
	end)

	self.diContainer:singleton("Domain", function()
		return self.shared.domain
	end)

    if self.presentation then
        self.diContainer:singleton("Presentation", function()
            return self.presentation
        end)
    end

    self.infrastructure:init()
    self.application:init()
    
    if self.presentation then
        self.presentation:init()
    end
end

return Master
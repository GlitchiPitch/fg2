local UserInputService = game:GetService("UserInputService")
---@class CameraController
---@field diContainer DIContainer
---@field camera Camera
---@field eventBus EventBus
---@field constants SharedConstants
---@field playerService ClientPlayerService
---@field cameraPos Vector3
---@field targetCameraPos Vector3
---@field angleX number
---@field targetAngleX number
---@field angleY number
---@field targetAngleY number
---@field fieldOfView number
---@field mouse Mouse
---@field headOffset CFrame
---@field smoothness number
---@field sensitivity number
---@field _head Part?
local CameraController = {}
CameraController.__index = CameraController

---@param diContainer DIContainer
---@return CameraController
function CameraController.new(diContainer)
	local self = setmetatable({}, CameraController)
	self.diContainer = diContainer
	self.camera = workspace.CurrentCamera
	self._freemouse = true
	self.headOffset = CFrame.new(-5, 0.7, 20) -- how far your camera is from your head
	self.smoothness = 0.1
	self.sensitivity = 0.6
	self._head = nil

	self.angleX, self.targetAngleX = 0, 0
	self.angleY, self.targetAngleY = 0, 0
	self.cameraPos, self.targetCameraPos = self.camera.CFrame.Position, self.camera.CFrame.Position
	self.fieldOfView = 80
	return self
end

function CameraController:init()
	---@type Shared
	local shared = self.diContainer:resolve("Shared")
	---@type ClientApp
	local app = self.diContainer:resolve("Application")
	self.playerService = app.services.playerService
	self.mouse = self.playerService.player:GetMouse()
	self.constants = shared.constants
	self.eventBus = shared.eventBus

	self.eventBus:connectToEvents({
		[shared.constants.CLIENT_EVENTS.SET_CAMERA_MODE] = function(data)
			self:setCameraMode(data)
		end,
		[shared.constants.CLIENT_EVENTS.ON_CHARACTER_ADDED] = function(data)
			self:_onCharacterAdded(data.character)
		end,
		[shared.constants.CLIENT_EVENTS.MOUSE_MOVEMENT] = function(data)
			self:_mouseMovement(data.input)
		end,
	})

	self:setCameraMode({ mode = self.constants.CAMERA_MODES.FOLLOWING })
end

function CameraController:update()
	if not self._head then
		return
	end

	if self.cameraMode == self.constants.CAMERA_MODES.FOLLOWING then
		self:_followingCamera()
	end
end

---@param data setModeData
function CameraController:setCameraMode(data)
	if data.mode == self.constants.CAMERA_MODES.DEFAULT then
		self:_setDefaultCameraMode()
	elseif data.mode == self.constants.CAMERA_MODES.FOLLOWING then
		self:_setFollowingCameraMode()
	end
end

---@param input InputObject
function CameraController:_mouseMovement(input)
	-- local delta = Vector2.new(input.Delta.X / self.sensitivity, input.Delta.Y / self.sensitivity) * self.smoothness
	local delta = Vector2.new(input.Delta.X, input.Delta.Y) * self.sensitivity
	local X = self.targetAngleX - delta.Y
	self.targetAngleX = (X >= 80 and 80) or (X <= -80 and -80) or X
	self.targetAngleY = (self.targetAngleY - delta.X) % 360
end

---@param character Model
function CameraController:_onCharacterAdded(character)
	self._head = character:WaitForChild("Head")
end

function CameraController:_setDefaultCameraMode()
	self.cameraMode = self.constants.CAMERA_MODES.DEFAULT
	self.camera.CameraType = Enum.CameraType.Custom
	self:_setFreeMouse(true)
end

function CameraController:_setFollowingCameraMode()
	self.cameraMode = self.constants.CAMERA_MODES.FOLLOWING
	self.camera.CameraType = Enum.CameraType.Scriptable
	self:_setFreeMouse(false)
end

function CameraController:_followingCamera()
	-- Smooth angles towards target angles (from mouse input)
	self.angleX = self.angleX + (self.targetAngleX - self.angleX) * 0.3
	local dist = self.targetAngleY - self.angleY
	dist = math.abs(dist) > 180 and dist - (dist / math.abs(dist)) * 360 or dist
	self.angleY = (self.angleY + dist * 0.3) % 360

	-- Calculate camera CFrame: start with offset from head, then apply rotations
	local cameraCFrame = CFrame.new(self._head.Position)
		* CFrame.Angles(math.rad(self.angleX), math.rad(self.angleY), 0)
		* self.headOffset

	self.camera.CFrame = cameraCFrame
	self.camera.FieldOfView = self.fieldOfView

end

---@param state boolean
function CameraController:_setFreeMouse(state)
	self._freemouse = state
	if self._freemouse then
		UserInputService.MouseBehavior = Enum.MouseBehavior.Default
		self.mouse.Icon = "" -- replaces mouse icon
	else
		UserInputService.MouseBehavior = Enum.MouseBehavior.LockCenter
		self.mouse.Icon = "http://www.roblox.com/asset/?id=569021388" -- replaces mouse icon
	end
end

---@class setModeData
---@field mode cameraMode

return CameraController

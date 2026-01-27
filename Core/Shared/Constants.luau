local MINIGAMES = {
	SHOOTING = "Shooting",
	ITEM_SEARCH = "ItemSearch",
	FOOD_EATING = "FoodEating",
	RACING = "Racing",
	DUNGEON_CLEARING = "DungeonClearing",
}

---@alias cameraMode "Default" | "Following"

---@class SharedConstants
local Constants = {
	INIT_SERVER = "INIT_SERVER",

	CLIENT_EVENTS = {
		MOUSE_MOVEMENT = "MOUSE_MOVEMENT",
		SET_CAMERA_MODE = "SET_CAMERA_MODE",
		ON_CHARACTER_ADDED = "ON_CHARACTER_ADDED",
	},

	REMOTE_EVENTS = {
		SEND_CAMERA_CFRAME = "SEND_CAMERA_CFRAME",
	},
	
	CAMERA_MODES = {
		DEFAULT = "Default",
		FOLLOWING = "Following",
	},

	SERVER_EVENTS = {
		SET_PLAYER_CAMERA_MODE = "SET_PLAYER_CAMERA_MODE",
		REWARD_PLAYER = "REWARD_PLAYER",
	},

	MINIGAMES = MINIGAMES,
	MINIGAME_REQUIREMENTS = {
		[MINIGAMES.SHOOTING] = { minPlayers = 1, maxPlayers = 4 },
		[MINIGAMES.ITEM_SEARCH] = { minPlayers = 2, maxPlayers = 6 },
		[MINIGAMES.FOOD_EATING] = { minPlayers = 1, maxPlayers = 4 },
		[MINIGAMES.RACING] = { minPlayers = 2, maxPlayers = 6 },
		[MINIGAMES.DUNGEON_CLEARING] = { minPlayers = 1, maxPlayers = 4 },
	},

	PLAYER_ATTRIBUTES = {
		CAMERA_MODE = "CameraMode",
	},
}

return Constants

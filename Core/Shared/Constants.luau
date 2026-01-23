local MINIGAMES = {
	CROSSBOW_SHOOTING = "CrossbowShooting",
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

	CAMERA_MODES = {
		DEFAULT = "Default",
		FOLLOWING = "Following",
	},

	SERVER_EVENTS = {},

	MINIGAMES = MINIGAMES,
	MINIGAME_REQUIREMENTS = {
		[MINIGAMES.CROSSBOW_SHOOTING] = { minPlayers = 1, maxPlayers = 4 },
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

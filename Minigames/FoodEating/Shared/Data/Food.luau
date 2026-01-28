local Assets = require(game.ReplicatedStorage.Minigames.FoodEating.Assets)

---@alias eatingType "taper" | "clicker" | "combo"

local Food = {
	Bread = {
		model = Assets.Bread,
		eatingType = "taper",
	},
	Burger = {
		model = Assets.Burger,
		eatingType = "clicker",
	},
	Fries = {
		model = Assets.Fries,
		eatingType = "combo",
		combo = {
			[1] = Enum.KeyCode.Left,
			[2] = Enum.KeyCode.Right,
			[3] = Enum.KeyCode.Right,
			[4] = Enum.KeyCode.Down,
			[5] = Enum.KeyCode.Up,
		},
	},
	Pizza = {
		model = Assets.Pizza,
		eatingType = "taper",
	},
	Steak = {
		model = Assets.Steak,
		eatingType = "clicker",
	},
	PieCherry = {
		model = Assets.PieCherry,
		eatingType = "combo",
	},
	PieApple = {
		model = Assets.PieApple,
		eatingType = "taper",
	},
	PieBlueberry = {
		model = Assets.PieBlueberry,
		eatingType = "clicker",
	},
	Cake = {
		model = Assets.Cake,
		eatingType = "combo",
	},
	BirthdayCake = {
		model = Assets.BirthdayCake,
		eatingType = "taper",
	},
	Pancaik = {
		model = Assets.Pancaik,
		eatingType = "clicker",
	},
	Waffle = {
		model = Assets.Waffle,
		eatingType = "combo",
	},
	Muffin = {
		model = Assets.Muffin,
		eatingType = "taper",
	},
	HotDog = {
		model = Assets.HotDog,
		eatingType = "clicker",
	},
	Taco = {
		model = Assets.Taco,
		eatingType = "combo",
	},
	TurkeyLeg = {
		model = Assets.TurkeyLeg,
		eatingType = "taper",
	},
	AppleGreen = {
		model = Assets.AppleGreen,
		eatingType = "clicker",
	},
	AppleRed = {
		model = Assets.AppleRed,
		eatingType = "combo",
	},
	Grapes = {
		model = Assets.Grapes,
		eatingType = "taper",
	},
}

return Food

local Assets = require(game.ReplicatedStorage.Minigames.FoodEating.Assets)

---@alias eatingType "taper" | "clicker" | "combo"

local Food = {
	Bread = {
		model = Assets.Bread,
		eatingType = "taper",
		score = 100,
	},
	Burger = {
		model = Assets.Burger,
		eatingType = "clicker",
		score = 130,
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
		score = 150,
	},
	Pizza = {
		model = Assets.Pizza,
		eatingType = "taper",
		score = 200,
	},
	Steak = {
		model = Assets.Steak,
		eatingType = "clicker",
		score = 250,
	},
	PieCherry = {
		model = Assets.PieCherry,
		eatingType = "combo",
		combo = {
			[1] = Enum.KeyCode.Down,
			[2] = Enum.KeyCode.Down,
			[3] = Enum.KeyCode.Right,
			[4] = Enum.KeyCode.Down,
			[5] = Enum.KeyCode.Up,
		},
		score = 300,
	},
	PieApple = {
		model = Assets.PieApple,
		eatingType = "taper",
		score = 1,
	},
	PieBlueberry = {
		model = Assets.PieBlueberry,
		eatingType = "clicker",
		score = 1,
	},
	Cake = {
		model = Assets.Cake,
		eatingType = "combo",
		combo = {
			[1] = Enum.KeyCode.Up,
			[2] = Enum.KeyCode.Left,
			[3] = Enum.KeyCode.Right,
			[4] = Enum.KeyCode.Left,
		},
		score = 1,
	},
	BirthdayCake = {
		model = Assets.BirthdayCake,
		eatingType = "taper",
		score = 400,
	},
	Pancaik = {
		model = Assets.Pancaik,
		eatingType = "clicker",
		score = 450,
	},
	Waffle = {
		model = Assets.Waffle,
		eatingType = "combo",
		combo = {
			[1] = Enum.KeyCode.Up,
			[2] = Enum.KeyCode.Right,
			[3] = Enum.KeyCode.Right,
		},
		score = 500,
	},
	Muffin = {
		model = Assets.Muffin,
		eatingType = "taper",
		score = 550,
	},
	HotDog = {
		model = Assets.HotDog,
		eatingType = "clicker",
		score = 600,
	},
	Taco = {
		model = Assets.Taco,
		eatingType = "combo",
		combo = {
			[1] = Enum.KeyCode.Left,
			[2] = Enum.KeyCode.Left,
			[3] = Enum.KeyCode.Right,
			[4] = Enum.KeyCode.Up,
		},
		score = 650,
	},
	TurkeyLeg = {
		model = Assets.TurkeyLeg,
		eatingType = "taper",
		score = 700,
	},
	AppleGreen = {
		model = Assets.AppleGreen,
		eatingType = "clicker",
		score = 750,
	},
	AppleRed = {
		model = Assets.AppleRed,
		eatingType = "combo",
		combo = {
			[1] = Enum.KeyCode.Down,
			[2] = Enum.KeyCode.Right,
			[3] = Enum.KeyCode.Up,
		},
		score = 800,
	},
	Grapes = {
		model = Assets.Grapes,
		eatingType = "taper",
		score = 850,
	},
}

return Food

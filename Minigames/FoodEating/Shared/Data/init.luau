local Assets = require(script.Parent.Assets)

---@alias eatingType "taper" | "clicker" | "combo"

---@class SharedFoodEatingData
local Data = {
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
	},
	Pizza = {
		model = Assets.Pizza,
		eatingType = "combo",
	},
	Steak = {
		model = Assets.Steak,
		eatingType = "combo",
	},
	PieCherry = {
		model = Assets.PieCherry,
		eatingType = "combo",
	},
	PieApple = {
		model = Assets.PieApple,
		eatingType = "combo",
	},
	PieBlueberry = {
		model = Assets.PieBlueberry,
		eatingType = "combo",
	},
	Cake = {
		model = Assets.Cake,
		eatingType = "combo",
	},
	BirthdayCake = {
		model = Assets.BirthdayCake,
		eatingType = "combo",
	},
	Pancaik = {
		model = Assets.Pancaik,
		eatingType = "combo",
	},
	Waffle = {
		model = Assets.Waffle,
		eatingType = "combo",
	},
	Muffin = {
		model = Assets.Muffin,
		eatingType = "combo",
	},
	HotDog = {
		model = Assets.HotDog,
		eatingType = "combo",
	},
	Taco = {
		model = Assets.Taco,
		eatingType = "combo",
	},
	TurkeyLeg = {
		model = Assets.TurkeyLeg,
		eatingType = "combo",
	},
	AppleGreen = {
		model = Assets.AppleGreen,
		eatingType = "combo",
	},
	AppleRed = {
		model = Assets.AppleRed,
		eatingType = "combo",
	},
	Grapes = {
		model = Assets.Grapes,
		eatingType = "combo",
	},
}

return Data

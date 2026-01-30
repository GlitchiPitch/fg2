local Animations = {
	OneHandedIdle2 = "rbxassetid://128930183986958",
	TwoHandedIdle = "rbxassetid://106578561265820",
	OneHandedIdle = "rbxassetid://91227783134589",
	OneHandednSlash1 = "rbxassetid://75685844155538",
	OneHandednSlash2 = "rbxassetid://81267510004041",
	OneHandednSlash3 = "rbxassetid://91203262263459",
	OneHandednSlash4 = "rbxassetid://124580953562436",
	OneHandedBlock = "rbxassetid://136984402984617",
	PickupLoot = "rbxassetid://75771484012541",
	Lectern = "rbxassetid://74388291990601",
	Eat = "rbxassetid://115354805353614",
	Walk = "rbxassetid://138456918929926",
	Run = "rbxassetid://102729767070225",
}

for i, v in Animations do
	local animation = Instance.new("Animation")
	animation.AnimationId = v
	Animations[i] = animation
end

return Animations

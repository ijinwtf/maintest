if game.PlaceId == 286090429 then
local OrionLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/shlexware/Orion/main/source')))()
local Window = OrionLib:MakeWindow({Name = "Ayo Oleke", HidePremium = false, IntroText = "Ayo Oleke", SaveConfig = true, ConfigFolder = "AyoMagDick"})

    
local Tab = Window:MakeTab({
	Name = "Ayo Oleke",
	Icon = "rbxassetid://4483345998",
	PremiumOnly = false
})

Tab:AddToggle({
	Name = "Ayos Dick",
	Default = false,
	Callback = function(Value)
		_G.autoTap = Value
        autoTap()
	end    
})

end
OrionLib:Init()




loadstring(game:HttpGet("https://raw.githubusercontent.com/1201for/V.G_Hub_Extras/main/Universal_Client_Bypass"))()
local A = loadstring(game:HttpGet("https://raw.githubusercontent.com/1201for/V.G-Hub/main/V.G-Hub-Games-List"))()
getgenv().Get =
    setmetatable(
    {},
    {
        __index = function(A, B)
            return game:GetService(B)
        end
    }
)
local CoreGui = Get.CoreGui
local StarterGui = Get.StarterGui
local Lighting = Get.Lighting

local function Copy()
    setclipboard("https://discord.gg/HUBfmJUA2H")
end
local Gang = Instance.new("BindableFunction")

local function Hoe(i, v)
    StarterGui:SetCore("SendNotification", {Title = i, Text = v, Icon = "", Duration = 5})
end

StarterGui:SetCore(
    "SendNotification",
    {
        Title = "Warning",
        Text = "RightControl to toggle if the gui does not show up then the game is not supported please try again later or never if the game is supported the gui will pop up reguardless GOOD DAY!",
        Duration = 15
    }
)
StarterGui:SetCore(
    "SendNotification",
    {
        Title = "Credis",
        Text = "CharWar Serverhops Toxic Mods screen thingy And Kiriot22 esp,IY for fly script inspiration,Staylin Save Settings,Felix for being sexy, E621 Anticheat bypasses"
    }
)

function Gang.OnInvoke(v)
    if v == "Yes" then
        Copy()
        Hoe("Discord Copied")
    end 



StarterGui:SetCore(
    "SendNotification",
    {
        Title = "V.G Hub Discord",
        Text = "Copy to clipboard?",
        Duration = 5,
        Callback = Gang,
        Button1 = "Yes",
        Button2 = "No"
    }
)



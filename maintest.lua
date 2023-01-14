local triggerBoton
local rageon

local noSpreadon
local noRecoilon
local noSpeedReductionon
local infAmmoon
local automaticOn

local noBulletHoleson
local noParticleson
local noTrailson

local infJumpon
local noclipon
local walkspeed = 23.32

local silentAimon
local silentAimPart = "Head"
local preferedSilentAimMode = "getClosestToCharacter"
local silentAimOneShot

local playerNamesOn
local playerNamesPaused = false

local tracersOn
local espPaused = false

local tracersColor = Color3.fromRGB(255, 105, 195)
local playerNamesColor = Color3.fromRGB(255, 105, 195)
local boxesColor = Color3.fromRGB(255, 105, 195)
local useDefaultTeamColors = false

local showDistanceOn
local showDistancePaused = false

local showHealthOn
local showHealthPaused = false

local espon
local boxesOn
local boxesPaused = false

local aimbotOn
local aimbotEnabled
local aimbotKey = Enum.KeyCode.T
local aimbotPart = "Head"

local toggleUIKey = Enum.KeyCode.RightShift

local Client
for i,v in pairs(getgc(true)) do
	if type(v) == "table" and rawget(v, "mode") then
		Client = v;
	end
end
local JumpPower = Client.JP

function Action(Object, Function) if Object ~= nil then Function(Object) end end

local oldFireBullet

local mt = getrawmetatable(game)
local old = mt.__namecall
oldFireBullet = mt.__namecall

local wkspc = Client.wkspc
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local LocalPlayer = Players.LocalPlayer
local Mouse = LocalPlayer:GetMouse()
local Workspace = game:GetService("Workspace")
local RunService = game:GetService("RunService")
local UIS = game:GetService("UserInputService")
local Camera = Workspace.CurrentCamera

local WTVP = Camera.WorldToViewportPoint
local WorldToViewport = function(...) return WTVP(Camera, ...) end
local WTSP = Camera.WorldToScreenPoint
local WorldToScreen = function(...) return WTSP(Camera, ...) end

local library = loadstring(game:HttpGet("https://raw.githubusercontent.com/GreenDeno/Venyx-UI-Library/main/source.lua"))()
local venyx = library.new("Arsenal", 5013109572)

local aimPage = venyx:addPage("Aim", 5012544693)
local aimbotSection = aimPage:addSection("Aimbot")
local silentAimSection = aimPage:addSection("Silent Aim")
local othersSection = aimPage:addSection("Others")

local espPage = venyx:addPage("ESP", 5012544693)
local espFeaturesSection = espPage:addSection("Features")
local espColorsSection = espPage:addSection("Colors")

local weaponsPage = venyx:addPage("Weapons", 5012544693)
local mainWeaponsSection = weaponsPage:addSection("Weapons Mods")
local miscWeaponsSection = weaponsPage:addSection("Misc")

local playerPage = venyx:addPage("Player", 5012544693)
local playerSection = playerPage:addSection("Player Mods")

local creditsPage = venyx:addPage("Credits", 5012544693)
local creditsSection = creditsPage:addSection("Scripting by Compl1cated#9058")
local creditsSection2 = creditsPage:addSection("UI Library - Venyx")

pcall(function()
    UIS.InputBegan:Connect(function(UserInput)
        if UserInput.UserInputType == Enum.UserInputType.Keyboard and UserInput.KeyCode == Enum.KeyCode.J then
            rageon = not rageon    
        end
        if UserInput.UserInputType == Enum.UserInputType.Keyboard and UserInput.KeyCode == Enum.KeyCode.Space and infJumpon then
            Action(LocalPlayer.Character.Humanoid, function(self)
                if self:GetState() == Enum.HumanoidStateType.Jumping or self:GetState() == Enum.HumanoidStateType.Freefall then
                    Action(self.Parent.HumanoidRootPart, function(self)
                        self.Velocity = Vector3.new(0, JumpPower, 0) 
                    end) 
                end
            end)
        end
        if UserInput.UserInputType == Enum.UserInputType.Keyboard and UserInput.KeyCode == Enum.KeyCode.E then
            noclipon = not noclipon
        end
        --[[
        if UserInput.UserInputType == Enum.UserInputType.Keyboard and UserInput.KeyCode == toggleUIKey then
            venyx:toggle()
        end
        --]]
        if UserInput.UserInputType == Enum.UserInputType.Keyboard and UserInput.KeyCode == aimbotKey and aimbotOn then
            aimbotEnabled = true
            spawn(function()
                while wait() do
                    local target = WorldToScreen(getClosestToMouse().Character[aimbotPart].Position)
                    mousemoverel(target.X - Mouse.X, target.Y - Mouse.Y)
                    if not aimbotEnabled then return end
                end
            end)
        end
    end)
end)

UIS.InputEnded:Connect(function(UserInput)
    if UserInput.UserInputType == Enum.UserInputType.Keyboard and UserInput.KeyCode == aimbotKey and aimbotOn then
        aimbotEnabled = false
    end
end)

function isSameTeam(Player, Player2)
	if wkspc.FFA.Value == true then
		return false
	else
		return Player.TeamColor == Player2.TeamColor and true or false
	end
end

function hasVal(t, val)
    if type(t) ~= "table" then return end
    for i, v in ipairs(t) do
        if v == val then return true end
    end
    return false
end

function clearTable(t)
    if type(t) ~= "table" then return end
    for k in pairs (t) do
        t[k] = nil
    end
end

local function removeESP(t)
    if type(t) ~= "table" then return end
    for k, v in pairs(t) do
        t[k].Remove()
    end
end

function getLowestValue(t)
    if type(t) ~= "table" then return end
    local temp
    for _, v in next, t do
        temp = v
        break
    end
    
    for _, v in next, t do
        if v < temp then temp = v end
    end
    return temp
end

local players1 = {}
function getClosestToMouse() [nonamecall]
    local md = math.huge
    local closestplayer
    for i,v in next, Players:GetPlayers() do
        if v ~= LocalPlayer and not isSameTeam(LocalPlayer, v) and v.Character and v.Character:FindFirstChild("HumanoidRootPart") then
            local dist = v:DistanceFromCharacter(Mouse.hit.p)
            local pName = v.Name
            players1[pName] = dist
        end
    end
    local val = getLowestValue(players1)
    for k, v in next, players1 do
        if v == val then 
            closestplayer = Players:FindFirstChild(k)
        end
    end
    return closestplayer
end

local players2 = {}
function getClosestToChar() [nonamecall]
    local md = math.huge
    local closestplayer
    for _, v in next, Players:GetPlayers() do
        if v ~= LocalPlayer and not isSameTeam(LocalPlayer, v) and v.Character and v.Character:FindFirstChild("HumanoidRootPart") and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
            local dist = v:DistanceFromCharacter(LocalPlayer.Character.HumanoidRootPart.Position)
            local pName = v.Name
            players2[pName] = dist
        end
    end
    local val = getLowestValue(players2)
    for k, v in next, players2 do
        if v == val then
            closestplayer = Players:FindFirstChild(k)
        end
    end
    return closestplayer
 end

aimbotSection:addToggle("Aimbot", nil, function(value)
    aimbotOn = value
end)
aimbotSection:addKeybind("Aimbot Key", Enum.KeyCode.T, function() end, function(value) aimbotKey = value end)
aimbotSection:addDropdown("Aim Part", {"Head", "Body"}, function(value)
    aimbotPart = value
    if aimbotPart == "Body" then
        aimbotPart = "UpperTorso"
    end
end)

local triggerBotButton = othersSection:addToggle("Trigger Bot", nil, function(value)
    triggerBoton = value
    pcall(function()
        RunService.RenderStepped:Connect(function()
            if triggerBoton then
                if Mouse.target ~= nil then
                    if Mouse.target.Parent.Name == "Gun" or Mouse.target.Parent.Name == "scruc" then
                        if Mouse.target.Parent.Parent:FindFirstChild("Humanoid") and Mouse.target.Parent.Parent:FindFirstChild("Hitbox") and Players:FindFirstChild(Mouse.target.Parent.Parent.Name).Status.Alive.Value == true and not isSameTeam(LocalPlayer, Players:FindFirstChild(Mouse.target.Parent.Parent.Name)) then
                           mouse1press()
                           wait()
                           mouse1release()
                        end
                    else
                       if Mouse.target.Parent:FindFirstChild("Humanoid") and Mouse.target.Parent:FindFirstChild("Hitbox") and Players:FindFirstChild(Mouse.target.Parent.Name).Status.Alive.Value == true and not isSameTeam(LocalPlayer, Players:FindFirstChild(Mouse.target.Parent.Name)) then
                           mouse1press()
                           wait()
                           mouse1release()
                        end
                    end
                end
            end
        end)
    end)
end)

local silentAimButton = silentAimSection:addToggle("Silent Aim", nil, function(value)
    silentAimon = value
    pcall(function()
        if silentAimon then
            local mt = getrawmetatable(game)
            local old = mt.__namecall

            setreadonly(mt, false)

            mt.__namecall = newcclosure(function(self, ...) [nonamecall]
                local args = {...}
                if not checkcaller() and getnamecallmethod() == 'FireServer' and self.Name == 'HitPart' then
                    local ActiveGun = ReplicatedStorage.Weapons:FindFirstChild(LocalPlayer.NRPBS.EquippedTool.Value)
                    local temp
                    math.randomseed(os.time())
                    math.random(); math.random(); math.random()
                    local rand = math.random(1, 2)
                    if silentAimPart == "Random" then
                        if rand == 1 then temp = "Head"
                        elseif rand == 2 then temp = "LowerTorso" end 
                    else
                        temp = silentAimPart
                    end
                    if preferedSilentAimMode == "getClosestToCharacter" and getClosestToChar().Status.Alive.Value and not ActiveGun:FindFirstChild("Projectile") then
                        if temp == "Head" then
                            args[1] = getClosestToChar().Character[temp]
                            args[7] = true
                        else
                            args[1] = getClosestToChar().Character[temp]
                            args[7] = false
                        end
                    elseif preferedSilentAimMode == "getClosestToMouse" and getClosestToMouse().Status.Alive.Value and not ActiveGun:FindFirstChild("Projectile") then
                        if temp == "Head" then
                            args[1] = getClosestToMouse().Character[temp]
                            args[7] = true
                        else
                            args[1] = getClosestToMouse().Character[temp]
                            args[7] = false
                        end
                    end
                end
                if silentAimOneShot then
                    for i = 1, 3 do old(self, unpack(args)) end
                else
                    return old(self, unpack(args))
                end
                temp = nil
                return old(self, unpack(args))
            end)

            setreadonly(mt, true)
        else
            local mt = getrawmetatable(game)
            setreadonly(mt, false)
            mt.__namecall = oldFireBullet
            setreadonly(mt, true)
        end
    end)
end)

silentAimSection:addDropdown("Aim Part", {"Head", "Body", "Random"}, function(value)
    silentAimPart = value
    if silentAimPart == "Body" then silentAimPart = "LowerTorso" end 
end)

local rageButton = othersSection:addToggle("Spinbot(press J to disable/enable) BROKEN", nil, function(value)
    rageon = value
end)

othersSection:addButton("Kill All", function()
    for i,v in pairs(Players:GetPlayers()) do
        if v.Character and v.Character:FindFirstChild("HumanoidRootPart") and v.Status.Alive.Value and not isSameTeam(LocalPlayer, v) and v ~= LocalPlayer then
            local Target = v.Character
            local ActiveGun = ReplicatedStorage.Weapons:FindFirstChild(LocalPlayer.NRPBS.EquippedTool.Value)
            local Distance = (LocalPlayer.Character.Head.Position - Target.Head.Position).magnitude

            if ActiveGun:FindFirstChild("Projectile") then
                local HRP = LocalPlayer.Character.HumanoidRootPart
                HRP.CFrame = Target.HumanoidRootPart.CFrame
                ReplicatedStorage.Events.ApplyGun:FireServer(ReplicatedStorage.Weapons.Knife, false)
                for i = 0, 4 do ReplicatedStorage.Events.HitPart:FireServer(
                    Target.Head,
                    Target.Head.Position + Vector3.new(math.random(), math.random(), math.random()),
                    ActiveGun.Name,
                    2,
                    Distance,
                    false,
                    true,
                    false,
                    1,
                    false,
                    ActiveGun.FireRate.Value,
                    ActiveGun.ReloadTime.Value,
                    ActiveGun.Ammo.Value,
                    ActiveGun.StoredAmmo.Value,
                    ActiveGun.Bullets.Value,
                    ActiveGun.EquipTime.Value,
                    ActiveGun.RecoilControl.Value,
                    ActiveGun.Auto.Value,
                    ActiveGun["Speed%"].Value,
                    wkspc.DistributedTime.Value
                )
                end
                ReplicatedStorage.Events.ApplyGun:FireServer(ActiveGun, false)
            elseif ActiveGun.Name == "Knife" or ActiveGun.Name == "Golden Knife" or ActiveGun.Name == "Minigun" or ActiveGun.Name == "Candy Cane Miniguns" then
                local HRP = LocalPlayer.Character.HumanoidRootPart
                HRP.CFrame = Target.HumanoidRootPart.CFrame
                for i = 0, 4 do ReplicatedStorage.Events.HitPart:FireServer(
                    Target.Head,
                    Target.Head.Position + Vector3.new(math.random(), math.random(), math.random()),
                    ActiveGun.Name,
                    2,
                    Distance,
                    false,
                    true,
                    false,
                    1,
                    false,
                    ActiveGun.FireRate.Value,
                    ActiveGun.ReloadTime.Value,
                    ActiveGun.Ammo.Value,
                    ActiveGun.StoredAmmo.Value,
                    ActiveGun.Bullets.Value,
                    ActiveGun.EquipTime.Value,
                    ActiveGun.RecoilControl.Value,
                    ActiveGun.Auto.Value,
                    ActiveGun["Speed%"].Value,
                    wkspc.DistributedTime.Value
                )
                end
            else
                for i = 0, 4 do ReplicatedStorage.Events.HitPart:FireServer(
                    Target.Head,
                    Target.Head.Position + Vector3.new(math.random(), math.random(), math.random()),
                    ActiveGun.Name,
                    2,
                    Distance,
                    false,
                    true,
                    false,
                    1,
                    false,
                    ActiveGun.FireRate.Value,
                    ActiveGun.ReloadTime.Value,
                    ActiveGun.Ammo.Value,
                    ActiveGun.StoredAmmo.Value,
                    ActiveGun.Bullets.Value,
                    ActiveGun.EquipTime.Value,
                    ActiveGun.RecoilControl.Value,
                    ActiveGun.Auto.Value,
                    ActiveGun["Speed%"].Value,
                    wkspc.DistributedTime.Value
                )
                end
            end
        end
    end
end)

local noSpreadButton = mainWeaponsSection:addToggle("No Spread", nil, function(value)
    noSpreadon = value
    pcall(function()
        while wait() do
            local ActiveGun = ReplicatedStorage.Weapons:FindFirstChild(LocalPlayer.NRPBS.EquippedTool.Value)
            if noSpreadon then
                Client.currentspread = 0
            else
                Client.currentspread = ActiveGun.Spread.Value
                Client.spreadmodifier = 1.2
            end
        end
    end)
end)
local noRecoilButton = mainWeaponsSection:addToggle("No Recoil", nil, function(value) 
    noRecoilon = value
    pcall(function()
        while wait() do
            local ActiveGun = ReplicatedStorage.Weapons:FindFirstChild(LocalPlayer.NRPBS.EquippedTool.Value)
            if noRecoilon then
                Client.recoil = 0
            else
                Client.recoil = ActiveGun.RecoilControl.Value
            end
        end
    end)
end)
local infAmmoButton = mainWeaponsSection:addToggle("Inf Ammo", nil, function(value)
    infAmmoon = value
    pcall(function()
        if not infAmmoon then
            local ActiveGun = ReplicatedStorage.Weapons:FindFirstChild(LocalPlayer.NRPBS.EquippedTool.Value)
            debug.setupvalue(Client.updtprimary, 1, ActiveGun.Ammo.Value)
        end
    end)
end)

local isAuto
if Client.mode == "automatic" then isAuto = true
else isAuto = false end
mainWeaponsSection:addToggle("Automatic", isAuto, function(value)
    automaticOn = value
    spawn(function()
        while wait() do
            if automaticOn then
                Client.mode = "automatic"
            else
                Client.mode = "semi"
            end
        end
    end)
end)

local noBulletHoleButton = miscWeaponsSection:addToggle("No Bullet Holes", nil, function(value)
    noBulletHoleson = value
    pcall(function()
        local oldFunc
        if noBulletHoleson then
            oldFunc = hookfunction(Client.createbullethole, function() end)
        else
            hookfunction(Client.createbullethoes, oldFunc)
        end
    end)
end)
local noParticlesButton = miscWeaponsSection:addToggle("No Particles", nil, function(value)
    noParticleson = value
    pcall(function()
        local oldFunc
        if noParticleson then
            oldFunc = hookfunction(Client.createparticle, function() end)
        else
            hookfunction(Client.createparticle, oldFunc)
        end
    end)
end)
local noTrailsButton = miscWeaponsSection:addToggle("No Trails(For weapons like Railgun)", nil, function(value)
    noTrailson = value
    pcall(function()
        local oldFunc
        if noTrailson then
            oldFunc = hookfunction(Client.createtrail, function() end)
        else
            hookfunction(Client.createtrail, oldFunc)
        end
    end)
end)
local infJumpButton = playerSection:addToggle("Inf Jump", nil, function(value)
    infJumpon = value 
end)

playerSection:addSlider("Jump Power", Client.JP, 0, 500, function(value) JumpPower = value end)

playerSection:addSlider("FOV Adjuster", Client.defaultfov, 0, 120, function(value) Client.defaultfov = value end)

playerSection:addSlider("Walkspeed", walkspeed, 0, 500, function(value) walkspeed = value end)

local noclipButton = playerSection:addButton("Noclip(Press E to disable/enable)", nil, function(value)
    noclipon = value
end)

playerSection:addKeybind("Toggle UI Keybind", Enum.KeyCode.RightShift, function() 
    venyx:toggle()
end, 
function(value) toggleUIKey = value end)

silentAimSection:addDropdown("Silent Aim Prefered Mode", {"Shoot the enemy closest to your crosshair", "Shoot the enemy closest to your character"}, function(value)
    if value == "Shoot the enemy closest to your crosshair" then 
        preferedSilentAimMode = "getClosestToMouse" 
    elseif value == "Shoot the enemy closest to your character" then 
        preferedSilentAimMode = "getClosestToCharacter"
    end
end)
silentAimSection:addToggle("Silent Aim One Shot", nil, function(value)
    silentAimOneShot = value
end)

espFeaturesSection:addToggle("Tracers", nil, function(value)
    tracersOn = value
end)
espFeaturesSection:addToggle("Show Player Names", nil, function(value)
    playerNamesOn = value
end)
espFeaturesSection:addToggle("Show Distance", nil, function(value)
    showDistanceOn = value
end)
espFeaturesSection:addToggle("Show Health", nil, function(value)
    showHealthOn = value 
end)
espFeaturesSection:addToggle("Boxes(Quad Support Required)", nil, function(value)
    boxesOn = value
end)
espFeaturesSection:addToggle("Other Boxes(Use if the feature above doesnt work)", nil, function(value)
    espon = value
end)
espColorsSection:addColorPicker("Tracers Color", Color3.fromRGB(255, 105, 195), function(value)
    tracersColor = value
end)
espColorsSection:addColorPicker("Player Names Color", Color3.fromRGB(255, 105, 195), function(value)
    playerNamesColor = value
end)
espColorsSection:addColorPicker("Boxes Color", Color3.fromRGB(255, 105, 195), function(value)
    boxesColor = value
end)
espColorsSection:addToggle("Use Default Team Colors", nil, function(value)
    useDefaultTeamColors = value
end)

spawn(function()
    pcall(function()
        RunService.RenderStepped:Connect(function()
            if noclipon and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then LocalPlayer.Character.Humanoid:ChangeState(11) end
        end)
    end)
end)
spawn(function()
    pcall(function()
        while wait() do
            if infAmmoon then debug.setupvalue(Client.updtprimary, 1, 999) end 
            if walkspeed ~= 23.32 then LocalPlayer.Character.Humanoid.WalkSpeed = walkspeed end
            if JumpPower ~= Client.JP then LocalPlayer.Character.Humanoid.JumpPower = JumpPower end
        end
    end)
end)

local PlayerNames = {}
local PlayerLines = {}

spawn(function()
    pcall(function()
        RunService.RenderStepped:Connect(function()
            if tracersOn and not espPaused then
                if not syn then return end
                for i, v in pairs(Players:GetPlayers()) do
                    if v.Character and v.Character:FindFirstChild("HumanoidRootPart") then
                        if not hasVal(PlayerNames, v.Name) or PlayerLines[v.Name] == nil then
                            table.insert(PlayerNames, v.Name)
                            PlayerLines[v.Name] = Drawing.new("Line")

                            if v ~= LocalPlayer and not isSameTeam(LocalPlayer, v) then
                                local vector, onScreen = Camera:WorldToScreenPoint(v.Character.HumanoidRootPart.Position)

                                PlayerLines[v.Name].Visible = true
                                PlayerLines[v.Name].Transparency = 1
                                PlayerLines[v.Name].From = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y - 2)
                                PlayerLines[v.Name].To = Vector2.new(vector.x, vector.y)
                                if useDefaultTeamColors then
                                    PlayerLines[v.Name].Color = v.TeamColor.Color
                                else
                                    PlayerLines[v.Name].Color = tracersColor
                                end
                                PlayerLines[v.Name].Thickness = 2
                            end
                            
                        elseif hasVal(PlayerNames, v.Name) and PlayerLines[v.Name] ~= nil then
                            if v.Character and v.Character:FindFirstChild("HumanoidRootPart") and v ~= LocalPlayer and not isSameTeam(LocalPlayer, v) then
                                local vector, onScreen = Camera:WorldToScreenPoint(v.Character.HumanoidRootPart.Position)

                                if onScreen then
                                    PlayerLines[v.Name].From = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y - 2)
                                    PlayerLines[v.Name].To = Vector2.new(vector.x, vector.y)
                                    if useDefaultTeamColors then
                                        PlayerLines[v.Name].Color = v.TeamColor.Color
                                    else
                                        PlayerLines[v.Name].Color = tracersColor
                                    end
                                    PlayerLines[v.Name].Thickness = 2
                                    PlayerLines[v.Name].Visible = true
                                elseif not onScreen or not v.Status.Alive.Value then
                                    PlayerLines[v.Name].Visible = false
                                end
                            end 
                        end
                    end 
                end
            else
                if #PlayerNames >= 2 then
                    espPaused = true
                    removeESP(PlayerLines)
                    clearTable(PlayerNames)
                    clearTable(PlayerLines)
                    espPaused = false
                end
            end
        end)
    end)
end)


local PlayerNames2 = {}
local NamedPlayers = {}

spawn(function()
    pcall(function()
        RunService.RenderStepped:Connect(function()
            if playerNamesOn and not playerNamesPaused then
                for i, v in pairs(Players:GetPlayers()) do
                    if v.Character and v.Character:FindFirstChild("HumanoidRootPart") then
                        if not hasVal(PlayerNames2, v.Name) or NamedPlayers[i] == nil then
                            table.insert(PlayerNames2, v.Name)
                            NamedPlayers[i] = Drawing.new("Text")
                            
                            if v ~= LocalPlayer and not isSameTeam(LocalPlayer, v) then
                                local vector, onScreen = Camera:WorldToScreenPoint(v.Character.HumanoidRootPart.Position)
                                
                                NamedPlayers[i].Visible = true
                                NamedPlayers[i].Transparency = 1
                                NamedPlayers[i].Text = v.Name
                                NamedPlayers[i].Size = 14.0
                                if useDefaultTeamColors then
                                    NamedPlayers[i].Color = v.TeamColor.Color
                                else
                                    NamedPlayers[i].Color = playerNamesColor
                                end
                                NamedPlayers[i].Outline = true
                                NamedPlayers[i].Center = true
                                NamedPlayers[i].Position = Vector2.new(vector.X, vector.Y)
                            end
                        elseif hasVal(PlayerNames2, v.Name) and NamedPlayers[i] ~= nil then
                            if v.Character and v.Character:FindFirstChild("HumanoidRootPart") and v ~= LocalPlayer and not isSameTeam(LocalPlayer, v) then
                                local vector, onScreen = Camera:WorldToScreenPoint(v.Character.HumanoidRootPart.Position)
    
                                if onScreen then
                                    NamedPlayers[i].Position = Vector2.new(vector.X, vector.Y)
                                    if useDefaultTeamColors then
                                        NamedPlayers[i].Color = v.TeamColor.Color
                                    else
                                        NamedPlayers[i].Color = playerNamesColor
                                    end
                                    NamedPlayers[i].Transparency = 1
                                    NamedPlayers[i].Text = v.Name
                                    NamedPlayers[i].Size = 14.0
                                    NamedPlayers[i].Outline = true
                                    NamedPlayers[i].Center = true
                                    NamedPlayers[i].Visible = true
                                elseif not onScreen or not v.Status.Alive.Value then
                                    NamedPlayers[i].Visible = false
                                end
                            end
                        end
                    end
                end
            else
                if #PlayerNames2 >= 2 then
                    playerNamesPaused = true
                    removeESP(NamedPlayers)
                    clearTable(PlayerNames2)
                    clearTable(NamedPlayers)
                    playerNamesPaused = false
                end
            end
        end)
    end)
end)

local PlayerNames3 = {}
local TaggedPlayers = {}

spawn(function()
    pcall(function()
        RunService.RenderStepped:Connect(function()
            if showDistanceOn and not showDistancePaused then
                for i, v in pairs(Players:GetPlayers()) do
                    if v.Character and v.Character:FindFirstChild("HumanoidRootPart") then
                        if not hasVal(PlayerNames3, v.Name) or TaggedPlayers[i] == nil then
                            table.insert(PlayerNames3, v.Name)
                            TaggedPlayers[i] = Drawing.new("Text")
    
                            if v ~= LocalPlayer and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") and not isSameTeam(LocalPlayer, v) then
                                local vector, onScreen = Camera:WorldToScreenPoint(v.Character.HumanoidRootPart.Position)
    
                                TaggedPlayers[i].Visible = true
                                TaggedPlayers[i].Transparency = 1
                                TaggedPlayers[i].Text = tostring(math.floor(v:DistanceFromCharacter(LocalPlayer.Character.HumanoidRootPart.Position) + 0.5)) .. " studs"
                                TaggedPlayers[i].Size = 14.0
                                TaggedPlayers[i].Color = Color3.fromRGB(255, 255, 255)
                                TaggedPlayers[i].Outline = true
                                TaggedPlayers[i].Center = true
                                TaggedPlayers[i].Position = Vector2.new(vector.X + 60, vector.Y)
                            end
                        elseif hasVal(PlayerNames3, v.Name) and TaggedPlayers[i] ~= nil then
                            if v.Character and v.Character:FindFirstChild("HumanoidRootPart") and v ~= LocalPlayer and not isSameTeam(LocalPlayer, v) and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                                local vector, onScreen = Camera:WorldToScreenPoint(v.Character.HumanoidRootPart.Position)
    
                                if onScreen then
                                    TaggedPlayers[i].Text = tostring(math.floor(v:DistanceFromCharacter(LocalPlayer.Character.HumanoidRootPart.Position) + 0.5)) .. " studs"
                                    TaggedPlayers[i].Position = Vector2.new(vector.X + 60, vector.Y)
                                    TaggedPlayers[i].Size = 14.0
                                    TaggedPlayers[i].Transparency = 1
                                    TaggedPlayers[i].Color = Color3.fromRGB(255, 255, 255)
                                    TaggedPlayers[i].Outline = true
                                    TaggedPlayers[i].Center = true
                                    TaggedPlayers[i].Visible = true
                                elseif not onScreen or not v.Status.Alive.Value then
                                    TaggedPlayers[i].Visible = false
                                end
                            end
                        end
                    end
                end
            else
                if #PlayerNames3 >= 2 then
                    showDistancePaused = true
                    removeESP(TaggedPlayers)
                    clearTable(PlayerNames3)
                    clearTable(TaggedPlayers)
                    showDistancePaused = false
                end
            end
        end)
    end)
end)

local PlayerNames4 = {}
local BoxedPlayers = {}

spawn(function()
    pcall(function()
        RunService.RenderStepped:Connect(function()
            if boxesOn and not boxesPaused then
                for i, v in pairs(Players:GetPlayers()) do
                    if v.Character and v.Character:FindFirstChild("HumanoidRootPart") then
                        if not hasVal(PlayerNames4, v.Name) or BoxedPlayers[i] == nil then
                            table.insert(PlayerNames4, v.Name)
                            BoxedPlayers[i] = Drawing.new("Quad")
    
                            if v ~= LocalPlayer and not isSameTeam(LocalPlayer, v) and v.Status.Alive.Value then
                                local Size = Vector3.new(2, 3, 0) * ((v.Character.Head.Size.Y / 2) * 2)
                                
                                local TLPos, onScreen1 = WorldToViewport((v.Character.HumanoidRootPart.CFrame * CFrame.new(Size.X, Size.Y, 0)).Position)
                                local TRPos, onScreen2 = WorldToViewport((v.Character.HumanoidRootPart.CFrame * CFrame.new(-Size.X, Size.Y, 0)).Position)
                                local BLPos, onScreen3 = WorldToViewport((v.Character.HumanoidRootPart.CFrame * CFrame.new(Size.X, -Size.Y, 0)).Position)
                                local BRPos, onScreen4 = WorldToViewport((v.Character.HumanoidRootPart.CFrame * CFrame.new(-Size.X, -Size.Y, 0)).Position)
    
                                BoxedPlayers[i].Visible = true
                                BoxedPlayers[i].Transparency = 1 
                                BoxedPlayers[i].Thickness = 2
                                if useDefaultTeamColors then
                                    BoxedPlayers[i].Color = v.TeamColor.Color
                                else
                                    BoxedPlayers[i].Color = boxesColor
                                end
                                BoxedPlayers[i].Filled = false
                                if onScreen1 and onScreen2 and onScreen3 and onScreen4 then
                                    BoxedPlayers[i].PointA = Vector2.new(TLPos.X, TLPos.Y)
                                    BoxedPlayers[i].PointB = Vector2.new(TRPos.X, TRPos.Y)
                                    BoxedPlayers[i].PointC = Vector2.new(BRPos.X, BRPos.Y)
                                    BoxedPlayers[i].PointD = Vector2.new(BLPos.X, BLPos.Y)
                                end
                            end
                        elseif hasVal(PlayerNames4, v.Name) and BoxedPlayers[i] ~= nil then
                            if v.Character and v.Character:FindFirstChild("HumanoidRootPart") and v ~= LocalPlayer and not isSameTeam(LocalPlayer, v) and v.Status.Alive.Value then
                                local Size = Vector3.new(2, 3, 0) * ((v.Character.Head.Size.Y / 2) * 2)
                                
                                local TLPos, onScreen1 = WorldToViewport((v.Character.HumanoidRootPart.CFrame * CFrame.new(Size.X, Size.Y, 0)).Position)
                                local TRPos, onScreen2 = WorldToViewport((v.Character.HumanoidRootPart.CFrame * CFrame.new(-Size.X, Size.Y, 0)).Position)
                                local BLPos, onScreen3 = WorldToViewport((v.Character.HumanoidRootPart.CFrame * CFrame.new(Size.X, -Size.Y, 0)).Position)
                                local BRPos, onScreen4 = WorldToViewport((v.Character.HumanoidRootPart.CFrame * CFrame.new(-Size.X, -Size.Y, 0)).Position)
    
                                if onScreen1 and onScreen2 and onScreen3 and onScreen4 then
                                    BoxedPlayers[i].PointA = Vector2.new(TLPos.X, TLPos.Y)
                                    BoxedPlayers[i].PointB = Vector2.new(TRPos.X, TRPos.Y)
                                    BoxedPlayers[i].PointC = Vector2.new(BRPos.X, BRPos.Y)
                                    BoxedPlayers[i].PointD = Vector2.new(BLPos.X, BLPos.Y)
                                    if useDefaultTeamColors then
                                        BoxedPlayers[i].Color = v.TeamColor.Color
                                    else
                                        BoxedPlayers[i].Color = boxesColor
                                    end
                                    BoxedPlayers[i].Thickness = 2
                                    BoxedPlayers[i].Visible = true
                                elseif not onScreen or not v.Status.Alive.Value then
                                    BoxedPlayers[i].Visible = false
                                end
                            end
                        end
                    end
                end
            else
                if #PlayerNames4 >= 2 then
                    boxesPaused = true
                    removeESP(BoxedPlayers)
                    clearTable(PlayerNames4)
                    clearTable(BoxedPlayers)
                    boxesPaused = false
                end
            end
        end)
    end)
end)

local PlayerNames5 = {}
local HealthedPlayers = {}

spawn(function()
    pcall(function()
        RunService.RenderStepped:Connect(function()
            if showHealthOn and not showHealthPaused then
                for i, v in pairs(Players:GetPlayers()) do
                    if v.Character and v.Character:FindFirstChild("HumanoidRootPart") then
                        if not hasVal(PlayerNames5, v.Name) or HealthedPlayers[i] == nil then
                            table.insert(PlayerNames5, v.Name)
                            HealthedPlayers[i] = Drawing.new("Text")
    
                            if v ~= LocalPlayer and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") and not isSameTeam(LocalPlayer, v) then
                                local vector, onScreen = Camera:WorldToScreenPoint(v.Character.HumanoidRootPart.Position)
    
                                HealthedPlayers[i].Visible = true
                                HealthedPlayers[i].Transparency = 1
                                HealthedPlayers[i].Text = tostring(v.Character.Humanoid.Health) .. "/" .. tostring(v.Character.Humanoid.MaxHealth) .. " HP"
                                HealthedPlayers[i].Size = 14.0
                                HealthedPlayers[i].Color = Color3.fromRGB(255, 255, 255)
                                HealthedPlayers[i].Outline = true
                                HealthedPlayers[i].Center = true
                                HealthedPlayers[i].Position = Vector2.new(vector.X, vector.Y - 10)
                            end
                        elseif hasVal(PlayerNames5, v.Name) and HealthedPlayers[i] ~= nil then
                            if v.Character and v.Character:FindFirstChild("HumanoidRootPart") and v ~= LocalPlayer and not isSameTeam(LocalPlayer, v) and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                                local vector, onScreen = Camera:WorldToScreenPoint(v.Character.HumanoidRootPart.Position)
    
                                if onScreen then
                                    HealthedPlayers[i].Text = tostring(v.Character.Humanoid.Health) .. "/" .. tostring(v.Character.Humanoid.MaxHealth) .. " HP"
                                    HealthedPlayers[i].Position = Vector2.new(vector.X, vector.Y - 10)
                                    HealthedPlayers[i].Color = Color3.fromRGB(255, 255, 255)
                                    HealthedPlayers[i].Size = 14.0
                                    HealthedPlayers[i].Outline = true
                                    HealthedPlayers[i].Center = true
                                    HealthedPlayers[i].Transparency = 1
                                    HealthedPlayers[i].Visible = true
                                elseif not onScreen or not v.Status.Alive.Value then
                                    HealthedPlayers[i].Visible = false
                                end
                            end
                        end
                    end
                end
            else
                if #PlayerNames5 >= 2 then
                    showHealthPaused = true
                    removeESP(HealthedPlayers)
                    clearTable(PlayerNames5)
                    clearTable(HealthedPlayers)
                    showHealthPaused = false
                end
            end
        end)
    end)
end)

Players.PlayerRemoving:Connect(function()
    if tracersOn then
        espPaused = true
        removeESP(PlayerLines)
        clearTable(PlayerNames)
        clearTable(PlayerLines)
        espPaused = false
    end
    if playerNamesOn then
        playerNamesPaused = true
        removeESP(NamedPlayers)
        clearTable(PlayerNames2)
        clearTable(NamedPlayers)
        playerNamesPaused = false
    end
    if showDistanceOn then
        showDistancePaused = true
        removeESP(TaggedPlayers)
        clearTable(PlayerNames3)
        clearTable(TaggedPlayers)
        showDistancePaused = false
    end
    if boxesOn then
        boxesPaused = true
        removeESP(BoxedPlayers)
        clearTable(PlayerNames4)
        clearTable(BoxedPlayers)
        boxesPaused = false
    end
    if showHealthOn then
        showHealthPaused = true
        removeESP(HealthedPlayers)
        clearTable(PlayerNames5)
        clearTable(HealthedPlayers)
        showHealthPaused = false
    end
end)

spawn(function()
    pcall(function()
        RunService.RenderStepped:Connect(function()
            if espon then
                for i,v in pairs(Players:GetPlayers()) do
                    if v.Status.Alive.Value == true then
                        if not v.Character.HumanoidRootPart:FindFirstChild("scruc") and not isSameTeam(LocalPlayer, v) and v.Name ~= LocalPlayer.Name then
                            local part = Instance.new("BoxHandleAdornment")
                        
                            part.Name = "scruc"
                            part.AlwaysOnTop = true
                            part.Adornee = v.Character.HumanoidRootPart
                            part.ZIndex = 5
                            part.Parent = v.Character.HumanoidRootPart
                            part.Transparency = 0.6
                            part.Color3 = boxesColor
                            part.Size = v.Character.HumanoidRootPart.Size + Vector3.new(1, 1, 1)
                        elseif v.Character.HumanoidRootPart:FindFirstChild("scruc") and isSameTeam(LocalPlayer, v) then
                            v.Character.HumanoidRootPart:FindFirstChild("scruc"):Destroy()
                        end
                    end
                end
            else
                for i,v in pairs(Players:GetPlayers()) do
                    if v.Character and v.Character:FindFirstChild("HumanoidRootPart") and v.Character.HumanoidRootPart:FindFirstChild("scruc") then
                        v.Character.HumanoidRootPart.scruc:Destroy() 
                    end
                end
            end
        end)
    end)
end)

-- Config
local temp = {}
local config = {}
local guns = {"M9","Remington 870","AK-47","M4A1"}
local title = "Prison-Life GUI - v1.0"
local funcSupported = false

pcall(function()
    if (game.CoreGui:FindFirstChild("Esp") ~= nil) then
        game.CoreGui.Esp:Destroy()
        local Folder = Instance.new("Folder", game.CoreGui)
        Folder.Name = "Esp"
    else
        local Folder = Instance.new("Folder", game.CoreGui)
        Folder.Name = "Esp"
    end

    if (readfile and writefile and debug) then
        funcSupported = true
    end

    if (funcSupported) then
        if (readfile("prisonlife.json")) then
            config = game:GetService("HttpService"):JSONDecode(readfile("prisonlife.json"))
        end
    end
end)

-- Init
local library = loadstring(game:HttpGet("https://pastebin.com/raw/qwdPKKDN"))()
local window = library.new(title)

-- Pages
local guncheats = window:addPage("Guns", 5012544693)
local charactercheats = window:addPage("Character", 5012544693)
local teleports = window:addPage("Teleports", 5012544693)
local playeresp = window:addPage("Esp", 5012544693)
local misc = window:addPage("Misc", 5012544693)
local settings = window:addPage("Settings", 5012544693)

-- Sections: Gun Cheats
local mainGC1 = guncheats:addSection("Cheats")
local mainGC2 = guncheats:addSection("Guns")

-- Sections: Character Cheats
local mainCC = charactercheats:addSection("Cheats")

-- Sections: Teleports
local mainT1 = teleports:addSection("Prison")
local mainT2 = teleports:addSection("Criminal Base")

-- Sections: Player Esp
local mainPE1 = playeresp:addSection("Prisoners")
local mainPE2 = playeresp:addSection("Police")
local mainPE3 = playeresp:addSection("Criminals")
local mainPE4 = playeresp:addSection("Settings")

-- Sections: Misc
local mainM1 = misc:addSection("Misc")

-- Sections: Config
local mainS1

if (funcSupported) then
    mainS1 = settings:addSection("Config")
end

local mainS2 = settings:addSection("Theme")
local mainS3 = settings:addSection("Gui")

-- Interactables: Gun Cheats
mainGC1:addToggle("Infinite Ammo", nil, function(state)
    config["InfiniteAmmo"] = state
end)
mainGC1:addToggle("Auto Fire", nil, function(state)
    config["AutoFire"] = state
end)
mainGC1:addToggle("No Spread", nil, function(state)
    config["NoSpread"] = state
end)
mainGC1:addToggle("No Reload Time", nil, function(state)
    config["NoReloadTime"] = state
end)
mainGC1:addToggle("Rapid Fire", nil, function(state)
    config["RapidFire"] = state
end)
mainGC1:addToggle("Multi Bullet", nil, function(state)
    config["MultiBullet"] = state
end)
mainGC1:addButton("Apply All", function()
    for i,v in pairs(guns) do
        if (game.Players.LocalPlayer.Backpack:FindFirstChild(v)) then
            local rs = require(game.Players.LocalPlayer.Backpack:FindFirstChild(v).GunStates)
            for i,v in next, rs do
                rs.CurrentAmmo = math.huge
                rs.MaxAmmo = math.huge
                rs.AutoFire = true
                rs.Spread = 0
                rs.ReloadTime = 0
                rs.FireRate = 0
                rs.Bullets = 100
            end
        end
    end
end)
mainGC2:addButton("M9", function()
    local A_1 = game:GetService("Workspace")["Prison_ITEMS"].giver.M9.ITEMPICKUP
    local Event = game:GetService("Workspace").Remote.ItemHandler
    Event:InvokeServer(A_1)
end)
mainGC2:addButton("Shotgun", function()
    local A_1 = game:GetService("Workspace")["Prison_ITEMS"].giver["Remington 870"].ITEMPICKUP
    local Event = game:GetService("Workspace").Remote.ItemHandler
    Event:InvokeServer(A_1)
end)
mainGC2:addButton("AK-47", function()
    local A_1 = game:GetService("Workspace")["Prison_ITEMS"].giver["AK-47"].ITEMPICKUP
    local Event = game:GetService("Workspace").Remote.ItemHandler
    Event:InvokeServer(A_1)
end)
mainGC2:addButton("M4A1", function()
    local A_1 = game:GetService("Workspace")["Prison_ITEMS"].giver.M4A1.ITEMPICKUP
    local Event = game:GetService("Workspace").Remote.ItemHandler
    Event:InvokeServer(A_1)
end)
mainGC2:addButton("Riot Shield", function()
    local A_1 = game:GetService("Workspace")["Prison_ITEMS"].giver["Riot Shield"].ITEMPICKUP
    local Event = game:GetService("Workspace").Remote.ItemHandler
    Event:InvokeServer(A_1)
end)
mainGC2:addButton("Hammer", function()
    local A_1 = game:GetService("Workspace")["Prison_ITEMS"].single["Hammer"].ITEMPICKUP
    local Event = game:GetService("Workspace").Remote.ItemHandler
    Event:InvokeServer(A_1)
end)
mainGC2:addButton("Crude Knife", function()
    local A_1 = game:GetService("Workspace")["Prison_ITEMS"].single["Crude Knife"].ITEMPICKUP
    local Event = game:GetService("Workspace").Remote.ItemHandler
    Event:InvokeServer(A_1)
end)
mainGC2:addButton("Give All Guns", function()
    local paths = {
        game:GetService("Workspace")["Prison_ITEMS"].giver.M9.ITEMPICKUP,
        game:GetService("Workspace")["Prison_ITEMS"].giver["Remington 870"].ITEMPICKUP,
        game:GetService("Workspace")["Prison_ITEMS"].giver["AK-47"].ITEMPICKUP,
        game:GetService("Workspace")["Prison_ITEMS"].giver.M4A1.ITEMPICKUP,
        game:GetService("Workspace")["Prison_ITEMS"].giver["Riot Shield"].ITEMPICKUP,
        game:GetService("Workspace")["Prison_ITEMS"].single["Hammer"].ITEMPICKUP,
        game:GetService("Workspace")["Prison_ITEMS"].single["Crude Knife"].ITEMPICKUP
    }
    
    for i,v in pairs(paths) do
        local Event = game:GetService("Workspace").Remote.ItemHandler
        Event:InvokeServer(v)
    end
end)

-- Interactables: Character Cheats
mainCC:addSlider("WalkSpeed", 16, 16, 200, function(value)
    config["WalkSpeed"] = value
end)
mainCC:addSlider("JumpPower", 50, 50, 200, function(value)
    config["JumpPower"] = value
end)
mainCC:addToggle("Godmode", nil, function(state)
    config["GodMode"] = state
end)
mainCC:addToggle("Infinite Stamina", nil, function(state)
    config["InfiniteStamina"] = state
end)
mainCC:addButton("Btools", function()
    Instance.new("HopperBin", game.Players.LocalPlayer.Backpack).BinType = 1
    Instance.new("HopperBin", game.Players.LocalPlayer.Backpack).BinType = 3
    Instance.new("HopperBin", game.Players.LocalPlayer.Backpack).BinType = 4
end)
mainCC:addButton("Team Neutral", function()
    game:GetService("Workspace").Remote.TeamEvent:FireServer("Medium stone grey")
end)
mainCC:addButton("Team Prisoner", function()
    game:GetService("Workspace").Remote.TeamEvent:FireServer("Bright orange")
end)
mainCC:addButton("Team Guard", function()
    game:GetService("Workspace").Remote.TeamEvent:FireServer("Bright blue")
end)

-- Interactables: Teleports
mainT1:addButton("Cell Blocks", function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(Vector3.new(917.470581, 99.9899902, 2422.94263))
end)
mainT1:addButton("Main Hallway", function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(Vector3.new(855.681641, 99.9900055, 2362.7439))
end)
mainT1:addButton("Guard Room", function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(Vector3.new(835.0849, 99.9900055, 2312.85767))
end)
mainT1:addButton("Yard", function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(Vector3.new(822.401062, 98.1899414, 2404.22388))
end)
mainT1:addButton("Garage", function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(Vector3.new(615.874939, 98.0399399, 2481.35278))
end)
mainT2:addButton("Hanger", function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(Vector3.new(-915.732239, 94.1287842, 2064.94189))
end)
mainT2:addButton("Car Platform", function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(Vector3.new(-920.487244, 95.3272018, 2137.81763))
end)

-- Interactables: Player Esp
mainPE1:addToggle("Enabled", nil, function(state)
    config["PrisonerEsp"] = state
end)
mainPE1:addToggle("Nametag", nil, function(state)
    config["PrisonerNametagEsp"] = state
end)
mainPE1:addToggle("Health", nil, function(state)
    config["PrisonerHealthEsp"] = state
end)
mainPE2:addToggle("Enabled", nil, function(state)
    config["CriminalEsp"] = state
end)
mainPE2:addToggle("Nametag", nil, function(state)
    config["CriminalNametagEsp"] = state
end)
mainPE2:addToggle("Health", nil, function(state)
    config["CriminalHealthEsp"] = state
end)
mainPE3:addToggle("Enabled", nil, function(state)
    config["GuardEsp"] = state
end)
mainPE3:addToggle("Nametag", nil, function(state)
    config["GuardNametagEsp"] = state
end)
mainPE3:addToggle("Health", nil, function(state)
    config["GuardHealthEsp"] = state
end)
mainPE4:addDropdown("Font", {"Source Sans", "Source Sans Bold", "Gotham", "Gotham Bold"}, function(value)
    print(value)

    if (value == "Source Sans") then
        config["FontEsp"] = Enum.Font.SourceSans
    elseif (value == "Source Sans Bold") then
        config["FontEsp"] = Enum.Font.SourceSansBold
    elseif (value == "Gotham") then
        config["FontEsp"] = Enum.Font.Gotham
    elseif (value == "Gotham Bold") then
        config["FontEsp"] = Enum.Font.GothamBold
    end
end)
mainPE4:addSlider("Max Distance", 100, 100, 25000, function(value)
    config["MaxDistanceEsp"] = value
end)

-- Interactables: Misc
mainM1:addTextbox("Player", game.Players.LocalPlayer.Name, function(text)
    temp["player_kill"] = text
end)
mainM1:addButton("Kill", function()
    local player = temp["player_kill"]
    if (game.Players:FindFirstChild(player)) then
        if (player ~= game.Players.LocalPlayer.Name) then
            local hit_table = {
                [1] = {
                    ["RayObject"] = Ray.new(Vector3.new(845.555908, 101.429337, 2269.43945), Vector3.new(-390.73172, 3.2097764, -85.5477524)),
                    ["Distance"] = 3.222757101059,
                    ["Cframe"] = CFrame.new(840.317993, 101.286423, 2267.86035, 0.0517584644, 0.123365127, -0.991010666, 0, 0.992340803, 0.123530701, 0.99865967, -0.00639375951, 0.0513620302),
                    ["Hit"] = game:GetService("Workspace")[player].Torso
                }
            }
            if (not game.Players.LocalPlayer.Backpack:FindFirstChild("Remington 870")) then
                local A_1 = game:GetService("Workspace")["Prison_ITEMS"].giver["Remington 870"].ITEMPICKUP
                local Event = game:GetService("Workspace").Remote.ItemHandler
                Event:InvokeServer(A_1)
                game.ReplicatedStorage.ShootEvent:FireServer(hit_table, game.Players.LocalPlayer.Backpack:FindFirstChild("Remington 870"))
                game.ReplicatedStorage.ShootEvent:FireServer(hit_table, game.Players.LocalPlayer.Backpack:FindFirstChild("Remington 870"))
            end
        else
            window:Notify("Player Kill", "Player can not be you")
        end
    else
        window:Notify("Player Kill", "Player must be in the game")
    end  
end)

-- Interactables: Settings
if (funcSupported) then
    mainS1:addButton("Load Config", pcall(function()
        config = game:GetService("HttpService"):JSONDecode(readfile("prisonlife.json"))
    end))
    mainS1:addButton("Save Config", pcall(function()
        writefile("prisonlife.json", game:GetService("HttpService"):JSONEncode(config))
    end))
end
local themes = {
    Background = Color3.fromRGB(40,40,40),
    Accent = Color3.fromRGB(60,60,60),
    Glow = Color3.fromRGB(0, 0, 0),
    LightContrast = Color3.fromRGB(35,35,35),
    DarkContrast = Color3.fromRGB(30,30,30),  
    TextColor = Color3.fromRGB(255, 255, 255)
}
for theme, color in pairs(themes) do 
    mainS2:addColorPicker(theme, color, function(color3)
        window:setTheme(theme, color3)
    end)
end
mainS3:addButton("Delete Gui", function()
    game.CoreGui[title]:Destroy()
end)

-- Gui Settings
window:SelectPage(guncheats, true)
window:setTheme("DarkConstrast", Color3.fromRGB(30, 30, 30))
window:setTheme("LightConstrast", Color3.fromRGB(35, 35, 35))
window:setTheme("Background", Color3.fromRGB(40, 40, 40))
window:setTheme("Accent", Color3.fromRGB(60, 60, 60))

-- Functions
function CreateGunCheats()
    if (config["InfiniteAmmo"]) then
        for i,v in pairs(guns) do
            if (game.Players.LocalPlayer.Backpack:FindFirstChild(v)) then
                local rs = require(game.Players.LocalPlayer.Backpack:FindFirstChild(v).GunStates)
                for i,v in next, rs do
                    rs.CurrentAmmo = math.huge
                    rs.MaxAmmo = math.huge
                end
            end
        end
    end

    if (config["AutoFire"]) then
        for i,v in pairs(guns) do
            if (game.Players.LocalPlayer.Backpack:FindFirstChild(v)) then
                local rs = require(game.Players.LocalPlayer.Backpack:FindFirstChild(v).GunStates)
                for i,v in next, rs do
                    rs.AutoFire = true
                end
            end
        end
    end

    if (config["NoSpread"]) then
        for i,v in pairs(guns) do
            if (game.Players.LocalPlayer.Backpack:FindFirstChild(v)) then
                local rs = require(game.Players.LocalPlayer.Backpack:FindFirstChild(v).GunStates)
                for i,v in next, rs do
                    rs.Spread = 0
                end
            end
        end
    end

    if (config["NoReloadTime"]) then
        for i,v in pairs(guns) do
            if (game.Players.LocalPlayer.Backpack:FindFirstChild(v)) then
                local rs = require(game.Players.LocalPlayer.Backpack:FindFirstChild(v).GunStates)
                for i,v in next, rs do
                    rs.ReloadTime = 0
                end
            end
        end
    end

    if (config["RapidFire"]) then
        for i,v in pairs(guns) do
            if (game.Players.LocalPlayer.Backpack:FindFirstChild(v)) then
                local rs = require(game.Players.LocalPlayer.Backpack:FindFirstChild(v).GunStates)
                for i,v in next, rs do
                    rs.FireRate = 0
                end
            end
        end
    end

    if (config["MultiBullet"]) then
        for i,v in pairs(guns) do
            if (game.Players.LocalPlayer.Backpack:FindFirstChild(v)) then
                local rs = require(game.Players.LocalPlayer.Backpack:FindFirstChild(v).GunStates)
                for i,v in next, rs do
                    rs.Bullets = 100
                end
            end
        end
    end
end

function CreateCharacterCheats()
    if (config["WalkSpeed"]) then
        if (config["WalkSpeed"] > 16) then
            game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = config["WalkSpeed"]
        else
            game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 16
        end
    else
        config["WalkSpeed"] = 16
    end

    if (config["JumpPower"]) then
        if (config["JumpPower"] > 50) then
            game.Players.LocalPlayer.Character.Humanoid.JumpPower = config["JumpPower"]
        else
            game.Players.LocalPlayer.Character.Humanoid.JumpPower = 50
        end
    else
        config["JumpPower"] = 50
    end

    if (config["InfiniteStamina"]) then
        for _, v in pairs(getgc()) do
            if typeof(v) == "function" then
                local script = getfenv(v).script
                if script and typeof(script) == "Instance" then
                    if script == game.Players.LocalPlayer.Character.ClientInputHandler then
                        for a, s in pairs(debug.getupvalues(v)) do
                            if (a == 2 and type(s) == "number") then
                            	print(a,s)
                            end
                        end
                    end
                end
            end
        end
    end
end

function CreatePlayerEsp(v, team)
    -- Head Positions
    local LocalPlayerHead = game.workspace[game.Players.LocalPlayer.Name].Head.Position
    local PlayerHead = game.workspace[v.Name].Head.Position
    
    -- Calculate Distance
    local Magnitude = (PlayerHead - LocalPlayerHead).Magnitude
    local dist = math.round(Magnitude)
    
    -- Main Esp
    local Gui = Instance.new("BillboardGui")
    local TextLabel = Instance.new("TextLabel")
    
    -- Main Gui
    Gui.Name = v.Name
    Gui.Parent = game.CoreGui:FindFirstChild("Esp")
    Gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    Gui.Active = true
    Gui.AlwaysOnTop = true
    Gui.Adornee = game.Workspace[v.Name].Head
    Gui.Size = UDim2.new(100.000, 0, 16.000, 0)
    
    -- TextLabel
    TextLabel.Parent = Gui
    TextLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    TextLabel.BackgroundTransparency = 1.000
    TextLabel.Position = UDim2.new(0, 0, 0, 0)
    TextLabel.Size = UDim2.new(1.000, 0, 1.000, 0)
    TextLabel.TextScaled = false

    if (config["FontEsp"]) then
        TextLabel.Font = config["FontSizeEsp"]
    else
        config["FontEsp"] = Enum.Font.SourceSansBold
    end
    
    if (config["FontSizeEsp"]) then
        TextLabel.TextSize = config["FontSizeEsp"]
    else
        config["FontSizeEsp"] = 14.000
    end

    TextLabel.TextWrapped = false
    TextLabel.TextStrokeTransparency = 0
    TextLabel.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)

    -- Set Text/TextColor based on Team/Options
    if (team == "Prisoner") then
        TextLabel.TextColor3 = Color3.fromRGB(218, 133, 65)
        if (config["PrisonerNametagEsp"]) then
            if (config["PrisonerHealthEsp"]) then
                TextLabel.Text = TextLabel.Text .. v.Name .. "\n" .. "Health: " .. math.round(v.Character.Humanoid.Health)
            else
                TextLabel.Text = TextLabel.Text .. v.Name
            end
        end
    elseif (team == "Criminal") then
        TextLabel.TextColor3 = Color3.fromRGB(255, 0, 0)
        if (config["CriminalNametagEsp"]) then
            TextLabel.Text = TextLabel.Text .. v.Name
            if (config["CriminalHealthEsp"]) then
                TextLabel.Text = TextLabel.Text .. v.Name .. "\n" .. "Health: " .. math.round(v.Character.Humanoid.Health)
            else
                TextLabel.Text = TextLabel.Text .. v.Name
            end
        end
    elseif (team == "Guard") then
        TextLabel.TextColor3 = Color3.fromRGB(13, 105, 172)
        if (config["GuardNametagEsp"]) then
            TextLabel.Text = TextLabel.Text .. v.Name
            if (config["GuardHealthEsp"]) then
                TextLabel.Text = TextLabel.Text .. v.Name .. "\n" .. "Health: " .. math.round(v.Character.Humanoid.Health)
            else
                TextLabel.Text = TextLabel.Text .. v.Name
            end
        end
    end
end

function CreateEspCheats()
    for i,v in pairs(game.Players:GetPlayers()) do
        if (i ~= 1) then
            if (game.Workspace:FindFirstChild(v.Name)) then
                local Distance = math.round((game.Players.LocalPlayer.Character.HumanoidRootPart.Position - v.Character.HumanoidRootPart.Position).Magnitude)
                if (game.CoreGui.Esp:FindFirstChild(v.Name)) then
                    game.CoreGui.Esp:FindFirstChild(v.Name):Destroy()
                    if (config["MaxDistanceEsp"]) then
                        if (Distance < config["MaxDistanceEsp"]) then
                            if (config["PrisonerEsp"]) then
                                if (v.TeamColor == BrickColor.new("Bright orange")) then
                                    CreatePlayerEsp(v, "Prisoner")
                                end
                            end
                            if (config["CriminalEsp"]) then
                                if (v.TeamColor == BrickColor.new("Really red")) then
                                    CreatePlayerEsp(v, "Criminal")
                                end
                            end
                            if (config["GuardEsp"]) then
                                if (v.TeamColor == BrickColor.new("Bright blue")) then
                                    CreatePlayerEsp(v, "Guard")
                                end
                            end
                        end
                    else
                        config["MaxDistanceEsp"] = 100
                    end
                else
                    if (config["MaxDistanceEsp"]) then
                        if (Distance < config["MaxDistanceEsp"]) then
                            if (config["PrisonerEsp"]) then
                                if (v.TeamColor == BrickColor.new("Bright orange")) then
                                    CreatePlayerEsp(v, "Prisoner")
                                end
                            end
                            if (config["CriminalEsp"]) then
                                if (v.TeamColor == BrickColor.new("Really red")) then
                                    CreatePlayerEsp(v, "Criminal")
                                end
                            end
                            if (config["GuardEsp"]) then
                                if (v.TeamColor == BrickColor.new("Bright blue")) then
                                    CreatePlayerEsp(v, "Guard")
                                end
                            end
                        end
                    else
                        config["MaxDistanceEsp"] = 100
                    end
                end
            else
                if (game.CoreGui.Esp:FindFirstChild(v.Name)) then
                    game.CoreGui.Esp:FindFirstChild(v.Name):Destroy()
                end
            end
        end
    end
end

-- Loop
local savetable = {}
local activated = false
game:GetService("RunService").RenderStepped:Connect(function()
    -- Godmode
    if (game.Players.LocalPlayer.Character.Humanoid.Health == 0) then
	    if (config["GodMode"]) then
            if (not activated) then
                activated = true
               -- Save Tools
                local Backpack = game.Players.LocalPlayer.Backpack

                for i,v in pairs(Backpack:GetChildren()) do
                    if (v:IsA("Tool")) then
                        local clone = v:Clone()
                        table.insert(savetable, clone)
                    end
                end

                -- Load Character
                local Pos = game.Players.LocalPlayer.Character.HumanoidRootPart.Position
                workspace.Remote.TeamEvent:FireServer("Bright orange")
                workspace.Remote.loadchar:InvokeServer(game.Players.LocalPlayer.Name)
                workspace.Remote.TeamEvent:FireServer("Medium stone grey")
                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(Pos)

                -- Load Tools
                for i,v in pairs(savetable) do
                    v.Parent = game.Players.LocalPlayer.Backpack
                end

                activated = false
            end
        end
    end

    CreateGunCheats()
    CreateCharacterCheats()  
    CreateEspCheats()
end)

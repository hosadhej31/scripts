local EspLib = {}
EspLib.__index = EspLib
local self = setmetatable(EspLib, {})

EspLib.Options = {
    Enable = false,
    TeamCheck = false,
    TeamColor = false,
    VisibleOnly = false,
    Color = Color3.fromRGB(255, 255, 255),
    Name = false,
    Box = false,
    Health = false,
    Distance = false,
    Tracer = false,
    Font = "UI"
}

EspLib.Services = setmetatable({}, {
    __index = function(Self, Index)
        local GetService = game.GetService
        local Service = GetService(game, Index)

        if Service then
            Self[Index] = Service
        end

        return Service
    end
})

function EspLib:Toggle(state)
    if (state) then
        EspLib.Options.Enable = state
    else
        EspLib.Options.Enable = not EspLib.Options.Enable
    end
end

function EspLib:SetOptions(options)
    assert(options, "bad argument #1 to '?' (table expected, got no value)")
    assert(type(options) == "table", "bad argument #1 to '? (table expected, got " .. type(options) .. ")")
    EspLib.Options = options
end

local function GetDrawingObjects()
    return {
        Name = Drawing.new("Text"),
        Box = Drawing.new("Quad"),
        Tracer = Drawing.new("Line"),
    }
end

local function CreateEsp(Player)
    local Objects = GetDrawingObjects()
    local Character = Player.Character
    local Head = Character.Head
    local HeadPosition = Head.Position
    local Head2dPosition, OnScreen = workspace.CurrentCamera:WorldToScreenPoint(HeadPosition)
    local Origin = workspace.CurrentCamera.CFrame.p
    local HeadPos = Player.Character.Head.Position
    local IgnoreList = { Player.Character, EspLib.Services.Players.LocalPlayer.Character }
    local PlayerRay = Ray.new(Origin, HeadPos - Origin)
    local Hit = workspace:FindPartOnRayWithIgnoreList(PlayerRay, IgnoreList)

    local function Create()
        if (OnScreen) then
            local Name = ""
            local Health = ""
            local Distance = ""
    
            if (EspLib.Options.Name) then
                Name = Player.Name
            end
    
            if (EspLib.Options.Health) then
                Health = " [ " .. Character.Humanoid.Health .. " ]"
            end
    
            if (EspLib.Options.Distance) then
                Distance = " [ " .. math.round((HeadPosition - workspace.CurrentCamera.CFrame.p).Magnitude) .. " ]"
            end
    
            Objects.Name.Visible = true
            Objects.Name.Transparency = 1
            Objects.Name.Text = string.format("%s%s%s", Name, Health, Distance)
            Objects.Name.Size = 18
            Objects.Name.Center = true
            Objects.Name.Outline = true
            Objects.Name.OutlineColor = Color3.fromRGB(0, 0, 0)
            Objects.Name.Position = Vector2.new(Head2dPosition.X, Head2dPosition.Y)
            Objects.Name.Font = Drawing,Font[EspLib.Options.Font]
    
            if (EspLib.Options.TeamColor) then
                Objects.Name.Color = Player.Team.TeamColor.Color
            else
                Objects.Name.Color = EspLib.Options.Color
            end
    
            if (EspLib.Options.Box) then
                local Part = Character.HumanoidRootPart
                local Size = Part.Size * Vector3.new(1, 1.5)
                local Sizes = {
                    TopRight = (Part.CFrame * CFrame.new(-Size.X, -Size.Y, 0)).Position,
                    BottomRight = (Part.CFrame * CFrame.new(-Size.X, Size.Y, 0)).Position,
                    TopLeft = (Part.CFrame * CFrame.new(Size.X, -Size.Y, 0)).Position,
                    BottomLeft = (Part.CFrame * CFrame.new(Size.X, Size.Y, 0)).Position,
                }
    
                local TL, OnScreenTL = workspace.CurrentCamera:WorldToScreenPoint(Sizes.TopLeft)
                local TR, OnScreenTR = workspace.CurrentCamera:WorldToScreenPoint(Sizes.TopRight)
                local BL, OnScreenBL = workspace.CurrentCamera:WorldToScreenPoint(Sizes.BottomLeft)
                local BR, OnScreenBR = workspace.CurrentCamera:WorldToScreenPoint(Sizes.BottomRight)
    
                if (OnScreenTL and OnScreenTR and OnScreenBL and OnScreenBR) then
                    Objects.Box.Visible = true
                    Objects.Box.Transparency = 1
                    Objects.Box.Thickness = 2
                    Objects.Box.Filled = false
                    Objects.Box.PointA = Vector2.new(TL.X, TL.Y + 36)
                    Objects.Box.PointB = Vector2.new(TR.X, TR.Y + 36)
                    Objects.Box.PointC = Vector2.new(BR.X, BR.Y + 36)
                    Objects.Box.PointD = Vector2.new(BL.X, BL.Y + 36)
    
                    if (EspLib.Options.TeamColor) then
                        Objects.Box.Color = Player.Team.TeamColor.Color
                    else
                        Objects.Box.Color = EspLib.Options.Color
                    end
                end
            end
    
            if (EspLib.Options.Tracer) then
                local CharTorso = Character:FindFirstChild("Torso") or Character:FindFirstChild("UpperTorso")
                local Torso, OnScreen = workspace.CurrentCamera:WorldToScreenPoint(CharTorso.Position)
    
                if (OnScreen) then
                    Objects.Tracer.Visible = true
                    Objects.Tracer.Transparency = 1
                    Objects.Tracer.Thickness = 2
                    Objects.Tracer.From = Vector2.new(workspace.CurrentCamera.ViewportSize.X / 2, workspace.CurrentCamera.ViewportSize.Y / 2)
                    Objects.Tracer.To = Vector2.new(Torso.X, Torso.Y + 36)
    
                    if (EspLib.Options.TeamColor) then
                        Objects.Tracer.Color = Player.Team.TeamColor.Color
                    else
                        Objects.Tracer.Color = EspLib.Options.Color
                    end
                end
            end
        end
    end

    if (EspLib.Options.VisibleOnly) then
        if (Hit == nil) then
            Create()
        end
    else
        Create()
    end

    EspLib.Services.RunService.Heartbeat:Wait()
    EspLib.Services.RunService.Heartbeat:Wait()

    Objects.Name:Remove()
    Objects.Box:Remove()
    Objects.Tracer:Remove()
end

EspLib.Services.RunService.RenderStepped:Connect(function()
    local LocalPlayer = EspLib.Services.Players.LocalPlayer

    for i,v in pairs(EspLib.Services.Players:GetPlayers()) do
        if (v.Name ~= LocalPlayer.Name) then
            if (EspLib.Options.Enable) then
                if (EspLib.Options.TeamCheck) then
                    if (v.Team ~= LocalPlayer.Team) then
                        CreateEsp(v)
                    end
                else
                    CreateEsp(v)
                end
            end
        end
    end
end)

return EspLib

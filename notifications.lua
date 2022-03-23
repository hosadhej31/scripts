-- Services
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")

-- Cache
local CurrentCamera = workspace.CurrentCamera

-- Module
local NotificationsLib = {Drawings = {}}

local function Create(Class, Properties)
    local Object = Drawing.new(Class)

    for i,v in pairs(Properties) do
        Object[i] = v
    end

    table.insert(NotificationsLib.Drawings, Object)
    return Object
end

local function IsInArea(Object)
    local Mouse = UserInputService:GetMouseLocation()
    return (Mouse.X > Object.Position.X and Mouse.X < Object.Position.X + Object.Size.X) and (Mouse.Y > Object.Position.Y and Mouse.Y < Object.Position.Y + Object.Size.Y)
end

function NotificationsLib:Window(Title, Description, Callback)
    local WindowUtils = {}
    local MainSize = Vector2.new(350, 125)

    local DarkOutlineBox = Create("Square", {
        Visible = true,
        Transparency = 1,
        Color = Color3.fromRGB(24, 24, 24),
        Size = MainSize + Vector2.new(4, 4),
        Filled = true,
        ZIndex = 1
    })

    local HighlitedOutlineBox = Create("Square", {
        Visible = true,
        Transparency = 1,
        Color = Color3.fromRGB(255, 65, 65),
        Size = MainSize + Vector2.new(2, 2),
        Filled = true,
        ZIndex = 2
    })

    local MainBox = Create("Square", {
        Visible = true,
        Transparency = 1,
        Color = Color3.fromRGB(36, 36, 36),
        Size = MainSize,
        Filled = true,
        ZIndex = 3
    })

    local TitleBox = Create("Square", {
        Visible = true,
        Transparency = 1,
        Color = Color3.fromRGB(24, 24, 24),
        Size = Vector2.new(MainSize.X, 20),
        Filled = true,
        ZIndex = 4
    })

    local TitleText = Create("Text", {
        Visible = true,
        Transparency = 1,
        Color = Color3.new(1, 1, 1),
        Text = Title,
        Outline = true,
        OutlineColor = Color3.new(),
        Font = 2,
        Size = 13,
        ZIndex = 5,
    })

    local DescriptionText = Create("Text", {
        Visible = true,
        Transparency = 1,
        Color = Color3.new(1, 1, 1),
        Text = Description,
        Center = true,
        Outline = true,
        OutlineColor = Color3.new(),
        Font = 2,
        Size = 13,
        ZIndex = 5,
    })

    local ButtonOutline = Create("Square", {
        Visible = true,
        Transparency = 1,
        Color = Color3.fromRGB(255, 65, 65),
        Size = Vector2.new(102, 22),
        Filled = true,
        ZIndex = 6
    })

    local Button = Create("Square", {
        Visible = true,
        Transparency = 1,
        Color = Color3.fromRGB(24, 24, 24),
        Size = Vector2.new(100, 20),
        Filled = true,
        ZIndex = 7
    })

    local ButtonText = Create("Text", {
        Visible = true,
        Transparency = 1,
        Color = Color3.new(1, 1, 1),
        Text = "OK",
        Center = false,
        Outline = true,
        OutlineColor = Color3.new(),
        Font = 2,
        Size = 13,
        ZIndex = 8,
    })

    local MouseBlockOutline = Create("Square", {
        Visible = true,
        Transparency = 1,
        Color = Color3.fromRGB(255, 65, 65),
        Size = Vector2.new(8, 8),
        Filled = true,
        ZIndex = 9999
    })

    local MouseBlock = Create("Square", {
        Visible = true,
        Transparency = 1,
        Color = Color3.new(1, 1, 1),
        Size = Vector2.new(6, 6),
        Filled = true,
        ZIndex = 10000
    })

    local Connection = RunService.Heartbeat:Connect(function()
        local CenterPos = Vector2.new((CurrentCamera.ViewportSize.X / 2) - (MainSize.X / 2), (CurrentCamera.ViewportSize.Y / 2) - (MainSize.Y / 2))
        local ButtonPos = CenterPos + Vector2.new((MainSize.X / 2) - (Button.Size.X / 2), ((MainSize.Y / 2) - (Button.Size.Y / 2)) + TitleBox.Size.Y)

        DarkOutlineBox.Position = CenterPos - Vector2.new(2, 2)
        HighlitedOutlineBox.Position = CenterPos - Vector2.new(1, 1)
        MainBox.Position = CenterPos
        TitleBox.Position = CenterPos
        TitleText.Position = TitleBox.Position + Vector2.new(5, ((TitleText.TextBounds.Y / 2) - (TitleBox.Size.Y / 4)) + 2)
        DescriptionText.Position = TitleBox.Position + Vector2.new(TitleBox.Size.X / 2, ((DescriptionText.TextBounds.Y / 2) + (TitleBox.Size.Y * 3) / 2) + 1)
        ButtonOutline.Position = ButtonPos - Vector2.new(1, 1)
        Button.Position = ButtonPos
        ButtonText.Position = Button.Position + Vector2.new((Button.Size.X / 2) - (ButtonText.TextBounds.X / 2), (Button.Size.Y / 2) - (ButtonText.TextBounds.Y / 2))
        MouseBlockOutline.Position = UserInputService:GetMouseLocation()
        MouseBlock.Position = MouseBlockOutline.Position + Vector2.new(1, 1)

        local ShowMouse = IsInArea(DarkOutlineBox)

        MouseBlockOutline.Visible = ShowMouse
        MouseBlock.Visible = ShowMouse

        if (IsInArea(ButtonOutline) and UserInputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton1)) then
            Callback()
            WindowUtils:Unload()
        end
    end)

    function WindowUtils:Unload()
        for i,v in pairs(NotificationsLib.Drawings) do
            v:Remove()
        end

        Connection:Disconnect()
    end

    return WindowUtils
end

return NotificationsLib

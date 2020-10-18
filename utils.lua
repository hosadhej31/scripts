local utils = {}
function Utils:CreateEsp(Options)
	local options = (Options or Default = {
		EspName = "Esp",
		Parent = game.CoreGui,
		Adornee = game.CoreGui,
		TextFont = Enum.Font.Gotham,
		TextStroke = false,
		TextColor = Color3.new(1, 1, 1),
		Text = "Default",
	})

  -- Main Esp
  local Esp = Instance.new("BillboardGui")
  local TextLabel = Instance.new("TextLabel")


  -- Main Gui
  Volt.Name = options.EspName
  Volt.Parent = options.Parent
  Volt.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
  Volt.Active = true
  Volt.AlwaysOnTop = true
  Volt.Adornee = options.Adornee
  Volt.Size = UDim2.new(100.000, 0, 16.000, 0)

  -- TextLabel
  TextLabel.Parent = Volt
  TextLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
  TextLabel.BackgroundTransparency = 1.000
  TextLabel.Position = UDim2.new(0, 0, 0, 0)
  TextLabel.Size = UDim2.new(1.000, 0, 1.000, 0)
  TextLabel.Font = Enum.Font.Gotham
  TextLabel.TextScaled = true
  TextLabel.TextSize = 14.000
  TextLabel.TextWrapped = false
  TextLabel.Text = options.text

  if (options.TextStroke) then
    TextLabel.TextStrokeTransparency = 0
  else
    TextLabel.TextStrokeTransparency = 1
  end

  TextLabel.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
  TextLabel.TextColor3 = options.Color
end
return utils

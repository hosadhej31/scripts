local Esp = {
	Container = {},
	Settings = {
		Enabled = false,
		Name = false,
		Box = false,
		Health = false,
		Distance = false,
		Tracer = false,
		TeamCheck = false,
		TextSize = 13,
		TextFont = Drawing.Fonts.Plex,
		Range = 0
	}
}

local Camera = workspace.CurrentCamera
local WorldToViewportPoint = Camera.WorldToViewportPoint
local v2new = Vector2.new
local Player = game:GetService("Players").LocalPlayer
local TracerStart = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y - 36)

local CheckVis = newcclosure(function(esp, inview)
	if not inview or (Esp.Settings.TeamCheck and not Esp.TeamCheck(esp.Player)) or (esp.Root.Position - Camera.CFrame.Position).Magnitude > Esp.Settings.Range then
		esp.Name.Visible = false
		esp.Box.Visible = false
		esp.Box1.Visible = false
		esp.Box2.Visible = false
		esp.Health.Visible = false
		esp.Distance.Visible = false
		esp.Tracer.Visible = false
		return
	end
    
	esp.Name.Visible = Esp.Settings.Name
	esp.Box.Visible = Esp.Settings.Box
	esp.Box1.Visible = Esp.Settings.Box
	esp.Box2.Visible = Esp.Settings.Box
	esp.Health.Visible = Esp.Settings.Health
	esp.Distance.Visible = Esp.Settings.Distance
	esp.Tracer.Visible = Esp.Settings.Tracer
end)

-- newcclosure breaks Drawing.new apparently
Esp.Add = function(plr, root, col)
	if Esp.Container[root] then
        local Container = Esp.Container[root]
        Container.Connection:Disconnect()
		Container.Name:Remove()
		Container.Box:Remove()
		Container.Box1:Remove()
		Container.Box2:Remove()
		Container.Health:Remove()
		Container.HealthBack:Remove()
		Container.Distance:Remove()
		Container.Tracer:Remove()
		Esp.Container[root] = nil
	end
	local Holder = {
		Name = Drawing.new("Text"),
		Box = Drawing.new("Square"),
		Box1 = Drawing.new("Square"),
		Box2 = Drawing.new("Square"),
		Health = Drawing.new("Square"),
		HealthBack = Drawing.new("Square"),
		Distance = Drawing.new("Text"),
		Tracer = Drawing.new("Line"),
		Player = plr,
		Root = root,
		Colour = col
	}
	Esp.Container[root] = Holder

    Holder.Name.Text = plr.Name
    Holder.Name.Size = Esp.Settings.TextSize
    Holder.Name.Font = Esp.Settings.TextFont
    Holder.Name.Center = true
	Holder.Name.Color = col
    Holder.Name.Outline = true

    Holder.Box.Thickness = 1
	Holder.Box.Color = col
	Holder.Box.Filled = false

	Holder.Box1.Thickness = 1
	Holder.Box1.Color = Color3.fromRGB(0, 0, 0)
	Holder.Box1.Filled = false

	Holder.Box2.Thickness = 1
	Holder.Box2.Color = Color3.fromRGB(0, 0, 0)
	Holder.Box2.Filled = false

	Holder.Health.Thickness = 1
	Holder.Health.Color = Color3.fromRGB(0, 255, 0)
    Holder.Health.Filled = true

	Holder.HealthBack.Thickness = 1
	Holder.HealthBack.Color = Color3.fromRGB(0, 0, 0)
    Holder.HealthBack.Filled = true

    Holder.Distance.Size = Esp.Settings.TextSize
    Holder.Distance.Center = true
	Holder.Distance.Color = col
    Holder.Distance.Font = Esp.Settings.TextFont
	Holder.Distance.Outline = true

	Holder.Tracer.From = TracerStart
	Holder.Tracer.Color = col
    Holder.Tracer.Thickness = 1

	Holder.Connection = game:GetService("RunService").Stepped:Connect(function()
		if Esp.Settings.Enabled then
			local Pos, Vis = WorldToViewportPoint(Camera, root.Position)

			if Vis then
                local CF = CFrame.new(root.Position, workspace.CurrentCamera.CFrame.p)
                local Size = root.Size * Vector3.new(1, 1.5)
                local Sizes = {
                    TopRight = (CF * CFrame.new(-Size.X, -Size.Y, 0)).Position,
                    BottomRight = (CF * CFrame.new(-Size.X, Size.Y, 0)).Position,
                    TopLeft = (CF * CFrame.new(Size.X, -Size.Y, 0)).Position,
                    BottomLeft = (CF * CFrame.new(Size.X, Size.Y, 0)).Position,
                }

                local TopLeft = workspace.CurrentCamera:WorldToScreenPoint(Sizes.TopLeft)
                local BottomLeft = workspace.CurrentCamera:WorldToScreenPoint(Sizes.BottomLeft)
				local X = TopLeft.X - BottomLeft.X
				local BoxSize = v2new(X, X * 1.4)
				local Health = Esp.GetHealth(plr)

				Holder.Box.Size = BoxSize
				Holder.Box.Position = v2new(Pos.X - BoxSize.X / 2, Pos.Y - BoxSize.Y / 2)

				Holder.Box1.Size = v2new(BoxSize.X + 2, BoxSize.Y + 2)
				Holder.Box1.Position = v2new((Pos.X - BoxSize.X / 2) - 1, (Pos.Y - BoxSize.Y / 2) + 2)

				Holder.Box2.Size = v2new(BoxSize.X - 2, BoxSize.Y - 2)
				Holder.Box2.Position = v2new((Pos.X - BoxSize.X / 2) + 1, (Pos.Y - BoxSize.Y / 2) - 2)

				Holder.Health.Color = Color3.fromRGB(255 - ((Health / 100) * 255), (Health / 100) * 255, 0)
				Holder.Health.Size = v2new(1.5, BoxSize.Y * Health)
				Holder.Health.Position = v2new(Pos.X - (BoxSize.X / 2 + 4), (Pos.Y - BoxSize.Y / 2) + ((1 - Health) * BoxSize.Y))

				Holder.HealthBack.Size = v2new(1.7, (BoxSize.Y * 100) + 2)
				Holder.HealthBack.Position = v2new(Pos.X - (BoxSize.X / 2 + 4) - 1, (Pos.Y - BoxSize.Y / 2) + ((1 - Health) * BoxSize.Y) - 1)

				Holder.Distance.Text = math.floor((root.Position - Camera.CFrame.Position).Magnitude) .. " Studs"
				Holder.Distance.Position = v2new(Pos.X, Pos.Y + BoxSize.X / 2 + 4)
				Holder.Distance.Font = Esp.Settings.TextFont
				Holder.Distance.Size = Esp.Settings.TextSize

				Holder.Name.Position = v2new(Pos.X, Pos.Y - BoxSize.X / 2 - (4 + Esp.Settings.TextSize))
				Holder.Name.Font = Esp.Settings.TextFont
				Holder.Name.Size = Esp.Settings.TextSize

				Holder.Tracer.To = v2new(Pos.X, Pos.Y + BoxSize.Y / 2)
			end
			
			CheckVis(Holder, Vis)
		elseif Holder.Name.Visible then
			Holder.Name.Visible = false
			Holder.Box.Visible = false
			Holder.Box1.Visible = false
			Holder.Box2.Visible = false
			Holder.Health.Visible = false
			Holder.Distance.Visible = false
			Holder.Tracer.Visible = false
		end
	end)
end

Esp.Remove = newcclosure(function(root)
	for i, v in next, Esp.Container do
		if i == root then
			v.Connection:Disconnect()
			v.Name:Remove()
			v.Box:Remove()
			v.Box1:Remove()
			v.Box2:Remove()
			v.Health:Remove()
			v.Distance:Remove()
			v.Tracer:Remove()
		end
	end
	Esp.Container[root] = nil
end)

Esp.TeamCheck = newcclosure(function(plr)
	return plr.Team == Player.Team
end)
if game.PlaceId == 3233893879 then
    Esp.TeamCheck = newcclosure(function(plr)
        local Module = game:GetService("ReplicatedStorage").TS
        Module = require(Module)
        return Module.Teams:ArePlayersFriendly(Player, plr)
    end)
end
Esp.GetHealth = newcclosure(function(plr)
	return plr.Character.Humanoid.Health / plr.Character.Humanoid.MaxHealth
end)
if game.PlaceId == 292439477 then
    local GetPlayerHealthTable
    for I,V in pairs(getgc(true)) do
        if type(V) == "table" and rawget(V, "getplayerhealth") and rawget(V, "isplayeralive") then
            GetPlayerHealthTable = V
        end
    end
    Esp.GetHealth = newcclosure(function(plr)
        return GetPlayerHealthTable:getplayerhealth(plr) / 100
    end)
end

Esp.UpdateTextSize = newcclosure(function(num)
	Esp.Settings.TextSize = num
	for i, v in next, Esp.Container do
		v.Name.Size = num
		v.Distance.Size = num
	end
end)

Esp.UpdateTracerStart = newcclosure(function(pos)
    TracerStart = pos
    for i, v in next, Esp.Container do
        v.Tracer.From = pos
    end
end)

Esp.ToggleRainbow = newcclosure(function(bool)
	if Esp.RainbowConn then
		Esp.RainbowConn:Disconnect()
	end
	if bool then
		Esp.RainbowConn = game:GetService("RunService").Heartbeat:Connect(function()
			local Colour = Color3.fromHSV(tick() % 12 / 12, 1, 1)
			for i, v in next, Esp.Container do
				v.Name.Color = Colour
				v.Box.Color = Colour
				v.Distance.Color = Colour
				v.Tracer.Color = Colour
			end
		end)
	else
		for i, v in next, Esp.Container do
			v.Name.Color = v.Colour
			v.Box.Color = v.Colour
			v.Distance.Color = v.Colour
			v.Tracer.Color = v.Colour
		end
	end
end)

return Esp

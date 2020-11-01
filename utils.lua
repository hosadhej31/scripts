local utils = {
	crypt = {
		sha = loadstring(game:HttpGet("https://raw.githubusercontent.com/Egor-Skriptunoff/pure_lua_SHA/master/sha2.lua",true))()
	}
}

-- Crypt Library
function utils.crypt.md5(data)
	assert(data, "bad argument #1 to '?' (string expected, got no value)")
	assert(type(data) == "string", "bad argument #1 to '?' (string epected, got "..type(data)..")")
	return utils.crypt.sha.md5(data)
end

function utils.crypt.sha1(data)
	assert(data, "bad argument #1 to '?' (string expected, got no value)")
	assert(type(data) == "string", "bad argument #1 to '?' (string expected, got "..type(data)..")")
	return utils.crypt.sha.sha1(data)
end

function utils.crypt.sha256(data)
	assert(data, "bad argument #1 to '?' (string expected, got no value)")
	assert(type(data) == "string", "bad argument #1 to '?' (string expected, got "..type(data)..")")
	return utils.crypt.sha.sha256(data)
end

function utils.crypt.sha384(data)
	assert(data, "bad argument #1 to '?' (string expected, got no value)")
	assert(type(data) == "string", "bad argument #1 to '?' (string expected, got "..type(data)..")")
	return utils.crypt.sha.sha384(data)
end

function utils.crypt.sha512(data)
	assert(data, "bad argument #1 to '?' (string expected, got no value)")
	assert(type(data) == "string", "bad argument #1 to '?' (string expected, got "..type(data)..")")
	return utils.crypt.sha.sha512(data)
end

function utils.crypt.hmac(key, data)
	assert(key, "bad argument #1 to '?' (string expected, got no value)")
	assert(type(key) == "string", "bad argument #1 to '?' (string expected, got "..type(key)..")")
	assert(data, "bad argument #1 to '?' (string expected, got no value)")
	assert(type(data) == "string", "bad argument #1 to '?' (string expected, got "..type(data)..")")
	return utils.crypt.sha.sha512(key .. data .. key)
end

function utils.RandomString(length)
	local chars = {};

	for i = ("a"):byte(), ("z"):byte() do
	    table.insert(chars, string.char(i));
	end;

	for i = ("A"):byte(), ("Z"):byte() do
	    table.insert(chars, string.char(i));
	end;

	for i = ("0"):byte(), ("9"):byte() do
	    table.insert(chars, string.char(i));
	end;

	local str = "";

	for i = 1, length do
		str = str .. chars[math.random(1, #chars)];
	end;

	return str;	
end

function utils.CreateEsp(Options)
	local options = (Options or {
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

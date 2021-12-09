local collection = {
	Characters = {}
}

local plrs = game:GetService("Players")
local lp = plrs.LocalPlayer

local callbacks = {
    CharacterAdded = {},
	PlayerRemoving = {},
	CharacterRemoving = {}
}

local connections = {}

local function listenToPlayerEvents(plr)
    if plr.Character:FindFirstChild("HumanoidRootPart") then collection.Characters[plr.Name] = plr.Character end
    local cac = plr.CharacterAdded:Connect(function(c)
		c:WaitForChild("HumanoidRootPart")
		collection.Characters[plr.Name] = c
        for _, v in pairs(callbacks.CharacterAdded) do v(c) end
    end)
	local crc = plr.CharacterRemoving:Connect(function()
		collection.Characters[plr.Name] = nil
		for _, v in pairs(callbacks.CharacterRemoving) do v(c) end
	end)
	
	connections[plr.Name] = {cac, crc}
end

collection.use = function(thing, args)
	local type = typeof(thing)
	if type == "function" then
		return coroutine.wrap(thing)(args or {})
	end
end

collection.on = function(t, callback)
	if not t then return "A type is required." end
	if not callback or typeof(callback) ~= "function" then return end
	if t == "respawn" then
		table.insert(callbacks.CharacterAdded, callback)
	elseif t == "leave" then
		table.insert(callbacks.PlayerRemoving, callback)
	elseif t == "die" then
		table.insert(callbacks.CharacterRemoving, callback)
	end
end

for _, v in pairs(plrs:GetPlayers()) do
	listenToPlayerEvents(v)
end
plrs.PlayerAdded:Connect(function(plr)
	listenToPlayerEvents(plr)
end)
plrs.PlayerRemoving:Connect(function(plr)
	for _, v in pairs(callbacks.PlayerRemoving) do v(plr) end
	for _, v in pairs(connections[plr.Name]) do v:Disconnect() end
	collection.Characters[plr.Name] = nil
end)

return collection

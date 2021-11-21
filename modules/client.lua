local collection = {}

local plrs = game:GetService("Players")
local lp = plrs.LocalPlayer

local callbacks = {
    CharacterAdded = {},
	PlayerRemoving = {}
}

local function listenToPlayerEvents(plr)
    plr.CharacterAdded:Connect(function(c)
        for _, v in pairs(callbacks.CharacterAdded) do
            v(c)
        end
    end)
end

collection.use = function(thing, args)
	local type = typeof(thing)
	if type == "function" then
		if args then
			return coroutine.wrap(thing)(args)
		end
		coroutine.wrap(thing)()
	end
end

collection.on = function(t, callback)
	if not t then return "A type is required." end
	if not callback or typeof(callback) ~= "function" then return end
	if t == "respawn" then
		table.insert(callbacks.CharacterAdded, callback)
	elseif t == "leave" then
		table.insert(callbacks.PlayerRemoving, callback)
	end
end

for _, v in pairs(plrs:GetPlayers()) do
	listenToPlayerEvents(v)
end
plrs.PlayerAdded:Connect(function(plr)
	listenToPlayerEvents(plr)
end)
plrs.PlayerRemoving:Connect(function(plr)
	for _, v in pairs(callbacks.PlayerRemoving) do
		v(plr)
	end
end)

return collection

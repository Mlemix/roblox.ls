local collection = {}

local plrs = game:GetService("Players")
local lp = plrs.LocalPlayer

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
	if t == "respawn" then
		lp.CharacterAdded:Connect(function()
			callback(lp.Character)
		end)
	elseif t == "leave" then
		plrs.PlayerRemoving:Connect(function(plr)
			callback(plr)
		end)
	end
end

return collection

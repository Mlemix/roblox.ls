local existingModules = {"client", "fs"}

return _G.roblox_ls or function()
	_G.roblox_ls = {
		new = function(m)
			for _, v in pairs(existingModules) do
				if v == m then return loadstring(game:HttpGet("https://raw.githubusercontent.com/Mlemix/roblos/main/modules/".. m ..".lua")) end
			end
		return nil
    end
}
return _G.roblox_ls
end

local existingModules = {"client", "fs"}

if _G.roblox_ls then return print("roblos already loaded!"); _G.roblox_ls.main end
_G.roblox_ls = {
	moduleCache = {},
	main = {
		new = function(m)
			if _G.roblox_ls.moduleCache[m] then print("module already cached!"); return _G.roblox_ls.moduleCache[m] end
			for _, v in pairs(existingModules) do
				if v == m then
					_G.roblox_ls.moduleCache[m] = loadstring(game:HttpGet("https://raw.githubusercontent.com/Mlemix/roblos/main/modules/".. m ..".lua"))
					return _G.roblox_ls.moduleCache[m]
				end
			end
			return nil 
		end
	}
}
return _G.roblox_ls.main

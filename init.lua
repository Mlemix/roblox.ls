local existingModules = {"client", "fs"}

return {
    new = function(m)
        for _, v in pairs(existingModules) do
		if v == m then return loadstring(game:HttpGet("https://raw.githubusercontent.com/Mlemix/roblos/main/modules/".. m ..".lua")) end
	end
	return nil
    end
}

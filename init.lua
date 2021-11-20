local existingModules = {"client"}

return {
    new = function(m)
        for _, v in pairs(existingModules) do
			if v == m then return loadstring(game:HttpGet("..."))
		end
    end
}

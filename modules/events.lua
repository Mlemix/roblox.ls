local collection = {}

local callbacks = {
    FireServer = {},
    InvokeServer = {}
}

collection.on = function(t, c)
    if t == "FireServer" then
        table.insert(callbacks.FireServer, c)
    elseif t == "InvokeServer" then
        table.insert(callbacks.InvokeServer, c)
    end
end

NC = hookfunction(getrawmetatable(game).__namecall, function(self, ...)
    local method = getnamecallmethod()
    local Args = {...}
    if method == "InvokeServer" then
        for _, v in pairs(callbacks.InvokeServer) do
            if v(NC, {
                caller = getfenv(2).script,
                name = self.name,
                args = Args[1]
            }, self) == "pass" then return NC(self, ...)  end
        end
    elseif method == "FireServer" then
        for _, v in pairs(callbacks.FireServer) do
            if v(NC, {
                caller = getfenv(2).script,
                name = self.name,
                args = Args[1]
            }, self) == "pass" then return NC(self, ...)  end
        end
    end
    
    return NC(self, ...)
end)

return collection

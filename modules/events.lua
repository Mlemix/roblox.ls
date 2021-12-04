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

NC = hookfunction(getrawmetatable(game).__namecall, function(...)
    local method = getnamecallmethod()
    local Args = {...}
    if method == "InvokeServer" then
        for _, v in pairs(callbacks.InvokeServer) do
            v(NC, {
                caller = getfenv(2).script,
                name = Args[1],
                args = Args[2]
            }, ...)
        end
        return
    elseif method == "FireServer" then
        for _, v in pairs(callbacks.FireServer) do
            v(NC, {
                caller = getfenv(2).script,
                name = Args[1],
                args = Args[2]
            }, ...)
        end
        return
    end
    return NC(...)
end)

return collection

# Roblox.ls
A lua roblox exploiting library that looks like nodejs 💀
the name is just a combination between js and lua 💀💀💀

## client module
```
local roblox_ls = loadstring(game:HttpGet("https://raw.githubusercontent.com/Mlemix/roblos/main/init.lua"))()
local client = roblox_ls.new("client")()

client.on("respawn", function(c)
    print(c, "just respawned")
end)

client.on("leave", function(c)
    print(c, "just left the game")
end)
```

## fs module
```
local roblox_ls = loadstring(game:HttpGet("https://raw.githubusercontent.com/Mlemix/roblos/main/init.lua"))()
local fs = roblox_ls.new("fs")()

local written = fs.writeFile("bruh/ok/nah.txt", "file written", function(err, thing)
    if err then return print("failed to save or something") end
    print("saved (callback):", thing)
end)
print("saved (variable):", written)
```

more coming soon idk

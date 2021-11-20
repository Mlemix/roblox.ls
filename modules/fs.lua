local collection = {}

local function parseFileName(p)
    local ret = {}
    local slashy = p:split('/')
    for i, v in pairs(slashy) do
        if i ~= #slashy then
            table.insert(ret, {v, "folder"})
        else
            if #v:split('.') > 1 then
                table.insert(ret, {v, "file"})
            else
                table.insert(ret, {v, "folder"})
            end
        end
    end
    return ret
end

collection.pathExists = function(f, callback)
    local pathParsed = parseFileName(f)
    if pathParsed[#pathParsed][2] == "folder" then
        local is = isfolder(f)
        if callback then callback(nil, is) end; return is
    else
        local is = isfile(f)
        if callback then callback(nil, is) end; return is
    end
end

collection.readFile = function(f, callback)
    if not collection.pathExists(f) then if callback then callback("File does not exist.", nil) end; return nil end
    local ran, err = pcall(function()
        return readfile(f)
    end)
    if not err or string.len(err) < 1 then return callback("Failed to read file.", nil) end
    if ran then callback(nil, err); return err end
end

collection.makeFile = function(f, callback)
    local pathParsed = parseFileName(f)
    local pathCompleted = ""
    for _, v in pairs(pathParsed) do
        pathCompleted = pathCompleted.. "/".. v[1]
        if v[2] == "folder" then makefolder(pathCompleted) 
        else writefile(pathCompleted, "") end
    end
    if callback then callback(nil, true) end; return true
end

collection.writeFile = function(f, c, callback)
    if not collection.pathExists(f) then collection.makeFile(f) end
    writefile(f, c)
    if callback then callback(nil, true) end; return true
end

return collection

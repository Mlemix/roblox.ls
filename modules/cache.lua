local collection = {}

local function cfind(cache, val)
    for j, k in pairs(cache) do
        if k.key == val then
            return j
        end
    end
    return nil
end

collection.new = function()
    local ret = {}
    ret.cache = {}
    ret.del = function(key)
        local t = typeof(key)
        local deleted = 0
        if t == "table" then
            for _, v in pairs(key) do
                local index = cfind(ret.cache, v)
                if index then
                    table.remove(ret.cache, index)
                    deleted = deleted + 1
                end
            end
        else
            local index = cfind(ret.cache, key)
            if index then
                table.remove(ret.cache, index)
                deleted = deleted + 1
            end
        end
        return deleted
    end
    ret.set = function(key, data, ttl)
        if not key or not data then return false end
        if typeof(key) ~= "string" then return false end
        if ttl then
            if typeof(ttl) ~= "number" then return false end
            func = coroutine.wrap(function()
                wait(ttl)
                ret.del(key)
            end)()
        end
        table.insert(ret.cache, {
            key = key,
            data = data,
            ttl = ttl
        })
        return true
    end
    ret.get = function(key)
        local found = cfind(ret.cache, key)
        if found then return ret.cache[found].data end
        return nil
    end
    return ret
end

return collection

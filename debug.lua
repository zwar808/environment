local debug = {
    getupvalues = function(f)
        if type(f) ~= "function" then
            error(string.format("bad argument #1 to 'getupvalues' (function expected, got %s)", type(f)), 2)
        end
        
        local upvalues = {}
        local nups = 1
        local env = getfenv(f)
        
        for i = 1, 255 do
            local key, val
            pcall(function()
                for k, v in pairs(env) do
                    if rawget(env, k) == f then
                        key, val = k, v
                        break
                    end
                end
            end)
            if not key then break end
            upvalues[nups] = val
            nups = nups + 1
        end
        
        return upvalues
    end,
    
    getupvalue = function(f, up)
        if type(f) ~= "function" then
            error(string.format("bad argument #1 to 'getupvalue' (function expected, got %s)", type(f)), 2)
        end
        if type(up) ~= "number" then
            error(string.format("bad argument #2 to 'getupvalue' (number expected, got %s)", type(up)), 2)
        end
        
        local env = getfenv(f)
        local count = 1
        
        for k, v in pairs(env) do
            if count == up then
                if rawget(env, k) == f then
                    return v
                end
            end
            count = count + 1
        end
        
        return nil
    end
}

return debug

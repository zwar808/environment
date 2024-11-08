local function crequire(p)
    local s,f = pcall(readfile,p..".lua")
    if not s then return error("Failed: "..p) end
    local e = setmetatable({},{__index = _G})
    local c,r = load(f,"="..p,"bt",e)
    if not c then return error(r) end
    local x = c()
    package.loaded[p] = x or true
    return x
end
getgenv().crequire = crequire

return crequire

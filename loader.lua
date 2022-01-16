getgenv().cultware = { }
local format = string.format;

cultware.debug = function(module, ...)
    warn(format("Cultware %s Debug Console - ", module) .. format(...))
end

cultware.loader = { }
local loader = cultware.loader;

loader.debug = function(...)
    cultware.debug("Loader", ...)
end

loader.mainFolderChecker = function()
    loader.debug("Check main folder...")
    if isfolder("cultware") then
        loader.debug("Main folder found!")
    else
        loader.debug("Main folder not found, creating...")
        makefolder("cultware")
        loader.debug("Main folder created!")
    end
    return 1;
end

loader.Modules = {
    "Functions",
    "UI"
}

loader.checkModule = function(module)
    loader.debug("Checking module %s...", module)
    local fullName = format("%s-Module.lua", module)
    local path = "cultware/" .. fullName;
    local data = game:HttpGet("https://raw.githubusercontent.com/mymainwithstuffstonksbitcoin/cultware/main/" .. fullName)
    if isfile(path) then
        loader.debug("%s module found!", module)
        loader.debug("Matching %s module data...", module)
        if readfile(path) == data then
            loader.debug("%s module data is up to date!", module)
        else
            loader.debug("%s module data mismatch!", module)
            loader.debug("Updating %s module data...", module)
            writefile(path, data)
            loader.debug("%s module data has been updated!", module)
        end
    else
        loader.debug("%s module not found!", module)
        loader.debug("Creating %s module...", module)
        writefile(path, data)
        loader.debug("%s module created!", module)
    end
    return 1;
end

loader.checkModules = function(modules)
    for i,v in next, modules do
        loader.checkModule(v)
    end
end

loader.loadModule = function(module)
    loader.debug("Loading module %s...", module)
    return loadstring(readfile(format("cultware/%s-Module.lua", module)))()(), loader.debug("%s module loaded!", module)
end

loader.loadModules = function(modules)
    for i,v in next, modules do
        loader.loadModule(v)
    end
end

loader.ready = function()
    loader.debug("Starting...")
    loader.mainFolderChecker()
    loader.checkModules(loader.Modules)
    loader.loadModules(loader.Modules)
    loader.debug("Loaded!")
end

loader.ready()

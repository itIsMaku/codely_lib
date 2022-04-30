Loader = {}
Loader.Loaders = {}
Loader.Loaded = {}

function Loader.RegisterLoader(name, loadFunction)
    Loader.Loaders[name] = loadFunction
    CoreLogger.Info('Registered loader ' .. name .. '.')
end

function Loader.UnregisterLoaded(name)
    Loader.Loaders[name] = nil
    CoreLogger.Info('Unregistered loader ' .. name .. '.')
end

function Loader.LoadCoreLoaders(side)
    local canBeStarted = true
    local loaded = {}
    for name, loadFunction in pairs(Loader.Loaders) do
        if string.starts(name, 'core:' .. side) then
            CoreLogger.Loading('Loading ' .. name .. '...')
            loaded[name] = loadFunction()
        end
    end
    for name, isLoaded in pairs(loaded) do
        if not isLoaded then
            CoreLogger.Error(name .. ' was not loaded.')
            canBeStarted = false
        end
    end
    return canBeStarted
end

function Loader.IsLoadedServerCore()
    return Loader.Loaded['core:server']
end

function Loader.IsLoadedClientCore()
    return Loader.Loaded['core:client']
end

function Loader.FinalLoad(resource, side)
    local canBeStarted = true
    local loaded = {}
    for name, loadFunction in pairs(Loader.Loaders) do
        if not string.starts(name, 'core:' .. side) then
            CoreLogger.Loading('Loading ' .. name .. '...')
            loaded[name] = loadFunction()
        end
    end
    for name, isLoaded in pairs(loaded) do
        if not isLoaded then
            CoreLogger.Error(name .. ' was not loaded.')
            canBeStarted = false
        end
    end
    if not canBeStarted then
        Loader.Stop(resource)
        return
    end
    CoreLogger.Info('Resource ' .. resource .. ' successfully loaded.')
end

function Loader.Stop(resource)
    CoreLogger.Error('Stopping resource ' .. resource .. '...')
    --StopResource(resource)
end

function GetLoaderObject()
    return Loader
end

exports('GetLoaderObject', GetLoaderObject)

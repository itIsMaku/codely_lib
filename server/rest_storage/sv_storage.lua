function InitializeStorage(name, url, authToken)
    Storage = {}
    Storage.Identifier = name
    Storage.Settings = {
        Url = url,
        AuthToken = authToken,
        Cache = {
            Downloading = true,
            Uploading = true,
            DownloadInterval = 3000 * 1000 * 60,
            UploadInterval = 1 * 1000 * 60,
            --UploadInterval = 0,
            DownloadLimit = 0
        }
    }

    Storage.Cache = {}
    Storage.Cache.Data = {}

    Storage.Functions = {}

    Storage.Functions.Download = function()
        local newData = {}
        PerformHttpRequest(
            Storage.Settings.url .. '/download',
            function(errorCode, rawData, rawHeaders)
                newData = json.decode(rawData)
            end,
            'GET',
            json.encode({ identifier = Storage.Identifier, limit = Storage.Settings.Cache.DownloadLimit }),
            { ['Auth-Token'] = authToken, ['Content-Type'] = 'application/json' }
        )
        Storage.Cache.Data = newData
        Storage.Cache.LastUpdate = os.date('%H:%M - %d.%m. %Y', os.time())
        return newData
    end

    Storage.Functions.Upload = function()
        PerformHttpRequest(
            Storage.Settings.Url .. '/upload',
            function(errorCode, rawData, rawHeaders) end,
            'POST',
            json.encode({ identifier = Storage.Identifier, data = json.encode(Storage.Cache.Data) }),
            { ['Auth-Token'] = authToken, ['Content-Type'] = 'application/json' }
        )
    end

    Storage.Functions.StartDownloadThread = function()
        Citizen.CreateThread(function()
            while true do
                Storage.Functions.Download()
                Citizen.Wait(Storage.Settings.Cache.DownloadInterval)
            end
        end)
    end

    Storage.Functions.StartUploadThread = function()
        Citizen.CreateThread(function()
            while true do
                Citizen.Wait(Storage.Settings.Cache.UploadInterval)
                Storage.Functions.Upload()
            end
        end)
    end

    return Storage
end

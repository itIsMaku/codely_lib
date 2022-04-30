function InitLogger(name)
    Logger = {}
    Logger.Name = name
    Logger.Info = function(str)
        print('^2[' .. GetNetworkSide() .. ':' .. Logger.Name .. ']' .. ' ^0| ' .. str)
    end

    Logger.Warn = function(str)
        print('^3[' .. GetNetworkSide() .. ':' .. Logger.Name .. ']' .. ' ^0| ' .. str)
    end

    Logger.Error = function(str)
        print('^1[' .. GetNetworkSide() .. ':' .. Logger.Name .. ']' .. ' ^0| ' .. str)
    end

    Logger.Loading = function(str)
        print('^5[' .. GetNetworkSide() .. ':' .. Logger.Name .. ']' .. ' ^0| ' .. str)
    end

    Logger.TableDebug = function(t)
        for k, v in pairs(t) do
            --[[if type(v) == "table" then
                Logger.TableDebug(t)
            else]]
            print('^3[' .. GetNetworkSide() .. ':debug] ' .. '^0 | Key: ' .. k .. ' | Value: ' .. json.encode(v))
            --end
        end
    end

    return Logger
end

CoreLogger = InitLogger(GetCurrentResourceName())

function GetLoggerObject()
    return CoreLogger
end

exports('InitLogger', InitLogger)
exports('GetCoreLoggerObject', GetLoggerObject)

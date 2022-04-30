QBCore = nil

if FrameWork == 'qb-core' then
    QBCore = exports['qb-core']:GetCoreObject()
    FrameWorkFunctions.Object = QBCore

    FrameWorkFunctions.GetCharacterName = function(source)
        if source == nil then return 'none' end

        local qbPlayer = QBCore.Functions.GetPlayer(source).PlayerData
        return qbPlayer.charinfo.firstname .. ' ' .. qbPlayer.charinfo.lastname
    end

    FrameWorkFunctions.Notify = function(text, type, source)
        if source == nil then return 'none' end
        TriggerClientEvent('QBCore:Notify', source, text, type, 5000)
    end

    FrameWorkFunctions.GiveMoney = function(source, amount, type)
        if source == nil then return 'none' end
        return QBCore.Functions.GetPlayer(source).Functions.AddMoney(type, amount)
    end

    FrameWorkFunctions.GiveItem = function(source, item, count)
        if source == nil then return 'none' end
        return QBCore.Functions.GetPlayer(source).Functions.AddItem(item, count)
    end

    FrameWorkFunctions.GetMoney = function(source, type)
        if source == nil then return 'none' end
        local qbPlayer = QBCore.Functions.GetPlayer(source)
        return qbPlayer.Functions.GetMoney(type)
    end

    FrameWorkFunctions.RemoveMoney = function(source, type, price)
        if source == nil then return 'none' end
        local qbPlayer = QBCore.Functions.GetPlayer(source)
        return qbPlayer.Functions.RemoveMoney(type, price)
    end

    FrameWorkFunctions.GetIdentifier = function(source)
        if source == nil then return 'none' end
        local qbPlayer = QBCore.Functions.GetPlayer(source)
        return qbPlayer.PlayerData.citizenid
    end

    FrameWorkFunctions.GetOfflineCharacterName = function(identifier)
        if identifier == nil then return 'none' end
        local result = MySQL.Sync.fetchAll(
            'SELECT * FROM players WHERE citizenid = @citizenid',
            {
            ['@citizenid'] = citizenid
        }
        )
        local charInfo = json.decode(result[1]['charinfo'])
        return charInfo.firstname .. ' ' .. charInfo.lastname
    end

    FrameWorkFunctions.IsItemExist = function(item)
        --return QBCore.Shared.Items[item] ~= nil // qb-core includes only default items, not edited items.lua, idk why but idc
        return true
    end
end

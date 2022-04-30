ESX = nil

if FrameWork == 'esx' then
    local ESX = exports['es_extended']:getSharedObject()
    FrameWorkFunctions.Object = ESX

    FrameWorkFunctions.GetCharacterName = function(source)
        if source == nil then return 'none' end
        return ESX.GetPlayerFromId(source).getName()
    end

    FrameWorkFunctions.Notify = function(text, type, source)
        if source == nil then return 'none' end
        TriggerClientEvent('esx:showNotification', source, text)
    end

    FrameWorkFunctions.GiveMoney = function(source, amount, type)
        if source == nil then return 'none' end
        local xPlayer = ESX.GetPlayerFromId(source)
        if type == 'cash' then
            return xPlayer.addMoney(amount)
        else
            return xPlayer.addBank(amount)
        end
    end

    FrameWorkFunctions.GiveItem = function(source, item, count)
        if source == nil then return 'none' end
        return ESX.GetPlayerFromId(source).addInventoryItem(item, count)
    end

    FrameWorkFunctions.GetMoney = function(source, type)
        if source == nil then return 'none' end
        local xPlayer = ESX.GetPlayerFromId(source)
        if type == 'cash' then
            return xPlayer.getMoney()
        else
            return xPlayer.getBank()
        end
    end

    FrameWorkFunctions.RemoveMoney = function(source, type, price)
        if source == nil then return 'none' end
        local xPlayer = ESX.GetPlayerFromId(source)
        if type == 'cash' then
            return xPlayer.removeMoney(price)
        else
            return xPlayer.removeBank(price)
        end
    end

    FrameWorkFunctions.GetIdentifier = function(source)
        if source == nil then return 'none' end
        local xPlayer = ESX.GetPlayerFromId(source)
        return xPlayer.getIdentifier()
    end

    FrameWorkFunctions.GetOfflineCharacterName = function(identifier)
        if identifier == nil then return 'none' end
        local result = MySQL.Sync.fetchAll(
            'SELECT firstname, lastname FROM users WHERE identifier = @identifier',
            { ['@identifier'] = identifier }
        )
        return result[1].firstname .. ' ' .. result[1].lastname
    end

    FrameWorkFunctions.IsItemExist = function(item)
        local result = MySQL.Sync.fetchScalar(
            'SELECT name FROM items WHERE name = @name',
            { ['@name'] = item }
        )
        return result ~= nil
    end
end

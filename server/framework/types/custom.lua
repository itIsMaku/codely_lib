if FrameWork == 'custom' then
    FrameWorkFunctions.Object = nil

    FrameWorkFunctions.GetCharacterName = function(source)
        return 'not_implemented'
    end

    FrameWorkFunctions.Notify = function(text, type, source)
        return 'not_implemented'
    end

    FrameWorkFunctions.GiveMoney = function(source, amount, type)
        return 'not_implemented'
    end

    FrameWorkFunctions.GiveItem = function(source, item, count)
        return 'not_implemented'
    end

    FrameWorkFunctions.GetMoney = function(source, type)
        return 'not_implemented'
    end

    FrameWorkFunctions.RemoveMoney = function(source, type, price)
        return 'not_implemented'
    end

    FrameWorkFunctions.GetIdentifier = function(source)
        return 'not_implemented'
    end

    FrameWorkFunctions.GetOfflineCharacterName = function(identifier)
        return 'not_implemented'
    end

    FrameWorkFunctions.IsItemExist = function(item)
        return 'not_implemented'
    end
end

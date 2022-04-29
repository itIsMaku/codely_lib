--[[function LoadItems()
    for ticket, price in pairs(Config.LotteryShop.Tickets) do
        local item = ticket:lower()
        print(QBCore.Shared.Items)
        if not QBCore.Shared.Items[item] then
            Error('Item with name lottery_' .. item .. ' is not registered in QBCore/shared/items.lua. Follow installation instructions in Instructions.txt!')
            return false
        end
    end
    return true
end

LoadItems()
]]

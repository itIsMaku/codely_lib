WarMenu.CreateMenu('lottery', Config.LotteryShop.Menu.Title)

WarMenu.CreateSubMenu('buy', 'lottery', Config.LotteryShop.Menu.Buy)
WarMenu.CreateSubMenu('payoff', 'lottery', Config.LotteryShop.Menu.PayOff)

function OpenMenu()
    if WarMenu.IsAnyMenuOpened() then
        WarMenu.CloseMenu()
    end
    WarMenu.OpenMenu('lottery')

    while true do
        if WarMenu.Begin('lottery') then
            WarMenu.MenuButton(Config.LotteryShop.Menu.Buy, 'buy')
            WarMenu.MenuButton(Config.LotteryShop.Menu.PayOff, 'payoff')
            WarMenu.End()
        elseif WarMenu.Begin('buy') then
            for key, value in pairs(Config.LotteryShop.Tickets) do
                if WarMenu.Button(key .. '$' .. value) then
                    TriggerServerEvent('codely_lottery:buyTicket', key)
                end
            end
            WarMenu.End()
        elseif WarMenu.Begin('payoff') then
            for key, value in pairs(Config.LotteryShop.Tickets) do
                if WarMenu.Button(key) then
                    TriggerServerEvent('codely_lottery:payOff', key)
                end
            end
            WarMenu.End()
        else
            return
        end
        Citizen.Wait(0)
    end
end

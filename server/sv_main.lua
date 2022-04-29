QBCore = exports['qb-core']:GetCoreObject()

RegisterServerEvent('codely_lottery:buyTicket')
AddEventHandler('codely_lottery:buyTicket', function(ticketType)
    local qbPlayer = QBCore.Functions.GetPlayer(source)
    local price = Config.LotteryShop.Tickets[ticketType]
    local itemName = 'ticket_' .. ticketType:lower()
    if qbPlayer.Functions.GetMoney('cash') >= price then
        qbPlayer.Functions.RemoveMoney('cash', price)
        print(itemName)
        qbPlayer.Functions.AddItem(itemName, 1)
        SendServerNotification(
            source,
            'success',
            (Config.LotteryShop.Messages.Bought)
            :format(
                ticketType,
                price
            )
        )
        RegisterTicket(source, ticketType)
    else
        SendServerNotification(
            source,
            'error',
            Config.LotteryShop.Messages.EnoughMoney
        )
    end
end)

RegisterServerEvent('codely_lottery:payOff')
AddEventHandler('codely_lottery:payOff', function(ticketType)
    local source = source
    local qbPlayer = QBCore.Functions.GetPlayer(source)
    if IsPlayerHasWin(qbPlayer.license, ticketType) then
        if not IsPlayerClaimedWin(qbPlayer.license, ticketType) then
            ClaimWin(
                source,
                qbPlayer.license,
                ticketType
            )
        else
            SendServerNotification(
                source,
                'error',
                Config.LotteryShop.Messages.NotWin
            )
        end
    else
        SendServerNotification(
            source,
            'error',
            Config.LotteryShop.Messages.NotWin
        )
    end
end)

if Config.Debug.StartCommand.Enabled then
    RegisterCommand('startlottery', function()
        Info('Starting lottery debug.')
        StartLottery(Config.Debug.StartCommand.TicketType)
    end)
end

TriggerEvent('cron:runAt', Config.LotteryStart.Start.Hour, Config.LotteryStart.Start.Minutes, CronTask)

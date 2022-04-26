QBCore = exports['qb-core']:GetCoreObject()

local blip = nil

function CreateLotteryShopBlip()
    blip = AddBlipForCoord(Config.LotteryShop.Location)
    SetBlipSprite(blip, Config.LotteryShop.Blip.Sprite)
    SetBlipDisplay(blip, Config.LotteryShop.Blip.Display)
    SetBlipScale(blip, Config.LotteryShop.Blip.Scale)
    SetBlipColour(blip, Config.LotteryShop.Blip.Color)
    SetBlipAsShortRange(blip, true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString(Config.LotteryShop.Blip.Title)
    EndTextCommandSetBlipName(blip)
end

CreateLotteryShopBlip()

Citizen.CreateThread(function()
    while true do
        if #(GetEntityCoords(PlayerPedId()) - vector3(Config.LotteryShop.Location)) < Config.LotteryShop.Text.ViewDistance then
            CreateUsable3DText(Config.LotteryShop.Location, Config.LotteryShop.Text.ViewDistance, Config.LotteryShop.Text.UseDistance, Config.LotteryShop.Text.Text)
            if #(GetEntityCoords(PlayerPedId()) - vector3(Config.LotteryShop.Location)) < Config.LotteryShop.Text.UseDistance
                and
                IsControlJustReleased(0, 38)
            then
                OpenMenu()
            end
        else
            Citizen.Wait(500)
        end
        Wait(0)
    end
end)

local RSGCore = exports['rsg-core']:GetCoreObject()

for itemType, cfg in pairs(Config.ItemTypes) do

    CreateThread(function()
        while true do
            Wait(cfg.decayTime * 1000)
            local Players = RSGCore.Functions.GetRSGPlayers()
            local svslot = nil
            print(itemType)
            print(cfg.decayTime)
            for k, v in pairs(Players) do
                for slot, item in pairs(v.PlayerData.items) do
                    if item.type == itemType then
                        local svslot = item.slot
                        if v.PlayerData.items[svslot].info.quality == nil then
                            v.PlayerData.items[svslot].info.quality = 100
                            v.Functions.SetInventory(v.PlayerData.items)
                        end
                        local newquality = math.floor((v.PlayerData.items[svslot].info.quality - cfg.decayAmount))
                        v.PlayerData.items[svslot].info.quality = newquality
                        v.Functions.SetInventory(v.PlayerData.items)
                        if item.info.quality < 0 then
                            v.PlayerData.items[svslot].info.quality = 0
                            v.Functions.SetInventory(v.PlayerData.items)
                            local Player = RSGCore.Functions.GetPlayer(k)
                            Player.Functions.RemoveItem(item.name, 1, svslot)
                        end
                    end
                end
            end
        end
    end)
end
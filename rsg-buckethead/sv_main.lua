local RSGCore = exports['rsg-core']:GetCoreObject()
local HeadbagList = {}

RegisterNetEvent("headbag:addHeadbagS", function(cPlayer)
    HeadbagList[cPlayer] = true
    TriggerClientEvent("headbag:addHeadbag", cPlayer)
end)

RegisterNetEvent("headbag:removeHeadbagS", function(cPlayer)
    HeadbagList[cPlayer] = false
    TriggerClientEvent("headbag:removeHeadBag", cPlayer)
end)

RegisterNetEvent('headbag:damageHeadbag', function(item)
    local src = source
    local Player = RSGCore.Functions.GetPlayer(src)
    local uses = Player.PlayerData.items[item.slot].info.uses
    if (uses-1) <= 0 then
        TriggerClientEvent("inventory:client:ItemBox", src, RSGCore.Shared.Items[item.name], "remove", 1)
        Player.Functions.RemoveItem(item.name, 1, item.slot)
    else
        Player.PlayerData.items[item.slot].info.uses = Player.PlayerData.items[item.slot].info.uses - 1
        Player.Functions.SetInventory(Player.PlayerData.items)
    end
end)

RSGCore.Functions.CreateCallback("headbag:isHeadbagOn", function(source, cb, pid)
    local isOn = false
    if HeadbagList[pid] then
        isOn = HeadbagList[pid]
    end
    cb(isOn)
end)

RSGCore.Functions.CreateUseableItem("buckethead", function(source, item)
    local src = source
    local Player = RSGCore.Functions.GetPlayer(src)
    if Player.Functions.GetItemByName("buckethead") ~= nil then
        TriggerClientEvent("headbag:enableHeadbag", src, item)
    end
end)

RegisterCommand("removebuckethead", function(source, _)
    TriggerClientEvent("headbag:removeHeadbagCmd", source)
end, false)
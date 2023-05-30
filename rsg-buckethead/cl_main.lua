local RSGCore = exports['rsg-core']:GetCoreObject()
local object = nil

local function GetClosestPlayer()
    local players = GetActivePlayers()
    local closestPlayer = -1
    local closestDistance = -1
    local playerPed = PlayerPedId()
    local playerCoords = GetEntityCoords(playerPed)

    for _, player in ipairs(players) do
        if player ~= PlayerId() then
            local targetPed = GetPlayerPed(player)
            local targetCoords = GetEntityCoords(targetPed)
            local distance = GetDistanceBetweenCoords(playerCoords, targetCoords, true)

            if closestDistance == -1 or distance < closestDistance then
                closestPlayer = player
                closestDistance = distance
            end
        end
    end

    return closestPlayer, closestDistance
end

RegisterNetEvent("headbag:addHeadbag", function()
    local closestPlayer, closestDistance = GetClosestPlayer()

    if closestPlayer ~= -1 and closestDistance <= 2.0 then
        local playerPed = GetPlayerPed(closestPlayer)
        object = CreateObject(GetHashKey("p_bucket03x"), 0, 0, 0, true, true, true)
        local closestPlayerPed = GetPlayerPed(closestPlayer)
        local boneIndex = GetPedBoneIndex(closestPlayerPed, 0x796e)
        ped = PlayerPedId()

        AttachEntityToEntity(object, ped, GetPedBoneIndex(ped, 21030), 0.2, -0.02, 0, 0, 270.0, 60.0, true, true, false, true, 1, true)
        SetEntityCompletelyDisableCollision(object, false, true)

        SendNUIMessage({
            action = "open"
        })
    else
        RSGCore.Functions.Notify("No player nearby", "error")
    end
end)

RegisterNetEvent("headbag:removeHeadBag", function()
    local closestPlayer, closestDistance = GetClosestPlayer()

    if closestPlayer ~= -1 and closestDistance <= 2.0 then
        local playerPed = GetPlayerPed(closestPlayer)

        -- Check if the 'object' variable is valid and remove the prop
        if object and DoesEntityExist(object) then
            DeleteEntity(object)
            object = nil -- Reset the 'object' variable
        end

        SendNUIMessage({
            action = "remove"
        })
    else
        RSGCore.Functions.Notify("No player nearby", "error")
    end
end)

local isUsingHeadbag = false
RegisterNetEvent("headbag:enableHeadbag", function(item)
    local closestPlayer, closestDistance = GetClosestPlayer()

    if closestPlayer ~= -1 and closestDistance <= 2.0 then
        if not isUsingHeadbag then
            isUsingHeadbag = true
            local playerId = GetPlayerServerId(closestPlayer)
            RSGCore.Functions.TriggerCallback("headbag:isHeadbagOn", function(isOn)
                if isOn then
                    TriggerServerEvent("headbag:removeHeadbagS", playerId)
                    SetTimeout(3000, function()
                        isUsingHeadbag = false
                    end)
                else
                    TriggerServerEvent("headbag:damageHeadbag", item)
                    TriggerServerEvent("headbag:addHeadbagS", playerId)
                    SetTimeout(3000, function()
                        isUsingHeadbag = false
                    end)
                end
            end, playerId)
        else
            RSGCore.Functions.Notify("Please wait before you try again", "error")
        end
    else
        RSGCore.Functions.Notify("No player nearby", "error")
    end
end)

RegisterNetEvent("headbag:removeHeadbagCmd", function()
    local closestPlayer, closestDistance = GetClosestPlayer()

    if closestPlayer ~= -1 and closestDistance <= 2.0 then
        local playerId = GetPlayerServerId(closestPlayer)
        RSGCore.Functions.TriggerCallback("headbag:isHeadbagOn", function(isOn)
            if isOn then
                TriggerServerEvent("headbag:removeHeadbagS", playerId)
            else
                RSGCore.Functions.Notify("Person doesn't have a headbag on their head", "error")
            end
        end, playerId)
    else
        RSGCore.Functions.Notify("No player nearby", "error")
    end
end)



-- Rest of the script...


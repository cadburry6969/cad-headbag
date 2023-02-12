local QBCore = exports['qb-core']:GetCoreObject()

local function GetClosestPlayer()
    local closestPlayers = QBCore.Functions.GetPlayersFromCoords()
    local closestDistance = -1
    local closestPlayer = -1
    local coords = GetEntityCoords(GetPlayerPed(-1))

    for i=1, #closestPlayers, 1 do
        if closestPlayers[i] ~= PlayerId() then
            local pos = GetEntityCoords(GetPlayerPed(closestPlayers[i]))
            local distance = GetDistanceBetweenCoords(pos.x, pos.y, pos.z, coords.x, coords.y, coords.z, true)

            if closestDistance == -1 or closestDistance > distance then
                closestPlayer = closestPlayers[i]
                closestDistance = distance
            end
        end
    end

    return closestPlayer, closestDistance
end

RegisterNetEvent("headbag:addHeadbag", function()
    local ped = PlayerPedId()
    Object = CreateObject(GetHashKey("prop_money_bag_01"), 0, 0, 0, true, true, true)
    AttachEntityToEntity(Object, ped, GetPedBoneIndex(ped, 12844), 0.2, 0.04, 0, 0, 270.0, 60.0, true, true, false, true, 1, true)
    SetEntityCompletelyDisableCollision(Object, false, true)
    SendNUIMessage({
        action = "open"
    })
end)

RegisterNetEvent('headbag:removeHeadBag', function(player)
    DeleteEntity(Object)
    SetEntityAsNoLongerNeeded(Object)
    SendNUIMessage({
        action = "remove"
    })
end)

local isUsingHeadbag = false
RegisterNetEvent("headbag:enableHeadbag", function(item)
    local cPlayer, cDist = GetClosestPlayer()
    if cPlayer == -1 or cDist > 2.0 then
        QBCore.Functions.Notify("No one nearby", "error")
    else
        if not isUsingHeadbag then
            isUsingHeadbag = true
            local playerId = GetPlayerServerId(cPlayer)
            QBCore.Functions.TriggerCallback("headbag:isHeadbagOn", function(isOn)
                if isOn then
                    TriggerServerEvent("headbag:removeHeadbagS", playerId)
                    SetTimeout(3000, function()
                        isUsingHeadbag = false
                    end)
                else
                    if IsEntityPlayingAnim(cPlayer, "missminuteman_1ig_2", "handsup_base", 3) then
                        TriggerServerEvent("headbag:damageHeadbag", item)
                        TriggerServerEvent("headbag:addHeadbagS", playerId)
                    else
                        QBCore.Functions.Notify("Person's hands are down", "error")
                    end
                    SetTimeout(3000, function()
                        isUsingHeadbag = false
                    end)
                end
            end, playerId)
        else
            QBCore.Functions.Notify("Please wait before you try again", "error")
        end
    end
end)

RegisterNetEvent("headbag:removeHeadbagCmd", function()
    local cPlayer, cDist = GetClosestPlayer()
    if cPlayer == -1 or cDist > 2.0 then
        QBCore.Functions.Notify("No one nearby", "error")
    else
        local playerId = GetPlayerServerId(cPlayer)
        QBCore.Functions.TriggerCallback("headbag:isHeadbagOn", function(isOn)
            if isOn then
                TriggerServerEvent("headbag:removeHeadbagS", playerId)
            else
                QBCore.Functions.Notify("Person doesnt have headbag on their head", "error")
            end
        end, playerId)
    end
end)
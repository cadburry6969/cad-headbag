local headbagList = GlobalState.headbagList or {}
local attachedObject = nil

RegisterNetEvent("headbag:addHeadbag", function()
    local ped = cache.ped
    local obj = Config.ObjectAttach
    lib.requestModel(obj.model, 5000)
    attachedObject = CreateObject(obj.model, 0, 0, 0, true, true, true)
    AttachEntityToEntity(attachedObject, ped, GetPedBoneIndex(ped, obj.bone), obj.xPos, obj.yPos, obj.zPos, obj.xRot, obj.yRot, obj.zRot, true, true, false, true, 1, true)
    SetEntityCompletelyDisableCollision(attachedObject, false, true)
    SendNUIMessage({ action = "open" })
end)

RegisterNetEvent('headbag:removeHeadBag', function(player)
    if attachedObject and DoesEntityExist(attachedObject) then
        DeleteEntity(attachedObject)
        SetEntityAsNoLongerNeeded(attachedObject)
    end
    SendNUIMessage({ action = "remove" })
end)

local isUsingHeadbag = false
RegisterNetEvent("headbag:toggleHeadbag", function(item)
    local cPlayer = GetClosestPlayer()
    if not cPlayer then return Notify(Config.Lang['no_one_nearby'], "error") end
    if isUsingHeadbag then return Notify(Config.Lang['use_timeout'], "error") end
    isUsingHeadbag = true
    local playerId = GetPlayerServerId(cPlayer)
    if not playerId then return end
    if headbagList[playerId] then
        TriggerServerEvent("headbag:removeHeadbag", playerId)
        SetTimeout(Config.UseHeadbagTimeout, function()
            isUsingHeadbag = false
        end)
    else
        local ped = GetPlayerPed(cPlayer)
        if ped == 0 or ped == -1 then return end
        if IsEntityPlayingAnim(ped, Config.HandsupAnimation.dict, Config.HandsupAnimation.anim, 3) then
            TriggerServerEvent("headbag:damageHeadbag", item)
            TriggerServerEvent("headbag:addHeadbag", playerId)
        else
            Notify(Config.Lang['no_handup'], "error")
        end
        SetTimeout(Config.UseHeadbagTimeout, function()
            isUsingHeadbag = false
        end)
    end
end)

AddStateBagChangeHandler('headbagList', 'global', function(_, _, value)
    headbagList = value
end)

if Config.RemoveCommand then
    RegisterCommand(Config.ToggleCommand, function(source, _)
        TriggerEvent("headbag:toggleHeadbag", false)
    end, false)
    TriggerEvent('chat:addSuggestion', '/'..Config.ToggleCommand, Config.ToggleCommandHelp)
end

if Config.RemoveCommand then
RegisterCommand(Config.RemoveCommand, function(source, _)
    local cPlayer = GetClosestPlayer()
    if not cPlayer then return Notify(Config.Lang['no_one_nearby'], "error") end
    local playerId = GetPlayerServerId(cPlayer)
    if not headbagList[playerId] then return Notify(Config.Lang['no_headbag_onhead'], "error") end
    TriggerServerEvent("headbag:removeHeadbag", playerId)
end, false)
TriggerEvent('chat:addSuggestion', '/'..Config.RemoveCommand, Config.RemoveCommandHelp)
end
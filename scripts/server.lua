local HeadbagList = {}
GlobalState.headbagList = {}

RegisterNetEvent("headbag:addHeadbag", function(cPlayer)
    HeadbagList[cPlayer] = true
    GlobalState.headbagList = HeadbagList
    TriggerClientEvent("headbag:addHeadbag", cPlayer)
end)

RegisterNetEvent("headbag:removeHeadbag", function(cPlayer)
    HeadbagList[cPlayer] = false
    GlobalState.headbagList = HeadbagList
    TriggerClientEvent("headbag:removeHeadBag", cPlayer)
end)
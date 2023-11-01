function Notify(msg, type)
    lib.notify({ description = msg, type = type })
end

function GetClosestPlayer()
    local coords = GetEntityCoords(cache.ped)
    local playerId, _, _ = lib.getClosestPlayer(coords, 2.0, false)
    return playerId
end
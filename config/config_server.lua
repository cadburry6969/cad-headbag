Config = Config or {}

if not Config.DisableItem then
if GetResourceState('qb-inventory') == 'started' or GetResourceState('lj-inventory') == 'started' or GetResourceState('ps-inventory') == 'started' then
    local QBCore = exports['qb-core']:GetCoreObject()
    --[[
    local success, message = exports['qb-core']:AddItem("headbag", {
        ['name'] = 'headbag',
        ['label'] = 'Headbag',
        ['weight'] = 100,
        ['type'] = 'item',
        ['image'] = 'headbag.png',
        ['unique'] = true,
        ['useable'] = true,
        ['shouldClose'] = true,
        ['combinable'] = nil,
        ['description'] = 'Headbag to put on someones head',
    })
    if not success then print(message) end]]

    RegisterNetEvent('headbag:damageHeadbag', function(item)
        local src = source
        if not item or not item.slot or not item.name then return end
        local Player = QBCore.Functions.GetPlayer(src)
        local uses = Player.PlayerData.items[item.slot].info.uses
        if (uses - 1) < 1 then
            TriggerClientEvent("inventory:client:ItemBox", src, QBCore.Shared.Items[item.name], "remove", 1)
            Player.Functions.RemoveItem(item.name, 1, item.slot)
        else
            Player.PlayerData.items[item.slot].info.uses = Player.PlayerData.items[item.slot].info.uses - 1
            Player.Functions.SetInventory(Player.PlayerData.items)
        end
    end)

    QBCore.Functions.CreateUseableItem("headbag", function(source, item)
        local src = source
        local Player = QBCore.Functions.GetPlayer(src)
        if Player.Functions.GetItemByName("headbag") ~= nil then
            TriggerClientEvent("headbag:toggleHeadbag", src, item)
        end
    end)
end

if GetResourceState('ox_inventory') == 'started' then
    --[[ (Add below code in ox_inventory/data/items.lua)
        ['headbag'] = {
            label = 'Headbag',
            description = 'Headbag to put on someones head'
            weight = 100,
            stack = false,
            close = true,
            server = {
                export = 'cad-headbag.useItem'
            }
        },
    ]]
    RegisterNetEvent('headbag:damageHeadbag', function(item)
        local src = source
        if not item or not item.slot then return end
        local invItem = exports.ox_inventory:GetSlot(src, item.slot)
        local metadata = invItem.metadata
        local uses = invItem.metadata?.uses or 1
        if (uses - 1) < 1 then
            exports.ox_inventory:RemoveItem(src, 'headbag', 1, nil, item.slot)
        else
            metadata.uses = metadata.uses - 1
            Wait(100)
            exports.ox_inventory:SetMetadata(src, item.slot, metadata)
        end
    end)

    exports('useItem', function(event, item, inventory, slot, data)
        if event == 'usingItem' then
            if item.name == 'headbag' then
                local source = inventory.id
                local itemData = {
                    name = item.name,
                    slot = slot
                }
                TriggerClientEvent("headbag:toggleHeadbag", source, itemData)
                return false
            end
            return
        end
    end)
end
end
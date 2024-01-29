# Install Guide (qb-inventory)

> Add the below code in `qb-core/shared/items.lua`
```lua
["headbag"] = {["name"] = "headbag", ["label"] = "Head Bag", ["weight"] = 100, ["type"] = "item", ["image"] = "headbag.png", ["unique"] = true, ["useable"] = true, ["shouldClose"] = true, ["combinable"] = nil, ["description"] = "A bag to put over someone elses head and make them blind." },
```

> Add `headbag.png` to `qb-inventory/html/images`

> Add the below code in `qb-inventory/html/js` under `FormatItemInfo` function
```lua
else if (itemData.name == "headbag") {
    $(".item-info-title").html("<p>" + itemData.label + "</p>");
    $(".item-info-description").html(
        "<p>" + Math.floor((itemData.info.uses / 10) * 100) + " Durability.</p>"
    );
} 
```

> Add the below code in `qb-inventory/server/main.lua` under `giveitem` command
```lua
elseif itemData["name"] == "headbag" then
	info.uses = 10
```

> To add headbag in shop add below code in `qb-shops/config.lua`
```lua
[13] = { -- change this [13] according to your order
    name = "headbag",
    price = 400,
    amount = 50,
    info = { uses = 10 },
    type = "item",
    slot = 13, -- change this [13] according to your order
},
```

> Note: if you want to give headbag in any other resource then you have to pass the info.uses for that item
```lua
    -- Example (server): 
    local Player = QBCore.Functions.GetPlayer(source)
    Player.Functions.AddItem("headbag", 1, false, { uses = 10 })
```


# Install Guide (ox_inventory)

> Add the below code in `ox_inventory/data/items.lua`
```lua
    ['headbag'] = {
        label = 'Headbag',
        description = 'Headbag to put on someones head',
        weight = 100,
        stack = false,
        close = true,
        server = {
            export = 'cad-headbag.useItem'
        }
    }
```

> Add `headbag.png` to `ox_inventory/web/images`

> To add headbag in shop add below code in `ox_inventory/data/shops.lua` any shop you prefer under inventory secton
```lua
    { name = 'headbag', price = 100, metadata = { uses = 10 } },
```

> Note: if you want to give headbag in any other resource then you have to pass the metadata.uses for that item
```lua
    -- Example (server): 
    exports.ox_inventory(source, "headbag", 1, { uses = 10 })
```

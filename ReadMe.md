Headbag for QBCore Servers with most of the issues fixed.

# Dependencies
* qb-core

# Install Guide

> Add the below code in `qb-core/shared/items.lua`
```lua
["headbag"] = { ["name"] = "headbag", ["label"] = "Head Bag", ["weight"] = 400, ["type"] = "item", ["image"] = "headbag.png", ["unique"] = true, ["useable"] = true, ["shouldClose"] = true, ["combinable"] = nil, ["description"] = "A bag to put over someone elses head and make them blind." },
```

> Add `headbag.png` to `qb-inventory/html/images`

> Add the below code in `qb-inventory/html/js` under `FormatItemInfo` function
```lua
else if (itemData.name == "headbag") {
    $(".item-info-title").html("<p>" + itemData.label + "</p>");
    $(".item-info-description").html(
        "<p>" + Math.floor((itemData.info.uses / 5) * 100) + " Durability.</p>"
    );
} 
```

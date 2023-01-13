Headbag for QBCore Servers with most of the issues fixed.

# Dependencies
* qb-core

# Install Guide

> Add the below in `qb-core/shared/items.lua`
```lua
["headbag"] = { ["name"] = "headbag", ["label"] = "Head Bag", ["weight"] = 400, ["type"] = "item", ["image"] = "headbag.png", ["unique"] = true, ["useable"] = true, ["shouldClose"] = true, ["combinable"] = nil, ["description"] = "A bag to put over someone elses head and make them blind." },
```

> Add `headbag.png` to `qb-inventory/html/images`
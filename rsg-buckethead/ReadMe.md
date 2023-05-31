RSG-BUCKETHEAD
 Mad Respects to the original Script ['cad-headbag' for qb-core fiveM.](https://github.com/cadburry6969/cad-headbag)
 Fully Converted to RSG by RMS_dnb
 
[https://www.youtube.com/watch?v=ybigKbIy5A4](https://youtu.be/ybigKbIy5A4)
https://cdn.discordapp.com/attachments/1100113490150174821/1113233762831044668/Screenshot_1.png
 

#Info
Place a bucket on someones head so they cant see. Each bucket has 5 uses before it deletes from your inventory.  Please add everything below so the script works properly.  You can see the Durability of the bucket each time you use it, located in your inventory if you hover over the item.

# Dependencies
* rsg-core

# Install Guide

> Add the below code in `rsg-core/shared/items.lua`
```lua
["buckethead"] = { ["name"] = "buckethead", ["label"] = "Bucket for head", ["weight"] = 400, ["type"] = "item", ["image"] = "headbag.png", ["unique"] = true, ["useable"] = true, ["shouldClose"] = true, ["combinable"] = nil, ["description"] = "A bucket to put over someone elses head and make them blind." },
```

> Add `buckethead.png` to `rsg-inventory/html/images`

> Add the below code in `rsg-inventory/html/js` under `FormatItemInfo` function
```lua
else if (itemData.name == "buckethead") {
    $(".item-info-title").html("<p>" + itemData.label + "</p>");
    $(".item-info-description").html(
        "<p>" + Math.floor((itemData.info.uses / 5) * 100) + " Durability.</p>"
    );
} 
```

> Add the below code in `rsg-inventory/server/main.lua` under `giveitem` command
```lua
elseif itemData["name"] == "buckethead" then
	info.uses = 5
```

> To add headbag in shop add below code in `rsg-shops/config.lua` (OPTIONAL)
```lua
[13] = { -- change this [13] according to your order
    name = "buckethead",
    price = 400,
    amount = 50,
    info = {uses=5},
    type = "item",
    slot = 13, -- change this [13] according to your order
},
```

> Note: if you want to give headbag in any other resource then you have to pass the info.uses for that item
```lua
    -- Example (server): 
    local Player = RSGCore.Functions.GetPlayer(source)
    Player.Functions.AddItem("buckethead", 1, false, {uses=5})
```

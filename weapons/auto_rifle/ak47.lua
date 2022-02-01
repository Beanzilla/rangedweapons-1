local modpath = minetest.get_modpath(minetest.get_current_modname())

local weapon = dofile(modpath.."/weapon.lua")
local auto_rifle = dofile(modpath.."/weapons".."/auto_rifle".."/auto_rifle.lua")

local weapon_type = "auto_rifle"
local weapon_name = "ak47"

local weapon_item_name = ranged_weapons.mod_name .. ":" .. weapon_name

-- Attributes for the weapon
local ak_data = {
    name = "AK-47",
    damage = 7,
    capacity = 30,
    ammunition_string = "7.62x39mm Ammo",
    texture = {
        icon = "rangedweapons_ak47_icon.png",
        default = "rangedweapons_ak47.png",
        reload = "rangedweapons_ak47_rld.png",
    },
    fire_sound = "rangedweapons_ak"
}

ak_data.suitable_ammo = {{ranged_weapons.mod_name .. ":" .. "762mm", ak_data.capacity}}

-- Populate any unset values with handgun defaults
for k,v in pairs(auto_rifle) do
    if ak_data[k] == nil then
        ak_data[k] = v
    end
end

-- Define the item
minetest.register_tool("rangedweapons:ak47", {
    description = weapon.generate_description(ak_data),
	wield_scale = ak_data.default_wield_scale,
	range = 0,
	inventory_image = ak_data.texture.default,
    rw_gun_data = ak_data,
	on_secondary_use = function(itemstack, user, pointed_thing)
rangedweapons_reload_gun(itemstack, user)
return itemstack
end,
	on_use = function(itemstack, user, pointed_thing)
rangedweapons_shoot_gun(itemstack, user)
return itemstack
	end,
})

-- This is a trick that animates the weapon icon in the inventory. It creates multiple in-game items for each step of the
-- reload animation, which are cycled through during the reload process.

tools = {
    {name = "rangedweapons:ak47_r", next_reload = "rangedweapons:ak47_rr", load_sound = "rangedweapons_rifle_clip_in", inventory_image = "rangedweapons_ak47_rld.png"},
    {name = "rangedweapons:ak47_rr", next_reload = "rangedweapons:ak47_rrr", load_sound = "rangedweapons_rifle_reload_a", inventory_image = "rangedweapons_ak47.png"},
    {name = "rangedweapons:ak47_rrr", next_reload = "rangedweapons:ak47", load_sound = "rangedweapons_rifle_reload_b", inventory_image = "rangedweapons_ak47.png"}
}

for i, tool in pairs() do
    minetest.register_tool(tool.name, {
        stack_max = 1,
        wield_scale = ak_data.wield_scale,
        description = "",
        rw_next_reload = tool.next_reload,
        load_sound = tool.load_sound,
        range = 0,
        groups = {not_in_creative_inventory = 1},
        inventory_image = tool.inventory_image
    })
end

-- Crafting recipe for the AK-47
minetest.register_craft({
	output = "rangedweapons:ak47",
	recipe = {
		{"default:diamond", "default:steel_ingot", "default:tree"},
		{"default:tree", "default:mese", "default:steel_ingot"},
		{"default:steel_ingot", "", "default:tree"},
	}
})

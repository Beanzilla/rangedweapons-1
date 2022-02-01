-- General defaults for an automatic rifle.

local auto_rifle = {
    automatic_gun=true,
    damage = 6,
    knock_back=5,
    critical_chance = 12,
    critical_efficiency = 2.9,
    velocity = 40,
    skill = {"arifle_skill",50},
    magazine = "rangedweapons:assaultrifle_mag",
    fire_rate = 0.9,
    cooldown = 0.1,
    reload_delay = 0.35,
    projectiles = 1,
    has_shell = 1,
    smoke_size = 5,
    unload_sound = "rangedweapons_rifle_clip_out",
    accuracy = 77,
    gun_projectiles = 1,
    has_shell = 1,
    gravity = 0,
    durability = 1200,
    mob_penetration = 15,
    node_penetration = 5,
    wield_scale = {x = 1.75, y = 1.75, z = 1.3}
}

return auto_rifle

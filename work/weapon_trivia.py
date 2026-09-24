"""Gameplay ammo policy is independent of historical calibre labels.

Shared by the targeted audit and port_weapon.py; never regenerate weapons to apply it.
"""
AMMO_BY_CATEGORY = {
    "Pistols": "pistol", "Machine Pistols": "pistol", "Revolvers": "pistol",
    "Submachine Guns": "pistol", "Carbines": "smg1", "Assault Rifles": "smg1",
    "Battle Rifles": "ar2", "Bolt-Action Rifles": "357", "Sniper Rifles": "357",
    "Shotguns": "buckshot", "Rifle Grenades": "smg1_grenade",
}
AMMO_EXCEPTIONS = {
    "kolos": "smg1_grenade", "m79_sog": "buckshot", "crossbow": "XBowBolt",
    "gyrojet_carbine": "pistol", "gyrojet_pistol": "pistol",
    "ptrd": "357", "ptrd_sniper": "357",
    "m8": "mcv_flareround", "type97": "mcv_flareround",
    "bazooka": "rpg_round", "panzerschreck": "rpg_round", "m72": "rpg_round",
    "rpg2": "rpg_round", "rpg7": "rpg_round", "m202": "rpg_round",
    "m79": "smg1_grenade", "chinalake": "smg1_grenade",
    "svd": "ar2", "svt40_s": "ar2", "m1d": "ar2",
    "m21": "ar2", "m656": "ar2", "mas49_s": "ar2",
}
INTERMEDIATE = {"5.56x45mm", "7.62x39mm", "7.92x33mm", ".30 Carbine"}
FULL_POWER = {"7.62x51mm", "7.62x54mmR", "7.92x57mm", ".30-06", ".303 British", "7.5x54mm"}
PISTOL_CALIBERS = {".45 ACP", "9x19mm", "9x18mm", ".32 ACP", ".380 ACP", ".25 ACP",
                  ".38 Special", ".357 Magnum", "7.63x25mm Mauser", "7.62x25mm Tokarev",
                  "7.65x20mm", ".22 Long Rifle", "7.62x38mmR"}
CATEGORY_OVERRIDES = {"g3": "Battle Rifles"}
CALIBER_CORRECTIONS = {
    "blackhawk": ".357 Magnum", "lebel": "8x27mmR French Ordnance",
    "c96_stock": "7.63x25mm Mauser", "c96": "7.63x25mm Mauser",
    "fm24": "7.5x54mm", "mas36": "7.5x54mm", "mas36_cr39": "7.5x54mm",
    "mat49": "9x19mm", "mat49_sog": "9x19mm",
    "m56": "7.62x25mm Tokarev", "type64": "7.62x25mm Tokarev (subsonic)",
    "type64p": "7.65x17mm Type 64 rimless", "type67": "7.65x17mm Type 64 rimless",
    "vz24": "7.92x57mm", "kolos": "30mm Rocket",
    "m79_sog": "40x46mm Buckshot", "gyrojet_pistol": "13 mm Gyrojet rocket",
    "gyrojet_carbine": "13 mm Gyrojet rocket",
}
CALIBER_ALIASES = {"7.62x25mm": "7.62x25mm Tokarev", "12 Gauge Shell": "12 Gauge"}


def trivia_caliber(name, current):
    return CALIBER_CORRECTIONS.get(name.removeprefix("mcv_"), CALIBER_ALIASES.get(current, current))


def gameplay_ammo(name, category, caliber, current):
    name = name.removeprefix("mcv_")
    category = CATEGORY_OVERRIDES.get(name, category)
    if name in AMMO_EXCEPTIONS:
        return AMMO_EXCEPTIONS[name]
    if category == "Carbines" and caliber in PISTOL_CALIBERS:
        return "pistol"
    if category == "Light-Machine Guns":
        if caliber in INTERMEDIATE:
            return "smg1"
        if caliber in FULL_POWER:
            return "ar2"
        raise ValueError(f"Classify LMG cartridge before assigning ammo: {name}: {caliber}")
    return AMMO_BY_CATEGORY.get(category, current)

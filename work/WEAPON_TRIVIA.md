# Weapon ammo and trivia audit

`weapon_trivia_audit.tsv` lists resolved metadata for all 259 weapon definitions
across both packs, including inherited fields and non-spawnable definitions.
Historical calibre labels are independent of gameplay ammo pools.

## Ammo policy

- Pistols, revolvers, machine pistols and SMGs: Pistol.
- Carbines: SMG1, except pistol-cartridge carbines (Reising M60, C96 Carbine,
  Shanxi Type 17) and the explicitly requested Gyrojet: Pistol.
- Assault rifles: SMG1; battle rifles: AR2.
- Bolt-action rifles and snipers: .357; semi-auto snipers: AR2, including M656.
- LMGs: SMG1 for intermediate cartridges, AR2 for full-power rifle cartridges.
- Shotguns and M79 SOG: Buckshot.
- Rocket launchers: RPG rounds, except Kolos: SMG1 grenades.
- Grenade launchers and rifle grenades: SMG1 grenades.
- M79/M79 SOG can switch between HE and Buckshot with Use + Reload. Their
  `Firemodes` lists use `MCV.FIREMODE_HE` and `MCV.FIREMODE_BUCKSHOT`; order
  determines the starting cartridge. `MCV.FiremodeAmmo` maps these enums to
  SMG1 grenades and Buckshot. The static ammo field and audit show the spawn
  default; the live reserve and reload use the selected enum. Switching returns
  any live round to its original reserve, plays the break-open reload, and loads
  the selected cartridge on completion if reserve ammo is available. The ammo
  bodygroup keeps the outgoing cartridge through frame 50, then shows the new type.
  Loaded switches use `reload_live` (intact warhead, no spent casing effect);
  empty switches use the original spent-shell reload. Rebuild both model variants
  with `python work/m79_live_reload.py --compile`; restart GMod after compiling.
- Crossbow: HL2 crossbow bolts, including recovered bolts.
- Flare pistols keep dedicated flare ammo. Fuel, thrown explosives and equipment
  keep their existing supplies.

The policy lives in `weapon_trivia.py`, shared with the porting generator.
Country aliases and corrections live in `weapon_countries.py`. Existing hand-tuned
weapon files are patched field by field; do not regenerate them to update trivia.

Run from the addon directory:

```
python work/audit_weapon_trivia.py
python work/audit_weapon_trivia.py --apply
```

The first command reports differences and refreshes the TSV; the second applies
them. Both resolve inheritance, including variants that need their own overrides.
Future variants with different ammunition or actions must update the policy.

## Calibre reference notes

The game wiki sometimes contradicts itself between its historical description and
gameplay ammunition table. Calibre trivia follows the described cartridge, not
the game's shared ammunition pool. Variant-specific or homemade chamberings are
retained where the assets do not establish a better answer.

- MAS-36, CR39 and FM 24/29: 7.5x54mm; standard MAT-49 and SOG: 9x19mm,
  distinct from the Vietnamese MAT-49K conversion.
  https://wiki.militaryconflictvietnam.com/index.php?title=MAS-36
  https://wiki.militaryconflictvietnam.com/index.php?title=FM_24%2F29
  https://wiki.militaryconflictvietnam.com/index.php?title=MAT-49
- M56: 7.62x25mm Tokarev.
  https://muzeum.swinoujscie.pl/katalog-zabytkow/katalog-zabytkow/uzbrojenie-strzeleckie/pistolet-maszynowy-zastava-m56/
- Type 64/67 pistols: special rimless 7.65x17mm, not ordinary .32 ACP.
  https://www.bulletpicker.com/pdf/DIA-ST-HB-07-03-74.pdf
- Vz.24: 7.92x57mm.
  https://www.vhu.sk/792-mm-ceskoslovenska-pechotna-puska-vzor-24/

Validation is offline only. Lua changes require a map change.

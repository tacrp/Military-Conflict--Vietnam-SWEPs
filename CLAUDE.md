# Working on this addon

Military Conflict: Vietnam's weapons ported to Garry's Mod. `work/PORTING.md` is the long
reference for the porting pipeline; `BUGLIST.md` is the running log of what has been fixed.

## Convars

Every convar the addon has must appear in the Q menu tab, **Options > Military Conflict:
Vietnam**, so nothing has to be typed into the console. Adding one is two steps:

1. Register it. Gameplay convars that both realms read go in `lua/mcv/shared/sh_convars.lua`
   through `MCV.RegisterConVar` (archived, replicated, notify) with an accessor beside it.
   A client's own preference is a `CreateClientConVar` in a file under `lua/mcv/client/`;
   pass `true` for userinfo where other players need to see the choice, as the tracer colour
   does.
2. Add one entry to `SETTINGS` in `lua/mcv/client/cl_settings.lua`. An entry with `choices` is
   a dropdown, anything else a checkbox; `section` starts a heading. Give every entry a `help`
   line saying what it does in plain words.

The `mcv_wm_*` convars are deliberately left out of the menu: they are for tuning world model
placement by hand against Crowbar and hold raw numbers, not settings anyone plays with.

## House rules

* Never regenerate a whole weapon lua to change a few fields. The generators drop hand-tuned
  keys (sights, secondaries, rifle-grenade keys, placement offsets). Copy the values you mean
  to change into the committed file instead.
* Hand-tuned iron sight offsets are the user's. `work/fix_sight_offsets.py` leaves them alone
  without `--sights`, and the generator reuses whatever the lua already has. Do not sweep them.
* Stage files explicitly when committing. `git add -A lua` has swept the user's uncommitted
  work into unrelated commits more than once, and a `git checkout` across `lua/weapons` has
  destroyed hand tuning that was never committed. Stash first if the tree has to be cleaned.
* Check Lua with `python work/glua_check.py "lua/weapons/*.lua"` after editing; there is no
  luac on this machine and the checker translates GLua before compiling it.
* Write patch scripts with the file tool rather than shell heredocs, which mangle backslashes
  in regular expressions.
* Models only load when Garry's Mod starts. A Lua change needs a map change; a recompiled model
  needs a full restart. Say which in the report.

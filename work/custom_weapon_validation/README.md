# Custom weapon asset validation — 2026-09-14

The XM16 Super screenshots and game results here predate the user's subsequent
correction to the M16-M203 firing donor. That correction replaced all 12 rifle-shot
and corrective SMDs, verified byte-for-byte against the M203 donor, and compiled
from the editable bundle. Its compile logs are beside the local QCs. No new
in-game run was performed for that donor substitution.

Fresh local multiplayer instance on gm_flatgrass, port 27016, sv_cheats 1,
net_fakelag 0. These are functional and visual checks, not a prediction regression
suite. `custom_weapon_assets.json` contains all three successful material checks.

- PTRD-41 Sniper: canted scope aligned; view/world materials loaded; clip 1 to 0
  after firing, then 0 to 1 after reload. The separate cartridge is hidden after
  the shot (bodygroup 1), shown during insertion (bodygroup 0), and remains shown
  once loaded. Scope, cartridge and world-model screenshots were inspected.
- M635: updated M601 receiver material resolves in viewmodel and worldmodel.
  Both were visually inspected. Compiled model events place the M76 magazine-in
  sound at 0.966667 seconds, frame 29 instead of frame 44, in both reloads.
  The hand/magazine motion and gameplay reload timing were not changed.
- XM16 Super: M16A1 rifle-shot animations and playback rate 0.5; hip fire consumed
  30 to 28 rounds, aimed fire consumed another two (26 shown in the screenshot).
  All view/world materials resolved; `gl_shoot_deployed` remains in the model.

All three local editable source folders compiled both their view and world QCs.
Original input-mesh SHA256 values are recorded in `custom_compile_validation.json`;
compilation did not alter those meshes. The M635 was compiled again after adding
the M601 material directory, before the final game restart.

Commands from the addon root:

```
python work/verify_custom_compile_files.py
python work/check_custom_model_events.py
python work/harness.py start gm_flatgrass --mp --multirun --port 27016
python work/harness.py run work/tests/ptrd_sniper_preview.txt --port 27016
python work/harness.py run work/tests/custom_weapon_assets.txt --port 27016
python work/harness.py run work/tests/custom_weapon_world.txt --port 27016
python work/glua_check.py "lua/weapons/*.lua" "lua/mcv_harness/custom_weapon_assets.lua"
```

The final syntax check covered 242 Lua files, with no syntax errors. The side-view
fixture anchors its camera to player origin because a first-person player's
cached hand-bone transform did not reliably frame the weapon.

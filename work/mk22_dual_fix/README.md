# Mk 22 Mod 0 dual suppressors

The single `v_mk22` model has basic/suppressed variants in bodygroup 1. The ordinary
`v_dual_mk22` model has three fixed bodyparts and no suppressor variant, so setting
the single gun's `01` bodygroup string cannot add either suppressor.

The source game's `weapon_dual_mk22_mod0.txt` names `v_dual_mk22_mod0`. This model
is already compiled and installed. It contains the suppressed pair and moves
both muzzle attachments from -7.4 to -14.4 along the guns' respective bone X axes.
Changed only `ViewModelAkimbo` in the weapon definition; the existing single and
worldmodel bodygroup configurations remain correct.

`port_weapon.py` now reads an available dual script's viewmodel instead of always
prefixing the single model's name. Dual animation metadata uses that same model.
Generated only a scratch preview of the Mk 22 Lua to confirm the resulting model;
the installed Lua was patched in place to preserve hand tuning.

Validation on a fresh local multiplayer instance, port 27018:

- Normal E+walk toggle selected the suppressed dual model on client and server.
- Both suppressors are visibly present in `mk22_dual.png`; both muzzle attachments exist.
- Primary shot consumed ammunition; switching back retained the single suppressor.
- Toggling dual again, switching to a crowbar and re-deploying restored the dual model.
- Explicit client assertions and the harness job completed without errors.
- The selected Lua files passed syntax checking (242 files); changed Python files compiled.

The recorded reports and assertions are beside this file. Reproduce with
`python work/harness.py run work/tests/mk22_dual.txt --port 27018` on a disposable
local MP session. That fixture clears the test player's inventory and also checks
the five custom spawn icons. This fix needs a map change, not a model recompile.

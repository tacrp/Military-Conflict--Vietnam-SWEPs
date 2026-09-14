# XM16 Super

`mcv_xm16super` is a spawnable Assault Rifle built from the user's original
`MCV_SMD/weapons/v_xm16super/xm16super.smd`. The source mesh is unchanged.

It has a 30-round magazine, one optional chambered round, the Mk.4 suppressor and
muzzle position, XM177 stock and 4x scope, and a deployed M203. It inherits the
M16A1 M203's handling and launcher animations. Its three hip/aimed rifle-shot
deltas and matching correctives now come from the M16A1, with `ShootAnimRate = 0.5`
matching the M16's playback rate instead of the old, snappier 0.15. Scope mode uses the scope eye position;
launcher mode uses the M203 ladder position and disables the scope lens.

## Rebuild

From the addon directory:

```
python work/build_xm16super.py --install
```

Requires the existing ported M203/Mk.4 donor assets, NumPy/Pillow and the documented
`work/compile_test_game` scratch game. Builds both QCs and installs only this
weapon's model files and silhouette icon. `--icon-only` regenerates just its icon.

For hand editing, `work/MCV_SMD/weapons/v_xm16super/` contains local view/world QCs,
their animation SMDs and hand-rig QCI under `assets/`, and `compile.py`. Edit these
and run `python compile.py` there, or use Crowbar. The local compile command does
not regenerate the QCs or replace your edits.

The viewmodel reuses the M203 animation rig and hand merge. A separate
`gl_shoot_deployed` sequence uses the same launcher base poses as its idle;
the donor's immediate hip-fire activity is preserved. The world model is a
static conversion of the full kitbash mesh, using the Mk.4's hand placement and
collision mesh. It currently has no reduced-detail LODs.

## Validation

Both models compiled successfully and loaded in a fresh local multiplayer game.
The VM has 65,518 vertices, close to the compiler's 65,536 limit; adding geometry
will require reducing or splitting it. Materials, hands, scope lens, launcher
sights and world placement were inspected in-game.

- `work/tests/xm16super_preview.txt`: spawn clip, scope material and magnification,
  launcher lens exclusion, screenshots and client/server reports.
- `work/tests/xm16super_firing.txt`: automatic fire, three semi-auto shots,
  31-round tactical reload and 30-round empty reload, plus world-model preview.
- `work/launcher_prediction.py --port 27016 --label xm16super_launcher100 --lag 100 --classes mcv_xm16super`:
  aimed launcher firing/reload, blocked rifle selector, return to rifle mode.
  Both realms passed. Render trace includes `gl_shoot_deployed` and 9,410 replays.

Firing and launcher tests used 100 ms fakelag; full replay was enabled for the
main firing/launcher intervals. No native weapon/viewmodel field errors occurred.
The engine logged player `m_nTickBase` corrections (five in the launcher test,
two in the rifle test), so these were not completely error-free engine runs.

**Restart Garry's Mod fully to load the new models.** Subsequent Lua-only edits
need a map change.

The M16A1 firing-animation update was compiled again from the local editable
QCs and checked in a fresh multiplayer game. Hip and aimed shots consumed ammo,
the M16 playback rate was active, all view/world materials resolved, and the
deployed launcher sequence remained available. These were asset/function checks;
the prediction results above describe the earlier launcher validation. Updated
screenshots and results are in `work/custom_weapon_validation/`.

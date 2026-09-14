# Worldmodel trigger-finger placement

The September 14 pass corrects the translation of 181 worldmodels whose root right-hand
bone was rotated by the preceding pitch pass. Their barrel angles are preserved.
The hand origin lies below the trigger; rotating about that origin lifted the gun away
from the index finger.

The harness measured the midpoint of the right index finger's two distal joints in
the hand's local frame for six GMod hold types. With the hand bind transform `H = (R,t)`
and finger point `p`, the correction is `t_new = t_old + (R_old - R_new) p`.
Thus the same point on the mesh remains at the finger after changing pitch.
This is approximate placement: GMod's generic poses cannot perfectly grip every stock,
trigger guard, rocket launcher and support hand at once.

`world_model_contact_pivots.json` contains the measurements.
`fix_world_model_contact.py` changes only the root-hand QC line, retains a per-model
backup and records exact before/after values in `world_model_contact/changes.json`.
It refuses to overwrite a subsequently hand-edited line. `port_qc.py` uses the same
correction when generating a worldmodel, so rebuilding preserves the placement.

All 181 models compiled and were installed. After restarting GMod, close-ups were
checked on AK-47, M76, M1911A1, China Lake, bazooka, DP-28, SKS, Blackhawk, Owen and M72.
The nine matched before/after views are in `world_model_contact/comparison.png`.
Props, mounts, unsupported parented hand rigs and models outside the previous pitch
pass are listed as skipped in `world_model_contact/plan.json`.

Reproduction: `python work/fix_world_model_contact.py` checks the current plan;
add `--apply --compile --install --jobs 6` to rebuild it. **Fully restart Garry's Mod**
to load the new models. Viewmodels and hand-tuned iron-sight offsets are unaffected.

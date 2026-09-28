# Clientside model lifetime and NPC poses

`lua/mcv/client/cl_modelgc.lua` owns a strong registry of the worldmodel copies
and placeable previews created by the addon. Explicit removal remains immediate;
a one-second sweep catches missed callbacks, overwritten slots, deleted models,
invalid weapons/owners, owner changes, dormant entities and holstered weapons.
Entity removal and transmission-loss hooks cover every registered copy belonging
to that entity, including copies no longer reachable through its active weapon.
Map cleanup, shutdown and loader refresh explicitly empty the registry.

New production client models should use `MCV.TrackClientModel(weapon, slot, model)`
and `MCV.RemoveClientModel(weapon, slot)`. The collector visits only registered
copies, never the entire entity list. It does not call Lua's garbage collector:
[ClientsideModel entities require explicit removal](https://wiki.facepunch.com/gmod/Global.ClientsideModel).

The NPC report has no named NPC, weapon or reproduction. The installed Combine,
Metropolice and Citizen skeletons were read from `hl2_misc_dir.vpk`; all contain
`ValveBiped.Bip01_R_Hand` and none contain `ValveBiped.weapon_bone`. Inspection of
the weapon models found the right-hand bone in every installed referenced model
(226 unique worldmodel paths across both packs). This does not support a general
missing-hand-root or conflicting-weapon-bone explanation for stock NPCs.

The renderer did assume that DrawWorldModel was always called with the owner's
current bones already prepared. NPCs now explicitly prepare owner bones first.
Owner model changes refresh parenting/bone adjustment state. Missing hand bones
or matrices retire copies and fall back to native weapon rendering. A failed
dual-hand transform no longer returns a stale left copy for drawing. PVS parent
repair remains in place; attachment readers use the same pose preparation.

`python work/test_client_models.py` exercises actual Lua lifetime and draw paths
with engine stand-ins: lost slots, missed callbacks, owner and PVS changes, inactive
weapons, cleanup/reload, NPC bone order, missing transforms and stale dual copies.
These are concrete failure-path fixes, not confirmation of the reported visual
bug. No game was launched. Lua changes require a map change; the pending base and
prewar-model changes still require a full restart.

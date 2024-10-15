I highly recommend using the version of StudioMDL included with MCV itself. It compiles significantly faster than GMod's version and gets around certain limitations like the vertex and bone limit.


## Viewmodel Method 1 -- The OG: 
(cross-reference this with the SKS' QC if you need a good example of how to do this)

1. Find the weapon's idle $sequence. If it has a blendlayer for "ironsight_test", remove it.

2. Add the "ironsight" $animation (or equivalent) to the $sequence and change the blendwidth accordingly (3 anims = blendwith of 3).

3. For every firing $sequence, make a copy of the idle $sequence. Rename all your shoot $sequences to something else (i.e. "shootpose1", "shootpose2", etc.) and name all your cloned idle sequences to "shoot", "shoot2", etc. (Or whatever you want to name everything it doesnt matter as long as you set everything up correctly)

4. Delete the ACT_VM_PRIMARYATTACK from the old shoot sequences and add them to your new ones (the ones cloned from the idle $sequence) while removing ACT_VM_IDLE. If this a lastshoot animation (used for pistols or any weapon where the bolt will lock back on empty) make sure it calls ACT_VM_LASTSHOOT.

5. Add the old shoot $sequences as layers to your new $sequences. i.e. "addlayer "shootpose1""

NOTE: You will also need to do this process for pumping/cycling $sequences on weapons that have them. Do the above steps for your cycle $sequence and make sure you call "ACT_VM_RELOAD_INSERT_PULL" in your new $sequence. 

6. Add the "snap" command to your shoot $sequences. If the weapon jerks awkwardly after shooting, instead of adding "snap" to your shoot $sequences, define their fadein and fadeout as both 0 (keep "snap" on the shootposes). 

7. Go to all the $animations referenced in the idle $sequence and add:

    numframes 60

   to each of them. Make sure their FPS is the same as well.

8. Remove the "walklyer" and "runlayer" layers and replace them with just "walklayerironsights" in the following $sequences:

 - "draw"
 - "firstdraw"
 - "holster


9. Remove the "walklayerironsight" layer from reload and related animations. (Otherwise the hands clip)

Compile your model and see if everything worked.


## Extra advice:

- For firstdraw $sequences ensure they call ACT_VM_READY and not ACT_VM_FIRSTDRAW

- Some slide position $sequences will need to have their included $animations inverted to work correctly. i.e. The $animation for the slide going back should be called BEFORE the $animation of the slide going forward. Experiment with this until you get the desired result, as this isn't applicable to every weapon.

- If a slide position $animation causes issues with certain bones twisting and looking wrong, try subtracting a corrective animation from it (assuming it doesn't already have one).

- For weapons that use a single model with bodygroups to represent multiple variants, you may need to add a blank "dummy" bodygroup to the QC to make sure they're set correctly by Lua in-game. Be sure to add the bodygroup as the second one in the list (giving it an ID of 1) and be sure to account for it when defining bodygroups in the weapon's Lua.
DO NOT do this if the weapon has bayonet functionality. Only do it on weapons which lack a bayonet.

- This method so far has only worked on the Kar 98 but I'm still noting it here. The jerking at the end of firing anims can be fixed by adding "numframes <length of the animation>" to all shoot $animations. This eliminates the need to add "snap" to your idle or spoof a snap with zeroed fadein and fadeout on your shoot $sequences.


## Setting up worldmodels:

Most worldmodels have "ValveBiped.weapon_bone" as their base bone. To make them work with (most) Garry's Mod playermodels they will need to have "ValveBiped.Bip01_R_Hand" defined somewhere.

1. Add a new $definebone line above topmost existing one (typically "ValveBiped.weapon_bone") and have it define "ValveBiped.Bip01_R_Hand."

2. Make "ValveBiped.weapon_bone" (or equivalent) a child of "ValveBiped.Bip01_R_Hand" by placing its name in the second pair of quote marks. Make sure to keep the bone's translations (the long string of numbers at the end of the line) intact.

3. On the $definebone line for "ValveBiped.Bip01_R_Hand", set its translations to lineup with the playermodel's hand. It's probably best to use a default or normative humanoid playermodel when testing this. A good set of starting values is:
	
	-6 -1 -2 0 0 180 0 0 0 0 0 0

For reference: The first six values are, in order from left to right: 
X position, Y position, Z position, X rotation, Y rotation & Z rotation. 

X/Y is usually left-right and forward-back and Z is typically up-down though this can change depending on the rotations you've set. Play around with the position translations so you know what does what.

Changes can be viewed in-game or HLMV. Regardless of which you choose it's still useful to look at changes in-game to ensure everything looks correct.

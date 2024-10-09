## Universal advice:
- It's sometimes better to remove the walklayers from reload animations, as they cause hands to move out of place if you move during the animation. Removing the layer doesnt adversely affect quality. (Subject to change)

- QC attachments should be in a specific order: Muzzle, Eject, Camera

- For firstdraw $sequences ensure they call ACT_VM_READY and not ACT_VM_FIRSTDRAW

- All draw and firstdraw $sequences should use "walklayerironsight" instead of "walklayer"

- Some slide position $sequences will need to have their included $animations inverted to work correctly. i.e. The $animation for the slide going back should be called BEFORE the $animation of the slide going forward.

- If a slide position $animation causes issues with certain bones, try subtracting a corrective animation.


### Method 1 (cross-reference this with the SKS' QC):

1. Find the weapon's idle $sequence. If it has a blendlayer for "ironsight_test", remove it.

2. Add the "ironsight" $animation (or equivalent) to the $sequence and change the blendwidth accordingly (3 anims = blendwith of 3).

3. For every firing $sequence, make a copy of the idle $sequence. Rename all your shoot $sequences to something else (i.e. "shootpose1", "shootpose2", etc.) and name all your cloned idle sequences to "shoot", "shoot2", etc. (Or whatever you want to name everything it doesnt matter as long as you set everything up correctly)

4. Delete the ACT_VM_PRIMARYATTACK from the old shoot sequences and add them to your new ones (the ones cloned from the idle $sequence) while removing ACT_VM_IDLE. If this a lastshoot animation (used for pistols or any weapon where the bolt will lock back on empty) make sure it calls ACT_VM_LASTSHOOT.

5. Add the old shoot $sequences as layers to your new $sequences. i.e. "addlayer "shootpose1""

6. Go to all the $animations referenced in the idle $sequence and add:

    numframes 60

to each of them. Make sure their fps is the same as well.

7. Replace "walklayer" "runlayer" with "walklayerironsights" in the following animations:

 - "draw"
 - "firstdraw"
 - "holster


8. Remove the "walklayerironsight" layer from reload and related animations (Otherwise the hands clip)
9. Add "snap" to your idle and firing animations (This is to prevent firing animations from jerking after shooting)
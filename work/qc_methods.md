## Universal advice:
- It's sometimes better to remove the walklayers from reload animations, as they cause hands to move out of place if you move during the animation. Removing the layer doesnt adversely affect quality. (Subject to change)

- QC attachments should be in a specific order: Muzzle, Eject, Camera

- For firstdraw $sequences ensure they call ACT_VM_READY and not ACT_VM_FIRSTDRAW

- All draw and firstdraw $sequences should use "walklayerironsight" instead of "walklayer"


### Method 1 (cross-reference this with the SKS' QC):

1. Find the weapon's idle $sequence. If it has a blendlayer for ironsights, remove it.

2. Add the "ironsight" $animation (or equivalent) to the $sequence and change the blendwidth accordingly (3 anims = blendwith of 3).

3. For every firing $sequence, make a copy of the idle $sequence. Rename all your shoot $sequences to something else (i.e. "shootpose1", "shootpose2", etc.) and name all your cloned idle sequences to "shoot", "shoot2", etc. (Or whatever you want to name everything it doesnt matter as long as you set everything up correctly)

4. Ensure all the new shoot $sequences (the ones cloned from the idle $sequence) are properly calling ACT_VM_PRIMARYATTACK. If this a lastshoot animation (used for pistols or any weapon where the bolt will lock back on empty) make sure it calls ACT_VM_LASTSHOOT. Also ensure the old shoot $sequences (your shootposes) aren't calling any activities themselves.

5. Add the old shoot $sequences as layers to your new $sequences. i.e. "addlayer "shootpose1""

6. Go to all the $animations referenced in the idle $sequence and ensure they all have the same framerate and numframes. This is key to animations playing correctly.
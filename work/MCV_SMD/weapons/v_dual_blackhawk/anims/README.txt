run_a.smd: the game's run layer moves only the gun base bones (BaseMesh / BaseLeftMesh, 7-10 units)
and relies on IK to drag the hands along. The port has no IK. This copy gives `root` (the arm
rig's parent) the guns' average translation delta per frame, so hands and guns bob together as
the game's IK made them; the guns keep their own authored motion. Generated Sep 6 2026; see
PORTING.md, "Dual Blackhawk run layer".

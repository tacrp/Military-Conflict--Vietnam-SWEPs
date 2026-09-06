run_a.smd: the game's run layer moves only the gun base bones (BaseMesh / BaseLeftMesh, 7-10 units)
and relies on IK to drag the hands along. The port has no IK. This copy turns the guns' authored
travel into a swing of the whole rig about `root` (angle = travel / lever, axis = lever x travel),
applied to root and to both gun bones, so hands and guns move together in position and angle.
Generated Sep 6 2026 by the scratch script; see PORTING.md, "Dual Blackhawk run layer".

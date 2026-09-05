run_a.smd: the game's run layer moves only the gun base bones (BaseMesh / BaseLeftMesh, 7-10 units)
and relies on IK to drag the hands along. The port has no IK, so the guns left the hands while
sprinting. This copy holds those two bones at the corrective's frame-0 values (zero delta), which
is what the dual M1917 and the other dual revolvers effectively do (their "Base" is a dummy bone).
Generated Sep 6 2026; see PORTING.md, "Dual Blackhawk run layer".

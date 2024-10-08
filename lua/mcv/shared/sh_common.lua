MCV.FIREMODE_AUTO = 0
MCV.FIREMODE_SEMI = 1
MCV.FIREMODE_BURST = 2
MCV.FIREMODE_SA = 3
MCV.FIREMODE_DA = 4
MCV.FIREMODE_FAN = 5
MCV.FIREMODE_BOLT = 6
MCV.FIREMODE_PUMP = 7

MCV.CancelMultipliers = {
    [1] = {
        [HITGROUP_HEAD]     = 2,
        [HITGROUP_LEFTARM]  = 0.25,
        [HITGROUP_RIGHTARM] = 0.25,
        [HITGROUP_LEFTLEG]  = 0.25,
        [HITGROUP_RIGHTLEG] = 0.25,
        [HITGROUP_GEAR]     = 0.25,
    },
    ["terrortown"] = {
        [HITGROUP_HEAD]     = 1,
        [HITGROUP_LEFTARM]  = 0.55,
        [HITGROUP_RIGHTARM] = 0.55,
        [HITGROUP_LEFTLEG]  = 0.55,
        [HITGROUP_RIGHTLEG] = 0.55,
        [HITGROUP_GEAR]     = 0.55,
    },
}

MCV.ShellTypes = {
    [1] = {
        Model = "models/weapons/shells/shell_762x39sov.mdl",
        Sound = "MCV_Bounce.Shell"
    }
}
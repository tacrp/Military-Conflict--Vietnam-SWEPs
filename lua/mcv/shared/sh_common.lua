MCV.FIREMODE_AUTO = 0
MCV.FIREMODE_SEMI = 1
MCV.FIREMODE_BURST = 2
MCV.FIREMODE_SA = 3
MCV.FIREMODE_DA = 4
MCV.FIREMODE_FAN = 5
MCV.FIREMODE_BOLT = 6
MCV.FIREMODE_PUMP = 7


MCV.FiremodeNames = {
    [MCV.FIREMODE_AUTO] = "Automatic",
    [MCV.FIREMODE_SEMI] = "Single-Fire",
    [MCV.FIREMODE_BURST] = "3-Round Burst",
}

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
    },
    [2] = {
        Model = "models/weapons/shells/shell_12g.mdl",
        Sound = "MCV_Bounce.ShotgunShell"
    },
    [3] = {
        Model = "models/weapons/shells/shell_145x114.mdl",
        Sound = "MCV_Bounce.Shell"
    },
    [4] = {
        Model = "models/weapons/shells/shell_556x45n.mdl",
        Sound = "MCV_Bounce.Shell"
    },
    [5] = {
        Model = "models/weapons/shells/shell_762x25t.mdl",
        Sound = "MCV_Bounce.Shell"
    },
    [6] = {
        Model = "models/weapons/shells/shell_762x38mmr.mdl",
        Sound = "MCV_Bounce.Shell"
    },
    [7] = {
        Model = "models/weapons/shells/shell_762x51n.mdl",
        Sound = "MCV_Bounce.Shell"
    },
    [8] = {
        Model = "models/weapons/shells/shell_762x54mmr.mdl",
        Sound = "MCV_Bounce.Shell"
    },
    [9] = {
        Model = "models/weapons/shells/shell_792x33ku.mdl",
        Sound = "MCV_Bounce.Shell"
    },
    [10] = {
        Model = "models/weapons/shells/shell_792x57ma.mdl",
        Sound = "MCV_Bounce.Shell"
    },
    [11] = {
        Model = "models/weapons/shells/shell_9x18m.mdl",
        Sound = "MCV_Bounce.Shell"
    },
    [12] = {
        Model = "models/weapons/shells/shell_9x19.mdl",
        Sound = "MCV_Bounce.Shell"
    },
    [13] = {
        Model = "models/weapons/shells/shell_flare.mdl",
        Sound = "MCV_Bounce.Shell"
    },
    [14] = {
        Model = "models/weapons/shells/shell_gren.mdl",
        Sound = "MCV_Bounce.Shell"
    },
    [15] = {
        Model = "models/weapons/shells/shell_x22lr.mdl",
        Sound = "MCV_Bounce.Shell"
    },
    [16] = {
        Model = "models/weapons/shells/shell_x30-06.mdl",
        Sound = "MCV_Bounce.Shell"
    },
    [17] = {
        Model = "models/weapons/shells/shell_x30.mdl",
        Sound = "MCV_Bounce.Shell"
    },
    [18] = {
        Model = "models/weapons/shells/shell_x45apc.mdl",
        Sound = "MCV_Bounce.Shell"
    },
    [19] = {
        Model = "models/weapons/shells/shell_x50bmg.mdl",
        Sound = "MCV_Bounce.Shell"
    },
    [20] = {
        Model = "models/weapons/shells/lmg_chain_m60.mdl",
        Sound = "MCV_Bounce.Shell"
    },
    [21] = {
        Model = "models/weapons/shells/lmg_chain_rp46.mdl",
        Sound = "MCV_Bounce.Shell"
    },
    [22] = {
        Model = "models/weapons/shells/lmg_chain_rpd.mdl",
        Sound = "MCV_Bounce.Shell"
    },
    [23] = {
        Model = "models/weapons/shells/lmg_chain_stoner63.mdl",
        Sound = "MCV_Bounce.Shell"
    },
}
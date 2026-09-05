// Console variables. Gameplay toggles are server convars, replicated and archived, so the
// predicted weapon code reads the same value on both realms and a listen server's choice reaches
// its clients; register them here (not in the weapon files, which load per weapon) with
// MCV.RegisterConVar and read them through the accessors below. Client-only preferences (HUD)
// stay CreateClientConVar in the client files.
MCV = MCV or {}
MCV.ConVars = MCV.ConVars or {}

function MCV.RegisterConVar(name, default, help, flags)
    local cv = GetConVar(name)
    if !cv then
        cv = CreateConVar(name, default, bit.bor(FCVAR_ARCHIVE, FCVAR_REPLICATED, FCVAR_NOTIFY, flags or 0), help)
    end
    MCV.ConVars[name] = cv
    return cv
end

function MCV.GetConVar(name)
    return MCV.ConVars[name]
end

// ------------------------------------------------------------------------------------------
// Shooting mechanics. 1: the addon's own recoil and spread (the bullet leaves the barrel where
// it points, so hip fire is inaccurate because the gun is not lined up with the eye rather than
// through a cone; recoil kicks randomly up or down from the hip and settles; the view zooms out
// a little as a burst goes on). 0: the game's numbers as they are in the weapon scripts (a hip
// fire cone that narrows to the sighted spread as the sights come up, stance multipliers on it,
// a fixed view slide up and to one side per shot, the optional random ViewKick).
MCV.RegisterConVar("mcv_realistic_shooting", "0",
    "1: the addon's recoil and spread (barrel-accurate hip fire, random kick). 0: the game's own recoil and spread cone.")

function MCV.RealisticShooting()
    return MCV.ConVars.mcv_realistic_shooting:GetBool()
end

// ------------------------------------------------------------------------------------------
// Hybrid reload on stripper-clip rifles that also have round-by-round loading animations
// (Kar98k, Springfield, Vz.24): 1 tops a partly loaded magazine up one round at a time and
// uses the clip only when empty; 0 always reloads with the clip (the game's behaviour). Only
// guns flagged HybridReloadCapable (the model has both sets of animations) are affected.
MCV.RegisterConVar("mcv_hybrid_reload", "1",
    "1: stripper-clip rifles with single-round animations top up round by round when partly loaded. 0: always the clip.")

function MCV.HybridReload()
    return MCV.ConVars.mcv_hybrid_reload:GetBool()
end

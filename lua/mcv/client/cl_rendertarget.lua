// The scope lens shader samples the frame from before the viewmodel was drawn: the world
// without the gun. gShader's early effects also contain the gun's depth silhouette, so
// its PreDrawReconstruction hook provides an earlier clean capture point.
local function captureScope(beforeReconstruction)
    // Do not replace the main view with a reflection, camera or another addon's RT view.
    local view = render.GetViewSetup()
    if view.id and view.id != 0 and view.id != 4 then return end
    local ply = LocalPlayer()
    if !IsValid(ply) then return end
    local wpn = ply:GetActiveWeapon()

    if !IsValid(wpn) or !wpn.MilitaryConflictVietnam then return end

    if wpn.CaptureScopeScreen then wpn:CaptureScopeScreen(beforeReconstruction) end
end

hook.Add("PreDrawViewModels", "MCV_CaptureScopeScreen", function()
    captureScope(false)
end)

hook.Add("PreDrawReconstruction", "MCV_CaptureScopeBeforeShaders", function()
    captureScope(true)
end)

// The model's own $bbox is the viewmodel's render box, and a box that ends at eye height (the
// molotov's and the dynamite's) had the whole viewmodel culled: nothing drawn, and none of
// the weapon's PreDrawViewModel hooks run for a culled viewmodel, so the bounds are set here,
// before the viewmodels are considered at all. port_qc's step_bbox widens the box at compile
// time as well.
local VM_BOUNDS_MIN, VM_BOUNDS_MAX = Vector(-96, -96, -96), Vector(96, 96, 96)
hook.Add("PreDrawViewModels", "MCV_ViewModelBounds", function()
    local ply = LocalPlayer()
    if !IsValid(ply) then return end
    local wep = ply:GetActiveWeapon()
    if !IsValid(wep) or !wep.MilitaryConflictVietnam then return end
    local vm = ply:GetViewModel()
    if IsValid(vm) then vm:SetRenderBounds(VM_BOUNDS_MIN, VM_BOUNDS_MAX) end
end)

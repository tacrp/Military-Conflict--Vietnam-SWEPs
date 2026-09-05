// The scope lens shader samples the frame from before the viewmodel was drawn: the world
// without the gun. Capture it here, once per frame, only while a scope is in use.
hook.Add("PreDrawViewModels", "MCV_CaptureScopeScreen", function()
    local ply = LocalPlayer()
    if !IsValid(ply) then return end
    local wpn = ply:GetActiveWeapon()

    if !IsValid(wpn) or !wpn.MilitaryConflictVietnam then return end

    if wpn.CaptureScopeScreen then wpn:CaptureScopeScreen() end
end)

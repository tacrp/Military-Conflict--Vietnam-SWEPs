// The scope picture is a second render of the world from the scope's camera. It has to happen
// before the frame's own scene: a nested view rendered from inside the scene hooks leaves its
// camera behind for the viewmodel pass, which then draws the gun from the scope camera.
hook.Add("PreRender", "MCV_RenderScopeView", function()
    local ply = LocalPlayer()
    if !IsValid(ply) then return end
    local wpn = ply:GetActiveWeapon()

    if !IsValid(wpn) or !wpn.MilitaryConflictVietnam then return end

    if wpn.RenderScopeView then wpn:RenderScopeView() end
end)

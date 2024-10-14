hook.Add("PreDrawViewModels", "MCV_PreDrawViewModels", function()
    local wpn = LocalPlayer():GetActiveWeapon()

    if !wpn.MilitaryConflictVietnam then return end

    wpn:DoCheapScope()
end)
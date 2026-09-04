hook.Add("PreDrawViewModels", "MCV_PreDrawViewModels", function()
    local wpn = LocalPlayer():GetActiveWeapon()

    if !IsValid(wpn) or !wpn.MilitaryConflictVietnam then return end

    wpn:DoCheapScope()
end)
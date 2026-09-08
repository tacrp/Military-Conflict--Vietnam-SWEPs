// Whether this client is looking down its own viewmodel or at its own back.
//
// The server decides who hears the game's third person weapon foley, and the one player it
// leaves out is the holder, because their viewmodel is playing the first person set at the same
// time. That reasoning only holds in first person: in third person the viewmodel is not on
// screen, so they should hear themselves the way everyone standing near them does.
//
// ShouldDrawLocalPlayer is a client-side question with no server-side answer, so the client
// carries it across as userinfo, the way the tracer colour does. It is read on the server with
// GetInfoNum (mcv_base_core/shared.lua, EmitThirdPersonSound).

local cv = CreateClientConVar("mcv_cl_thirdperson", "0", false, true,
    "Set by the addon, not by hand: 1 while this client is drawing its own player model")

// A userinfo convar is a message to the server every time it is set, so it is only touched when
// the answer actually changes, which is when the player switches view.
local last = nil

hook.Add("Think", "MCV_ViewState", function()
    local ply = LocalPlayer()
    if !IsValid(ply) then return end

    local third = ply:ShouldDrawLocalPlayer()
    if third == last then return end

    last = third
    RunConsoleCommand("mcv_cl_thirdperson", third and "1" or "0")
end)

// the value is the client's own, so a fresh connection starts from whatever the view is now
hook.Add("InitPostEntity", "MCV_ViewState", function()
    last = nil
end)

function MCV.DrawingOwnPlayer()
    return cv:GetBool()
end

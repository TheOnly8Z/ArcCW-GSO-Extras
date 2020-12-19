att.PrintName = "Double Tapper"
att.Icon = Material("entities/acwatt_go_perk_hyper.png")
att.Description = "Firemode conversion allowing for a rapid two-round burst and semi-automatic fire. Due to the high firerate, the first shot's recoil will be reduced."
att.Desc_Pros = {
}
att.Desc_Cons = {
}
att.AutoStats = true
att.Slot = "go_perk"

att.Override_Firemodes_Priority = 100
att.Override_Firemodes = {
    {
        Mode = -2,
        Mult_RPM = 2,
        RunawayBurst = true,
        PostBurstDelay = 0.2,
        Override_ShotRecoilTable = {
            [0] = 0.1
        }
    },
    {
        Mode = 1
    },
    {
        Mode = 0
    }
}

att.Hook_Compatible = function(wep)
    if wep:GetIsShotgun() or wep.ManualAction then return false end
end
att.PrintName = "8-Round M225 M6D"
att.Icon = Material("entities/acwatt_go_usp_mag_20.png", "mips smooth")
att.Description = "How did you manage to do this?\nConverts the weapon to fire the M225 12.7x40mm SAP-HE (semi-armor-piercing, high-explosive) round.\nRequires a barrel conversion."
att.Desc_Pros = {
    "pro.magcap"
}
att.Desc_Cons = {
}
att.SortOrder = 0
att.AutoStats = true
att.Slot = "go_usp_mag"

att.ActivateElements = {"go_usp_mag_20"}
att.GivesFlags = {"nocomp"}
att.Override_ClipSize = 8
att.Mult_Damage = 1.25
att.Mult_DamageMin = 1.25
att.Mult_Recoil = 2
att.Mult_RPM = 0.466
--att.Mult_ShootPitch = 0.85

att.Mult_MoveSpeed = 0.95
att.Mult_SightTime = 1.2
att.Mult_ReloadTime = 1.2

att.Hook_SelectReloadAnimation = function(wep, anim)
    if anim == "reload" then
        return "reload_med"
    elseif anim == "reload_empty" then
        return "reload_med_empty"
    end
end

att.Override_Firemodes_Priority = -2
att.Override_Firemodes = {
    {
        Mode = 2,
    },
    {
        Mode = 1,
	},
    {
        Mode = 0
    }
}

att.Hook_GetShootSound = function(wep, snd)
    if snd == wep.ShootSound or snd == wep.FirstShootSound then return "arccw_go/usp/usp_unsilenced_127.wav" end
end
att.Hook_GetDistantShootSound = function(wep, sound)
    if snd == wep.DistantShootSound then return "arccw_go/deagle/deagle-1-distant.wav" end
end

--MA-HK USP-X12.7 PDWS
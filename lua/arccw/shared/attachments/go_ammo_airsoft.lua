att.PrintName = "Airsoft"
att.Icon = Material("entities/acwatt_go_ammo_airsoft.png", "smooth mips")
att.Description = "Replace weapon internals to fire tiny plastic BB pellets, effectively making the gun a toy. While the projectile does minimal damage, the weapon can load a lot more pellets and handles incredibly well.\nRemember, no full auto in the buildings!"
att.Desc_Pros = {
    "pro.gsoe.airsoft.1",
    "pro.gsoe.airsoft.2",
    "pro.gsoe.airsoft.3"
}
att.Desc_Cons = {
    "con.gsoe.airsoft.1"
}
att.Desc_Neutrals = {
    "desc.gsoe.airsoft.1",
    "desc.gsoe.airsoft.2"
}
att.Slot = "go_ammo"

att.AutoStats = false

att.Mult_Penetration = 0
att.Mult_Recoil = 0.1
att.Mult_HipDispersion = 0.5
att.Mult_MoveDispersion = 0.5
att.Mult_Damage = 0.1
att.Mult_DamageMin = 0.1
att.Mult_RPM = 1.3
att.Mult_CycleSpeed = 1.3
att.Mult_HeatCapacity = 2
att.Mult_HeatDissipation = 4
att.Mult_AccuracyMOA = 3

att.Override_AlwaysPhysBullet = true
att.O_Hook_Override_PhysBulletMuzzleVelocity = function(wep, data)
    local r = wep:GetBuff("Range")
    data.current = math.Clamp(math.sqrt(r * (wep.DamageMin > wep.Damage and r or 1)), 7, 40) * 15
    return data
end
att.Mult_PhysBulletGravity = 2
att.Override_PhysTracerProfile = 0
att.NoRandom = true

att.Override_Ammo = "airsoft"
att.Override_Ammo_Priority = 10000

att.AddPrefix = "Airsoft "

att.Hook_GetCapacity = function(wep, cap)
    if wep.ShotgunReload or wep.RevolverReload or cap <= 2 then
        return cap
    else
        return cap * 2
    end
end

att.Hook_SelectInsertAnimation = function(wep, data)
    data.count = data.count * 2
    return data
end

att.Hook_PreDoEffects = function(wep, fx)
    return true
end

att.Hook_GetShootSound_Priority = 100
att.Hook_GetShootSound = function(wep, sound)
    return "arccw_go/airsoft2.wav"
end
att.Hook_GetDistantShootSound_Priority = 100
att.Hook_GetDistantShootSound = function(wep, sound)
    return false
end

att.Override_PhysBulletImpact = false
att.Hook_PhysBulletHit = function(wep, data)
    if SERVER then
        local ent = data.tr.Entity
        local bullet = data.bullet
        local wep2 = IsValid(ent) and ent.GetActiveWeapon and ent:GetActiveWeapon()
        if (ent:IsNPC() or ent:IsPlayer()) and IsValid(wep2)
                and wep2.ArcCW and wep2.Primary.Ammo == "airsoft" then
            ent:TakeDamage(9999, wep:GetOwner(), wep)
        else
            ent:TakeDamage(wep:GetDamage(bullet.Travelled * ArcCW.HUToM, true), wep:GetOwner(), wep)
        end
        local breakeffect = ents.Create( "info_particle_system" )
        breakeffect:SetKeyValue( "effect_name", "bb_impact_break" )
        breakeffect:SetOwner( wep )
        breakeffect:SetPos( data.tr.HitPos )
        breakeffect:Spawn()
        breakeffect:Activate()
        breakeffect:Fire( "start", "", 0 )
        breakeffect:Fire( "kill", "", 3 )
    end
    return true
end

game.AddAmmoType({
    name = "airsoft"
})

if CLIENT then
    language.Add("airsoft_ammo", "BB Pellets")
end
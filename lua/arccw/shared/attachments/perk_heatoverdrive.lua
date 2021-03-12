att.PrintName = "Overdrive"
att.Icon = Material("entities/acwatt_perk_heatair.png", "smooth mips")
att.Description = "Insanely destructive modification to the weapon that enables it to tolerate insane amounts of weapon heat, spewing fire on both the user and the enemy as it goes."

att.Desc_Pros = {
    "pro.gsoe.overdrive.1",
    "pro.gsoe.overdrive.2",
    "pro.gsoe.overdrive.3",
}

att.Desc_Cons = {
    "con.gsoe.overdrive.1",
    "con.gsoe.overdrive.2",
    "con.gsoe.overdrive.3",
}

att.Desc_Neutrals = {
    "desc.gsoe.overdrive.1",
    "desc.gsoe.overdrive.2",
}

att.Slot = {"perk", "go_perk"}

att.NotForNPC = true
att.SortOrder = 1
att.AutoStats = true

att.Ignore = true

att.Override_HeatLockout = false
att.Override_HeatFix = false

att.Mult_HeatDelayTime = 2
att.Mult_HeatDissipation = 0.5

att.GSOE_Overdrive = true

att.Hook_Compatible = function(wep)
    if not (wep.Jamming or wep:GetBuff_Override("Override_Jamming")) then return false end
end

att.Hook_Overheat = function(wep)
    return true -- :troll:
end

att.M_Hook_Mult_HeatDissipation = function(wep, data)
    if wep:GetHeat() >= wep:GetMaxHeat() then
        data.mult = data.mult * (1 - math.Clamp((wep:GetHeat() / wep:GetMaxHeat() - 1) * 0.3, 0, 0.9))
    end
end

att.Hook_AddShootSound = function(wep, data)
    local pers = wep:GetHeat() / wep:GetMaxHeat()
    if pers >= 1 and pers < 3 then
        wep:EmitSound("arccw_go/oapi_hot.wav", data.volume, 100 + 45 * math.Clamp(pers - 1, 0, 2), pers, CHAN_STATIC)
    end
end

att.M_Hook_Mult_RPM = function(wep, data)
    if wep:GetHeat() >= wep:GetMaxHeat() then
        data.mult = (data.mult - math.Clamp((wep:GetHeat() / wep:GetMaxHeat() - 1) * 0.25, 0, 0.5))
    end
end

att.M_Hook_Mult_AccuracyMOA = function(wep, data)
    if wep:GetHeat() >= wep:GetMaxHeat() then
        data.mult = (data.mult + math.Clamp((wep:GetHeat() / wep:GetMaxHeat() - 1) * 2, 0, 4))
    end
end

att.M_Hook_Mult_HipDispersion = function(wep, data)
    if wep:GetHeat() >= wep:GetMaxHeat() then
        data.mult = (data.mult + math.Clamp((wep:GetHeat() / wep:GetMaxHeat() - 1) * 1.5, 0, 3))
    end
end

att.Hook_BulletHit = function(wep, data)
    if CLIENT or not IsValid(wep:GetOwner()) then return end
    if wep:GetHeat() >= wep:GetMaxHeat() then
        data.damage = data.damage * ((wep:GetHeat() / wep:GetMaxHeat() - 1) * 0.3 + 1)

        if IsValid(data.tr.Entity) and math.random() <= wep:GetHeat() / wep:GetMaxHeat() / 4
                and (data.tr.Entity.ArcCW_GSOE_Ignited or 0) ~= CurTime() then
            data.tr.Entity.ArcCW_GSOE_Ignited = CurTime()
            data.tr.Entity:Ignite(3)
        end

    end
end

att.Hook_PostFireBullets = function(wep)
    if CLIENT or not IsValid(wep:GetOwner()) then return end
    if wep:GetHeat() >= wep:GetMaxHeat() * 5 then
        wep:SetHeat(0)
        local dmg = DamageInfo()
        dmg:SetDamage(500)
        dmg:SetDamageType(DMG_BLAST)
        dmg:SetInflictor(wep)
        dmg:SetAttacker(wep:GetOwner())
        util.BlastDamageInfo(dmg, wep:GetOwner():GetPos(), 512)
        for i = 1, 10 do
            local cloud = ents.Create( "arccw_go_fire" )
            if not IsValid(cloud) then return end
            local vel = Vector(math.Rand(-1, 1), math.Rand(-1, 1), math.Rand(-1, 1)) * 1500
            cloud.Order = i
            cloud:SetPos(wep:GetOwner():GetPos() + VectorRand() + Vector(0, 0, 32))
            cloud:SetAbsVelocity(vel)
            cloud:SetOwner(wep:GetOwner())
            cloud:Spawn()
        end
        wep:EmitSound("arccw_go/incgrenade/inc_grenade_detonate_2.wav", 120, 90, 1, CHAN_STATIC)
        SafeRemoveEntity(wep)
    elseif wep:GetHeat() >= wep:GetMaxHeat() * 3 then
        -- FIRE EXPLOSION
        wep:EmitSound("arccw_go/oapi_hot.wav", 100, 150, 1, CHAN_STATIC)
        local dmg = DamageInfo()
        dmg:SetDamage(math.Round(wep:GetHeat() / wep:GetMaxHeat() * 3))
        dmg:SetDamageType(DMG_BURN)
        dmg:SetInflictor(wep)
        dmg:SetAttacker(wep:GetOwner())
        util.BlastDamageInfo(dmg, wep:GetOwner():GetPos(), 256)
        if math.random() <= 0.25 then
            local cloud = ents.Create( "arccw_go_fire" )
            if not IsValid(cloud) then return end
            local vel = Vector(math.Rand(-1, 1), math.Rand(-1, 1), math.Rand(-1, 1)) * 1500
            cloud.Order = i
            cloud:SetPos(wep:GetOwner():GetPos() + VectorRand() + Vector(0, 0, 32))
            cloud:SetAbsVelocity(vel)
            cloud:SetOwner(wep:GetOwner())
            cloud:Spawn()
            wep:EmitSound("arccw_go/molotov/fire_ignite_5.wav", 100, 100, 1, CHAN_STATIC)
        end
        wep:GetOwner():Ignite(2)
    elseif wep:GetHeat() >= wep:GetMaxHeat() then
        local dmg = DamageInfo()
        dmg:SetDamage(math.Round(wep:GetHeat() / wep:GetMaxHeat()))
        dmg:SetDamageType(DMG_BURN)
        dmg:SetInflictor(wep)
        dmg:SetAttacker(wep:GetOwner())
        wep:GetOwner():TakeDamageInfo(dmg)
    end
end

local mat_grad = Material("arccw/gsoe_oapi_heat.png", "mips smooth")

att.Hook_DrawHUD = function(wep)
    local pers = wep:GetHeat() / wep:GetMaxHeat()
    local thres = 0.8
    if pers >= thres then
        surface.SetDrawColor(255, 0, 0, math.Clamp((pers - thres) * 255 / (3 - thres), 0, 255))
        surface.SetMaterial(mat_grad)
        surface.DrawTexturedRect(ScrW() / 2, ScrH() / 2, ScrW() / 2, ScrH() / 2)
    end
end

att.Hook_GetHUDData = function(wep, data)
    local pers = wep:GetHeat() / wep:GetMaxHeat()
    if pers >= 1 then
        data.heat_name = ArcCW.GetTranslation("ui.gsoe.overdrive")
        for i = 1, math.floor((pers - 1) * 2) + 1 do data.heat_name = data.heat_name .. "!" end
    end
end
att.PrintName = "O-API! Rounds"
att.Icon = Material("entities/acwatt_go_ammo_api.png")
att.Description = "Omega Company manufactured armor piercing, incendiary rounds that penetrates further and lights targets on fire. The excessive heat generated can easily cook the ammunition of an untrained operative."

att.Desc_Pros = {"pro.ignite"}

att.Desc_Cons = {"con.gsoe.cook"}

att.AutoStats = true
att.Slot = "go_ammo"
att.Mult_Penetration = 1.5
--att.Mult_Recoil = 1.3
att.Override_DamageType = DMG_BURN
att.Override_Jamming = true
att.Override_HeatLockout = true

att.GSOE_API = true

att.O_Hook_Override_HeatDelayTime = function(wep, data)
    local cfm = wep:GetCurrentFiremode()
    local t = 1

    if cfm.Mode == 1 then
        t = 1.5
    elseif cfm.Mode < 0 then
        t = (cfm.PostBurstDelay or 0.1) * 10
    end

    data.current = t
    return data
end

att.O_Hook_Override_HeatDissipation = function(wep, data)
    local tbl = {}
    tbl.current = (wep.RegularClipSize or wep.Primary.ClipSize) * 0.25
            * ((wep:Clip1() == 0 or wep:GetReloading()) and 0.25 or 1)
            * (wep:Clip1() <= 0 and wep:GetHeatLocked() and (wep:Clip1() > 0 and 1.5 or 0) or 1)
            * (wep:GetBuff_Override("GSOE_Overdrive") and 0.75 or 1)
    return tbl
end

att.O_Hook_Override_HeatCapacity = function(wep, data)
    local tbl = {current = (wep.RegularClipSize or wep.Primary.ClipSize) * (wep:GetBuff_Override("GSOE_Overdrive") and 1.5 or 1.25)}
    return tbl
end

att.Hook_AddShootSound = function(wep, data)
    if wep:GetBuff_Override("GSOE_Overdrive") then return end
    local pers = wep:GetHeat() / wep:GetMaxHeat()
    wep:EmitSound("arccw_go/oapi_hot.wav", data.volume, 85 + 30 * (wep:GetHeat() / wep:GetMaxHeat()), pers, CHAN_STATIC)
end

att.Hook_PostOverheat = function(wep, heat)
    if SERVER then
        --if wep:GetBuff_Override("GSOE_Overdrive") then return true end -- :trollscream:

        wep:SetNWInt("OAPI_FuckedUpHowMuch", wep:Clip1())
        wep:SetNWFloat("OAPI_TimeSinceLastFuckUp", CurTime())
        local dmg = DamageInfo()
        dmg:SetDamage(math.ceil(wep:Clip1() / wep:GetMaxClip1() * 50))
        dmg:SetDamageType(DMG_BURN)
        dmg:SetInflictor(wep)
        dmg:SetAttacker(wep:GetOwner())
        wep:GetOwner():TakeDamageInfo(dmg)
        wep:GetOwner():Ignite(math.max(wep:Clip1() / wep:GetMaxClip1() * 5, 2))
        wep:SetClip1(0)
        wep:EmitSound("arccw_go/oapi_cooked.wav", 80, 100, 1, CHAN_STATIC)

        if wep:GetOwner():IsPlayer() then
            wep:GetOwner():SetViewPunchAngles(wep:GetOwner():GetViewPunchAngles() + Angle(1, 0, 3))
        end
    end
end

att.Hook_BulletHit = function(wep, data)
    if SERVER and IsValid(data.tr.Entity) then
        local p = math.Clamp(wep:GetHeat() / wep:GetMaxHeat(), 0.25, 1) * 5 * (1 - (wep.GetRangeFraction and wep:GetRangeFraction(data.range) or 1))
        data.tr.Entity:Ignite(p)
    end
end

att.Hook_Compatible = function(wep)
    if wep.Jamming or (wep:GetBuff_Override("Override_ManualAction") or wep.ManualAction) or wep:GetIsShotgun() then return false end
end

local mat_grad = Material("arccw/gsoe_oapi_heat.png", "mips smooth")

att.Hook_DrawHUD = function(wep)
    if wep:GetBuff_Override("GSOE_Overdrive") then return end
    local pers = wep:GetHeat() / wep:GetMaxHeat()
    surface.SetDrawColor(255, 0, 0, pers * 21)
    surface.SetMaterial(mat_grad)
    surface.DrawTexturedRect(ScrW() / 2, ScrH() / 2, ScrW() / 2, ScrH() / 2)
end

att.Hook_GetHUDData = function(wep, data)
    if wep:GetBuff_Override("GSOE_Overdrive") then return end
    local lastfuckup = wep:GetNWFloat("OAPI_TimeSinceLastFuckUp", -3)
    local howmuch = wep:GetNWInt("OAPI_FuckedUpHowMuch", 0)

    if lastfuckup > CurTime() - 3 then
        data.mode = string.format(ArcCW.GetTranslation("ui.gsoe.cook"), howmuch)
    end
end
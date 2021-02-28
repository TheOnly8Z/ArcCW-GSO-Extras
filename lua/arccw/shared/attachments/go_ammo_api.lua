att.PrintName = "O-API! Rounds"
att.Icon = Material("entities/acwatt_go_ammo_api.png")
att.Description = "Omega Company manufactured armor piercing, incendiary rounds that penetrates further and lights targets on fire. The excessive heat generated can easily cook the ammunition of an untrained operative."

att.Desc_Pros = {"pro.ignite",}

att.Desc_Cons = {"con.gsoe.cook"}

att.AutoStats = true
att.Slot = "go_ammo"
att.Mult_DamageMin = 0.8
att.Mult_Penetration = 1.5
att.Mult_Recoil = 1.3
att.Override_DamageType = DMG_DIRECT + DMG_BULLET
att.Override_Jamming = true
att.Override_HeatLockout = true

att.O_Hook_Override_HeatDelayTime = function(wep, data)
    local cfm = wep:GetCurrentFiremode()
    local t = .75

    if cfm.Mode == 1 then
        t = 1.5
    elseif cfm.Mode < 0 then
        t = (cfm.PostBurstDelay or 0.1) * 10
    end

    data.current = t
end

att.O_Hook_Override_HeatDissipation = function(wep, data)
    data.current = (wep.RegularClipSize or wep.Primary.ClipSize) * (wep:GetReloading() and 0.25 or 1) * (wep:Clip1() <= 0 and wep:GetHeatLocked() and 0 or 0.75)
end

att.O_Hook_Override_HeatCapacity = function(wep, data)
    data.current = (wep.RegularClipSize or wep.Primary.ClipSize) * 0.4
end

att.Hook_AddShootSound = function(wep, data)
    local pers = wep:GetHeat() / wep:GetMaxHeat()
    wep:EmitSound("arccw_go/oapi_hot.wav", data.volume, 85 + 30 * (wep:GetHeat() / wep:GetMaxHeat()), pers, CHAN_STATIC)
end

att.Hook_Overheat = function(wep, heat)
    -- even in singleplayer
    if SERVER then
        wep:SetNWInt("OAPI_FuckedUpHowMuch", wep:Clip1())
        wep:SetNWFloat("OAPI_TimeSinceLastFuckUp", CurTime())
        wep:SetClip1(0)
        wep:EmitSound("arccw_go/oapi_cooked.wav", 80, 100, 1, CHAN_STATIC)

        if wep:GetOwner():IsPlayer() then
            wep:GetOwner():SetViewPunchAngles(wep:GetOwner():GetViewPunchAngles() + Angle(1, 0, 3))
        end
    end
end

att.Hook_Compatible = function(wep)
    if wep.Jamming or (wep:GetBuff_Override("Override_ManualAction") or wep.ManualAction) or wep:GetIsShotgun() then return false end
end

local mat_grad = Material("arccw/gsoe_oapi_heat.png", "mips smooth")

att.Hook_DrawHUD = function(wep)
    local pers = wep:GetHeat() / wep:GetMaxHeat()
    surface.SetDrawColor(255, 0, 0, pers * 21)
    surface.SetMaterial(mat_grad)
    surface.DrawTexturedRect(ScrW() / 2, ScrH() / 2, ScrW() / 2, ScrH() / 2)
end

att.Hook_GetHUDData = function(wep, data)
    local lastfuckup = wep:GetNWFloat("OAPI_TimeSinceLastFuckUp", -3)
    local howmuch = wep:GetNWInt("OAPI_FuckedUpHowMuch", 0)

    if lastfuckup > CurTime() - 3 then
        data.mode = string.format(ArcCW.GetTranslation("ui.gsoe.cook"), howmuch)
    end
end
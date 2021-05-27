att.PrintName = "CMB Smackdown Unit"
att.Icon = Material("entities/acwatt_charm_punished.png")
att.Description = "Curious. This is no charm. An empty metal container has been attached to your weapon. Deal damage while using it to build dark energy, which will allow you a critical melee strike. Finish your beating quota three times over."

att.Desc_Pros = {
	"Deal 200 damage to earn a deadly 4x melee hit"
}
att.Desc_Cons = {
}
att.AutoStats = true
att.Slot = "charm"
att.SortOrder = 100
att.Ignore = true
att.Free = false

att.Model = "models/Items/combine_rifle_cartridge01.mdl"

local lazy = 0.35
att.ModelScale = Vector(lazy, lazy, lazy)
att.ModelOffset = Vector(0, -0.6, 0)
att.OffsetAng = Angle(0, 0, 0)

att.Mult_Damage = 0.95
att.Mult_DamageMin = 0.95

att.Override_Jamming = true
att.Override_HeatFix = false
att.Override_HeatLockout = false

att.Override_HeatCapacity = 400
att.Override_FixTime = 1
att.Override_HeatDissipation = 0
att.Override_HeatDelayTime = 0

att.Hook_Compatible = function(wep)
    if (wep.Jamming) and !wep:CheckFlags({"charm_util_cmdsmackdown"}, {}) then return false end
end

att.M_Hook_Mult_MeleeDamage = function(wep, data)
	if wep.Smackdown_WEgoin then
		data.mult = data.mult * 4
	end
end

att.Hook_GetHUDData = function(wep, data)
	data.heat_name = "CRIT"
end

att.O_Hook_Override_HeatDissipation = function(wep, data)
	if wep.Smackdown_WEgoin then
		data.current = 100
	else
		data.current = 0
	end
end

att.M_Hook_Mult_MeleeTime = function(wep, data)
	if wep.Smackdown_WEgoin then
		data.mult = 2/3
	else
		data.mult = 1
	end
end

att.Hook_PostBash = function(wep, data)
	if IsValid(data.tr.Entity) then
		if wep.Smackdown_WEgoin then
			wep:EmitSound( "ambient/energy/weld" .. math.random(1, 2) .. ".wav", 75, 100, 1, CHAN_AUTO )
		end
		wep:AddHeat(data.dmg*2)
	end
end

att.Hook_PreBash = function(wep, data)
	if wep:GetHeat() >= wep:GetMaxHeat() then
		wep:EmitSound( "ambient/energy/zap" .. table.Random({1, 2, 3, 5, 6, 7, 8, 9}) .. ".wav", 60, 100, .5, CHAN_AUTO )
		wep.Smackdown_WEgoin = true
	end
end

att.Hook_BulletHit = function(wep, data)
	if IsValid(data.tr.Entity) then
		wep:AddHeat(data.damage*2)
	end
end

att.Hook_Think = function(wep)
	if wep.Smackdown_WEgoin and wep:GetHeat()/wep:GetMaxHeat() <= 0 then
		wep.Smackdown_WEgoin = false
	end
	if wep.Smackdown_NextSound == nil then
		wep.Smackdown_NextSound = CurTime() + 2
	elseif ( wep:GetHeat()/wep:GetMaxHeat() >= 1 ) or wep.Smackdown_WEgoin then
        if wep.Smackdown_NextSound < CurTime() then
            local a = 1
            local b = 4
            if wep.Smackdown_WEgoin then
                a = 0.1
                b = 0.25
            end

            wep:EmitSound( "ambient/energy/spark" .. math.random(1, 6) .. ".wav", 60, 85, .4, CHAN_AUTO )
            wep.Smackdown_NextSound = CurTime() + math.Rand(a, b)
        end
	end
end

local mat_grad	= Material("arccw/gsoe_oapi_heat.png", "mips smooth")

att.Hook_DrawHUD = function(wep)
	local pers = wep:GetHeat()/wep:GetMaxHeat()
	local timesince = wep.Smackdown_NextSound or CurTime()
	local mult = ( wep.Smackdown_WEgoin and 2555 or 1 )
	
	surface.SetDrawColor(0, 255, 255, pers*6 - ( CurTime()-wep.Smackdown_NextSound )*6 / 2 )
	surface.SetMaterial(mat_grad)
	surface.DrawTexturedRect(ScrW()/2, ScrH()/2, ScrW()/2, ScrH()/2)
end
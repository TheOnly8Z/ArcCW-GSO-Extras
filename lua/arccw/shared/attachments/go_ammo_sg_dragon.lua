att.PrintName = "Incendiary Shells"
att.Icon = Material("entities/acwatt_go_ammo_sg_dragon.png", "smooth mips")
att.Description = "Nicknamed 'Dragon's Breath' by many, these shotgun shells are loaded with magnesium powder that ignites anything in front as it flies. Without an actual projectile load, it does little direct damage."
att.Desc_Pros = {"pro.gsoe.dragonsbreath"}
att.Desc_Cons = {
    "con.gsoe.dragonsbreath",
    "con.gsoe.add_accuracymoa.25"
}
att.Slot = "go_ammo"

att.AutoStats = true

att.Override_Num = 20
att.Override_DamageType = DMG_BURN

att.Override_AlwaysPhysBullet = true
att.Override_PhysBulletMuzzleVelocity = 100
att.Override_PhysTracerProfile = 0
att.Override_PhysBulletImpact = false
att.Override_PhysBulletGravity = 3

att.Mult_Damage = 0.7
att.Mult_DamageMin = 0.7
att.Mult_Recoil = 0.6
att.Add_AccuracyMOA = 25
att.Override_Penetration = 96

att.Hook_Compatible = function(wep)
    if !wep:GetIsShotgun() then return false end
end

local fired = {
    "sprites/flamelet1",
    "sprites/flamelet2",
    "sprites/flamelet3",
    "sprites/flamelet4",
    "sprites/flamelet5",
}

att.Hook_AddShootSound = function(wep, data)
    wep:EmitSound("arccw_go/molotov/fire_ignite_1.wav", data.volume, 200, 0.9, CHAN_STATIC)
end

att.Hook_PhysBulletHit = function(wep, data)
    local tr, bullet = data.tr, data.bullet

    if SERVER and IsValid(tr.Entity) then

        local delta = bullet.Travelled / (bullet.Range / ArcCW.HUToM)
        delta = math.Clamp(delta, 0, 1)

        if math.random() > delta * 2 and (tr.Entity.ArcCW_GSOE_Ignited or 0) ~= CurTime() then
            tr.Entity.ArcCW_GSOE_Ignited = CurTime()
            tr.Entity:Ignite(math.random() * (0.5 - delta) * 5 + 5)
        end

        local dmg = DamageInfo()
        dmg:SetDamage(Lerp(delta, bullet.DamageMax, bullet.DamageMin))
        dmg:SetDamageType(DMG_BURN + DMG_BULLET)
        dmg:SetInflictor(wep)
        dmg:SetAttacker(wep:GetOwner())
        tr.Entity:TakeDamageInfo(dmg)

        if tr.Entity:IsPlayer() or tr.Entity:IsNPC() or tr.Entity:IsNextBot() then
            local tr2 = util.TraceLine({
                start = bullet.Pos,
                endpos  = bullet.Pos + bullet.Vel:GetNormalized() * (bullet.Vel:Length() + 16),
                filter = table.GetKeys(bullet.Damaged),
            })
            ArcCW:DoPenetration(tr2, dmg, bullet, bullet.Penleft, true, bullet.Damaged)
        end

        -- Fire a fake bullet for the sole purpose of penetration
        --[[]
        wep:GetOwner():FireBullets({
            Src = bullet.Pos,
            Dir = bullet.Vel:GetNormalized(),
            Distance = bullet.Vel:Length() + 16,
            Tracer = 0,
            Damage = 0,
            IgnoreEntity = bullet.Attacker,
            Callback = function(catt, ctr, cdmg)
                ArcCW:DoPenetration(ctr, cdmg, bullet, bullet.Penleft, true, bullet.Damaged)
            end
        }, true)
        ]]
    end

    if CLIENT then
        local range = bullet.Weapon:GetBuff("Range") / ArcCW.HUToM
        local emitter = ParticleEmitter(tr.HitPos)
        if !IsValid(emitter) then return end

        local inrange = bullet.Travelled < range * 0.5

        if inrange then
            local fire = emitter:Add(fired[math.random(#fired)], tr.HitPos)
            fire:SetVelocity( VectorRand() * 100 * VectorRand() )
            fire:SetGravity( Vector(0, 0, 100) )
            fire:SetDieTime( math.Rand(0.5, 0.75) )
            fire:SetStartAlpha( 150 )
            fire:SetEndAlpha( 0 )
            fire:SetStartSize( 5 )
            fire:SetEndSize( 20 )
            fire:SetRoll( math.Rand(-180, 180) )
            fire:SetRollDelta( math.Rand(-0.2,0.2) )
            fire:SetColor( 255, 255, 255 )
            fire:SetAirResistance( 150 )
            fire:SetPos( tr.HitPos )
            fire:SetLighting( false )
            fire:SetCollide(true)
            fire:SetBounce(0.75)
            fire:SetNextThink( CurTime() + FrameTime() )
            fire:SetThinkFunction( function(pa)
                if !pa then return end
                local col1 = Color(255, 255, 255)
                local col2 = Color(0, 0, 0)

                local col3 = col1
                local d = pa:GetLifeTime() / pa:GetDieTime()
                col3.r = Lerp(d, col1.r, col2.r)
                col3.g = Lerp(d, col1.g, col2.g)
                col3.b = Lerp(d, col1.b, col2.b)

                pa:SetColor(col3.r, col3.g, col3.b)
                pa:SetNextThink( CurTime() + FrameTime() )
            end )
        end

        if not inrange or math.random(1, 100) < 25 then
            local smoke = emitter:Add("particles/smokey", tr.HitPos)
            smoke:SetVelocity( VectorRand() * 25 )
            smoke:SetGravity( Vector(0, 0, 0) )
            smoke:SetDieTime( math.Rand(0.25, 1) )
            smoke:SetStartAlpha(inrange and 150 or 50 )
            smoke:SetEndAlpha( 0 )
            smoke:SetStartSize( 5 )
            smoke:SetEndSize( inrange and 50 or 25 )
            smoke:SetRoll( math.Rand(-180, 180) )
            smoke:SetRollDelta( math.Rand(-0.2,0.2) )
            smoke:SetColor( 255, 255, 255 )
            smoke:SetAirResistance( 150 )
            smoke:SetPos( tr.HitPos )
            smoke:SetLighting( false )
            smoke:SetCollide(true)
            smoke:SetBounce(0.75)
            smoke:SetNextThink( CurTime() + FrameTime() )
            smoke:SetThinkFunction( function(pa)
                if !pa then return end
                local col1 = Color(255, 135, 0)
                local col2 = Color(150, 150, 150)

                local col3 = col1
                local d = pa:GetLifeTime() / pa:GetDieTime()
                col3.r = Lerp(d, col1.r, col2.r)
                col3.g = Lerp(d, col1.g, col2.g)
                col3.b = Lerp(d, col1.b, col2.b)

                pa:SetColor(col3.r, col3.g, col3.b)
                pa:SetNextThink( CurTime() + FrameTime() )
            end )
        end

        emitter:Finish()
    end
end
local attBal = CreateConVar("arccw_gsoe_attbal", 1, FCVAR_ARCHIVE + FCVAR_REPLICATED, "Custom tweaks to GSO attachments. See WS page for details.", 0, 1)
local gunBal = CreateConVar("arccw_gsoe_gunbal", 1, FCVAR_ARCHIVE + FCVAR_REPLICATED, "Custom tweaks to GSO weapons. See WS page for details.", 0, 1)
local originTweak = CreateConVar("arccw_gsoe_origintweak", 0, FCVAR_ARCHIVE + FCVAR_REPLICATED, "Resets origin of GSO weapons, making them look more like how they are in CSGO.", 0, 1)
local catMode = CreateConVar("arccw_gsoe_catmode", 1, FCVAR_ARCHIVE + FCVAR_REPLICATED, "Change GSO weapon categories.", 0, 3)
local laserColor = CreateConVar("arccw_gsoe_lasermode", 1, FCVAR_ARCHIVE + FCVAR_REPLICATED, "Make 1mW, 3mW and 5mW lasers use custom colors defined by the player.", 0, 3)
local addSway = CreateConVar("arccw_gsoe_addsway", 0, FCVAR_ARCHIVE + FCVAR_REPLICATED, "Dynamically insert aim sway to every GSO gun and attachment. Set to 2 to apply to ALL guns and attachments.", 0, 2)
if CLIENT then
    CreateClientConVar("arccw_gsoe_laser_enabled", "1", true, true, "", 0, 1)
    CreateClientConVar("arccw_gsoe_laser_r", "255", true, true, "", 0, 255)
    CreateClientConVar("arccw_gsoe_laser_g", "0", true, true, "", 0, 255)
    CreateClientConVar("arccw_gsoe_laser_b", "0", true, true, "", 0, 255)
    CreateClientConVar("arccw_gsoe_laser_special", "0", true, true, "", 0, 2)
end

local balanceList = {
    -- SMG
    ["arccw_go_mac10"] = {
        Damage = 30,
        DamageMin = 12,
        Category = "SMG",
    },
    ["arccw_go_mp5"] = {
        Damage = 24,
        DamageMin = 18,
        Category = "SMG",
    },
    ["arccw_go_mp7"] = {
        Damage = 25,
        DamageMin = 17,
        Category = "SMG",
    },
    ["arccw_go_mp9"] = {
        Damage = 27,
        DamageMin = 15,
        Category = "SMG",
    },
    ["arccw_go_p90"] = {
        Damage = 24,
        DamageMin = 20,
        Category = "SMG",
    },
    ["arccw_go_ump"] = {
        Damage = 32,
        DamageMin = 19,
        Category = "SMG",
    },
    ["arccw_go_bizon"] = {
        Category = "SMG",
    },
    -- ARs
    ["arccw_go_ar15"] = {
        AccuracyMOA = 3,
        Recoil = 0.32,
        RecoilSide = 0.2,
        SpeedMult = 0.93,
        Range = 120,
        Category = "Rifles",
    },
    ["arccw_go_aug"] = {
        Damage = 28,
        DamageMin = 24,
        Category = "Rifles",
    },
    ["arccw_go_ace"] = {
        SightTime = 0.3,
        Trivia_Mechanism = "Gas-Operated",
        Category = "Rifles",
    },
    ["arccw_go_ak47"] = {
        Category = "Rifles",
    },
    ["arccw_go_famas"] = {
        Category = "Rifles",
    },
    ["arccw_go_m16a2"] = {
        Category = "Rifles",
    },
    ["arccw_go_m4"] = {
        Category = "Rifles",
    },
    ["arccw_go_sg556"] = {
        Category = "Rifles",
    },
    -- BRs
    ["arccw_go_fnfal"] = {
        Category = "Rifles",
    },
    ["arccw_go_g3"] = {
        Category = "Rifles",
    },
    ["arccw_go_scar"] = {
        Category = "Rifles",
    },
    -- SRs
    ["arccw_go_awp"] = {
        Category = "Rifles",
    },
    ["arccw_go_ssg08"] = {
        Category = "Rifles",
    },
    -- SGs
    ["arccw_go_m1014"] = {
        HipDispersion = 400,
        MoveDispersion = 75,
        Recoil = 3,
        RecoilSide = 2,
        AccuracyMOA = 20,
        Category = "Heavy",
    },
    ["arccw_go_mag7"] = {
        HipDispersion = 300,
        MoveDispersion = 75,
        Recoil = 3,
        RecoilSide = 2,
        AccuracyMOA = 30,
        Category = "Heavy",
    },
    ["arccw_go_870"] = {
        HipDispersion = 300,
        MoveDispersion = 75,
        Recoil = 2,
        RecoilSide = 1.5,
        AccuracyMOA = 30,
        Category = "Heavy",
    },
    ["arccw_go_nova"] = {
        HipDispersion = 300,
        MoveDispersion = 75,
        Recoil = 2,
        RecoilSide = 1.5,
        AccuracyMOA = 20,
        Category = "Heavy",
    },
    -- MGs
    ["arccw_go_m249para"] = {
        Category = "Heavy",
    },
    ["arccw_go_negev"] = {
        Category = "Heavy",
    },
    -- Pistols
    ["arccw_go_cz75"] = {
        HipDispersion = 200,
        MoveDispersion = 25,
        Recoil = 0.34,
        AccuracyMOA = 10,
        Damage = 26,
        DamageMin = 22,
        Trivia_Desc = "Czech handgun developed to export to the West during the height of the Cold War. It functions similarly to other 9mm double-stack pistols but handles better.",
        Category = "Pistols",
    },
    ["arccw_go_fiveseven"] = {
        HipDispersion = 200,
        MoveDispersion = 25,
        AccuracyMOA = 5,
        DamageMin = 20,
        Trivia_Desc = "Handgun designed as a companion to the P90 PDW. Its thin but long cartridge allows for exceptional range and accuracy for a pistol, but isn't very hard hitting.",
        Category = "Pistols",
    },
    ["arccw_go_glock"] = {
        HipDispersion = 250,
        MoveDispersion = 50,
        AccuracyMOA = 12,
        Category = "Pistols",
    },
    ["arccw_go_m9"] = {
        HipDispersion = 300,
        MoveDispersion = 50,
        AccuracyMOA = 5,
        Range = 60,
        Damage = 25,
        DamageMin = 22,
        Trivia_Desc = "Popular full-sized Italian 9mm handgun adopted by the US military. The longer slide provides excellent accuracy at the cost of hip fire performance.",
        Category = "Pistols",
    },
    ["arccw_go_p2000"] = {
        HipDispersion = 150,
        MoveDispersion = 25,
        AccuracyMOA = 10,
        Recoil = 0.2,
        Damage = 25,
        DamageMin = 20,
        Trivia_Desc = "Handgun developed to meet modern police and paramilitary needs. It is comfortable to hold and provides better hip firing performance.",
        Category = "Pistols",
    },
    ["arccw_go_p250"] = {
        HipDispersion = 300,
        MoveDispersion = 50,
        AccuracyMOA = 10,
        Recoil = 0.45,
        RecoilSide = 0.45,
        SightTime = 0.3,
        Trivia_Desc = "Compact hard-hitting handgun that incorporates numerous improvements over previous generations of SIG pistols. Its .357 SIG cartridge is more powerful, but also kicks harder.",
        Category = "Pistols",
    },
    ["arccw_go_tec9"] = {
        HipDispersion = 400,
        MoveDispersion = 50,
        AccuracyMOA = 12,
        Trivia_Desc = "Cheap open bolt pistol notorious for its ease of conversion to full auto. Has a generous magazine capacity, but isn't particularly accurate.",
        Category = "Pistols",
    },
    ["arccw_go_usp"] = {
        HipDispersion = 250,
        MoveDispersion = 50,
        AccuracyMOA = 8,
        SightTime = 0.25,
        Damage = 35,
        DamageMin = 24,
        Trivia_Desc = "Iconic pistol designed for police and special forces use. Accurate and powerful, but magazine capacity is smaller than most pistols.",
        Category = "Pistols",
    },
    ["arccw_go_deagle"] = {
        VisualRecoilMult = 3,
        HipDispersion = 450,
        MoveDispersion = 100,
        Damage = 65,
        DamageMin = 40,
        Category = "Pistols",
    },
    ["arccw_go_r8"] = {
        HipDispersion = 100,
        MoveDispersion = 75,
        Damage = 58,
        DamageMin = 32,
        Category = "Pistols",
    },
    ["arccw_go_sw29"] = {
        Category = "Pistols",
    },
    -- Equipment
    ["arccw_go_taser"] = {
        Category = "Gear",
    },
    ["arccw_go_melee_knife"] = {
        Category = "Gear",
    },
    ["arccw_go_nade_knife"] = {
        Category = "Gear",
    },
    ["arccw_go_nade_incendiary"] = {
        Category = "Gear",
    },
    ["arccw_go_nade_frag"] = {
        Category = "Gear",
    },
    ["arccw_go_nade_flash"] = {
        Category = "Gear",
    },
    ["arccw_go_nade_smoke"] = {
        Category = "Gear",
    },
    ["arccw_go_shield"] = {
        Category = "Gear",
    },
    ["arccw_go_nade_molotov"] = {
        Category = "Gear",
    },
    -- GSO Extras
    ["arccw_go_galil_ar"] = {
        Category = "Rifles",
    },
}

local function GSOE()
    if gunBal:GetBool() then
        local wpnList = list.GetForEdit("Weapon")
        for class, t in pairs(balanceList) do
            local stored = weapons.GetStored(class)
            if not stored then continue end
            for i, v in pairs(t) do
                if i ~= "Category" then
                    stored[i] = v
                end
            end
            if originTweak:GetBool() then
                stored.ActivePos = Vector(0, 0, 0)
            end
            if wpnList[class] then
                if catMode:GetInt() == 1 then
                    wpnList[class].Category = "ArcCW - GSO (" .. t.Category .. ")"
                elseif catMode:GetInt() == 2 then
                    if t.Category == "Gear" then
                        wpnList[class].Category = "ArcCW - Other"
                    else
                        wpnList[class].Category = "ArcCW - GSO"
                    end
                elseif catMode:GetInt() == 3 then
                    wpnList[class].Category = "ArcCW - GSO"
                end
            end
        end
    end

    if addSway:GetInt() >= 1 then
        for _, t in pairs(weapons.GetList()) do
            local class = t.ClassName
            if not weapons.IsBasedOn(class, "arccw_base") then continue end
            if t.Throwing or t.IronSightStruct == false then continue end
            if addSway:GetInt() < 2 and string.Left(class, 9) ~= "arccw_go_" then continue end
            t.Sway = math.Clamp(t.SightTime / 1 + t.HipDispersion / 2000, 0, 1)
        end
    end

    local ar15 = weapons.GetStored("arccw_go_ar15")
    local function check_ar15(tbl)
        local fcg = 0
        local bar = 0
        local smg = false
        for i, v in pairs(tbl) do
            if v.Installed == "go_perk_burst" then
                fcg = 1
            elseif v.Installed == "go_homemade_auto" then
                fcg = 2
            elseif v.Installed == "go_ar15_barrel_med" then
                bar = 1
            elseif v.Installed == "go_ar15_barrel_long" then
                bar = 2
            elseif v.Installed == "go_m4_barrel_long" then
                bar = -1
            elseif v.Installed == "go_m4_mag_21_9mm" or v.Installed == "go_m4_mag_30_9mm" then
                smg = true
            end
        end
        return fcg, bar, smg
    end
    ar15.Hook_NameChange = function(wep, name)
        local fcg, bar, smg = check_ar15(wep.Attachments)
        if smg and fcg == 2 then
            return "R0635"
        elseif smg and fcg == 1 then
            return "R0639"
        elseif smg then
            return "Colt 9mm SMG"
        elseif fcg == 2 and bar == 2 then
            return "M16A3"
        elseif fcg == 1 and bar == 2 then
            return "M16A2"
        elseif bar == 1 and fcg > 0 then
            return "M4A1"
        elseif bar == 0 and fcg > 0 then
            return "Colt Commando"
        end
        return "AR-15"
    end
    ar15.Hook_ClassChange = function(wep, name)
        local fcg, bar, smg = check_ar15(wep.Attachments)
        if smg then
            return "Submachine Gun"
        elseif fcg > 0 and bar > 0 then
            return "Assault Rifle"
        elseif fcg > 0 then
            return "Assault Carbine"
        end
        return "Semi-Automatic Rifle"
    end
    ar15.Hook_DescChange = function(wep, data)
        local fcg, bar, smg = check_ar15(wep.Attachments)
        if smg then
            return "A submachine gun adapted from the AR-15 platform, used on a small scale by some departments in the US, one of which is the Department of Energy, somehow."
        elseif fcg == 2 and bar == 2 then
            return "An AR-15 converted into the M16A3 pattern. It is identical to the A2 but capable of automatic fire, adopted by select branches of the US military."
        elseif fcg == 1 and bar == 2 then
            return "An AR-15 converted into the M16A2 pattern, most famously used during the Vietnam War. The burst firing mechanism was added to conserve ammo due to G.I.s spraying wildly in the jungles."
        elseif bar == 1 and fcg > 0 then
            return "An automatic carbine adapted from the AR-15. Widely used in the US Military."
        elseif fcg > 0 then
            return "An automatic carbine adapted from the AR-15. The short barrel allows for high manuverability, and is mainly used by American crewmen and special forces."
        end
        return "A civilian version of the M4. Created by Eugene Stoner and sold originally by Armalite, it has since become the basis for the most popular rifles in the world. Semi-auto only!"
    end

    local r8 = weapons.GetStored("arccw_go_r8")
    r8.Delay = 60 / 120
    r8.TriggerDelay = true
    r8.Hook_TranslateAnimation = function(wep, anim)
        if (anim == "fire" or anim == "fire_iron")
                and wep:GetCurrentFiremode().Override_TriggerDelay == false then
            return "fire_alt"
        end
    end
    r8.Firemodes = {
        {
            Mode = 1,
            PrintName = "DACT"
        },
        {
            Mode = 1,
            PrintName = "FAN",
            Override_TriggerDelay = false,
            Mult_RPM = 3,
            Mult_HipDispersion = 3,
            Mult_AccuracyMOA = 3
        },
        {
            Mode = 0
        }
    }
    r8.Animations["fire"] = {
        Source = "fire",
        Time = 0.5,
        LHIK = false,
    }
    r8.Animations["fire_alt"] = {
        Source = {"alt1", "alt2", "alt3"},
        Time = 0.7,
        LHIK = true,
        LHIKIn = 0.1,
        LHIKOut = 0.1,
    }
    r8.Animations["trigger"] = {
        Source = "prepare",
        MinProgress = 0.25,
    }
    r8.Animations["untrigger"] = {
        Source = "idle",
    }

    local glock = weapons.GetStored("arccw_go_glock")
    glock.ViewModel = "models/weapons/arccw_go/v_pist_glock_extras.mdl"
    glock.WorldModel = "models/weapons/arccw_go/v_pist_glock_extras.mdl"
    glock.AttachmentElements["go_glock_slide_long"] = {
        NameChange = "Glock 17L",
        VMBodygroups = {
            {ind = 1, bg = 3}
        },
        AttPosMods = {
            [4] = {
                vpos = Vector(0, -2.35, 7.9),
            }
        }
    }

    local usp = weapons.GetStored("arccw_go_usp")
    usp.ViewModel = "models/weapons/arccw_go/v_pist_usp_extras.mdl"
    usp.WorldModel = "models/weapons/arccw_go/v_pist_usp_extras.mdl"
    usp.Attachments[2].ExcludeFlags = {"go_usp_muzzle_match"}
    usp.Attachments[2].GivesFlags = {"nocomp"}
    usp.Attachments[3].ExcludeFlags = {"go_usp_muzzle_match"}
    usp.Attachments[3].GivesFlags = {"nocomp"}
    usp.Attachments[4].Slot = {"muzzle", "go_muzzle_usp"}
    usp.AttachmentElements["9mm"] = {
        Override_Trivia_Calibre = "9x19mm Parabellum"
        -- NameChange = "USP-9"
    }
    usp.AttachmentElements["go_usp_muzzle_match"] = {
        -- NameChange = "USP Match",
        VMBodygroups = {
            {ind = 3, bg = 1}
        }
    }
    usp.Hook_NameChange = function(wep, name)
        if wep.Attachments[4].Installed == "go_usp_muzzle_match" then
            return "USP Match"
        elseif table.HasValue(wep:GetActiveElements(), "9mm") then
            return "USP-9"
        else
            return "USP-45"
        end
    end

    local akm = weapons.GetStored("arccw_go_ak47")
    table.insert(akm.Attachments, 6, {
        PrintName = "Grip",
        Slot = {"go_g3_grip"},
        DefaultAttName = "Standard Grip"
    })

    akm.AttachmentElements["go_g3_grip_black"] = {
        VMBodygroups = {{ind = 4, bg = 1},},
    }

    --[[]
    local ssg = weapons.GetStored("arccw_go_ssg08")
    ssg.Animations["fire"].MinProgress = 0.25
    ssg.Animations["fire_ads"].MinProgress = 0.25
    ssg.Animations["cycle"].MinProgress = 0.75

    local awp = weapons.GetStored("arccw_go_awp")
    awp.Animations["fire"].MinProgress = 0.4
    awp.Animations["fire_ads"].MinProgress = 0.4
    awp.Animations["cycle"].MinProgress = 0.8

    local m870 = weapons.GetStored("arccw_go_870")
    m870.Animations["fire"].MinProgress = 0.15
    m870.Animations["fire_ads"].MinProgress = 0.15
    m870.Animations["cycle"].Time = 0.45
    m870.Animations["cycle"].MinProgress = 0.35

    local nova = weapons.GetStored("arccw_go_nova")
    nova.Animations["fire"].MinProgress = 0.15
    nova.Animations["fire_ads"].MinProgress = 0.15
    nova.Animations["cycle"].Time = 0.5
    nova.Animations["cycle"].MinProgress = 0.3

    local mag7 = weapons.GetStored("arccw_go_mag7")
    mag7.Animations["fire"].MinProgress = 0.2
    mag7.Animations["fire_ads"].MinProgress = 0.2
    mag7.Animations["cycle"].Time = 0.6
    mag7.Animations["cycle"].MinProgress = 0.3
    ]]

    -- Dirty dirty overwrites
    local base = weapons.GetStored("arccw_base")
    base.DoLaser = function(self, world)
        local toworld = world or false

        if not self:GetNWBool("laserenabled", true) then return end

        for _, k in pairs(self.Attachments) do
            if not k.Installed then continue end
            local attach = ArcCW.AttachmentTable[k.Installed]
            if not attach.Laser then continue end
            local color = attach.LaserColor or attach.ColorOptionsTable[k.ColorOptionIndex or 1]
            if self:GetOwner():IsPlayer() and laserColor:GetInt() > 0
                    and self:GetOwner():GetInfoNum("arccw_gsoe_laser_enabled", 1) == 1
                    and (k.Installed == "go_flashlight_combo" or string.find(k.Installed, "go_laser")) then
                local mode = laserColor:GetInt() >= 2 and 0 or self:GetOwner():GetInfoNum("arccw_gsoe_laser_special", 0)
                if mode == 0 or mode == 1 then
                    local r, g, b
                    if mode == 0 then
                        r = math.Clamp(self:GetOwner():GetInfoNum("arccw_gsoe_laser_r", 255), 1, 255)
                        g = math.Clamp(self:GetOwner():GetInfoNum("arccw_gsoe_laser_g", 0), 1, 255)
                        b = math.Clamp(self:GetOwner():GetInfoNum("arccw_gsoe_laser_b", 0), 1, 255)
                    else
                        local plyclr = self:GetOwner():GetPlayerColor()
                        r = plyclr.x * 255
                        g = plyclr.y * 255
                        b = plyclr.z * 255
                    end
                    local sum = math.max(Vector(r, g, b):Length(), 1)
                    if sum < 255 and laserColor:GetInt() < 3 then -- Anti cheese
                        local add = (255 - sum)
                        r = r + math.ceil((r / sum) * add)
                        g = g + math.ceil((g / sum) * add)
                        b = b + math.ceil((b / sum) * add)
                    end
                    color.r = r
                    color.g = g
                    color.b = b
                elseif mode == 2 then -- RAINBOWS
                    color.r = 128 + 127 * math.Clamp(math.sin(1 * CurTime()), 0, 1)
                    color.g = 128 + 127 * math.Clamp(math.sin(1 * (CurTime() + math.pi / 3 * 2)), 0, 1)
                    color.b = 128 + 127 * math.Clamp(math.sin(1 * (CurTime() + math.pi / 3 * 4)), 0, 1)
                end
            end

            if toworld then
                if not k.WElement then continue end
                cam.Start3D()
                    self:DrawLaser(attach, k.WElement.Model, color, true)
                cam.End3D()
            else
                if not k.VElement then continue end
                self:DrawLaser(attach, k.VElement.Model, color)
            end
        end

        if self.Lasers then
            if world then
                cam.Start3D()
                for _, k in pairs(self.Lasers) do
                    self:DrawLaser(k, self.WMModel or self, k.LaserColor, true)
                end
                cam.End3D()
            else
                -- cam.Start3D(nil, nil, self.ViewmodelFOV)
                for _, k in pairs(self.Lasers) do
                    self:DrawLaser(k, self:GetOwner():GetViewModel(), k.LaserColor)
                end
                -- cam.End3D()
            end
        end
    end

end
hook.Add("PreGamemodeLoaded", "ArcCW_GSOE", function()
    GSOE()
end)

local function PostLoadAtt()
    if attBal:GetBool() then

        -- Folded/removed stocks add draw/holster speed
        local nostock = {
            ["go_stock_none"] = true,
            ["go_mp5_stock_in"] = true,
            ["go_ump_stock_in"] = true,
            ["go_negev_stock_in"] = true,
            ["go_awp_stock_obrez"] = true,
            ["go_870_stock_sawnoff"] = true,
            ["go_nova_stock_pistol"] = true,
            ["go_mac10_stock_in"] = true,
            ["go_mp9_stock_in"] = true,
        }
        for i, _ in pairs(nostock) do
            ArcCW.AttachmentTable[i].Mult_DrawTime = 0.5
            ArcCW.AttachmentTable[i].Mult_HolsterTime = 0.5
            table.insert(ArcCW.AttachmentTable[i].Desc_Cons, "Unstabilized sighted fire")
        end

        -- Pistol stock slows drawing but reduces more recoil
        table.insert(ArcCW.AttachmentTable["go_stock_pistol_bt"].Desc_Pros, "Stabilized sighted fire")
        ArcCW.AttachmentTable["go_stock_pistol_bt"].Mult_Recoil = 0.85
        ArcCW.AttachmentTable["go_stock_pistol_bt"].Mult_DrawTime = 1.5
        ArcCW.AttachmentTable["go_stock_pistol_bt"].Mult_HolsterTime = 1.5

        table.insert(ArcCW.AttachmentTable["go_stock_pistol_wire"].Desc_Pros, "Stabilized sighted fire")
        ArcCW.AttachmentTable["go_stock_pistol_wire"].Mult_DrawTime = 1.25
        ArcCW.AttachmentTable["go_stock_pistol_wire"].Mult_HolsterTime = 1.25

        -- AK skeleton stock
        ArcCW.AttachmentTable["go_ak_stock_skeleton"].Mult_Recoil = 1.15
        ArcCW.AttachmentTable["go_ak_stock_skeleton"].Mult_SightTime = 0.85
        ArcCW.AttachmentTable["go_ak_stock_skeleton"].Mult_DrawTime = 0.75
        ArcCW.AttachmentTable["go_ak_stock_skeleton"].Mult_HolsterTime = 0.75

        -- Weapon-specific heavy stocks reduce more recoil and move speed
        local hstock = {
            ["go_mac10_stock_heavy"] = true,
            ["go_mag7_stock_heavy"] = true,
            ["go_m4_stock_m16"] = true,
            ["go_ak_stock_heavy"] = true,
            ["go_mp5_stock_heavy"] = true,
        }
        for i, _ in pairs(hstock) do
            ArcCW.AttachmentTable[i].Mult_Recoil = 0.8
            ArcCW.AttachmentTable[i].Mult_MoveDispersion = nil --1.3
            ArcCW.AttachmentTable[i].Mult_SightTime = 1.3
            ArcCW.AttachmentTable[i].Mult_SightedSpeedMult = 0.8
            ArcCW.AttachmentTable[i].Mult_DrawTime = 1.2
            ArcCW.AttachmentTable[i].Mult_HolsterTime = 1.2
            ArcCW.AttachmentTable[i].Mult_SpeedMult = nil
        end

        local sb = {
            ["go_ssg08_barrel_short"] = true,
            ["go_sg_barrel_short"] = true,
            ["go_scar_barrel_short"] = true,
            ["go_nova_barrel_short"] = true,
            ["go_negev_barrel_short"] = true,
            ["go_mp5_barrel_short"] = true,
            ["go_mag7_barrel_short"] = true,
            ["go_m4_barrel_short"] = true,
            ["go_m249_barrel_short"] = true,
            ["go_m1014_barrel_short"] = true,
            ["go_g3_barrel_short"] = true,
            ["go_famas_barrel_short"] = true,
            ["go_awp_barrel_short"] = true,
            ["go_aug_barrel_short"] = true,
            ["go_ak_barrel_short"] = true,
            ["go_ace_barrel_short"] = true,
            ["go_870_barrel_short"] = true,
        }
        for i, _ in pairs(sb) do
            ArcCW.AttachmentTable[i].Mult_DrawTime = 0.75
            ArcCW.AttachmentTable[i].Mult_HolsterTime = 0.75
            ArcCW.AttachmentTable[i].Mult_ReloadTime = 0.9
        end

        -- SSQ is quieter but has a bigger range penalty
        ArcCW.AttachmentTable["go_supp_ssq"].Mult_ShootVol = 0.65
        ArcCW.AttachmentTable["go_supp_ssq"].Mult_Range = 0.75

        -- Monolith is quieter but has a bigger sight time penalty
        ArcCW.AttachmentTable["go_supp_monolith"].Mult_ShootVol = 0.65
        ArcCW.AttachmentTable["go_supp_monolith"].Mult_SightTime = 1.5
        ArcCW.AttachmentTable["go_supp_monolith_shot"].Mult_ShootVol = 0.65
        ArcCW.AttachmentTable["go_supp_monolith_shot"].Mult_SightTime = 1.25

        -- G3 SG1 barrel matches SCAR SSR barrel
        ArcCW.AttachmentTable["go_g3_barrel_long"].Mult_Range = 1.5
        ArcCW.AttachmentTable["go_g3_barrel_long"].Mult_AccuracyMOA = 0.75
        ArcCW.AttachmentTable["go_g3_barrel_long"].Mult_Recoil = 0.75
        ArcCW.AttachmentTable["go_g3_barrel_long"].Mult_RPM = 0.5

        -- Auto sniper barrels have less move disp
        ArcCW.AttachmentTable["go_g3_barrel_long"].Mult_MoveDispersion = 0.5
        ArcCW.AttachmentTable["go_scar_barrel_long"].Mult_MoveDispersion = 0.5

        -- Sniper stocks
        ArcCW.AttachmentTable["go_scar_stock_sniper"].Mult_Recoil = 0.8
        ArcCW.AttachmentTable["go_scar_stock_sniper"].Mult_MoveDispersion = 0.75
        ArcCW.AttachmentTable["go_scar_stock_sniper"].Mult_SightedSpeedMult = 0.5
        ArcCW.AttachmentTable["go_scar_stock_sniper"].Mult_SightTime = 1.15
        ArcCW.AttachmentTable["go_scar_stock_sniper"].Description = "Precision sniper stock for the SCAR-20 DMR. Improves recoil, but is slower to manuver when aiming."
        ArcCW.AttachmentTable["go_g3_stock_padded"].Mult_Recoil = 0.8
        ArcCW.AttachmentTable["go_g3_stock_padded"].Mult_MoveDispersion = 0.75
        ArcCW.AttachmentTable["go_g3_stock_padded"].Mult_SightedSpeedMult = 0.5
        ArcCW.AttachmentTable["go_g3_stock_padded"].Mult_SightTime = 1.15
        ArcCW.AttachmentTable["go_g3_stock_padded"].Description = "G3 sniper-style stock. Improves recoil, but is slower to manuver when aiming."

        -- Bayonet anim edit
        ArcCW.AttachmentTable["go_muzz_bayonet"].Override_BashPreparePos = Vector(2, -12, -2.6)
        ArcCW.AttachmentTable["go_muzz_bayonet"].Override_BashPrepareAng = Angle(8, 4, 5)
        ArcCW.AttachmentTable["go_muzz_bayonet"].Override_BashPos = Vector(1.2, 7, -1.8)
        ArcCW.AttachmentTable["go_muzz_bayonet"].Override_BashAng = Angle(4, 6, 0)

        -- MP5SD
        ArcCW.AttachmentTable["go_mp5_barrel_sd"].Mult_SightTime = 1.15
        ArcCW.AttachmentTable["go_mp5_barrel_sd"].Mult_Range = 0.9
        ArcCW.AttachmentTable["go_mp5_barrel_sd"].Mult_ShootVol = 0.6
        ArcCW.AttachmentTable["go_mp5_barrel_sd"].Mult_ShootPitch = 1.5
        ArcCW.AttachmentTable["go_mp5_barrel_sd"].Description = "Integral silencer used in MP5SD models. Reduces bullet velocity to subsonic while suppressing firing sound, making the weapon whisper-quiet. Significantly better handling than standalone suppressors."

        -- Stub barrel shouldn't be shit
        local stub = {"go_mac10_barrel_stub", "go_m4_barrel_stub"}
        for _, i in pairs(stub) do
            ArcCW.AttachmentTable[i].Mult_Range = 0.5
            ArcCW.AttachmentTable[i].Mult_AccuracyMOA = 3
            ArcCW.AttachmentTable[i].Mult_Recoil = 1.5
            ArcCW.AttachmentTable[i].Mult_RPM = 1.15
            ArcCW.AttachmentTable[i].Mult_SpeedMult = 1.1
            ArcCW.AttachmentTable[i].Mult_SightedSpeedMult = 1.2
            ArcCW.AttachmentTable[i].Mult_ShootVol = nil
            ArcCW.AttachmentTable[i].Mult_DrawTime = 0.5
            ArcCW.AttachmentTable[i].Mult_HolsterTime = 0.5
        end

        -- Pistol/short shotgun grips shouldn't be shit
        local grip = {"go_nova_stock_pistol", "go_870_stock_sawnoff"}
        for _, i in pairs(grip) do
            ArcCW.AttachmentTable[i].Mult_SightedSpeedMult = 1.25
            ArcCW.AttachmentTable[i].Mult_SightTime = 0.5
        end

        -- AUG 9mm
        ArcCW.AttachmentTable["go_aug_ammo_9mm"].Mult_Damage = 0.85
        ArcCW.AttachmentTable["go_aug_ammo_9mm"].Mult_DamageMin = 0.85
        ArcCW.AttachmentTable["go_aug_ammo_9mm"].Mult_AccuracyMOA = 1.5
        ArcCW.AttachmentTable["go_aug_ammo_9mm"].Mult_Recoil = 0.6
        ArcCW.AttachmentTable["go_aug_ammo_9mm"].Mult_RecoilSide = 0.6
        ArcCW.AttachmentTable["go_aug_ammo_9mm"].Mult_RPM = 1.2

        -- G3 5.56mm recoil
        ArcCW.AttachmentTable["go_g3_mag_60_556"].Mult_Recoil = 0.4
        ArcCW.AttachmentTable["go_g3_mag_30_556"].Mult_Recoil = 0.4
        ArcCW.AttachmentTable["go_g3_mag_20_556"].Mult_Recoil = 0.4

        -- Compact pistol
        local compact = {"go_glock_slide_short", "go_p250_slide_short"}
        for _, i in pairs(compact) do
            ArcCW.AttachmentTable[i].Desc_Cons = {"con.magcap"}
            ArcCW.AttachmentTable[i].Mult_SightTime = 0.7
            ArcCW.AttachmentTable[i].Mult_ReloadTime = 0.85
            ArcCW.AttachmentTable[i].Mult_Recoil = 1.15
            ArcCW.AttachmentTable[i].Mult_RPM = 1.2
        end

        -- Ammo
        ArcCW.AttachmentTable["go_ammo_sg_scatter"].Mult_Recoil = 0.7
        ArcCW.AttachmentTable["go_ammo_sg_magnum"].Mult_Recoil = 1.5
        ArcCW.AttachmentTable["go_ammo_sg_magnum"].Mult_AccuracyMOA = 1.5
        ArcCW.AttachmentTable["go_ammo_tmj"].Mult_DamageMin = 1.3
        ArcCW.AttachmentTable["go_ammo_match"].Mult_Damage = nil
        ArcCW.AttachmentTable["go_ammo_match"].Mult_Recoil = nil
        ArcCW.AttachmentTable["go_ammo_match"].Mult_AccuracyMOA = 0.5
        ArcCW.AttachmentTable["go_ammo_match"].Mult_HipDispersion = 1.2
        ArcCW.AttachmentTable["go_ammo_match"].Description = "Precision-tooled rounds with carefully meaasured powder improves weapon accuracy and range, but is more difficult to use when hip firing."

        -- G3 Stock
        ArcCW.AttachmentTable["go_g3_stock_collapsible"].Description = "Retractable and lightweight stock for the G3, improving sight time and moving spread at the cost of recoil."
        ArcCW.AttachmentTable["go_g3_stock_collapsible"].Mult_SightTime = 0.85

        -- Perks
        ArcCW.AttachmentTable["go_perk_rapidfire"].Mult_RPM = 1.1
        ArcCW.AttachmentTable["go_perk_light"].Mult_SightedSpeedMult = 1.2
        ArcCW.AttachmentTable["go_perk_diver"].Desc_Pros = {"-50% Recoil while underwater"}
        ArcCW.AttachmentTable["go_perk_diver"].Hook_ModifyRecoil = function(wep)
            if wep:GetOwner():WaterLevel() >= 2 then
                return {Recoil = 0.5}
            end
        end
        ArcCW.AttachmentTable["go_homemade_auto"].PrintName = "Automatic Internals"
        ArcCW.AttachmentTable["go_homemade_auto"].Description = "Switch in an automatic receiver, allowing the usage of semi/auto firemodes."
        ArcCW.AttachmentTable["go_homemade_auto"].Override_Firemodes = {{Mode = 2}, {Mode = 1}, {Mode = 0}}
    end

    if addSway:GetInt() >= 1 then
        for class, t in pairs(ArcCW.AttachmentTable) do
            if addSway:GetInt() < 2 and string.Left(class, 3) ~= "go_" then continue end
            if (t.Mult_Range or 1) > 1 and (t.Mult_AccuracyMOA or 1) < 1 and (t.Mult_Recoil or 1) < 1 then
                -- If it increases range, decreases precision and recoil it's probably a long barrel
                t.Mult_Sway = math.Clamp(t.Mult_Range or 1, 1, 2)
            elseif (t.Mult_Range or 1) < 1 and (t.Mult_AccuracyMOA or 1) > 1 and (t.Mult_Recoil or 1) > 1 then
                -- Vice versa, probably a short barrel
                t.Mult_Sway = math.Clamp(t.Mult_Range or 1, 0.25, 1)
            elseif (t.Mult_SightTime or 1) > 1 and t.Holosight then
                -- A sight of some kind
                t.Mult_Sway = math.Clamp(t.Mult_SightTime or 1, 1, 1.5)
            end
        end

        ArcCW.AttachmentTable["go_flashlight"].FlashlightBrightness = 1
        ArcCW.AttachmentTable["go_flashlight"].FlashlightFarZ = 2048

        ArcCW.AttachmentTable["go_flashlight_combo"].FlashlightBrightness = 1
        ArcCW.AttachmentTable["go_flashlight_combo"].FlashlightFarZ = 2048
    end

    if laserColor:GetBool() then
        --ArcCW.AttachmentTable["go_laser"].LaserStrength = 0.2 * 2
        ArcCW.AttachmentTable["go_laser"].Description = "Barely visible weak laser pointer. Improves hip-fire accuracy."
        --ArcCW.AttachmentTable["go_laser_peq"].LaserStrength = 1 * 2
        ArcCW.AttachmentTable["go_laser_peq"].Description = "Incredibly bright laser pointer. Improves hip fire, moving accuracy, and sight time."
        --ArcCW.AttachmentTable["go_laser_surefire"].LaserStrength = 0.6 * 2
        ArcCW.AttachmentTable["go_laser_surefire"].Description = "Noticeably bright laser pointer. Improves hip fire and sight time."
        --ArcCW.AttachmentTable["go_flashlight_combo"].LaserStrength = 0.6 * 2
    end

    ArcCW.AttachmentTable["go_glock_slide_auto"].ExcludeFlags = {"noauto"}

    ArcCW.AttachmentTable["go_g3_grip_black"].PrintName = "Polymer Grip"
    ArcCW.AttachmentTable["go_g3_grip_black"].Description = "Alternative polymer grip that is ever so slightly more egronomical."
    ArcCW.AttachmentTable["go_g3_grip_black"].Mult_SightTime = 0.9
    ArcCW.AttachmentTable["go_g3_grip_black"].Mult_RecoilSide = 1.1
end
hook.Add("ArcCW_PostLoadAtts", "ArcCW_GSOE", PostLoadAtt)
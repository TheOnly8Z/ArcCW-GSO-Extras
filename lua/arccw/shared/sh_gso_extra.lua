local attBal = CreateConVar("arccw_gsoe_attbal", 1, FCVAR_ARCHIVE + FCVAR_REPLICATED, "Custom tweaks to GSO attachments. See WS page for details.", 0, 1)
local gunBal = CreateConVar("arccw_gsoe_gunbal", 1, FCVAR_ARCHIVE + FCVAR_REPLICATED, "Custom tweaks to GSO weapons. See WS page for details.", 0, 1)
local originTweak = CreateConVar("arccw_gsoe_origintweak", 1, FCVAR_ARCHIVE + FCVAR_REPLICATED, "Resets origin of GSO weapons, making them look more like how they are in CSGO.", 0, 1)
local catMode = CreateConVar("arccw_gsoe_catmode", 1, FCVAR_ARCHIVE + FCVAR_REPLICATED, "Change GSO weapon categories.", 0, 3)
local laserColor = CreateConVar("arccw_gsoe_lasermode", 1, FCVAR_ARCHIVE + FCVAR_REPLICATED, "Make 1mW, 3mW and 5mW lasers use custom colors defined by the player.", 0, 3)
local addSway = CreateConVar("arccw_gsoe_addsway", 0, FCVAR_ARCHIVE + FCVAR_REPLICATED, "Dynamically insert aim sway to every GSO gun and attachment. Set to 2 to apply to ALL guns and attachments.", 0, 2)
local laserUpdateDelay = CreateConVar("arccw_gsoe_laser_updatedelay", 3, FCVAR_ARCHIVE + FCVAR_REPLICATED, "How long must a client wait before informing server of their laser color. Low values may increase server load.", 0)
local fireMult = CreateConVar("arccw_gsoe_mult_fire", 0.5, FCVAR_ARCHIVE + FCVAR_REPLICATED, "Fire damage multiplier for molotov.", 0)
local thermMult = CreateConVar("arccw_gsoe_mult_thermite", 0.5, FCVAR_ARCHIVE + FCVAR_REPLICATED, "Fire damage multiplier for thermite.", 0)
local sgMult = CreateConVar("arccw_gsoe_mult_shotgun", 1, FCVAR_ARCHIVE + FCVAR_REPLICATED, "Damage multiplier for shotguns.", 0)
local tttEdit = CreateConVar("arccw_gsoe_tttbal", 1, FCVAR_ARCHIVE + FCVAR_REPLICATED, "Apply a more drastic balance patch for TTT specifically. These should be more similar in power to vanilla TTT weapons. Set to 2 to apply even outside TTT.", 0, 2)


if CLIENT then
    CreateClientConVar("arccw_gsoe_laser_enabled", "1", true, true, "", 0, 1)
    CreateClientConVar("arccw_gsoe_laser_r", "255", true, true, "", 0, 255)
    CreateClientConVar("arccw_gsoe_laser_g", "0", true, true, "", 0, 255)
    CreateClientConVar("arccw_gsoe_laser_b", "0", true, true, "", 0, 255)
    CreateClientConVar("arccw_gsoe_laser_special", "0", true, true, "", 0, 2)

    local enable, clr, special
    local function ReportNewColorToServer(convar, oldValue, newValue)

        local cur_enable = GetConVar("arccw_gsoe_laser_enabled"):GetBool()
        local cur_clr = Color(GetConVar("arccw_gsoe_laser_r"):GetInt(), GetConVar("arccw_gsoe_laser_g"):GetInt(), GetConVar("arccw_gsoe_laser_b"):GetInt())
        local cur_special = GetConVar("arccw_gsoe_laser_special"):GetInt()

        enable = cur_enable
        clr = cur_clr
        special = cur_special

        -- Immediately update ourselves on client
        LocalPlayer().ArcCW_GSOE_LaserColor = {
            enabled = enabled,
            color = clr,
            special = special,
        }

        -- If value doesn't change in 5 seconds, update to server too
        local delay = game.SinglePlayer() and 0 or laserUpdateDelay:GetFloat()
        if timer.Exists("ArcCW_GSOE_UpdateLaserColor") then timer.Remove("ArcCW_GSOE_UpdateLaserColor") end
        timer.Create("ArcCW_GSOE_UpdateLaserColor", delay, 1, function()
            if enable == cur_enable and clr == cur_clr and special == cur_special then
                net.Start("ArcCW_GSOE_LaserColor")
                    net.WriteBool(enable)
                    if enable then
                        net.WriteColor(clr)
                        net.WriteUInt(special, 2)
                    end
                net.SendToServer()
            end
        end)
    end
    cvars.AddChangeCallback("arccw_gsoe_laser_enabled", ReportNewColorToServer)
    cvars.AddChangeCallback("arccw_gsoe_laser_r", ReportNewColorToServer)
    cvars.AddChangeCallback("arccw_gsoe_laser_g", ReportNewColorToServer)
    cvars.AddChangeCallback("arccw_gsoe_laser_b", ReportNewColorToServer)
    cvars.AddChangeCallback("arccw_gsoe_laser_special", ReportNewColorToServer)

    net.Receive("ArcCW_GSOE_LaserColor", function()
        local ply = net.ReadEntity()
        ply.ArcCW_GSOE_LaserColor = net.ReadTable()
    end)

    hook.Add("InitPostEntity", "ArcCW_GSOE_LaserColor", function()
        enable = GetConVar("arccw_gsoe_laser_enabled"):GetBool()
        clr = Color(GetConVar("arccw_gsoe_laser_r"):GetInt(), GetConVar("arccw_gsoe_laser_g"):GetInt(), GetConVar("arccw_gsoe_laser_b"):GetInt())
        special = GetConVar("arccw_gsoe_laser_special"):GetInt()
        net.Start("ArcCW_GSOE_LaserColor")
            net.WriteBool(enable)
            if enable then
                net.WriteColor(clr)
                net.WriteUInt(special, 2)
            end
        net.SendToServer()
    end)
elseif SERVER then
    util.AddNetworkString("ArcCW_GSOE_LaserColor")

    local nextReport = {}
    net.Receive("ArcCW_GSOE_LaserColor", function(len, ply)
        if (nextReport[ply] or 0) > CurTime() then return end
        nextReport[ply] = CurTime() + (game.SinglePlayer() and 0 or laserUpdateDelay:GetFloat())
        ply.ArcCW_GSOE_LaserColor = ply.ArcCW_GSOE_LaserColor or {}
        ply.ArcCW_GSOE_LaserColor.enabled = net.ReadBool()
        if ply.ArcCW_GSOE_LaserColor.enabled then
            ply.ArcCW_GSOE_LaserColor.color = net.ReadColor()
            ply.ArcCW_GSOE_LaserColor.special = net.ReadUInt(2)
        end
        net.Start("ArcCW_GSOE_LaserColor")
            net.WriteEntity(ply)
            net.WriteTable(ply.ArcCW_GSOE_LaserColor)
        net.Broadcast()
    end)
end

local knifeBal = {
    Category = "Gear",
    TTTWeight = 0,
    Backstab = true,
    Animations = {
        ["draw"] = { Source = "draw", Time = 1},
        ["idle"] = false,
        ["bash"] = {Source = {"light_hit1", "light_hit2"}, Time = 1},
        ["bash_backstab"] = {Source = "light_backstab", Time = 1},
        ["bash2"] = {Source = "heavy_hit1", Time = 1.75},
        ["bash2_backstab"] = {Source = "heavy_backstab", Time = 1.75}
    },
}

local balanceList = {
    -- SMG
    ["arccw_go_mac10"] = {
        Damage = 30,
        DamageMin = 12,
        Category = "SMG",
        TTTWeight = 200,
        TTTWeaponType = "weapon_ttt_m16",
    },
    ["arccw_go_mp5"] = {
        Damage = 24,
        DamageMin = 18,
        Category = "SMG",
        TTTWeight = 200,
        TTTWeaponType = "weapon_ttt_m16",
    },
    ["arccw_go_mp7"] = {
        Damage = 25,
        DamageMin = 17,
        Category = "SMG",
        TTTWeight = 200,
        TTTWeaponType = "weapon_zm_mac10",
    },
    ["arccw_go_mp9"] = {
        Damage = 27,
        DamageMin = 15,
        Category = "SMG",
        TTTWeight = 200,
        TTTWeaponType = "weapon_zm_mac10",
    },
    ["arccw_go_p90"] = {
        Damage = 24,
        DamageMin = 20,
        Category = "SMG",
        TTTWeight = 100,
        TTTWeaponType = "weapon_zm_mac10",
    },
    ["arccw_go_ump"] = {
        Damage = 32,
        DamageMin = 19,
        Recoil = 0.31,
        Category = "SMG",
        TTTWeight = 200,
        TTTWeaponType = "weapon_ttt_m16",
    },
    ["arccw_go_bizon"] = {
        Category = "SMG",
        TTTWeight = 200,
        TTTWeaponType = "weapon_ttt_m16",
    },
    -- ARs
    ["arccw_go_ar15"] = {
        AccuracyMOA = 3,
        Recoil = 0.32,
        RecoilSide = 0.2,
        SpeedMult = 0.93,
        Range = 120,
        Category = "Rifles",
        TTTWeight = 50,
        TTTWeaponType = {"weapon_ttt_m16", "weapon_zm_mac10"},
    },
    ["arccw_go_aug"] = {
        Damage = 28,
        DamageMin = 24,
        Category = "Rifles",
        TTTWeight = 50,
        TTTWeaponType = {"weapon_ttt_m16", "weapon_zm_mac10"},
    },
    ["arccw_go_ace"] = {
        SightTime = 0.3,
        Trivia_Mechanism = "Gas-Operated",
        Category = "Rifles",
        Damage = 28,
        DamageMin = 19,
        TTTWeight = 50,
        TTTWeaponType = {"weapon_ttt_m16", "weapon_zm_mac10"},
    },
    ["arccw_go_ak47"] = {
        Category = "Rifles",
        TTTWeight = 50,
        TTTWeaponType = {"weapon_ttt_m16", "weapon_zm_mac10"},
    },
    ["arccw_go_famas"] = {
        Category = "Rifles",
        SightTime = 0.27,
        TTTWeight = 50,
        TTTWeaponType = {"weapon_ttt_m16", "weapon_zm_mac10"},
    },
    ["arccw_go_m16a2"] = {
        Category = "Rifles",
        TTTWeight = 50,
        TTTWeaponType = {"weapon_ttt_m16", "weapon_zm_mac10"},
    },
    ["arccw_go_m4"] = {
        Category = "Rifles",
        TTTWeight = 50,
        TTTWeaponType = {"weapon_ttt_m16", "weapon_zm_mac10"},
    },
    ["arccw_go_sg556"] = {
        Category = "Rifles",
        TTTWeight = 50,
        TTTWeaponType = {"weapon_ttt_m16", "weapon_zm_mac10"},
    },
    -- BRs
    ["arccw_go_fnfal"] = {
        Category = "Rifles",
        TTTWeight = 50,
        TTTWeaponType = {"weapon_ttt_m16", "weapon_zm_rifle"},
        ShootSound = "arccw_go/fnfal/fal-good_inc.wav"
    },
    ["arccw_go_g3"] = {
        Category = "Rifles",
        TTTWeight = 50,
        TTTWeaponType = {"weapon_zm_rifle"},
    },
    ["arccw_go_scar"] = {
        Category = "Rifles",
        TTTWeight = 50,
        TTTWeaponType = {"weapon_zm_rifle"},
    },
    -- SRs
    ["arccw_go_awp"] = {
        Category = "Rifles",
        TTTWeight = 0,
        TTT_Stats = { -- This is only applied when there TTT Edit is not enabled
            Kind = 7, --WEAPON_EQUIP2,
            Slot = 6,
            RangeMin = 5,
            Range = 55,
            Damage = 150,
            DamageMin = 300,
            Override_Ammo = "none",
            AutoSpawnable = false,
            ForceDefaultClip = 0,
            CanBuy = {1, 2}, --{ROLE_TRAITOR, ROLE_DETECTIVE},
            EquipMenuData = {
                type = "Weapon",
                desc = "Powerful magnum sniper rifle.\n\nHas 10 rounds and cannot be reloaded."
            }
        }
    },
    ["arccw_go_ssg08"] = {
        Category = "Rifles",
        TTTWeight = 200,
        TTTWeaponType = "weapon_zm_rifle",
        TTT_Stats = {
            Range = 10,
            DamageMin = 75,
            SightTime = 0.28
        },
    },
    -- SGs
    ["arccw_go_m1014"] = {
        HipDispersion = 400,
        MoveDispersion = 75,
        Recoil = 3,
        RecoilSide = 2,
        AccuracyMOA = 20,
        Category = "Heavy",
        TTTWeight = 50,
        TTTWeaponType = "weapon_zm_shotgun",
        RangeMin = 10,
        TTT_Stats = {
            --DamageMin = 4,
            RangeMin = 8,
            Range = 20,
            Delay = 60 / 180,
            AccuracyMOA = 50,
        }
    },
    ["arccw_go_mag7"] = {
        HipDispersion = 300,
        MoveDispersion = 75,
        Recoil = 3,
        RecoilSide = 2,
        AccuracyMOA = 30,
        Category = "Heavy",
        TTTWeight = 100,
        RangeMin = 10,
        TTTWeaponType = "weapon_zm_shotgun",
        TTT_Stats = {
            --DamageMin = 4,
            AccuracyMOA = 40,
            RangeMin = 8,
            Range = 20,
        }
    },
    ["arccw_go_870"] = {
        HipDispersion = 300,
        MoveDispersion = 75,
        Recoil = 2,
        RecoilSide = 1.5,
        AccuracyMOA = 30,
        Category = "Heavy",
        TTTWeight = 100,
        RangeMin = 15,
        TTTWeaponType = "weapon_zm_shotgun",
        TTT_Stats = {
            --DamageMin = 4,
            AccuracyMOA = 40,
            RangeMin = 8,
            Range = 20,
        }
    },
    ["arccw_go_nova"] = {
        HipDispersion = 300,
        MoveDispersion = 75,
        Recoil = 2,
        RecoilSide = 1.5,
        AccuracyMOA = 20,
        Category = "Heavy",
        TTTWeight = 100,
        RangeMin = 20,
        TTTWeaponType = "weapon_zm_shotgun",
        TTT_Stats = {
            --DamageMin = 5,
            AccuracyMOA = 30,
            RangeMin = 10,
            Range = 30,
        }
    },
    -- MGs
    ["arccw_go_m249para"] = {
        Category = "Heavy",
        TTTWeight = 100,
        TTTWeaponType = "weapon_zm_sledge",
    },
    ["arccw_go_negev"] = {
        Category = "Heavy",
        TTTWeight = 100,
        TTTWeaponType = "weapon_zm_sledge",
    },
    -- Pistols
    ["arccw_go_cz75"] = {
        HipDispersion = 200,
        MoveDispersion = 25,
        Recoil = 0.37,
        AccuracyMOA = 10,
        Damage = 26,
        DamageMin = 22,
        SightTime = 0.2,
        Trivia_Desc = "Czech handgun developed to export to the West during the height of the Cold War. It functions similarly to other 9mm double-stack pistols but handles better.",
        Category = "Pistols",
        TTTWeight = 50,
        TTTWeaponType = {"weapon_zm_pistol", "weapon_ttt_glock"},
    },
    ["arccw_go_fiveseven"] = {
        HipDispersion = 250,
        MoveDispersion = 25,
        AccuracyMOA = 3,
        DamageMin = 20,
        SightTime = 0.3,
        Trivia_Desc = "Handgun designed as a companion to the P90 PDW. Its thin but long cartridge allows for exceptional range and accuracy for a pistol, but isn't very hard hitting.",
        Category = "Pistols",
        TTTWeight = 100,
        TTTWeaponType = "weapon_zm_pistol",
    },
    ["arccw_go_glock"] = {
        HipDispersion = 250,
        MoveDispersion = 50,
        AccuracyMOA = 12,
        SightTime = 0.2,
        Category = "Pistols",
        TTTWeight = 50,
        TTTWeaponType = {"weapon_zm_pistol", "weapon_ttt_glock"},
    },
    ["arccw_go_m9"] = {
        HipDispersion = 300,
        MoveDispersion = 50,
        AccuracyMOA = 4,
        Range = 60,
        Damage = 25,
        DamageMin = 22,
        SightTime = 0.3,
        Recoil = 0.29,
        Trivia_Desc = "Popular full-sized Italian 9mm handgun adopted by the US military. The longer slide provides excellent accuracy and recoil control at the cost of hip fire performance.",
        Category = "Pistols",
        TTTWeight = 50,
        TTTWeaponType = {"weapon_zm_pistol", "weapon_ttt_glock"},
    },
    ["arccw_go_p2000"] = {
        HipDispersion = 150,
        MoveDispersion = 25,
        AccuracyMOA = 10,
        Recoil = 0.2,
        Damage = 25,
        DamageMin = 20,
        SightTime = 0.25,
        Trivia_Desc = "Handgun developed to meet modern police and paramilitary needs. It is comfortable to hold and provides better hip firing performance.",
        Category = "Pistols",
        TTTWeight = 100,
        TTTWeaponType = "weapon_zm_pistol",
    },
    ["arccw_go_p250"] = {
        Delay = 60 / 400,
        HipDispersion = 300,
        MoveDispersion = 50,
        AccuracyMOA = 10,
        Recoil = 0.5,
        RecoilSide = 0.45,
        SightTime = 0.3,
        Damage = 34,
        DamageMin = 26,
        Trivia_Desc = "Compact hard-hitting handgun that incorporates numerous improvements over previous generations of SIG pistols. Its .357 SIG cartridge is more powerful, but also kicks harder.",
        Category = "Pistols",
        TTTWeight = 100,
        TTTWeaponType = "weapon_zm_pistol",
    },
    ["arccw_go_tec9"] = {
        Slot = 1,
        HipDispersion = 400,
        MoveDispersion = 50,
        AccuracyMOA = 12,
        SightTime = 0.3,
        Trivia_Desc = "Cheap open bolt pistol notorious for its ease of conversion to full auto. Has a generous magazine capacity, but isn't particularly accurate.",
        Category = "Pistols",
        TTTWeight = 100,
        TTTWeaponType = "weapon_zm_pistol",
    },
    ["arccw_go_usp"] = {
        HipDispersion = 250,
        MoveDispersion = 75,
        AccuracyMOA = 5,
        SightTime = 0.3,
        Damage = 35,
        DamageMin = 24,
        Trivia_Desc = "Iconic pistol designed for police and special forces use. Accurate and powerful, but magazine capacity is smaller than most pistols.",
        Category = "Pistols",
        TTTWeight = 100,
        TTTWeaponType = "weapon_zm_pistol",
    },
    ["arccw_go_deagle"] = {
        VisualRecoilMult = 3,
        HipDispersion = 450,
        MoveDispersion = 100,
        Damage = 65,
        DamageMin = 40,
        SightTime = 0.35,
        Category = "Pistols",
        TTTWeight = 100,
        TTTWeaponType = "weapon_zm_revolver",
        TTT_Stats = {
            Delay = 60 / 120
        },
    },
    ["arccw_go_r8"] = {
        HipDispersion = 50,
        MoveDispersion = 100,
        Damage = 58,
        DamageMin = 32,
        SightTime = 0.32,
        Category = "Pistols",
        TTTWeight = 100,
        TTTWeaponType = "weapon_zm_revolver",
    },
    ["arccw_go_sw29"] = {
        Category = "Pistols",
        TTTWeight = 100,
        TTTWeaponType = "weapon_zm_revolver",
    },
    -- Equipment
    ["arccw_go_taser"] = {
        Category = "Gear",
        TTTWeight = 0,
    },
    ["arccw_go_melee_knife"] = knifeBal,
    ["arccw_go_nade_knife"] = {
        Category = "Gear",
        TTTWeight = 0,
        MuzzleVelocity = 3000,
        MuzzleVelocityAlt = 1500,
    },
    ["arccw_go_nade_incendiary"] = {
        Category = "Gear",
        MuzzleVelocityAlt = 500,
        TTTWeight = 100,
        TTTWeaponType = "weapon_zm_molotov",
    },
    ["arccw_go_nade_frag"] = {
        Category = "Gear",
        MuzzleVelocityAlt = 500,
        TTTWeight = 0,
        --TTTWeaponType = "weapon_ttt_confgrenade",
    },
    ["arccw_go_nade_flash"] = {
        Category = "Gear",
        MuzzleVelocityAlt = 500,
        TTTWeight = 100,
        TTTWeaponType = "weapon_ttt_confgrenade",
    },
    ["arccw_go_nade_smoke"] = {
        Category = "Gear",
        MuzzleVelocityAlt = 500,
        TTTWeight = 100,
        TTTWeaponType = "weapon_ttt_smokegrenade",
    },
    ["arccw_go_shield"] = {
        Category = "Gear",
    },
    ["arccw_go_nade_molotov"] = {
        Category = "Gear",
        MuzzleVelocityAlt = 500,
        TTTWeight = 100,
        TTTWeaponType = "weapon_zm_molotov",
    },
    -- GSO Extras
    ["arccw_go_galil_ar"] = {
        Category = "Rifles",
        TTTWeight = 50,
        TTTWeaponType = {"weapon_ttt_m16", "weapon_zm_mac10"},
    },
    -- Additional Knives
    ["arccw_go_knife_bowie"] = knifeBal,
    ["arccw_go_knife_butterfly"] = knifeBal,
    ["arccw_go_knife_t"] = knifeBal,
    ["arccw_go_knife_karambit"] = knifeBal,
    ["arccw_go_knife_m9bayonet"] = knifeBal,
    ["arccw_go_knife_ct"] = knifeBal,
    ["arccw_go_knife_stiletto"] = knifeBal,
}

local tttEditList = {
    --[[
        Pistols:
        TTT Pistol has 25 damage and 0.38 delay, aka 65DPS, ~158RPM
        TTT Deagle has 37 damage and 0.6 delay, aka 61DPS, 100RPM
    ]]
    ["arccw_go_cz75"] = {
        -- 75-40 DPS
        Trivia_Desc = "Well-rounded pistol, more powerful up close.",
        HipDispersion = 400,
        MoveDispersion = 100,
        AccuracyMOA = 10,
        Damage = 15,
        DamageMin = 8,
        RangeMin = 5,
        Range = 40,
        Delay = 60 / 300,
        VisualRecoilMult = 0.25,
        Recoil = 2,
    },
    ["arccw_go_p2000"] = {
        -- 60-40 DPS
        Trivia_Desc = "Easy to handle pistol.",
        HipDispersion = 150,
        MoveDispersion = 100,
        AccuracyMOA = 10,
        Damage = 12,
        DamageMin = 8,
        RangeMin = 5,
        Range = 40,
        Delay = 60 / 300,
        VisualRecoilMult = 0.25,
        Recoil = 1,
    },
    ["arccw_go_fiveseven"] = {
        -- 50-150 DPS
        Trivia_Desc = "Long range pistol, less powerful up close.",
        HipDispersion = 400,
        MoveDispersion = 50,
        AccuracyMOA = 3,
        Damage = 10,
        DamageMin = 30,
        RangeMin = 5,
        Range = 30,
        Delay = 60 / 300,
        VisualRecoilMult = 0.25,
        Recoil = 2,
    },
    ["arccw_go_glock"] = {
        -- 80-53 DPS
        Trivia_Desc = "Close quarters pistol.",
        HipDispersion = 250,
        MoveDispersion = 100,
        AccuracyMOA = 20,
        Damage = 12,
        DamageMin = 8,
        RangeMin = 5,
        Range = 40,
        Delay = 60 / 400,
        VisualRecoilMult = 0.25,
        Recoil = 1.5,
    },
    ["arccw_go_m9"] = {
        -- 70-50 DPS
        Trivia_Desc = "High precision, medium range pistol.",
        HipDispersion = 500,
        MoveDispersion = 75,
        AccuracyMOA = 4,
        Damage = 14,
        DamageMin = 10,
        RangeMin = 10,
        Range = 50,
        Delay = 60 / 300,
        VisualRecoilMult = 0.25,
        Recoil = 2,
    },
    ["arccw_go_p250"] = {
        -- 75-45 DPS
        Trivia_Desc = "High damage pistol, slow to fire.",
        HipDispersion = 400,
        MoveDispersion = 75,
        AccuracyMOA = 10,
        Damage = 25,
        DamageMin = 15,
        RangeMin = 8,
        Range = 40,
        Delay = 60 / 180,
        VisualRecoilMult = 0.25,
        Recoil = 3,
    },
    ["arccw_go_tec9"] = {
        -- 120-80 DPS
        -- will be slightly lower due to mashing
        Slot = 1,
        Trivia_Desc = "High RPM pistol.",
        HipDispersion = 150,
        MoveDispersion = 150,
        AccuracyMOA = 20,
        Damage = 12,
        DamageMin = 8,
        RangeMin = 5,
        Range = 30,
        Delay = 60 / 600,
        VisualRecoilMult = 0.25,
        Recoil = 1,
    },
    ["arccw_go_usp"] = {
        -- 72-48 DPS
        Trivia_Desc = "Well-rounded pistol, slower to fire.",
        HipDispersion = 300,
        MoveDispersion = 50,
        AccuracyMOA = 5,
        Damage = 18,
        DamageMin = 12,
        RangeMin = 10,
        Range = 50,
        Delay = 60 / 240,
        VisualRecoilMult = 0.25,
        Recoil = 2.5,
    },

    ["arccw_go_deagle"] = {
        -- 100-60 DPS
        Trivia_Desc = "Powerful magnum pistol.",
        HipDispersion = 500,
        MoveDispersion = 50,
        AccuracyMOA = 5,
        Damage = 50,
        DamageMin = 30,
        RangeMin = 5,
        Range = 15,
        Delay = 60 / 120,
        VisualRecoilMult = 0.25,
        Recoil = 4,
    },
    ["arccw_go_r8"] = {
        -- 136-106DPS
        -- Probably much less due to trigger delay
        Trivia_Desc = "Accurate revolver, can be fanned for faster firing.",
        HipDispersion = 200,
        MoveDispersion = 25,
        AccuracyMOA = 5,
        Damage = 45,
        DamageMin = 35,
        RangeMin = 10,
        Range = 30,
        Delay = 60 / 180,
        VisualRecoilMult = 0.25,
        Recoil = 3.5,
    },

    --[[
        SMG and Rifles:
        TTT MAC10 has 12 damage and 0.065 delay, aka 184DPS, ~900RPM
        TTT M16 has 23 damage and 0.19 delay, aka 121DPS, ~300RPM
        "par" DPS around 200 up close and 125 far
        rifles can have higher because they have shit hip dispersion
    ]]
    ["arccw_go_mac10"] = {
        -- 261-152 DPS
        Trivia_Desc = "Short range bullet hose SMG.",
        HipDispersion = 500,
        MoveDispersion = 150,
        AccuracyMOA = 30,
        Damage = 12,
        DamageMin = 7,
        RangeMin = 5,
        Range = 30,
        Delay = 60 / 1300,
        VisualRecoilMult = 1,
        Recoil = 0.7,
        RecoilSide = 0.5
    },
    ["arccw_go_mp9"] = {
        -- 200-114 DPS
        Trivia_Desc = "High fire rate SMG.",
        HipDispersion = 500,
        MoveDispersion = 125,
        AccuracyMOA = 20,
        Damage = 14,
        DamageMin = 8,
        RangeMin = 7,
        Range = 30,
        Delay = 60 / 850,
        VisualRecoilMult = 1,
        Recoil = 0.4,
        RecoilSide = 0.3
    },
    ["arccw_go_mp5"] = {
        -- 173-133 DPS
        Trivia_Desc = "Easy to control SMG.",
        HipDispersion = 300,
        MoveDispersion = 50,
        AccuracyMOA = 8,
        Damage = 13,
        DamageMin = 10,
        RangeMin = 10,
        Range = 40,
        Delay = 60 / 800,
        VisualRecoilMult = 1,
        Recoil = 0.3,
        RecoilSide = 0.1
    },
    ["arccw_go_mp7"] = {
        -- 200-117 DPS
        Trivia_Desc = "Well-rounded SMG.",
        HipDispersion = 400,
        MoveDispersion = 100,
        AccuracyMOA = 15,
        Damage = 18,
        DamageMin = 10,
        RangeMin = 10,
        Range = 40,
        Delay = 60 / 700,
        VisualRecoilMult = 1,
        Recoil = 0.5,
        RecoilSide = 0.3
    },
    ["arccw_go_p90"] = {
        -- 227-121 DPS
        Trivia_Desc = "SMG suitable for rushing B.",
        HipDispersion = 600,
        MoveDispersion = 75,
        AccuracyMOA = 25,
        Damage = 15,
        DamageMin = 8,
        RangeMin = 12,
        Range = 40,
        Delay = 60 / 900,
        VisualRecoilMult = 1,
        Recoil = 0.5,
        RecoilSide = 0.3
    },
    ["arccw_go_bizon"] = {
        -- 175-150 DPS
        Trivia_Desc = "High capacity SMG.",
        HipDispersion = 300,
        MoveDispersion = 75,
        AccuracyMOA = 20,
        Damage = 15,
        DamageMin = 12,
        RangeMin = 10,
        Range = 40,
        Delay = 60 / 750,
        VisualRecoilMult = 1,
        Recoil = 0.25,
        RecoilSide = 0.1
    },
    ["arccw_go_ump"] = {
        -- 220-180 DPS
        Trivia_Desc = "High damage, low fire rate SMG.",
        HipDispersion = 500,
        MoveDispersion = 75,
        AccuracyMOA = 7,
        Damage = 22,
        DamageMin = 18,
        RangeMin = 5,
        Range = 40,
        Delay = 60 / 600,
        VisualRecoilMult = 1,
        Recoil = 0.5,
        RecoilSide = 0.3
    },
    ["arccw_go_ar15"] = {
        -- 266-213 DPS
        -- "omg so OP!" it's semi only dummy, practical firerate probably is more like 400-600rpm
        Trivia_Desc = "Semi-automatic rifle.",
        HipDispersion = 500,
        MoveDispersion = 100,
        AccuracyMOA = 4,
        Damage = 22,
        DamageMin = 18,
        RangeMin = 15,
        Range = 60,
        Delay = 60 / 800,
        VisualRecoilMult = 1.5,
        Recoil = 0.35,
        RecoilSide = 0.15
    },
    ["arccw_go_ace"] = {
        -- 213-160 DPS
        Trivia_Desc = "Low recoil rifle.",
        HipDispersion = 700,
        MoveDispersion = 150,
        AccuracyMOA = 8,
        Damage = 16,
        DamageMin = 12,
        RangeMin = 15,
        Range = 70,
        Delay = 60 / 800,
        VisualRecoilMult = 1.5,
        Recoil = 0.25,
        RecoilSide = 0.15
    },
    ["arccw_go_galil_ar"] = {
        -- 209-173 DPS
        Trivia_Desc = "Low recoil, long range rifle.",
        HipDispersion = 700,
        MoveDispersion = 100,
        AccuracyMOA = 3,
        Damage = 19,
        DamageMin = 16,
        RangeMin = 25,
        Range = 60,
        Delay = 60 / 650,
        VisualRecoilMult = 1.5,
        Recoil = 0.25,
        RecoilSide = 0.1
    },
    ["arccw_go_famas"] = {
        -- 303-242 DPS
        Trivia_Desc = "Burst fire rifle.",
        HipDispersion = 700,
        MoveDispersion = 150,
        AccuracyMOA = 3,
        Damage = 20,
        DamageMin = 16,
        RangeMin = 20,
        Range = 60,
        Delay = 60 / 900,
        VisualRecoilMult = 1.5,
        Recoil = 0.5,
        RecoilSide = 0.1
    },
    ["arccw_go_m16a2"] = {
        -- 293-240 DPS
        Trivia_Desc = "Burst fire rifle, low capacity.",
        HipDispersion = 600,
        MoveDispersion = 150,
        AccuracyMOA = 3,
        Damage = 22,
        DamageMin = 15,
        RangeMin = 20,
        Range = 60,
        Delay = 60 / 800,
        VisualRecoilMult = 1.5,
        Recoil = 0.4,
        RecoilSide = 0.2
    },
    ["arccw_go_ak47"] = {
        -- 260-180 DPS
        Trivia_Desc = "High recoil rifle.",
        HipDispersion = 900,
        MoveDispersion = 200,
        AccuracyMOA = 10,
        Damage = 26,
        DamageMin = 18,
        RangeMin = 12,
        Range = 60,
        Delay = 60 / 600,
        VisualRecoilMult = 1.5,
        Recoil = 0.7,
        RecoilSide = 0.65
    },
    ["arccw_go_m4"] = {
        -- 237-168 DPS
        Trivia_Desc = "Well-rounded rifle.",
        HipDispersion = 600,
        MoveDispersion = 150,
        AccuracyMOA = 6,
        Damage = 19,
        DamageMin = 14,
        RangeMin = 15,
        Range = 50,
        Delay = 60 / 725,
        VisualRecoilMult = 1.5,
        Recoil = 0.4,
        RecoilSide = 0.2
    },
    ["arccw_go_aug"] = {
        -- 211-176 DPS
        Trivia_Desc = "Long range, low recoil rifle.",
        HipDispersion = 750,
        MoveDispersion = 150,
        AccuracyMOA = 3,
        Damage = 18,
        DamageMin = 15,
        RangeMin = 20,
        Range = 80,
        Delay = 60 / 700,
        VisualRecoilMult = 1.5,
        Recoil = 0.35,
        RecoilSide = 0.15
    },
    ["arccw_go_sg556"] = {
        -- 200-175 DPS
        Trivia_Desc = "Long range, low fire rate rifle.",
        HipDispersion = 650,
        MoveDispersion = 150,
        AccuracyMOA = 2,
        Damage = 24,
        DamageMin = 21,
        RangeMin = 20,
        Range = 80,
        Delay = 60 / 500,
        VisualRecoilMult = 1.5,
        Recoil = 0.45,
        RecoilSide = 0.1
    },
    --[[
        Shotguns:
        TTT Shotgun has 88 damage and 0.8 delay, aka 110DPS, 75RPM
    ]]
    ["arccw_go_m1014"] = {
        -- 140-80 DPS
        Trivia_Desc = "Semi-automatic shotgun.",
        HipDispersion = 400,
        MoveDispersion = 75,
        AccuracyMOA = 40,
        Damage = 7,
        DamageMin = 4,
        Num = 8,
        RangeMin = 5,
        Range = 30,
        Delay = 60 / 150,
        VisualRecoilMult = 0.5,
        Recoil = 4,
        RecoilSide = 3,
    },
    ["arccw_go_mag7"] = {
        --
        Trivia_Desc = "Magazine-fed close range shotgun.",
        HipDispersion = 300,
        MoveDispersion = 100,
        AccuracyMOA = 50,
        Damage = 8,
        DamageMin = 3,
        Num = 8,
        RangeMin = 8,
        Range = 20,
        VisualRecoilMult = 0.5,
        Recoil = 5,
        RecoilSide = 3,
    },
    ["arccw_go_870"] = {
        --
        Trivia_Desc = "Easy to handle shotgun.",
        HipDispersion = 200,
        MoveDispersion = 50,
        AccuracyMOA = 40,
        Damage = 8,
        DamageMin = 5,
        Num = 8,
        RangeMin = 8,
        Range = 30,
        VisualRecoilMult = 0.5,
        Recoil = 2,
        RecoilSide = 2,
    },
    ["arccw_go_nova"] = {
        --
        Trivia_Desc = "Low spread shotgun.",
        HipDispersion = 400,
        MoveDispersion = 50,
        AccuracyMOA = 25,
        Damage = 9,
        DamageMin = 7,
        Num = 8,
        RangeMin = 10,
        Range = 40,
        VisualRecoilMult = 0.5,
        Recoil = 3,
        RecoilSide = 2,
    },
    --[[
        Machine Guns:
        TTT HUGE has 7(?) damage and 0.06 delay, aka 116DPS, 1000RPM\
        man this thing sucks. good thing our MGs are cooler
        our DPS are higher because our MGs slow you down and have overheat
    ]]
    ["arccw_go_m249para"] = {
        -- 294-141 DPS
        Trivia_Desc = "Close range machine gun.",
        HipDispersion = 700,
        MoveDispersion = 200,
        AccuracyMOA = 25,
        Damage = 20,
        DamageMin = 12,
        RangeMin = 20,
        Range = 80,
        Delay = 60 / 700,
        VisualRecoilMult = 1,
        Recoil = 0.6,
        RecoilSide = 0.3
    },
    ["arccw_go_negev"] = {
        -- 260-166 DPS
        Trivia_Desc = "High power machine gun.",
        HipDispersion = 800,
        MoveDispersion = 250,
        AccuracyMOA = 15,
        Damage = 25,
        DamageMin = 16,
        RangeMin = 25,
        Range = 100,
        Delay = 60 / 625,
        VisualRecoilMult = 1,
        Recoil = 0.7,
        RecoilSide = 0.5
    },
    --[[
        Snipers and Battle Rifles:
        TTT Rifle has 50 damage and 1.5 delay, and a 4x headshot multiplier
    ]]
    ["arccw_go_ssg08"] = {
        Trivia_Desc = "Scoped bolt action rifle.",
        HipDispersion = 500,
        MoveDispersion = 50,
        AccuracyMOA = 0.25,
        Damage = 70,
        DamageMin = 110,
        RangeMin = 25,
        Range = 50,
    },
    ["arccw_go_g3"] = {
        -- 260-225 DPS
        Trivia_Desc = "High power battle rifle.",
        Primary = {Ammo = "SniperPenetratedRound"},
        HipDispersion = 1000,
        MoveDispersion = 150,
        AccuracyMOA = 1,
        Damage = 52,
        DamageMin = 45,
        RangeMin = 25,
        Range = 80,
        Delay = 60 / 300,
        VisualRecoilMult = 1.5,
        Recoil = 1.25,
        RecoilSide = 0.7
    },
    ["arccw_go_scar"] = {
        -- 266-213 DPS
        Trivia_Desc = "Low recoil battle rifle.",
        Primary = {Ammo = "SniperPenetratedRound"},
        HipDispersion = 900,
        MoveDispersion = 100,
        AccuracyMOA = 2,
        Damage = 40,
        DamageMin = 32,
        RangeMin = 25,
        Range = 80,
        Delay = 60 / 400,
        VisualRecoilMult = 1.5,
        Recoil = 0.8,
        RecoilSide = 0.5
    },
}

local function GSOE()
    local wpnList = list.GetForEdit("Weapon")
    for class, t in pairs(balanceList) do
        local stored = weapons.GetStored(class)
        if not stored then continue end

        for i, v in pairs(t) do
            if i == "AttachmentElements" then
                for name, ae in pairs(v) do
                    stored.AttachmentElements[name] = ae
                end
            elseif gunBal:GetBool() and i ~= "Category" and i ~= "TTT_Stats" then
                if i == "Primary" or i == "Attachments" then
                    stored[i] = table.Merge(stored[i], v)
                else
                    stored[i] = v
                end
            end
        end
        if engine.ActiveGamemode() == "terrortown" or tttEdit:GetInt() == 2 then
            if tttEdit:GetBool() and tttEditList[class] then
                for i, v in pairs(tttEditList[class]) do
                    if i == "Primary" or i == "Attachments" then
                        stored[i] = table.Merge(stored[i], v)
                    else
                        stored[i] = v
                    end
                end
            elseif gunBal:GetBool() and t.TTT_Stats then
                for i, v in pairs(t.TTT_Stats) do
                    if i == "Primary" or i == "Attachments" then
                        stored[i] = table.Merge(stored[i], v)
                    else
                        stored[i] = v
                    end
                end
            end
        end



        if (stored.Num or 1) > 1 and sgMult:GetFloat() ~= 1 then
            stored.Damage = math.Round(stored.Damage * sgMult:GetFloat())
            stored.DamageMin = math.Round(stored.DamageMin * sgMult:GetFloat())
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

    if addSway:GetInt() >= 1 then
        for _, t in pairs(weapons.GetList()) do
            local class = t.ClassName
            if not weapons.IsBasedOn(class, "arccw_base") then continue end
            if t.Throwing or t.IronSightStruct == false then continue end
            if addSway:GetInt() < 2 and string.Left(class, 9) ~= "arccw_go_" then continue end
            t.Sway = math.Clamp(t.SightTime / 2 + t.HipDispersion / 2000, 0, 0.5)
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
    r8.ViewModel = "models/weapons/arccw_go/v_pist_r8_extras.mdl"
    --r8.WorldModel = "models/weapons/arccw_go/v_pist_r8_extras.mdl" -- I fucked up the collision mesh so let's not
    r8.Delay = 60 / 180
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
            PrintName = "DACT",
            --Override_TriggerDelay = true,
        },
        {
            Mode = 1,
            PrintName = "FAN",
            Override_TriggerDelay = false,
            Add_SightsDispersion = 50,
            Mult_HipDispersion = 4,
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
    r8.CaseBones = {
        [6] = {"v_weapon.cylbullet1", "v_weapon.lodbullet1"},
        [7] = {"v_weapon.cylbullet2", "v_weapon.lodbullet2"},
        [8] = {"v_weapon.cylbullet3", "v_weapon.lodbullet3"},
        [1] = {"v_weapon.cylbullet4", "v_weapon.lodbullet4"},
        [2] = {"v_weapon.cylbullet5", "v_weapon.lodbullet5"},
        [3] = {"v_weapon.cylbullet6", "v_weapon.lodbullet6"},
        [4] = {"v_weapon.cylbullet7", "v_weapon.lodbullet7"},
        [5] = {"v_weapon.cylbullet8", "v_weapon.lodbullet8"},
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
    usp.Attachments[1].ExcludeFlags = {"go_usp_muzzle_match"}
    usp.Attachments[1].GivesFlags = {"nocomp"}
    usp.Attachments[2].ExcludeFlags = {"go_usp_muzzle_match","go_usp_mag_8_127"}
    usp.Attachments[2].GivesFlags = {"nocomp"}
    usp.Attachments[3].ExcludeFlags = {"go_usp_muzzle_match"}
    usp.Attachments[3].GivesFlags = {"nocomp"}
    usp.Attachments[4].Slot = {"muzzle", "go_muzzle_usp"}
    usp.AttachmentElements["9mm"] = {
        Override_Trivia_Calibre = "9x19mm Parabellum"
    }
    usp.AttachmentElements["go_usp_muzzle_match"] = {
        VMBodygroups = {
            {ind = 3, bg = 1}
        }
    }
    usp.AttachmentElements["go_usp_mag_8_127"] = {
        VMBodygroups = {
            {ind = 0, bg = 0},
            {ind = 1, bg = 2},
        }
    }
    usp.Hook_NameChange = function(wep, name)
        if wep.Attachments[4].Installed == "go_usp_muzzle_match" then
            return "USP Match"
        elseif table.HasValue(wep:GetActiveElements(), "9mm") then
            return "USP-9"
        elseif table.HasValue(wep:GetActiveElements(), "go_usp_mag_8_127") then
            return "USP-X12.7 PDWS"
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

    local ssg = weapons.GetStored("arccw_go_ssg08")
    ssg.Animations["fire"].MinProgress = 0.3
    ssg.Animations["fire_iron"].MinProgress = 0.3
    ssg.Animations["cycle"].MinProgress = 0.75

    local awp = weapons.GetStored("arccw_go_awp")
    awp.Animations["fire"].MinProgress = 0.45
    awp.Animations["fire_iron"].MinProgress = 0.45
    awp.Animations["cycle"].MinProgress = 0.8

    local m870 = weapons.GetStored("arccw_go_870")
    m870.Animations["fire"].MinProgress = 0.15
    m870.Animations["fire_iron"].MinProgress = 0.15
    m870.Animations["cycle"].Time = 0.55
    m870.Animations["cycle"].MinProgress = 0.45

    local nova = weapons.GetStored("arccw_go_nova")
    nova.Animations["fire"].MinProgress = 0.15
    nova.Animations["fire_iron"].MinProgress = 0.15
    nova.Animations["cycle"].Time = 0.7
    nova.Animations["cycle"].MinProgress = 0.5

    local mag7 = weapons.GetStored("arccw_go_mag7")
    mag7.Animations["fire"].MinProgress = 0.2
    mag7.Animations["fire_iron"].MinProgress = 0.2
    mag7.Animations["cycle"].Time = 0.6
    mag7.Animations["cycle"].MinProgress = 0.3

    local mp7 = weapons.GetStored("arccw_go_mp7")
    mp7.Attachments[1].Slot = {"go_mp7_irons", "optic_lp", "optic"}

    local awesomesauce = {
        ["arccw_go_mp5"]        = { Slot = 2, Type = "go_extras_boondoggle" },
        ["arccw_go_ace"]        = { Slot = 2, Type = "go_extras_boondoggle3" },
        ["arccw_go_sg556"]        = { Slot = 2, Type = "go_extras_boondoggle" },
        ["arccw_go_awp"]        = { Slot = 2, Type = "go_extras_boondoggle" },
        ["arccw_go_scar"]        = { Slot = 2, Type = "go_extras_boondoggle2" },
        ["arccw_go_ump"]        = { Slot = 2, Type = "go_extras_boondoggle" },
        ["arccw_go_fnfal"]      = { Slot = 2, Type = "go_extras_boondoggle2" }
    }
    for i, v in pairs(awesomesauce) do
        local here = weapons.GetStored(i)
        if not here then continue end
        here.Attachments[awesomesauce[i].Slot].EmptyFallback = awesomesauce[i].Type
        here.Attachments[awesomesauce[i].Slot].Installed = awesomesauce[i].Type
    end

    local mp5 = weapons.GetStored("arccw_go_mp5")
    function mp5:Hook_TranslateAnimation(anim) end

    local bizon = weapons.GetStored("arccw_go_bizon")
    function bizon:Hook_TranslateAnimation(anim) end

    -- Dirty dirty overwrites
    local base = weapons.GetStored("arccw_base")
    base.DoLaser = function(self, world)
        world = world or false

        if world then
            cam.Start3D()
        else
            cam.Start3D(EyePos(), EyeAngles(), self.CurrentViewModelFOV)
        end

        for slot, k in pairs(self.Attachments) do
            if not k.Installed then continue end

            local attach = ArcCW.AttachmentTable[k.Installed]

            if self:GetBuff_Stat("Laser", slot) then
                local color = self:GetBuff_Stat("LaserColor", slot) or attach.ColorOptionsTable[k.ColorOptionIndex or 1]
                local lasertbl = self:GetOwner().ArcCW_GSOE_LaserColor
                if self:GetOwner():IsPlayer() and lasertbl and lasertbl.enabled and laserColor:GetInt() > 0
                        and (k.Installed == "go_flashlight_combo" or string.find(k.Installed, "go_laser")) then
                    local mode = laserColor:GetInt() >= 2 and 0 or lasertbl.special
                    if mode == 0 or mode == 1 then
                        local r, g, b
                        if mode == 0 then
                            local clr = lasertbl.color
                            r = clr.r
                            g = clr.g
                            b = clr.b
                        elseif mode == 1 then
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

                if world then
                    if not k.WElement then continue end
                    self:DrawLaser(attach, k.WElement.Model, color, true)
                else
                    if not k.VElement then continue end
                    self:DrawLaser(attach, k.VElement.Model, color)
                end
            end
        end

        if self.Lasers then
            if world then
                for _, k in pairs(self.Lasers) do
                    self:DrawLaser(k, self.WMModel or self, k.LaserColor, true)
                end
            else
                -- cam.Start3D(nil, nil, self.ViewmodelFOV)
                for _, k in pairs(self.Lasers) do
                    self:DrawLaser(k, self:GetOwner():GetViewModel(), k.LaserColor)
                end
                -- cam.End3D()
            end
        end

        cam.End3D()
    end

    local function myfiredamage(s, dmg, origin, radius)
        local infl = dmg:GetInflictor()
        local old_val = dmg:GetDamage()
        for _, ent in pairs(ents.FindInSphere(origin, radius)) do
            if not IsValid(ent) or ent:IsWorld() or ent:WaterLevel() >= 2 then continue end
            local t = util.TraceLine({
                start = origin,
                endpos = ent:GetPos(),
                filter = {s, ent},
                mask = MASK_SHOT_HULL
            })
            if IsValid(t.Entity) then
                t = util.TraceLine({
                    start = origin,
                    endpos = ent:WorldSpaceCenter(),
                    filter = {s, ent},
                    mask = MASK_SHOT_HULL
                })
            end
            if not IsValid(t.Entity) then
                local mult = math.pow((radius - (t.HitPos - origin):Length()) / radius, 2)
                if math.Round(old_val * mult) > 0 then
                    dmg:SetDamage(math.Round(old_val * mult))
                    if ent:IsPlayer() and dmg:GetDamage() > ent:Health() then
                        dmg:SetInflictor(dmg:GetAttacker())
                    end
                    -- UGLY HACK: players will be knocked back if inflictor is set
                    -- why valve, why???????????
                    ent:TakeDamageInfo(dmg)
                    if ent:IsPlayer() then
                        dmg:SetInflictor(infl)
                    elseif ent:IsNPC() or ent:IsNextBot() then
                        ent:Ignite(math.random() * mult * 5 + mult * 5)
                    end
                end
            end
        end
    end

    -- Overwrite molotov and thermite, only serverside since we only care about damage
    local ent_fire = (scripted_ents.GetStored("arccw_go_fire") or {}).t
    if SERVER and ent_fire then

        local init = ent_fire.Initialize
        ent_fire.Initialize = function(self)
            init(self)
            for _, ent in pairs(ents.FindInSphere(self:GetPos(), 256)) do
                if ent:GetClass() == "arccw_smoke" and ent.ArcCW_GSOE_Smoke then
                    local t = util.TraceLine({
                        start = origin,
                        endpos = ent:GetPos(),
                        filter = {self, ent}
                    })
                    if t.Fraction >= 0.99 then
                        self:EmitSound("arccw_go/molotov/molotov_extinguish.wav", 70, 100, 1)
                        SafeRemoveEntityDelayed(self, 0)
                        break
                    end
                end
            end
        end

        ent_fire.Think = function(self)
            if not self.SpawnTime then self.SpawnTime = CurTime() end

            if self:GetVelocity():LengthSqr() <= 32 then
                self:SetMoveType( MOVETYPE_NONE )
            end

            if self.NextDamageTick > CurTime() then return end
            if self:WaterLevel() > 2 then self:Remove() return end

            local dmg = DamageInfo()
            dmg:SetDamageType(DMG_BURN)
            dmg:SetDamage(math.floor(10 * fireMult:GetFloat() * math.min(1, (CurTime() - self.SpawnTime) / 5 * 0.8 + 0.2)))
            dmg:SetDamageForce(Vector(0, 0, 0))
            dmg:SetDamagePosition(self:GetPos())
            dmg:SetInflictor(self)
            dmg:SetAttacker(self:GetOwner())
            myfiredamage(self, dmg, self:GetPos(), 200)
            --util.BlastDamageInfo(dmg, self:GetPos(), 200)

            self.NextDamageTick = CurTime() + 0.25

            if self.SpawnTime + self.FireTime <= CurTime() then self:Remove() return end
        end
    end

    local ent_thermite = (scripted_ents.GetStored("arccw_thr_go_incendiary") or {}).t
    if SERVER and ent_thermite then
        ent_thermite.Think = function(self)
            if not self.SpawnTime then self.SpawnTime = CurTime() end

            if CurTime() - self.SpawnTime >= self.FuseTime and not self.Armed then

                for _, ent in pairs(ents.FindInSphere(self:GetPos(), 256)) do
                    if ent:GetClass() == "arccw_smoke" and ent.ArcCW_GSOE_Smoke then
                        local t = util.TraceLine({
                            start = origin,
                            endpos = ent:GetPos(),
                            filter = {self, ent}
                        })
                        if t.Fraction >= 0.99 then
                            self:EmitSound("arccw_go/molotov/molotov_extinguish.wav", 70, 100, 1)
                            SafeRemoveEntityDelayed(self, 0)
                            return
                        end
                    end
                end

                self:Detonate()
                self:SetArmed(true)
                self.ArmTime = CurTime()
            end

            if self:GetArmed() then
                if self.NextDamageTick > CurTime() then return end
                if not self.ArmTime then self.ArmTime = CurTime() end

                local dmg = DamageInfo()
                dmg:SetDamageType(DMG_BURN)
                dmg:SetDamage(math.floor(75 * 0.4 * thermMult:GetFloat() * math.min(1, (CurTime() - self.ArmTime) / 3 * 0.8 + 0.2)))
                dmg:SetDamageForce(Vector(0, 0, 0))
                dmg:SetDamagePosition(self:GetPos())
                dmg:SetInflictor(self)
                dmg:SetAttacker(self.Owner)
                myfiredamage(self, dmg, self:GetPos(), 256)
                --util.BlastDamageInfo(dmg, self:GetPos(), 256)

                self.NextDamageTick = CurTime() + 0.25 * 0.4

                self.ArcCW_Killable = false
            end
        end
    end

    local ent_smoke = (scripted_ents.GetStored("arccw_thr_go_smoke") or {}).t
    if SERVER and ent_smoke then
        ent_smoke.Detonate = function(self)
            if not self:IsValid() or self:WaterLevel() > 2 then return end
            self:EmitSound("arccw_go/smokegrenade/smoke_emit.wav", 90, 100, 1, CHAN_AUTO)

            for _, ent in pairs(ents.FindInSphere(self:GetPos() + Vector(0, 0, 8), 256)) do
                if ent:GetClass() == "arccw_go_fire" or (ent:GetClass() == "arccw_thr_go_incendiary" and ent:GetArmed()) then
                    local t = util.TraceLine({
                        start = origin,
                        endpos = ent:GetPos() + Vector(0, 0, 4),
                        filter = {self, ent}
                    })
                    if not IsValid(t.Entity) then
                        ent:EmitSound("arccw_go/molotov/molotov_extinguish.wav", 70, 100, 0.5)
                        ent:Remove() -- extinguish fire
                    end
                end
            end

            local cloud = ents.Create( "arccw_smoke" )
            if not IsValid(cloud) then return end
            cloud.ArcCW_GSOE_Smoke = true
            cloud:SetPos(self:GetPos())
            cloud:Spawn()

            self:Remove()
        end
    end

end
hook.Add("PreGamemodeLoaded", "ArcCW_GSOE", function()
    GSOE()
end)
concommand.Add("arccw_gsoe_debug_reload", function()
    GSOE()
end)

local function PostLoadAtt()
    if attBal:GetBool() then

        local bal_nostock = {
            Desc_Cons = {"con.gsoe.unstable"},
            Mult_DrawTime = 0.5,
            Mult_HolsterTime = 0.5
        }

        local bal_hstock = {
            Mult_Recoil = 0.8,
            Mult_MoveDispersion = "nil",
            Mult_SightTime = 1.25,
            Mult_SightedSpeedMult = 0.8,
            Mult_DrawTime = 1.25,
            Mult_HolsterTime = 1.25,
            Mult_SpeedMult = "nil",
        }

        local bal_sb = {
            Mult_DrawTime = 0.85,
            Mult_HolsterTime = 0.85,
            Mult_ReloadTime = 0.9,
            Mult_HipDispersion = 0.9,
        }

        local bal_stub = {
            Mult_Range = 0.5,
            Mult_AccuracyMOA = 3,
            Mult_Recoil = 1.75,
            Mult_RPM = 1.15,
            Mult_SpeedMult = 1.1,
            Mult_SightedSpeedMult = 1.2,
            Mult_ShootVol = "nil",
            Mult_DrawTime = 0.75,
            Mult_HolsterTime = 0.75,
            Mult_ReloadTime = 0.85,
        }

        local bal_compactpist = {
            Desc_Cons = {"con.magcap"},
            Mult_SightTime = 0.7,
            Mult_ReloadTime = 0.85,
            Mult_Recoil = 1.15,
            Mult_RPM = 1.2,
        }

        local baltable = {
            -- Folded/removed stocks add draw/holster speed
            ["go_stock_none"] = bal_nostock,
            ["go_mp5_stock_in"] = bal_nostock,
            ["go_ump_stock_in"] = bal_nostock,
            ["go_negev_stock_in"] = bal_nostock,
            ["go_awp_stock_obrez"] = bal_nostock,
            ["go_870_stock_sawnoff"] = bal_nostock,
            ["go_nova_stock_pistol"] = bal_nostock,
            ["go_mac10_stock_in"] = bal_nostock,
            ["go_mp9_stock_in"] = bal_nostock,

            -- Pistol stock slows drawing but reduces more recoil
            ["go_stock_pistol_bt"] = {
                Desc_Pros = {"pro.gsoe.stable"},
                Mult_Recoil = 0.85,
                Mult_MoveDispersion = 0.7,
                Mult_DrawTime = 1.5,
                Mult_HolsterTime = 1.5,
            },
            ["go_stock_pistol_wire"] = {
                Desc_Pros = {"pro.gsoe.stable"},
                Mult_DrawTime = 1.25,
                Mult_HolsterTime = 1.25,
            },

            ["go_ak_stock_skeleton"] = {
                Mult_Recoil = 1.15,
                Mult_SightTime = 0.85,
                Mult_DrawTime = 0.75,
                Mult_HolsterTime = 0.75,
            },

            -- Weapon-specific heavy stocks reduce more recoil and move speed
            ["go_mac10_stock_heavy"] = bal_hstock,
            ["go_mag7_stock_heavy"] = bal_hstock,
            ["go_m4_stock_m16"] = bal_hstock,
            ["go_ak_stock_heavy"] = bal_hstock,
            ["go_mp5_stock_heavy"] = bal_hstock,

            -- Short barrels give draw/holster speed and reload speed
            ["go_ssg08_barrel_short"] = bal_sb,
            ["go_sg_barrel_short"] = bal_sb,
            ["go_scar_barrel_short"] = bal_sb,
            ["go_nova_barrel_short"] = bal_sb,
            ["go_negev_barrel_short"] = bal_sb,
            ["go_mp5_barrel_short"] = bal_sb,
            ["go_mag7_barrel_short"] = bal_sb,
            ["go_m4_barrel_short"] = bal_sb,
            ["go_m249_barrel_short"] = bal_sb,
            ["go_m1014_barrel_short"] = bal_sb,
            ["go_g3_barrel_short"] = bal_sb,
            ["go_famas_barrel_short"] = bal_sb,
            ["go_awp_barrel_short"] = bal_sb,
            ["go_aug_barrel_short"] = bal_sb,
            ["go_ak_barrel_short"] = bal_sb,
            ["go_ace_barrel_short"] = bal_sb,
            ["go_870_barrel_short"] = bal_sb,

            ["go_glock_slide_auto"] = {
                Mult_SightTime = "nil",
                Mult_DrawTime = "nil",
                Mult_HolsterTime = "nil",
                Mult_Range = "nil",
                Mult_HipDispersion = 2,
            },
            ["go_cz75_slide_auto"] = {
                Mult_RPM = 1.6,
                Mult_HipDispersion = 2,
            },
            ["go_m9_slide_auto"] = {
                Description = "Beretta 93R slide with burst fire capability and an internal compensator.",
                Desc_Pros = {"pro.gsoe.burst"},
                Mult_HipDispersion = 1.5,
                Mult_RPM = "nil",
                Override_Firemodes = {
                    {
                        Mode = -3,
                        Mult_RPM = 1.8,
                        PostBurstDelay = 0.15,

                    },
                    { Mode = 1 },
                    { Mode = 0 }
                }
            },

            -- SSQ is quieter but has a bigger range penalty
            ["go_supp_ssq"] = {
                Mult_ShootVol = 0.65,
                Mult_Range = 0.75,
            },

            -- Monolith is quieter but has a bigger sight time penalty
            ["go_supp_monolith"] = {
                Mult_ShootVol = 0.65,
                Mult_SightTime = 1.5,
            },
            ["go_supp_monolith_shot"] = {
                Mult_ShootVol = 0.65,
                Mult_SightTime = 1.25,
            },

            -- G3 SG1 barrel matches SCAR SSR barrel
            ["go_g3_barrel_long"] = {
                Mult_Range = 1.5,
                Mult_AccuracyMOA = 0.75,
                Mult_Recoil = 0.75,
                Mult_RPM = 0.5,
                Mult_MoveDispersion = 0.5
            },

            -- Auto sniper barrels have less move disp
            ["go_scar_barrel_long"] = {
                Mult_MoveDispersion = 0.5
            },

            -- Bayonet anim edit
            ["go_muzz_bayonet"] = {
                Override_BashPreparePos = Vector(2, -12, -2.6),
                Override_BashPrepareAng = Angle(8, 4, 5),
                Override_BashPos = Vector(1.2, 7, -1.8),
                Override_BashAng = Angle(4, 6, 0),
            },

            -- Stub barrel shouldn't be shit
            ["go_mac10_barrel_stub"] = bal_stub,
            ["go_m4_barrel_stub"] = bal_stub,

            -- Sniper stocks
            ["go_scar_stock_sniper"] = {
                Mult_Recoil = 0.8,
                Mult_MoveDispersion = 0.75,
                Mult_SightedSpeedMult = 0.5,
                Mult_SightTime = 1.1,
                Description = "Precision sniper stock for the SCAR-20 DMR. Improves recoil, but is slower to manuver when aiming.",
            },

            ["go_g3_stock_padded"] = {
                Mult_Recoil = 0.8,
                Mult_MoveDispersion = 0.75,
                Mult_SightedSpeedMult = 0.5,
                Mult_SightTime = 1.1,
                Description = "G3 sniper-style stock. Improves recoil, but is slower to manuver when aiming.",
            },

            -- G3 5.56mm recoil
            ["go_g3_mag_60_556"] = {Mult_Recoil = 0.4},
            ["go_g3_mag_30_556"] = {Mult_Recoil = 0.4},
            ["go_g3_mag_20_556"] = {Mult_Recoil = 0.4},

            -- Improved shotgun pistol stocks
            ["go_nova_stock_pistol"] = {
                Mult_SightedSpeedMult = 1.25,
                Mult_SightTime = 0.6,
            },
            ["go_870_stock_sawnoff"] = {
                Mult_SightedSpeedMult = 1.25,
                Mult_SightTime = 0.6,
            },

            -- MP5SD rework
            ["go_mp5_barrel_sd"] = {
                Mult_SightTime = 1.2,
                Mult_Range = 0.9,
                Mult_ShootVol = 0.6,
                Mult_ShootPitch = 1.5,
                Description = "Integral silencer used in MP5SD models. Reduces bullet velocity to subsonic while suppressing firing sound, making the weapon whisper-quiet. Significantly better handling than standalone suppressors."
            },

            ["go_aug_ammo_9mm"] = {
                Mult_Damage = 0.85,
                Mult_DamageMin = 0.85,
                Mult_AccuracyMOA = 1.5,
                Mult_Recoil = 0.5,
                Mult_RecoilSide = 0.5,
                Mult_RPM = 1.2,
            },

            -- Compact pistol
            ["go_glock_slide_short"] = bal_compactpist,
            ["go_p250_slide_short"] = bal_compactpist,

            ["go_tec9_barrel_short"] = {Mult_RPM = 1.15},
            ["go_tec9_barrel_long"] = {Mult_RPM = 0.9, Mult_SightTime = 1.25},

            ["go_ammo_sg_scatter"] = {Mult_Recoil = 0.7, Mult_AccuracyMOA = 1.5, Mult_DamageMin = "nil", Mult_Range = 0.75},
            ["go_ammo_sg_magnum"] = {Mult_Recoil = 1.5, Mult_AccuracyMOA = 1.5},
            ["go_ammo_tmj"] = {Mult_DamageMin = 1.3},
            ["go_ammo_match"] = {
                Mult_Damage = 0.95,
                Mult_DamageMin = 0.95,
                Mult_Recoil = "nil",
                Mult_AccuracyMOA = 0.5,
                Mult_Range = 1.25,
                Mult_HipDispersion = "nil",
                Description = "Precision-tooled rounds with carefully measured powder improves weapon accuracy and range, but deals slightly less damage.",
            },

            ["go_negev_belt_100"] = {
                Mult_HeatCapacity = 1.5,
            },
        }
        local ttttable = {
            ["go_m249_mag_12g_45"] = {
                Mult_AccuracyMOA = 2,
            },
            ["go_negev_belt_100"] = {
                Mult_AccuracyMOA = 2,
                Mult_Damage = 0.7,
                Mult_DamageMin = 0.7,
                Mult_Range = 0.5,
            },
            ["go_g3_barrel_long"] = {
                Mult_Damage = 1.25,
                Mult_DamageMin = 1.25,
                Mult_RPM = 0.4
            },
            ["go_scar_barrel_long"] = {
                Mult_Damage = 1.2,
                Mult_DamageMin = 1.2,
                Mult_RPM = 0.45
            },
            ["go_glock_slide_auto"] = {
                Mult_HipDispersion = 3,
                Mult_AccuracyMOA = 2,
                Mult_Recoil = 0.85,
            },
            ["go_cz75_slide_auto"] = {
                Mult_RPM = 2,
                Mult_HipDispersion = 2,
                Mult_Recoil = 0.75,
            },
            ["go_m9_slide_auto"] = {
                Mult_Damage = 1.5,
                Mult_DamageMin = 1.5,
                Mult_HipDispersion = 1.5,
                Mult_Recoil = 0.5,
                Mult_RPM = 3,
                Override_Firemodes = {
                    {
                        Mode = -3,
                        Mult_RPM = 1,
                        PostBurstDelay = 0.2,
                    },
                    { Mode = 0 }
                }
            },
            ["go_mac10_barrel_long"] = {
                Mult_Damage = 1.5,
                Mult_DamageMin = 1.5,
            },
            ["go_scar_mag_20_556"] = {
                Mult_RPM = 1.5,
                Mult_Damage = 0.5,
                Mult_DamageMin = 0.5,
                Mult_AccuracyMOA = 2,
            },
            ["go_scar_mag_30_556"] = {
                Mult_RPM = 1.5,
                Mult_Damage = 0.5,
                Mult_DamageMin = 0.5,
                Mult_AccuracyMOA = 2,
            },
            ["go_scar_mag_60_556"] = {
                Mult_RPM = 1.5,
                Mult_Damage = 0.5,
                Mult_DamageMin = 0.5,
                Mult_AccuracyMOA = 2,
            },
            ["go_g3_mag_20_556"] = {
                Mult_RPM = 2,
                Mult_Damage = 0.4,
                Mult_DamageMin = 0.4,
                Mult_AccuracyMOA = 3,
            },
            ["go_g3_mag_30_556"] = {
                Mult_RPM = 2,
                Mult_Damage = 0.4,
                Mult_DamageMin = 0.4,
                Mult_AccuracyMOA = 3,
            },
            ["go_g3_mag_50_556"] = {
                Mult_RPM = 2,
                Mult_Damage = 0.4,
                Mult_DamageMin = 0.4,
                Mult_AccuracyMOA = 3,
            },
        }

        if tttEdit:GetInt() == 2 or (tttEdit:GetInt() == 1 and engine.ActiveGamemode() == "terrortown") then
            baltable = table.Merge(baltable, ttttable)
        end

        for i, t in pairs(baltable) do
            if not ArcCW.AttachmentTable[i] then continue end
            for k, v in pairs(t) do
                if k == "Desc_Pros" or k == "Desc_Cons" or k == "Desc_Neutrals" then
                    table.Add(ArcCW.AttachmentTable[i][k], v)
                elseif v == "nil" then
                    ArcCW.AttachmentTable[i][k] = nil
                else
                    ArcCW.AttachmentTable[i][k] = v
                end
            end
        end


        -- G3 Stock
        ArcCW.AttachmentTable["go_g3_stock_collapsible"].Description = "Retractable and lightweight stock for the G3, improving sight time and moving spread at the cost of recoil."
        ArcCW.AttachmentTable["go_g3_stock_collapsible"].Mult_SightTime = 0.85

        -- Perks
        ArcCW.AttachmentTable["go_perk_rapidfire"].Mult_RPM = 1.1
        ArcCW.AttachmentTable["go_perk_light"].Mult_SightedSpeedMult = 1.2
        ArcCW.AttachmentTable["go_perk_diver"].Desc_Pros = {"pro.gsoe.perk_underwater"}
        ArcCW.AttachmentTable["go_perk_diver"].Hook_ModifyRecoil = function(wep)
            if wep:GetOwner():WaterLevel() >= 2 then
                return {Recoil = 0.5}
            end
        end

        ArcCW.AttachmentTable["go_homemade_auto"].PrintName = "Automatic Internals"
        ArcCW.AttachmentTable["go_homemade_auto"].Description = "Switch in an automatic receiver, allowing the usage of semi/auto firemodes."
        ArcCW.AttachmentTable["go_homemade_auto"].Override_Firemodes = {{Mode = 2}, {Mode = 1}, {Mode = 0}}
        ArcCW.AttachmentTable["go_homemade_auto"].Hook_Compatible = function(wep)
            if wep:GetIsShotgun() or wep.ManualAction or wep.TriggerDelay or wep:GetBuff_Override("Override_TriggerDelay") then return false end
        end

        ArcCW.AttachmentTable["go_perk_burst"].Mult_RPM = nil
        ArcCW.AttachmentTable["go_perk_burst"].Description = "Alters weapon fire group to support a rapid 3-round burst as well as semi-automatic fire."
        ArcCW.AttachmentTable["go_perk_burst"].Desc_Pros = {"pro.gsoe.burst"}
        ArcCW.AttachmentTable["go_perk_burst"].Override_Firemodes = {
            {
                Mode = -3,
                Mult_RPM = 1.5,
                Mult_RecoilSide = 0.8,
                Mult_VisualRecoilMult = 0.8,
                PostBurstDelay = 0.15
            },
            { Mode = 1 },
            { Mode = 0 }
        }
        ArcCW.AttachmentTable["go_perk_burst"].Override_Firemodes_Priority = 100
        ArcCW.AttachmentTable["go_perk_burst"].Hook_Compatible = function(wep)
            if wep:GetIsShotgun() or wep.ManualAction or wep.TriggerDelay or wep:GetBuff_Override("Override_TriggerDelay") then return false end
        end

        ArcCW.AttachmentTable["go_ammo_sg_slug"].Override_Penetration = 9
        ArcCW.AttachmentTable["go_ammo_sg_slug"].Desc_Pros = {"pro.pen.9"}

        ArcCW.AttachmentTable["go_ammo_sg_sabot"].Override_Penetration = 24
        ArcCW.AttachmentTable["go_ammo_sg_sabot"].Desc_Pros = {"pro.pen.24"}

        ArcCW.AttachmentTable["go_usp_mag_20"].Mult_MoveSpeed = 0.95
        ArcCW.AttachmentTable["go_usp_mag_20"].Mult_SightTime = 1.15
        ArcCW.AttachmentTable["go_usp_mag_20"].Mult_ReloadTime = 1.25

        ArcCW.AttachmentTable["go_usp_mag_30"].Mult_MoveSpeed = 0.9
        ArcCW.AttachmentTable["go_usp_mag_30"].Mult_SightTime = 1.25
        ArcCW.AttachmentTable["go_usp_mag_30"].Mult_ReloadTime = 1.4
        ArcCW.AttachmentTable["go_usp_mag_30"].SortOrder = 19

        ArcCW.AttachmentTable["go_supp_osprey"].Description = "Medium sound suppressor with some ballistic-enhancing properties. Less quiet but more agile than other suppressors."
        ArcCW.AttachmentTable["go_supp_osprey"].Mult_ShootVol = 0.85
        ArcCW.AttachmentTable["go_supp_osprey"].Mult_SightTime = 1.05
        ArcCW.AttachmentTable["go_supp_osprey"].Mult_HipDispersion = 1.08

        ArcCW.AttachmentTable["go_supp_osprey_shot"].Description = "Medium sound suppressor with some ballistic-enhancing properties. Unable to fully suppress shotguns due to its size, but is slightly more agile than other suppressors."
        ArcCW.AttachmentTable["go_supp_osprey_shot"].Mult_ShootVol = 0.85
        ArcCW.AttachmentTable["go_supp_osprey_shot"].Mult_SightTime = 1.08

        ArcCW.AttachmentTable["go_muzz_brake"].Mult_Recoil = 0.95
        --ArcCW.AttachmentTable["go_muzz_brake"].Mult_RecoilSide = 0.8

        ArcCW.AttachmentTable["go_perk_headshot"].Description = "Increases headshot damage by 50%."
        ArcCW.AttachmentTable["go_perk_headshot"].Desc_Pros = {"pro.gsoe.perk_headshot"}
        ArcCW.AttachmentTable["go_perk_headshot"].Hook_BulletHit = function(wep, data)
            if SERVER and data.tr.HitGroup == HITGROUP_HEAD then
                data.damage = data.damage * 1.5
            end
        end

        print("Applied GSOE Attachment rebalance.")
    end

    if addSway:GetInt() >= 1 then
        for class, t in pairs(ArcCW.AttachmentTable) do
            if addSway:GetInt() < 2 and string.Left(class, 3) ~= "go_" or t.Mult_Sway then continue end
            if (t.Mult_Range or 1) > 1 and (t.Mult_AccuracyMOA or 1) < 1 and (t.Mult_Recoil or 1) < 1 then
                -- If it increases range, decreases precision and recoil it's probably a long barrel
                t.Mult_Sway = math.Clamp(t.Mult_Range or 1, 1, 2)
                t.Desc_Cons = t.Desc_Cons or {}
                table.insert(t.Desc_Cons, "+" .. math.Round((t.Mult_Sway - 1) * 100) .. "% Sway")
            elseif (t.Mult_Range or 1) < 1 and (t.Mult_AccuracyMOA or 1) > 1 and (t.Mult_Recoil or 1) > 1 then
                -- Vice versa, probably a short barrel
                t.Mult_Sway = math.Clamp(t.Mult_Range or 1, 0.25, 1)
                t.Desc_Pros = t.Desc_Pros or {}
                table.insert(t.Desc_Pros, "-" .. math.Round((1 - t.Mult_Sway) * 100) .. "% Sway")
            elseif (t.Mult_SightTime or 1) > 1 and t.Holosight then
                -- A sight of some kind
                t.Desc_Cons = t.Desc_Cons or {}
                t.Mult_Sway = math.Clamp(t.Mult_SightTime or 1, 1, 1.5)
                table.insert(t.Desc_Cons, "+" .. math.Round((t.Mult_Sway - 1) * 100) .. "% Sway")
            end
        end
    end

    if laserColor:GetBool() then
        --ArcCW.AttachmentTable["go_laser"].LaserStrength = 0.2 * 2
        ArcCW.AttachmentTable["go_laser"].Description = "Barely visible laser pointer. Improves hip-fire accuracy."
        ArcCW.AttachmentTable["go_laser"].ToggleStats = {
            {
                PrintName = "On",
                Laser = true,
                LaserColor = Color(255, 0, 0),
                Mult_HipDispersion = 0.75,
                AdditionalSights = {
                    {
                        Pos = Vector(-2, 10, -4), -- relative to where att.Model is placed
                        Ang = Angle(0, 0, -45),
                        GlobalPos = false,
                        GlobalAng = true,
                        Magnification = 1
                    }
                }
            },
            {
                PrintName = "Off",
            }
        }
        --ArcCW.AttachmentTable["go_laser_peq"].LaserStrength = 1 * 2
        ArcCW.AttachmentTable["go_laser_peq"].Description = "Incredibly bright laser pointer. Improves hip fire, moving accuracy, and sight time."
        ArcCW.AttachmentTable["go_laser_peq"].Mult_SightTime = 1.1
        ArcCW.AttachmentTable["go_laser_peq"].ToggleStats = {
            {
                PrintName = "On",
                Laser = true,
                LaserColor = Color(0, 0, 255),
                Mult_HipDispersion = 0.75,
                Mult_MoveDispersion = 0.75,
                Mult_SightTime = 0.85,
                AdditionalSights = {
                    {
                        Pos = Vector(-2, 10, -4), -- relative to where att.Model is placed
                        Ang = Angle(0, 0, -45),
                        GlobalPos = false,
                        GlobalAng = true,
                        Magnification = 1
                    }
                }
            },
            {
                PrintName = "Off",
            }
        }
        --ArcCW.AttachmentTable["go_laser_surefire"].LaserStrength = 0.6 * 2
        ArcCW.AttachmentTable["go_laser_surefire"].Description = "Somewhat visible laser pointer. Improves hip fire and move dispersion."
        ArcCW.AttachmentTable["go_laser_surefire"].ToggleStats = {
            {
                PrintName = "On",
                Laser = true,
                LaserColor = Color(0, 255, 0),
                Mult_HipDispersion = 0.75,
                Mult_MoveDispersion = 0.75,
                AdditionalSights = {
                    {
                        Pos = Vector(-2, 10, -4), -- relative to where att.Model is placed
                        Ang = Angle(0, 0, -45),
                        GlobalPos = false,
                        GlobalAng = true,
                        Magnification = 1
                    }
                }
            },
            {
                PrintName = "Off",
            }
        }
        --ArcCW.AttachmentTable["go_flashlight_combo"].LaserStrength = 0.6 * 2
    end

    ArcCW.AttachmentTable["go_glock_slide_auto"].ExcludeFlags = {"noauto"}

    ArcCW.AttachmentTable["go_g3_grip_black"].PrintName = "Polymer Grip"
    ArcCW.AttachmentTable["go_g3_grip_black"].Description = "Alternative polymer grip that is ever so slightly more egronomical."
    ArcCW.AttachmentTable["go_g3_grip_black"].Mult_SightTime = 0.9
    ArcCW.AttachmentTable["go_g3_grip_black"].Mult_RecoilSide = 1.1

    ArcCW.AttachmentTable["go_p250_mag_21"].Mult_MoveSpeed = 0.975
    ArcCW.AttachmentTable["go_p250_mag_21"].Mult_SightTime = 1.1
    ArcCW.AttachmentTable["go_p250_mag_21"].Mult_ReloadTime = 1.2

    -- Scale up the horribly small sights
    ArcCW.AttachmentTable["go_optic_compm4"].ModelScale = Vector(1.4, 1.4, 1.4)
    ArcCW.AttachmentTable["go_optic_compm4"].AdditionalSights[1].Pos = Vector(-0.018321, 2, -1.34972) * 1.4

    ArcCW.AttachmentTable["go_optic_eotech"].ModelScale = Vector(1.25, 1.25, 1.25) * 1.1
    ArcCW.AttachmentTable["go_optic_eotech"].AdditionalSights[1].Pos = ArcCW.AttachmentTable["go_optic_eotech"].AdditionalSights[1].Pos * 1.1

    ArcCW.AttachmentTable["go_optic_barska"].ModelScale = Vector(1.25, 1.25, 1.25)
    ArcCW.AttachmentTable["go_optic_barska"].AdditionalSights[1].Pos = ArcCW.AttachmentTable["go_optic_barska"].AdditionalSights[1].Pos * 1.25

    -- Flashlight
    ArcCW.AttachmentTable["go_flashlight"].FlashlightBrightness = 1
    ArcCW.AttachmentTable["go_flashlight"].FlashlightFarZ = 1024

    ArcCW.AttachmentTable["go_flashlight_xhair"].FlashlightBrightness = 1
    ArcCW.AttachmentTable["go_flashlight_xhair"].FlashlightFarZ = 1024

    ArcCW.AttachmentTable["go_flashlight_combo"].FlashlightBrightness = 1
    ArcCW.AttachmentTable["go_flashlight_combo"].FlashlightFarZ = 1024
end
hook.Add("ArcCW_PostLoadAtts", "ArcCW_GSOE", PostLoadAtt)

local function head(ent)
    local pos = ent:WorldSpaceCenter()
    if ent:GetAttachment(ent:LookupAttachment("eyes")) ~= nil then
        pos = ent:GetAttachment(ent:LookupAttachment("eyes")).Pos
    end
    return pos
end

local jw_dur = 3
hook.Add("StartCommand", "ArcCW_GSOE_JohnWick", function(ply, ucmd)
    if SERVER then return end
    local wep = ply:GetActiveWeapon()
    if not IsValid(wep) or not wep.ArcCW or not wep.Attachments then return end
    if not wep:GetBuff_Override("JohnWick") then return end

    local delta = wep:GetSightDelta()
    if (wep:GetState() == ArcCW.STATE_SIGHTS and delta > 0.05) or (wep:GetState() == ArcCW.STATE_SIGHTS and (ply.JWStart or 0) + jw_dur > CurTime()) then
        ply.JWStart = ply.JWStart or CurTime()
        if not ply.JWTarget or not IsValid(ply.JWTarget) or ply.JWTarget:Health() <= 0 then
            ply.JWTarget = nil
            local min_diff
            for _, ent in pairs(ents.FindInCone(ply:EyePos(), ply:EyeAngles():Forward(), 4096, math.cos(math.rad(300)))) do
                if ent == ply or (not ent:IsNPC() and not ent:IsNextBot() and not ent:IsPlayer()) or ent:Health() <= 0 then continue end
                local tr = util.TraceLine({
                    start = ply:EyePos(),
                    endpos = head(ent),
                    mask = MASK_SHOT,
                    filter = ply
                })
                if tr.Entity ~= ent then continue end
                local diff = (head(ent) - ply:EyePos()):Cross(ply:EyeAngles():Forward()):Length()
                if not ply.JWTarget or diff < min_diff then
                    ply.JWTarget = ent
                    min_diff = diff
                end
            end
        end

        if ply.JWTarget then
            local ang = ucmd:GetViewAngles()
            local pos = head(ply.JWTarget)
            local tgt = (pos - ply:EyePos()):Angle()
            local prog = math.Clamp(1 - (ply.JWStart + jw_dur - CurTime()) / jw_dur, 0, 1)
            ang = LerpAngle(prog, ang, tgt)
            ucmd:SetViewAngles(ang)
        end
    else
        ply.JWStart = nil
        ply.JWTarget = nil
    end
end)

hook.Add("OnNPCKilled", "ArcCW_GSOE_JohnWick", function(npc, attacker, inflictor)
    if attacker:IsPlayer() and IsValid(attacker:GetActiveWeapon()) and attacker:GetActiveWeapon().ArcCW and attacker:GetActiveWeapon():GetBuff_Override("JohnWick") then
        attacker:SendLua("LocalPlayer().JWStart = CurTime()")
        attacker:SendLua("LocalPlayer().JWTarget = nil")
    end
end)

hook.Add("PlayerDeath", "ArcCW_GSOE_JohnWick", function(victim, inflictor, attacker)
    if attacker:IsPlayer() and IsValid(attacker:GetActiveWeapon()) and attacker:GetActiveWeapon().ArcCW and attacker:GetActiveWeapon():GetBuff_Override("JohnWick") then
        attacker:SendLua("LocalPlayer().JWStart = CurTime()")
        attacker:SendLua("LocalPlayer().JWTarget = nil")
    end
end)
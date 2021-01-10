SWEP.Base = "arccw_base"
SWEP.Spawnable = true -- this obviously has to be set to true
SWEP.Category = "ArcCW - GSO (ARs)" -- edit this if you like
SWEP.AdminOnly = false

SWEP.PrintName = "M16A2"
SWEP.Trivia_Class = "Assault Rifle"
SWEP.Trivia_Desc = "An early American assault rifle adapted from the AR-15. This model was used extensively during the Vietnam War, made to address the M16A1's unreliability in the jungle and to conserve ammunition with burst fire."
SWEP.Trivia_Manufacturer = "Colt"
SWEP.Trivia_Calibre = "5.56x45mm NATO"
SWEP.Trivia_Mechanism = "Gas-Operated"
SWEP.Trivia_Country = "USA"
SWEP.Trivia_Year = 1982

SWEP.Slot = 2

SWEP.UseHands = true

SWEP.ViewModel = "models/weapons/arccw_go/v_rif_car15.mdl"
SWEP.WorldModel = "models/weapons/arccw_go/v_rif_car15.mdl"
SWEP.ViewModelFOV = 60

SWEP.DefaultBodygroups = "02220000000"

SWEP.Damage = 30
SWEP.DamageMin = 22 -- damage done at maximum range
SWEP.Range = 150 -- in METRES
SWEP.Penetration = 9
SWEP.DamageType = DMG_BULLET
SWEP.ShootEntity = nil -- entity to fire, if any
SWEP.MuzzleVelocity = 1050 -- projectile or phys bullet muzzle velocity
-- IN M/S
SWEP.ChamberSize = 1 -- how many rounds can be chambered.
SWEP.Primary.ClipSize = 20 -- DefaultClip is automatically set.

SWEP.PhysBulletMuzzleVelocity = 1000

SWEP.Recoil = 0.225
SWEP.RecoilSide = 0.260
SWEP.RecoilRise = 0.1

SWEP.Delay = 60 / 850 -- 60 / RPM.
SWEP.Num = 1 -- number of shots per trigger pull.
SWEP.Firemodes = {
    {
        Mode = -3,
        PostBurstDelay = 0.1,
    },
    {
        Mode = 1,
    },
    {
        Mode = 0
    }
}

SWEP.NPCWeaponType = "weapon_ar2"
SWEP.NPCWeight = 100

SWEP.AccuracyMOA = 2 -- accuracy in Minutes of Angle. There are 60 MOA in a degree.
SWEP.HipDispersion = 400 -- inaccuracy added by hip firing.
SWEP.MoveDispersion = 100

SWEP.Primary.Ammo = "smg1" -- what ammo type the gun uses
SWEP.MagID = "stanag" -- the magazine pool this gun draws from

SWEP.ShootVol = 110 -- volume of shoot sound
SWEP.ShootPitch = 90 -- pitch of shoot sound

SWEP.FirstShootSound = "arccw_go/m4a1/m4a1_01.wav"
SWEP.ShootSound = "arccw_go/m4a1/m4a1_04.wav"
SWEP.ShootSoundSilenced = "arccw_go/m4a1/m4a1_silencer_01.wav"
SWEP.DistantShootSound = "arccw_go/m4a1/m4a1-1-distant.wav"

SWEP.MeleeSwingSound = "arccw_go/m249/m249_draw.wav"
SWEP.MeleeMissSound = "weapons/iceaxe/iceaxe_swing1.wav"
SWEP.MeleeHitSound = "arccw_go/knife/knife_hitwall1.wav"
SWEP.MeleeHitNPCSound = "physics/body/body_medium_break2.wav"

SWEP.MuzzleEffect = "muzzleflash_minimi"
SWEP.ShellModel = "models/shells/shell_556.mdl"
SWEP.ShellPitch = 95
SWEP.ShellScale = 1.25
SWEP.ShellRotateAngle = Angle(0, 180, 0)

SWEP.MuzzleEffectAttachment = 1 -- which attachment to put the muzzle on
SWEP.CaseEffectAttachment = 2 -- which attachment to put the case effect on

SWEP.SpeedMult = 0.95
SWEP.SightedSpeedMult = 0.75
SWEP.SightTime = 0.4

SWEP.IronSightStruct = {
    Pos = Vector(-5.26, -8.573, 0.35),
    Ang = Angle(0.25, -0.33, -1.951),
    Magnification = 1.1,
    SwitchToSound = "", -- sound that plays when switching to this sight
    CrosshairInSights = false
}

SWEP.HoldtypeHolstered = "passive"
SWEP.HoldtypeActive = "ar2"
SWEP.HoldtypeSights = "rpg"

SWEP.AnimShoot = ACT_HL2MP_GESTURE_RANGE_ATTACK_AR2

SWEP.ActivePos = Vector(-1, 2, -1)
SWEP.ActiveAng = Angle(0, 0, 0)

SWEP.CrouchPos = Vector(-4, 0, -1)
SWEP.CrouchAng = Angle(0, 0, -10)

SWEP.HolsterPos = Vector(3, 3, 0)
SWEP.HolsterAng = Angle(-7.036, 30.016, 0)

SWEP.BarrelOffsetSighted = Vector(0, 0, -1)
SWEP.BarrelOffsetHip = Vector(2, 0, -2)

SWEP.CustomizePos = Vector(8, 0, 1)
SWEP.CustomizeAng = Angle(5, 30, 30)

SWEP.BarrelLength = 24

SWEP.AttachmentElements = {
    ["rail"] = {
        VMBodygroups = {{ind = 4, bg = 1}},
    },
    ["ubrms"] = {
        VMBodygroups = {{ind = 5, bg = 1}},
    },
    ["tacms"] = {
        VMBodygroups = {{ind = 6, bg = 1}},
    },
    ["go_stock_none"] = {
        VMBodygroups = {
            {ind = 3, bg = 1},
        },
    },
    ["go_stock"] = {
        VMBodygroups = {
            {ind = 3, bg = 1},
        },
    },
    ["go_m16a2_stock_car"] = {
        VMBodygroups = {
            {ind = 3, bg = 0},
        },
    },
    ["go_m4_stock_ergo"] = {
        VMBodygroups = {
            {ind = 3, bg = 3},
        },
    },
    ["go_m4_stock_basilisk"] = {
        VMBodygroups = {
            {ind = 3, bg = 4},
        },
    },
    ["go_m16a2_barrel_med"] = {
        VMBodygroups = {
            {ind = 2, bg = 1},
        },
        AttPosMods = {
            [5] = {
                vpos = Vector(0, -5.15, 19),
            }
        }
    },
    ["go_m16a2_barrel_short"] = {
        VMBodygroups = {
            {ind = 2, bg = 0},
        },
        AttPosMods = {
            [5] = {
                vpos = Vector(0, -5.15, 19),
            }
        },
        Override_IronSightStruct = {
            Pos = Vector(-5.275, -8.573, 0.2),
            Ang = Angle(1.35, -0.375, -1.951),
            Magnification = 1.1,
            SwitchToSound = "", -- sound that plays when switching to this sight
            CrosshairInSights = false
        },
    },
    ["go_m4_mag_10_50"] = {
        VMBodygroups = {
            {ind = 1, bg = 1},
        },
    },
    ["go_m16a2_mag_30"] = {
        VMBodygroups = {
            {ind = 1, bg = 0},
        },
    },
    ["go_m4_mag_30_9mm"] = {
        NameChange = "R0635",
        VMBodygroups = {
            {ind = 1, bg = 3},
        },
    },
    ["go_m4_mag_21_9mm"] = {
        NameChange = "R0635",
        VMBodygroups = {
            {ind = 1, bg = 5},
        },
    },
    ["go_556_ammo_60round"] = {
        VMBodygroups = {
            {ind = 1, bg = 4},
        },
    },
    ["go_homemade_auto"] = {
        NameChange = "M16A3"
    }
}

SWEP.ExtraSightDist = 10
SWEP.GuaranteeLaser = true

SWEP.WorldModelOffset = {
    pos = Vector(-11, 6, -6),
    ang = Angle(-10, 0, 180)
}

SWEP.MirrorVMWM = true
SWEP.Attachments = {
    {
        PrintName = "Optic",
        Slot = {"optic", "optic_lp"},
        Bone = "v_weapon.M4A1_Parent",
        DefaultAttName = "Iron Sights",
        Offset = {
            vpos = Vector(-0.04, -8.4, 3.5),
            vang = Angle(90, 0, -90),
            wpos = Vector(22, 1, -7),
            wang = Angle(-9.79, 0, 180)
        },
        CorrectiveAng = Angle(-0.3, 0, 0),
        VMScale = Vector(1, 1, 1),
        InstalledEles = {"rail"},
    },
    {
        PrintName = "Underbarrel",
        Slot = {"foregrip", "ubgl"},
        Bone = "v_weapon.M4A1_Parent",
        Offset = {
            vpos = Vector(0, -3.5, 10),
            vang = Angle(90, 0, -90),
            wpos = Vector(22, 1, -7),
            wang = Angle(-9.79, 0, 180)
        },
        InstalledEles = {"ubrms"},
    },
    {
        PrintName = "Tactical",
        Slot = "tac",
        Bone = "v_weapon.M4A1_Parent",
        Offset = {
            vpos = Vector(1.6, -5.1, 13),
            vang = Angle(90, -1, 0),
            wpos = Vector(22, 1, -7),
            wang = Angle(-9.79, 0, 180)
        },
        InstalledEles = {"tacms"},
    },
    {
        PrintName = "Barrel",
        Slot = "go_m16a2_barrel",
        DefaultAttName = "510mm A2 Barrel"
    },
    {
        PrintName = "Muzzle",
        DefaultAttName = "Standard Muzzle",
        Slot = "muzzle",
        Bone = "v_weapon.M4A1_Parent",
        Offset = {
            vpos = Vector(0, -5.15, 25.5),
            vang = Angle(90, 0, -90),
        },
        InstalledEles = {"fh_none"},
    },
    {
        PrintName = "Magazine",
        Slot = {"go_m16a2_mag", "go_m4_mag", "go_ammo_556_60"},
        DefaultAttName = "20-Round 5.56mm Steel"
    },
    {
        PrintName = "Stock",
        Slot = {"go_m16a2_stock", "go_stock_none", "go_stock"},
        DefaultAttName = "Standard Stock",
        Bone = "v_weapon.M4A1_Parent",
        Offset = {
            vpos = Vector(0, -5.15, -3),
            vang = Angle(90, 0, -90),
        },
        VMScale = Vector(1.15, 1.15, 1.15)
    },
    {
        PrintName = "Ammo Type",
        Slot = "go_ammo",
        DefaultAttName = "Standard Ammo"
    },
    {
        PrintName = "Perk",
        Slot = {"go_perk", "go_homemade_auto"}
    },
    {
        PrintName = "Charm",
        Slot = "charm",
        FreeSlot = true,
        Bone = "v_weapon.M4A1_Parent", -- relevant bone any attachments will be mostly referring to
        Offset = {
            vpos = Vector(0.6, -3.25, 4), -- offset that the attachment will be relative to the bone
            vang = Angle(90, 0, -90),
            wpos = Vector(6.099, 1.1, -3.301),
            wang = Angle(171.817, 180-1.17, 0),
        },
    },
}

SWEP.RejectAttachments = {
    go_m4_stock_m16 = true,
    go_m4_mag_20 = true,
    go_ar15_barrel_long = true
}

function SWEP:Hook_TranslateAnimation(anim)
    if anim == "fire_iron" then
        if self:GetBuff_Override("NoStock") then return "fire" end
    elseif anim == "fire_iron_empty" then
        if self:GetBuff_Override("NoStock") then return "fire_empty" end
    end
end

SWEP.Animations = {
    ["idle"] = {
        Source = "idle"
    },
    ["draw"] = {
        Source = "draw",
        LHIK = true,
        LHIKIn = 0,
        LHIKOut = 0.5,
    },
    ["ready"] = {
        Source = "ready",
        LHIK = true,
        LHIKIn = 0,
        LHIKOut = 0.5,
    },
    ["fire"] = {
        Source = {"shoot1", "shoot2", "shoot3"},
        Time = 0.5,
        ShellEjectAt = 0,
    },
    ["fire_iron"] = {
        Source = "idle",
        Time = 0.5,
        ShellEjectAt = 0,
    },
    ["reload"] = {
        Source = "reload_smallmag",
        Mult = 0.9,
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_AR2,
        Checkpoints = {16, 30},
        FrameRate = 30,
        LHIK = true,
        LHIKIn = 0.7,
        LHIKOut = 0.7,
    },
    ["reload_empty"] = {
        Source = "reload_smallmag_empty",
        Mult = 0.9,
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_AR2,
        Checkpoints = {16, 30, 55},
        FrameRate = 30,
        LHIK = true,
        LHIKIn = 0.7,
        LHIKOut = 0.8,
    },
    ["reload_smallmag"] = {
        Source = "reload_smallmag",
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_AR2,
        Checkpoints = {16, 30},
        FrameRate = 30,
        LHIK = true,
        LHIKIn = 0.7,
        LHIKOut = 0.7,
    },
    ["reload_smallmag_empty"] = {
        Source = "reload_smallmag_empty",
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_AR2,
        Checkpoints = {16, 30, 55},
        FrameRate = 30,
        LHIK = true,
        LHIKIn = 0.7,
        LHIKOut = 0.8,
    },
    ["enter_inspect"] = false,
    ["idle_inspect"] = false,
    ["exit_inspect"] = false,
}
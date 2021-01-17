att.PrintName = "Debug Laser"
att.Icon = Material("entities/acwatt_go_laser.png", "mips smooth")
att.Description = "I wonder if togglable lasers work."
att.Desc_Pros = {
}
att.Desc_Cons = {
    "con.beam"
}
att.AutoStats = true
att.Slot = {"tac_pistol", "tac"}

att.Model = "models/weapons/arccw_go/atts/laser.mdl"
att.Ignore = true
att.KeepBaseIrons = true

att.ToggleStats = {
    [1] = {
        PrintName = "Red",
        AutoStatName = "On",
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
        },
    },
    [2] = {
        PrintName = "Blue",
        NoAutoStats = true,
        Laser = true,
        LaserColor = Color(0, 0, 255),
        Mult_HipDispersion = 0.75,
        Flashlight = true,
        FlashlightFOV = 50,
        FlashlightFarZ = 512,
        FlashlightNearZ = 1,
        FlashlightAttenuationType = ArcCW.FLASH_ATT_LINEAR,
        FlashlightColor = Color(255, 255, 255),
        FlashlightTexture = "effects/flashlight001",
        FlashlightBrightness = 4,
        FlashlightBone = "laser",
        AdditionalSights = {
            {
                Pos = Vector(-2, 10, -4), -- relative to where att.Model is placed
                Ang = Angle(0, 0, -45),
                GlobalPos = false,
                GlobalAng = true,
                Magnification = 1
            }
        },
    },
    [3] = {
        PrintName = "Off",
        Laser = false,
        Mult_HipDispersion = 1,
    }
}

att.LaserStrength = 0.2
att.LaserBone = "laser"

att.Mult_MoveSpeed = 0.95
att.Mult_SightTime = 1.1

--att.ColorOptionsTable = {Color(255, 0, 0)}

--[[]
att.Mult_HipDispersion = 0.75
-- att.Mult_MoveDispersion = 0.5
--att.Mult_SightTime = 0.9

att.Mult_MoveSpeed = 0.95

att.Mult_SightTime = 1.1
]]
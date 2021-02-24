att.PrintName = "Crosshair Flashlight"
att.Icon = Material("entities/acwatt_go_flashlight.png", "mips smooth")
att.Description = "Mountable flashlight with cross pattern. Narrow field of view, but assists in aiming a little and goes rather far. Able to point fire."
att.Ignore = false
att.Desc_Pros = {
}
att.Desc_Cons = {
    "con.light"
}
att.AutoStats = true
att.Slot = {"tac_pistol", "tac"}

att.Model = "models/weapons/arccw_go/atts/flashlight.mdl"

att.Flashlight = false
att.FlashlightFOV = 45
att.FlashlightFarZ = 4096 -- how far it goes
att.FlashlightNearZ = 1 -- how far away it starts
att.FlashlightAttenuationType = ArcCW.FLASH_ATT_LINEAR -- LINEAR, CONSTANT, QUADRATIC are available
att.FlashlightColor = Color(255, 255, 255)
att.FlashlightTexture = "effects/flashlight_xhair"
att.FlashlightBrightness = 2
att.FlashlightBone = "laser"
att.KeepBaseIrons = true

att.Mult_SightTime = 1.05

att.ToggleStats = {
    {
        PrintName = "On",
        Flashlight = true,
        AdditionalSights = {
            {
                Pos = Vector(-2, 10, -4), -- relative to where att.Model is placed
                Ang = Angle(0, 0, -45),
                GlobalPos = false,
                GlobalAng = true,
                Magnification = 1
            }
        },
        Mult_HipDispersion = 0.9,
    },
    {
        PrintName = "Off",
        Flashlight = false,
    }
}
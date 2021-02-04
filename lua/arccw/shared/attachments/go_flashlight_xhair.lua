att.PrintName = "Flashlight"
att.Icon = Material("entities/acwatt_go_flashlight.png", "mips smooth")
att.Description = "Mountable flashlight. Illuminates targets for the user, but may give away their position."
att.Desc_Pros = {
}
att.Desc_Cons = {
    "con.light"
}
att.AutoStats = true
att.Slot = {"tac_pistol", "tac"}

att.Model = "models/weapons/arccw_go/atts/flashlight.mdl"

att.Flashlight = false
att.FlashlightFOV = 50
att.FlashlightFarZ = 512 -- how far it goes
att.FlashlightNearZ = 1 -- how far away it starts
att.FlashlightAttenuationType = ArcCW.FLASH_ATT_LINEAR -- LINEAR, CONSTANT, QUADRATIC are available
att.FlashlightColor = Color(255, 255, 255)
att.FlashlightTexture = "effects/flashlight001"
att.FlashlightBrightness = 4
att.FlashlightBone = "laser"

att.ToggleStats = {
    {
        PrintName = "High",
        Flashlight = true
    },
    {
        PrintName = "Eco",
        Flashlight = true,
        FlashlightFOV = 50,
        FlashlightFarZ = 365,
        FlashlightBrightness = 1
    },
    {
        PrintName = "Off",
        Flashlight = false,
    }
}
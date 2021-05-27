att.PrintName = "Energy Encapsulator"
att.Icon = Material("entities/acwatt_charm_punished.png")
att.Description = "Curious. This is no charm. What appears to be a battery has been attached to your firearm, soaking up heat in a sort of void-like state. For what it's worth, it seems to.. work like a charm."

att.Desc_Pros = {
}
att.Desc_Cons = {
}
att.AutoStats = true
att.Slot = "charm"
att.SortOrder = 100
att.Ignore = true
att.Free = false

att.Model = "models/Items/battery.mdl"

local lazy = 0.35
att.ModelScale = Vector(lazy, lazy, lazy)
att.ModelOffset = Vector(0.2, 0, -2)
att.OffsetAng = Angle(-90, 0, 90)

att.Mult_HeatCapacity = 1.15

att.Mult_HeatDelayTime = 1.1
att.Mult_FixTime = 1.1
att.PrintName = "Match Compensator"
att.Icon = Material("entities/acwatt_go_usp_muzzle_match.png", "smooth mips")
att.Description = "Special fitted compensator for the USP, greatly improving recoil control, precision, and on-the-move accuracy.\nIt mounts on the lower rail, making LAMs and different slide lengths impossible to use."
att.Desc_Pros = {
}
att.Desc_Cons = {
}
att.Slot = "go_muzzle_usp"

att.ExcludeFlags = {"nocomp"}

att.AutoStats = true

att.Mult_ShootPitch = 0.9
att.Mult_SightTime = 1.2
att.Mult_MoveDispersion = 0.7
att.Mult_AccuracyMOA = 0.4
att.Mult_Recoil = 0.7
att.Mult_RecoilSide = 0.7
att.Mult_MoveSpeed = 0.95

att.SortOrder = 1000
local GSOEPanel = {
    { type = "h", text = "#arccw.gsoe_info" },
    { type = "b", text = "#arccw.cvar.gsoe_attbal", var = "arccw_gsoe_attbal", sv = true },
    { type = "b", text = "#arccw.cvar.gsoe_gunbal", var = "arccw_gsoe_gunbal", sv = true },
    { type = "h", text = "#arccw.gsoe_balinfo" },
    { type = "b", text = "#arccw.cvar.gsoe_origintweak", var = "arccw_gsoe_origintweak", sv = true },
    { type = "i", text = "#arccw.cvar.gsoe_catmode", var = "arccw_gsoe_catmode", sv = true, min = 0, max = 2 },
    { type = "c", text = "#arccw.cvar.gsoe_catmode.desc" },
    { type = "i", text = "#arccw.cvar.gsoe_lasermode", var = "arccw_gsoe_lasermode", sv = true, min = 0, max = 2 },
    { type = "c", text = "#arccw.cvar.gsoe_lasermode.desc" },

    { type = "m", text = "#arccw.cvar.gsoe_laser", r = "arccw_gsoe_laser_r", g = "arccw_gsoe_laser_g", b = "arccw_gsoe_laser_b"},
}

hook.Add("PopulateToolMenu", "ArcCW_GSOE_Options", function()
    spawnmenu.AddToolMenuOption("Options", "ArcCW", "ArcCW_Options_GSOE", "#arccw.menus.gsoe", "", "", function(panel)
        ArcCW.GeneratePanelElements(panel, GSOEPanel)
    end)
end)
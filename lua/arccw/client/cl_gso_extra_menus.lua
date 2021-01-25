local GSOEPanel_SV = {
    { type = "h", text = "#arccw.adminonly" },
    { type = "h", text = "#arccw.gsoe_balinfo" },
    { type = "b", text = "#arccw.cvar.gsoe_attbal", var = "arccw_gsoe_attbal", sv = true },
    { type = "b", text = "#arccw.cvar.gsoe_gunbal", var = "arccw_gsoe_gunbal", sv = true },
    { type = "b", text = "#arccw.cvar.gsoe_origintweak", var = "arccw_gsoe_origintweak", sv = true },
    { type = "c", text = "#arccw.cvar.gsoe_origintweak.desc" },
    --{ type = "i", text = "#arccw.cvar.gsoe_catmode", var = "arccw_gsoe_catmode", sv = true, min = 0, max = 2 },
    { type = "o", text = "#arccw.cvar.gsoe_catmode", var = "arccw_gsoe_catmode", sv = true,
            choices = {[0] = "#arccw.cvar.gsoe_catmode.0", [1] = "#arccw.cvar.gsoe_catmode.1", [2] = "#arccw.cvar.gsoe_catmode.2", [3] = "#arccw.cvar.gsoe_catmode.3"}},
    { type = "c", text = "#arccw.cvar.gsoe_catmode.desc" },

    --{ type = "i", text = "#arccw.cvar.gsoe_lasermode", var = "arccw_gsoe_lasermode", sv = true, min = 0, max = 2 },
    { type = "o", text = "#arccw.cvar.gsoe_lasermode", var = "arccw_gsoe_lasermode", sv = true,
            choices = {[0] = "#arccw.cvar.gsoe_lasermode.0", [1] = "#arccw.cvar.gsoe_lasermode.1", [2] = "#arccw.cvar.gsoe_lasermode.2", [3] = "#arccw.cvar.gsoe_lasermode.3"}},
    { type = "c", text = "#arccw.cvar.gsoe_lasermode.desc" },

    { type = "o", text = "#arccw.cvar.gsoe_addsway", var = "arccw_gsoe_addsway", sv = true,
            choices = {[0] = "#arccw.cvar.gsoe_addsway.0", [1] = "#arccw.cvar.gsoe_addsway.1", [2] = "#arccw.cvar.gsoe_addsway.2"}},
    { type = "c", text = "#arccw.cvar.gsoe_addsway.desc" },
}

local GSOEPanel_CL = {
    { type = "h", text = "#arccw.clientcfg"},
    { type = "b", text = "#arccw.cvar.gsoe_laser_enabled", var = "arccw_gsoe_laser_enabled"},
    { type = "m", text = "#arccw.cvar.gsoe_laser", r = "arccw_gsoe_laser_r", g = "arccw_gsoe_laser_g", b = "arccw_gsoe_laser_b"},
}

hook.Add("PopulateToolMenu", "ArcCW_GSOE_Options", function()
    spawnmenu.AddToolMenuOption("Options", "ArcCW", "ArcCW_Options_GSOE_SV", "#arccw.menus.gsoe.sv", "", "", function(panel)
        ArcCW.GeneratePanelElements(panel, GSOEPanel_SV)
    end)
    spawnmenu.AddToolMenuOption("Options", "ArcCW", "ArcCW_Options_GSOE_CL", "#arccw.menus.gsoe.cl", "", "", function(panel)
        ArcCW.GeneratePanelElements(panel, GSOEPanel_CL)
    end)
end)

hook.Add("TTTSettingsTabs", "ArcCW_GSOE_TTT", function(dtabs)

    local padding = dtabs:GetPadding() * 2

    local panellist = vgui.Create("DPanelList", dtabs)
    panellist:StretchToParent(0,0,padding,0)
    panellist:EnableVerticalScrollbar(true)
    panellist:SetPadding(10)
    panellist:SetSpacing(10)

    local form = vgui.Create("DForm", panellist)
    form:SetName("#arccw.menus.gsoe.cl")
    ArcCW.GeneratePanelElements(form, GSOEPanel_CL)
    panellist:AddItem(form)

    local form2 = vgui.Create("DForm", panellist)
    form2:SetName("#arccw.menus.gsoe.sv")
    ArcCW.GeneratePanelElements(form2, GSOEPanel_SV)
    panellist:AddItem(form2)

    dtabs:AddSheet("ArcCW GSOE", panellist, "icon16/gun.png", false, false, "ArcCW Settings")
end)
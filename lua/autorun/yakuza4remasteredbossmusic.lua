

CreateConVar("minami_music", 0, FCVAR_ARCHIVE, "Battle Music (Minami)", 0, 1)
CreateConVar("takumi_music", 0, FCVAR_ARCHIVE, "Battle Music (Takumi)", 0, 1)
CreateConVar("arai_music", 0, FCVAR_ARCHIVE, "Battle Music (Arai)", 0, 1)
CreateConVar("kido_music", 0, FCVAR_ARCHIVE, "Battle Music (Kido)", 0, 1)
CreateConVar("munakata_music", 0, FCVAR_ARCHIVE, "Battle Music (Munakata)", 0, 1)

local function DRG_YAKUZA_4(Panel)
    if !game.SinglePlayer() then
        if !LocalPlayer():IsAdmin() or !LocalPlayer():IsSuperAdmin() then
            Panel:AddControl( "Label", {Text = "You are not an admin!"})
            Panel:ControlHelp("Notice: Only admins can change this settings.")
            return
        end
    end
	Panel:AddControl("Checkbox", {Label = "Takumi", Command = "takumi_music"})
	Panel:AddControl("Checkbox", {Label = "Minami", Command = "minami_music"})
	Panel:AddControl("Checkbox", {Label = "Arai", Command = "arai_music"})
   	Panel:AddControl("Checkbox", {Label = "Kido", Command = "kido_music"})
    Panel:AddControl("Checkbox", {Label = "Munakata", Command = "munakata_music"})
end
hook.Add("PopulateToolMenu", "DRG_ADDTOMENU_YK01", function()spawnmenu.AddToolMenuOption("DrGBase", "Yakuza 4", "Music Settings", "Boss Music Settings", "", "", DRG_YAKUZA_4, {})end)
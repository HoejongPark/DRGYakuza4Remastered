

CreateConVar("akiyama_music", 0, FCVAR_ARCHIVE, "Battle Music (Akiyama)", 0, 1)
CreateConVar("saejima_music", 0, FCVAR_ARCHIVE, "Battle Music (Saejima)", 0, 1)
CreateConVar("tanimura_music", 0, FCVAR_ARCHIVE, "Battle Music (Tanimura)", 0, 1)
CreateConVar("kiryu_music", 0, FCVAR_ARCHIVE, "Battle Music (Kiryu)", 0, 1)

local function DRG_YAKUZA_4(Panel)
    if !game.SinglePlayer() then
        if !LocalPlayer():IsAdmin() or !LocalPlayer():IsSuperAdmin() then
            Panel:AddControl( "Label", {Text = "You are not an admin!"})
            Panel:ControlHelp("Notice: Only admins can change this settings.")
            return
        end
    end

	Panel:AddControl("Checkbox", {Label = "Akiyama", Command = "akiyama_music"})
	Panel:AddControl("Checkbox", {Label = "Saejima", Command = "saejima_music"})
   	Panel:AddControl("Checkbox", {Label = "Tanimura", Command = "tanimura_music"})
    Panel:AddControl("Checkbox", {Label = "Kiryu", Command = "kiryu_music"})
end
hook.Add("PopulateToolMenu", "DRG_ADDTOMENU_YK01", function()spawnmenu.AddToolMenuOption("DrGBase", "Yakuza 4", "Music Settings", "Music Settings", "", "", DRG_YAKUZA_4, {})end)
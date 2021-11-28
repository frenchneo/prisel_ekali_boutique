if CLIENT then

    surface.CreateFont( "FAS", {
        font = "Font Awesome 5 Free Solid",
        extended = true,
        size = ScreenScale(6),
    } )

    surface.CreateFont( "FAR", {
        font = "Font Awesome 5 Free Regular",
        extended = true,
        size = ScreenScale(6),
    } )
    
    surface.CreateFont( "VED", {
        font = "Vegur",
        extended = true,
        size = ScreenScale(7),
    } )
    
    surface.CreateFont( "VED2", {
        font = "Vegur",
        extended = true,
        size = ScreenScale(9),
    } )

end

hook.Add("OnScreenSizeChanged", "Ekali::Prisel::Boutique::NewResolution::Changed", function()

    surface.CreateFont( "FAS", {
        font = "Font Awesome 5 Free Solid",
        extended = true,
        size = ScreenScale(6),
    } )

    surface.CreateFont( "FAR", {
        font = "Font Awesome 5 Free Regular",
        extended = true,
        size = ScreenScale(6),
    } )
    
    surface.CreateFont( "VED", {
        font = "Vegur",
        extended = true,
        size = ScreenScale(7),
    } )
    
    surface.CreateFont( "VED2", {
        font = "Vegur",
        extended = true,
        size = ScreenScale(9),
    } )

end)

--[[ 

local wep = {
    weapon_357 = {
        ["name"] = ".357",
        ["wep"] = "weapon_357",
        ["category"] = 1
    },

    w127 = {
        ["name"] = ".W127",
        ["wep"] = "w127",
        ["category"] = 2
    },

}

local wepw = {
    "weapon_357",
    "w127"
}

local mycateg = 2

for k, v in pairs(wep) do
    for key, value in pairs(wepw) do
        if value == v.wep then
            if v.category == mycateg then
                Affiche pas
            else
                Affiche
            end
        end
    end
end


]]--

local listearme
local dcategoryframe
local weaponPanelDpanel
local frame
local dfavoriteButton
local ChoosePanelAction

function OpenWeaponMenu(category, WepPlayer)

    if category == "lien boutique" then
        gui.OpenURL(ArmeConfig.LienBoutique)
    return end

    if category == "prendre armes favorites" then

        notification.AddLegacy("Option temporairement désactivée.", NOTIFY_ERROR, 4)
        -- if not file.Exists("prisel_favoris_armes", "DATA") then notification.AddLegacy("Vous n'avez aucune armes en favoris !", NOTIFY_ERROR, 4) return end
        -- if not file.Exists("prisel_favoris_armes/armes_fav.txt", "DATA") then notification.AddLegacy("Vous n'avez aucune armes en favoris !", NOTIFY_ERROR, 4) return end
        -- local fileFav = file.Read("prisel_favoris_armes/armes_fav.txt")
        -- local tblFav = string.Explode(";", fileFav)

        -- net.Start("Ekali:Prisel:OnRecup:PermanentWeaponFav:Net")
        -- net.WriteTable(tblFav)
        -- net.SendToServer()
    return end

    if category == "armes favorites" then
        if not file.Exists("prisel_favoris_armes", "DATA") then notification.AddLegacy("Vous n'avez aucune armes en favoris !", NOTIFY_ERROR, 4) return end
        if not file.Exists("prisel_favoris_armes/armes_fav.txt", "DATA") then notification.AddLegacy("Vous n'avez aucune armes en favoris !", NOTIFY_ERROR, 4) return end
        local fileFav = file.Read("prisel_favoris_armes/armes_fav.txt")
        local tblFav = string.Explode(";", fileFav)

        dcategoryframe = vgui.Create("KVS.Frame")
        dcategoryframe:SetTitle(category)
        dcategoryframe:SetToolBarBackgroundColor(Color(22, 92, 146))
        dcategoryframe:SetSmoothAlpha(true)
        dcategoryframe:SetMainColor(main_color)
        dcategoryframe:SetBackgroundColor(Color(10, 61, 98))
        dcategoryframe:SetSize(ScrW()*.4, ScrH()*.55)
        dcategoryframe:SetDraggable(false)
        dcategoryframe:Center()
        dcategoryframe:MakePopup()
        dcategoryframe:SetFrameIcon('FAS', 0xf54e, color_main)
        dcategoryframe:MoveTo(ScrW()*.53, ScrH() / 2 - dcategoryframe:GetTall() / 2, 1, 0, -1)
    
        function dcategoryframe:Think()
            if not IsValid(frame) then self:Remove() return end
        end

        local scroll = vgui.Create( "DScrollPanel", dcategoryframe )
        scroll:Dock( FILL )
        scroll:DockMargin(20, 10, 20, 10)
    
        local sbar = scroll:GetVBar()
        function sbar:Paint(w, h)
            draw.RoundedBox(3, 0, 0, w, h, Color(30, 30, 30, 100))
        end
        function sbar.btnGrip:Paint(w, h)
            draw.RoundedBox(3, 0, 0, w, h, Color(150, 150, 150, 200))
        end
        sbar:SetSize(dcategoryframe:GetWide()*.01, dcategoryframe:GetTall()*.02)
        sbar:SetHideButtons(true)

        local weppd = {}

        for key, values in pairs(ArmeConfig.WeaponList) do
            if table.HasValue(tblFav, values.wep) then
                local wepd = {
                    ["name"] = values.name,
                    ["wep"] = values.wep,
                    ["rareter"] = values.rareter
                }

                table.insert(weppd, wepd)
            end
        end

        for k, v in pairs(weppd) do
            local butFav = vgui.Create("KVS.Button", scroll)
            butFav:Dock(TOP)
            butFav:DockMargin(0, 0, 5, 10)
            butFav:SetText(v.name.." | "..v.rareter)
            butFav:SetFont('VED')

            function butFav:DoClick()
                if IsValid(ChoosePanelAction) then ChoosePanelAction:Remove() end 
                ChoosePanelAction = vgui.Create("KVS.Frame")
                ChoosePanelAction:SetTitle(v.name)
                ChoosePanelAction:SetToolBarBackgroundColor(Color(22, 92, 146))
                ChoosePanelAction:SetSmoothAlpha(true)
                ChoosePanelAction:SetMainColor(main_color)
                ChoosePanelAction:SetBackgroundColor(Color(10, 61, 98))
                ChoosePanelAction:SetSize(ScrW()*.15, ScrH()*.2)
                ChoosePanelAction:SetDraggable(false)
                ChoosePanelAction:SetPos( ScrW() / 2 - ChoosePanelAction:GetWide()/2, ScrH()*.01)
                ChoosePanelAction:MakePopup()
                ChoosePanelAction:SetFrameIcon('FAS', 0xf54e, color_main)

                function ChoosePanelAction:Think()
                    if not IsValid(dcategoryframe) then self:Remove() return end
                end

                local butTake = vgui.Create("KVS.Button", ChoosePanelAction)
                butTake:SetSize(ChoosePanelAction:GetWide()*.9, ChoosePanelAction:GetTall()*.3)
                butTake:SetPos(ChoosePanelAction:GetWide()/2 - butTake:GetWide()/2, ChoosePanelAction:GetTall()*.3)

                function butTake:Paint(w, h)
                    self:ApplyColor( )
                    if self.Outlined and not self.NoAnimation then
                        local x = 0
                        local y = 0
                        local bordersize = 8
                        surface.SetDrawColor( self.Color )
                
                        surface.SetTexture( texOutlinedCorner )
                        surface.DrawTexturedRectRotated( x + bordersize / 2 , y + bordersize / 2, bordersize, bordersize, 0 )
                        surface.DrawTexturedRectRotated( x + w - bordersize / 2 , y + bordersize / 2, bordersize, bordersize, 270 )
                        surface.DrawTexturedRectRotated( x + w - bordersize / 2 , y + h - bordersize / 2, bordersize, bordersize, 180 )
                        surface.DrawTexturedRectRotated( x + bordersize / 2 , y + h - bordersize / 2, bordersize, bordersize, 90 )
                
                        surface.DrawLine( x + bordersize, y, x + w - bordersize, y )
                        surface.DrawLine( x + bordersize, y + h - 1, x + w - bordersize, y + h - 1 )
                        surface.DrawLine( x, y + bordersize, x, y + h - bordersize )
                        surface.DrawLine( x + w - 1, y + bordersize, x + w - 1, y + h - bordersize )
                
                    else
                        draw.RoundedBoxEx( self.BorderRadius, 0, 0, w, h, self.Color, unpack( self.BorderRounded ) )
                        draw.SimpleText("PRENDRE L'ARME", 'VED', self:GetWide()/2, self:GetTall()/2, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
                        draw.SimpleText(utf8.char(0xf218), 'FAS', self:GetWide()*.2, self:GetTall()/2, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
                    end
                end

                function butTake:DoClick()
                    if LocalPlayer():HasWeapon(v.wep) then notification.AddLegacy("Vous avez déjà cette arme !", NOTIFY_ERROR, 4) return end
                    net.Start("Ekali:Prisel:OnRecup:PermanentWeapon:Net")
                    net.WriteTable(v)
                    net.SendToServer()
                    ChoosePanelAction:Close()
                    dcategoryframe:Close()
                end

                local buttonSupprOfFAV = vgui.Create("KVS.Button", ChoosePanelAction)
                buttonSupprOfFAV:SetSize(ChoosePanelAction:GetWide()*.9, ChoosePanelAction:GetTall()*.3)
                buttonSupprOfFAV:SetPos(ChoosePanelAction:GetWide()/2 - buttonSupprOfFAV:GetWide()/2, ChoosePanelAction:GetTall()*.65)
                buttonSupprOfFAV:SetColor(Color(192, 57, 43))

                function buttonSupprOfFAV:Paint(w, h)
                    self:ApplyColor( )
                    if self.Outlined and not self.NoAnimation then
                        local x = 0
                        local y = 0
                        local bordersize = 8
                        surface.SetDrawColor( self.Color )
                
                        surface.SetTexture( texOutlinedCorner )
                        surface.DrawTexturedRectRotated( x + bordersize / 2 , y + bordersize / 2, bordersize, bordersize, 0 )
                        surface.DrawTexturedRectRotated( x + w - bordersize / 2 , y + bordersize / 2, bordersize, bordersize, 270 )
                        surface.DrawTexturedRectRotated( x + w - bordersize / 2 , y + h - bordersize / 2, bordersize, bordersize, 180 )
                        surface.DrawTexturedRectRotated( x + bordersize / 2 , y + h - bordersize / 2, bordersize, bordersize, 90 )
                
                        surface.DrawLine( x + bordersize, y, x + w - bordersize, y )
                        surface.DrawLine( x + bordersize, y + h - 1, x + w - bordersize, y + h - 1 )
                        surface.DrawLine( x, y + bordersize, x, y + h - bordersize )
                        surface.DrawLine( x + w - 1, y + bordersize, x + w - 1, y + h - bordersize )
                
                    else
                        draw.RoundedBoxEx( self.BorderRadius, 0, 0, w, h, self.Color, unpack( self.BorderRounded ) )
                        draw.SimpleText("SUPPRIMER DES FAVORIS", 'VED', self:GetWide()/2, self:GetTall()/2, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
                        draw.SimpleText(utf8.char(0xf005), 'FAS', self:GetWide()*.095, self:GetTall()/2, Color(243, 156, 18), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
                    end
                end

                function buttonSupprOfFAV:DoClick()
                    if not file.Exists("prisel_favoris_armes", "DATA") or not file.Exists("prisel_favoris_armes/armes_fav.txt", "DATA") then return end
                    local textAppend = file.Read("prisel_favoris_armes/armes_fav.txt")
                    if file.Exists("prisel_favoris_armes", "DATA") and string.find(textAppend, v.wep) then
                        if string.find(textAppend, ";" .. v.wep) then
                            file.Write("prisel_favoris_armes/armes_fav.txt", string.Replace(textAppend, ";" .. v.wep, ""))
                        else
                            file.Write("prisel_favoris_armes/armes_fav.txt", string.Replace(textAppend, v.wep, ""))
                        end
                    end
                    ChoosePanelAction:Close()
                    dcategoryframe:Close()
                end

            end
        end
    return end

    local wep = {}

    for k, v in pairs(WepPlayer) do
        for key, values in pairs(ArmeConfig.WeaponList) do
            if v == values.wep then
                if values.category == category then
                    vl = {
                        ["name"] = values.name,
                        ["wep"] = values.wep,
                        ["model"] = values.model,
                        ["categ"] = values.category,
                        ["rareter"] = values.rareter,
                        ["prixboutique"] = values.priceb,
                    }

                    table.insert(wep, vl)
                end
            end
        end
    end

    dcategoryframe = vgui.Create("KVS.Frame")
    dcategoryframe:SetTitle("Categorie " ..category)
    dcategoryframe:SetToolBarBackgroundColor(Color(22, 92, 146))
    dcategoryframe:SetSmoothAlpha(true)
    dcategoryframe:SetMainColor(main_color)
    dcategoryframe:SetBackgroundColor(Color(10, 61, 98))
    dcategoryframe:SetSize(ScrW()*.4, ScrH()*.55)
    dcategoryframe:SetDraggable(false)
    dcategoryframe:Center()
    dcategoryframe:MakePopup()
    dcategoryframe:SetFrameIcon('FAS', 0xf54e, color_main)
    dcategoryframe:MoveTo(ScrW()*.53, ScrH() / 2 - dcategoryframe:GetTall() / 2, 1, 0, -1)

    function dcategoryframe:Think()
        if not IsValid(frame) then self:Remove() return end
    end

    -- local WeaponPanel = vgui.Create("DPanel", dcategoryframe)
    -- WeaponPanel:SetSize(dcategoryframe:GetWide()*.2, dcategoryframe:GetTall()*.2)
    -- WeaponPanel:SetPos(dcategoryframe:GetWide()*.2, dcategoryframe:GetTall()*.085)

    local scroll = vgui.Create( "DScrollPanel", dcategoryframe )
    scroll:Dock( FILL )
    scroll:DockMargin(20, 10, dcategoryframe:GetWide()*.4, 10)

    
    local sbar = scroll:GetVBar()
    function sbar:Paint(w, h)
        draw.RoundedBox(3, 0, 0, w, h, Color(30, 30, 30, 100))
    end
    function sbar.btnGrip:Paint(w, h)
        draw.RoundedBox(3, 0, 0, w, h, Color(150, 150, 150, 200))
    end
    sbar:SetSize(dcategoryframe:GetWide()*.01, dcategoryframe:GetTall()*.02)
    sbar:SetHideButtons(true)


    for k, v in pairs(wep) do 
        if v.categ == category then
            local but = vgui.Create("KVS.Button", scroll)
            but:Dock(TOP)
            but:DockMargin(0, 0, 5, 10)
            but:SetText(v.name)
            but:SetFont('VED')



            function but:DoClick()
                if IsValid(weaponPanelDpanel) then weaponPanelDpanel:Remove() end
                weaponPanelDpanel = vgui.Create("DPanel", dcategoryframe)
                weaponPanelDpanel:SetSize(dcategoryframe:GetWide()*.35, dcategoryframe:GetTall()*.68)
                weaponPanelDpanel:SetPos(dcategoryframe:GetWide()*.63, dcategoryframe:GetTall()*.1)

                weaponPreview = vgui.Create("DPanel", weaponPanelDpanel)
                weaponPreview:SetSize(weaponPanelDpanel:GetWide()*.7, weaponPanelDpanel:GetTall()*.45)
                weaponPreview:SetPos(weaponPanelDpanel:GetWide()/2 - weaponPreview:GetWide()/2, weaponPanelDpanel:GetTall()*.2)


                local icon = vgui.Create( "SpawnIcon", weaponPreview )
                icon:SetModel( v.model or "models/props/cs_office/cardboard_box03.mdl")
                icon:Dock(FILL)
                icon:DockMargin(0, 0,0, 0)

                function weaponPreview:Paint(w, h)
                    surface.SetDrawColor(9, 132, 227)
                    surface.DrawOutlinedRect(0, 0, w, h, 5)
                end

                function weaponPanelDpanel:Paint(w, h)
                    draw.RoundedBox(3, 0, 0, w, h, Color(52, 73, 94))
                    draw.SimpleText("Arme: " ..v.name, 'VED2', weaponPanelDpanel:GetWide()/2, weaponPanelDpanel:GetTall()*.05, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
                    draw.SimpleText("Rareté: " ..v.rareter, 'VED2', weaponPanelDpanel:GetWide()/2, weaponPanelDpanel:GetTall()*.13, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
                end

                local tblFav = {}

                if file.Exists("prisel_favoris_armes", "DATA") && file.Exists("prisel_favoris_armes/armes_fav.txt", "DATA") then
                    fileFav = file.Read("prisel_favoris_armes/armes_fav.txt")

                    tblFav = string.Explode(";", fileFav)
                end

                local favButton = vgui.Create("KVS.Button", weaponPanelDpanel)
                favButton:SetSize(weaponPanelDpanel:GetWide()*.9, weaponPanelDpanel:GetTall()*.14)
                favButton:SetPos(weaponPanelDpanel:GetWide()/2 - favButton:GetWide()/2, weaponPanelDpanel:GetTall()*.85)

                function favButton:DoClick()
                    local textAppend = file.Read("prisel_favoris_armes/armes_fav.txt")
                    if file.Exists("prisel_favoris_armes", "DATA") and not string.find(textAppend, v.wep) then
                        file.Append("prisel_favoris_armes/armes_fav.txt", ";" .. v.wep)
                    elseif not file.Exists("prisel_favoris_armes", "DATA") then
                        file.CreateDir("prisel_favoris_armes")
                        file.Append("prisel_favoris_armes/armes_fav.txt", v.wep)
                    elseif file.Exists("prisel_favoris_armes", "DATA") and string.find(textAppend, v.wep) then
                        if string.find(textAppend, ";" .. v.wep) then
                            file.Write("prisel_favoris_armes/armes_fav.txt", string.Replace(textAppend, ";" .. v.wep, ""))
                        else
                            file.Write("prisel_favoris_armes/armes_fav.txt", string.Replace(textAppend, v.wep, ""))
                        end
                    end
                end

                function favButton:Paint(w, h)
                    if file.Exists("prisel_favoris_armes", "DATA") && file.Exists("prisel_favoris_armes/armes_fav.txt", "DATA") then
                        fileFav = file.Read("prisel_favoris_armes/armes_fav.txt")
    
                        tblFav = string.Explode(";", fileFav)
                    end
                    self:ApplyColor( )
                    if self.Outlined and not self.NoAnimation then
                        local x = 0
                        local y = 0
                        local bordersize = 8
                        surface.SetDrawColor( self.Color )
                
                        surface.SetTexture( texOutlinedCorner )
                        surface.DrawTexturedRectRotated( x + bordersize / 2 , y + bordersize / 2, bordersize, bordersize, 0 )
                        surface.DrawTexturedRectRotated( x + w - bordersize / 2 , y + bordersize / 2, bordersize, bordersize, 270 )
                        surface.DrawTexturedRectRotated( x + w - bordersize / 2 , y + h - bordersize / 2, bordersize, bordersize, 180 )
                        surface.DrawTexturedRectRotated( x + bordersize / 2 , y + h - bordersize / 2, bordersize, bordersize, 90 )
                
                        surface.DrawLine( x + bordersize, y, x + w - bordersize, y )
                        surface.DrawLine( x + bordersize, y + h - 1, x + w - bordersize, y + h - 1 )
                        surface.DrawLine( x, y + bordersize, x, y + h - bordersize )
                        surface.DrawLine( x + w - 1, y + bordersize, x + w - 1, y + h - bordersize )
                
                    else
                        draw.RoundedBoxEx( self.BorderRadius, 0, 0, w, h, self.Color, unpack( self.BorderRounded ) )

                        if table.HasValue(tblFav, v.wep) then
                            draw.SimpleText("SUPPRIMER FAVORI", 'VED', self:GetWide()/2, self:GetTall()/2, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
                            draw.SimpleText(utf8.char(0xf005), 'FAS', self:GetWide()*.12, self:GetTall()/2, Color(243, 156, 18), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
                        else
                            draw.SimpleText("METTRE EN FAVORI", 'VED', self:GetWide()/2, self:GetTall()/2, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
                            draw.SimpleText(utf8.char(0xf005), 'FAR', self:GetWide()*.12, self:GetTall()/2, Color(243, 156, 18), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
                        end
                    end
                end

                local buttonTake = vgui.Create("KVS.Button", weaponPanelDpanel)
                buttonTake:SetSize(weaponPanelDpanel:GetWide()*.9, weaponPanelDpanel:GetTall()*.14)
                buttonTake:SetPos(weaponPanelDpanel:GetWide()/2 - favButton:GetWide()/2, weaponPanelDpanel:GetTall()*.7)

                function buttonTake:Paint(w, h)
                    self:ApplyColor( )
                    if self.Outlined and not self.NoAnimation then
                        local x = 0
                        local y = 0
                        local bordersize = 8
                        surface.SetDrawColor( self.Color )
                
                        surface.SetTexture( texOutlinedCorner )
                        surface.DrawTexturedRectRotated( x + bordersize / 2 , y + bordersize / 2, bordersize, bordersize, 0 )
                        surface.DrawTexturedRectRotated( x + w - bordersize / 2 , y + bordersize / 2, bordersize, bordersize, 270 )
                        surface.DrawTexturedRectRotated( x + w - bordersize / 2 , y + h - bordersize / 2, bordersize, bordersize, 180 )
                        surface.DrawTexturedRectRotated( x + bordersize / 2 , y + h - bordersize / 2, bordersize, bordersize, 90 )
                
                        surface.DrawLine( x + bordersize, y, x + w - bordersize, y )
                        surface.DrawLine( x + bordersize, y + h - 1, x + w - bordersize, y + h - 1 )
                        surface.DrawLine( x, y + bordersize, x, y + h - bordersize )
                        surface.DrawLine( x + w - 1, y + bordersize, x + w - 1, y + h - bordersize )
                
                    else
                        draw.RoundedBoxEx( self.BorderRadius, 0, 0, w, h, self.Color, unpack( self.BorderRounded ) )
                        draw.SimpleText("PRENDRE L'ARME", 'VED', self:GetWide()/2, self:GetTall()/2, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
                        draw.SimpleText(utf8.char(0xf218), 'FAS', self:GetWide()*.15, self:GetTall()/2, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
                    end
                end

                function buttonTake:DoClick()
                    if LocalPlayer():HasWeapon(v.wep) then notification.AddLegacy("Vous avez déjà cette arme !", NOTIFY_ERROR, 4) return end
                    net.Start("Ekali:Prisel:OnRecup:PermanentWeapon:Net")
                    net.WriteTable(v)
                    net.SendToServer()
                    PrintTable(v)
                end


            end

        function but:Paint(w, h)
            self:ApplyColor( )
                if self.Outlined and not self.NoAnimation then
                    local x = 0
                    local y = 0
                    local bordersize = 8
                    surface.SetDrawColor( self.Color )
            
                    surface.SetTexture( texOutlinedCorner )
                    surface.DrawTexturedRectRotated( x + bordersize / 2 , y + bordersize / 2, bordersize, bordersize, 0 )
                    surface.DrawTexturedRectRotated( x + w - bordersize / 2 , y + bordersize / 2, bordersize, bordersize, 270 )
                    surface.DrawTexturedRectRotated( x + w - bordersize / 2 , y + h - bordersize / 2, bordersize, bordersize, 180 )
                    surface.DrawTexturedRectRotated( x + bordersize / 2 , y + h - bordersize / 2, bordersize, bordersize, 90 )
            
                    surface.DrawLine( x + bordersize, y, x + w - bordersize, y )
                    surface.DrawLine( x + bordersize, y + h - 1, x + w - bordersize, y + h - 1 )
                    surface.DrawLine( x, y + bordersize, x, y + h - bordersize )
                    surface.DrawLine( x + w - 1, y + bordersize, x + w - 1, y + h - bordersize )
            
                else
                    draw.RoundedBoxEx( self.BorderRadius, 0, 0, w, h, self.Color, unpack( self.BorderRounded ) )
                end
            end
        end
    end
end

net.Receive("Ekali:Prisel:PermanentWeapon:PlayerSpawn", function(len, ply)
    local myWep = net.ReadTable()

    local percentD = table.Count(myWep)
    local percentE = table.Count(ArmeConfig.WeaponList)
    local percentage = math.Round((percentD*1)/percentE, 2)

    local validate = Material("materials/prisel_newboutiquematerials/validate.png")

    frame = vgui.Create("KVS.Frame")
    frame:SetTitle("Liste des armes permanentes")
    frame:SetSubTitle("Vous avez " ..table.Count(myWep).." armes sur "..table.Count(ArmeConfig.WeaponList).." armes au total")
    frame:SetToolBarBackgroundColor(Color(22, 92, 146))
    frame:SetSmoothAlpha(true)
    frame:SetMainColor(main_color)
    frame:SetBackgroundColor(Color(10, 61, 98))
    frame:SetSize(ScrW()*.4, ScrH()*.55)
    frame:SetDraggable(false)
    frame:Center()
    frame:MakePopup()
    frame:SetFrameIcon('FAS', 0xf54e, color_main)
    frame:MoveToFront()

    -- local panelInfo = vgui.Create("DPanel", frame)
    -- panelInfo:SetSize(frame:GetWide()*.95, frame:GetTall()*.1)
    -- panelInfo:SetPos(frame:GetWide()/2 - panelInfo:GetWide()/2, frame:GetTall()*.85)

    -- function panelInfo:Paint(w, h)
    --     draw.RoundedBox(3, 0, 0, w, h, Color(35,99,200))
    --     draw.RoundedBox(3, w*.02, h*.2, w*.41, h*.6, Color(38,74,131))
    --     draw.SimpleText("Vous avez "..(percentage*100).."% des armes permanentes !", "VED", w*.03, h*.32, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_LEFT)
    --     draw.RoundedBox(3, w*.535, h*.2, w*.455, h*.6, Color(38,74,131))
    --     draw.SimpleText("De nouvelles fonctionnalités arrivent bientôt !", "VED", w*.545, h*.32, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_LEFT)
    -- end

    local progressPanel = vgui.Create("DProgress", frame)
    progressPanel:SetSize(frame:GetWide()*.9, frame:GetTall()*.09)
    progressPanel:SetPos(frame:GetWide()/2 - progressPanel:GetWide()/2, frame:GetTall()*.85)
    progressPanel:SetFraction(percentage)

    function progressPanel:Paint(w, h)

        local t = self:GetFraction()
        local c = Color(41, 128, 185)
        local b = Color(45, 52, 54)

        draw.RoundedBox(6, 0, 0, w , h, b)
        draw.RoundedBox(6, 0, 0, t * w , h, c)
        if (percentage*100) >= 100 then
            draw.SimpleText("Tu as toutes les armes de la boutique, Fais !nartal (commande secrète)", "VED2", w/2, h/2, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
        else
            draw.SimpleText("Vous avez " .. (percentage*100) .. "% des armes permanentes", "VED2", w/2, h/2, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
        end


    end



    local scroll = vgui.Create( "DScrollPanel", frame )
    scroll:Dock( FILL )
    scroll:DockMargin(20, 10, 15, 10)

    local List = vgui.Create( "DIconLayout", scroll )
    List:Dock( FILL )
    List:SetSpaceY( 5 )
    List:SetSpaceX( 5 )

    for k, v in ipairs(ArmeConfig.Category) do 
        but = vgui.Create("KVS.Button", List)
        but:SetSize(frame:GetWide()*.308, frame:GetTall()*.23)
        but:SetColor(Color(41, 128, 185))

        function but:Paint(w, h)
            self:ApplyColor( )
            if self.Outlined and not self.NoAnimation then
                local x = 0
                local y = 0
                local bordersize = 8
                surface.SetDrawColor( self.Color )
        
                surface.SetTexture( texOutlinedCorner )
                surface.DrawTexturedRectRotated( x + bordersize / 2 , y + bordersize / 2, bordersize, bordersize, 0 )
                surface.DrawTexturedRectRotated( x + w - bordersize / 2 , y + bordersize / 2, bordersize, bordersize, 270 )
                surface.DrawTexturedRectRotated( x + w - bordersize / 2 , y + h - bordersize / 2, bordersize, bordersize, 180 )
                surface.DrawTexturedRectRotated( x + bordersize / 2 , y + h - bordersize / 2, bordersize, bordersize, 90 )
        
                surface.DrawLine( x + bordersize, y, x + w - bordersize, y )
                surface.DrawLine( x + bordersize, y + h - 1, x + w - bordersize, y + h - 1 )
                surface.DrawLine( x, y + bordersize, x, y + h - bordersize )
                surface.DrawLine( x + w - 1, y + bordersize, x + w - 1, y + h - bordersize )
        
            else
                draw.RoundedBoxEx( self.BorderRadius, 0, 0, w, h, self.Color, unpack( self.BorderRounded ) )
            end
            surface.SetDrawColor(color_white)
            surface.SetMaterial(v.icon)
            surface.DrawTexturedRect(but:GetWide()/2 - (but:GetWide()*.32)/2, (but:GetTall()/2 - (but:GetTall()*.61)/2) *1.5, but:GetWide()*.325, but:GetTall()*.615)
            draw.SimpleText(string.upper(v.name), 'VED', but:GetWide()/2, but:GetTall()*.2, main_color, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
        end

        function but:DoClick()
            if IsValid(listearme) then listearme:Remove() end
            if IsValid(dcategoryframe) then dcategoryframe:Remove() end
            if IsValid(dfavoriteButton) then dfavoriteButton:Remove() end
            if IsValid(ChoosePanelAction) then ChoosePanelAction:Remove() end
            OpenWeaponMenu(v.name, myWep)
            frame:MoveTo(ScrW()*.1, ScrH() / 2 - frame:GetTall() / 2, 1, 0, -1)
        end
    end 

    function frame:Think()
        if IsValid(dcategoryframe) then
             return
        else
             frame:Center()
        end
    end




    local favorite = Material("materials/prisel_newboutiquematerials/favorite.png")



end)

hook.Add("OnPlayerChat", "Ekali::EasterEgg::PriselBoutique::CSecretEnFait", function(pl, str)

    if str == "!nartal" then
        if LocalPlayer():GetNWInt("Ekali::Prisel::ArmeP") == table.Count(ArmeConfig.WeaponList) then
            pl:EmitSound("prisel_sound/prisel_secret_sound.wav")
            LocalPlayer():ChatPrint("!nartals pour arrêter la musique")
        else
            LocalPlayer():ChatPrint("Petit malin, c'est dommage..")
        end
        return true
    end

    if str == "!nartals" then
        if LocalPlayer():GetNWInt("Ekali::Prisel::ArmeP") == table.Count(ArmeConfig.WeaponList) then
            pl:StopSound("prisel_sound/prisel_secret_sound.wav")
        else
            LocalPlayer():ChatPrint("Petit malin, c'est dommage..")
        end
        return true
    end
end)
if SERVER then
    util.AddNetworkString("Ekali:Prisel:PermanentWeapon:PlayerSpawn")
    util.AddNetworkString("Ekali:Prisel:OnBuy:PermanentWeapon:Notif")
    util.AddNetworkString("Ekali:Prisel:OnRecup:PermanentWeapon:Net")
    util.AddNetworkString("Ekali:Prisel:OnRecup:PermanentWeaponFav:Net")

    -- Commande
    concommand.Add("prisel_gweapon", function(ply, cmd, args)
        if ply:IsPlayer() then return end

        local stid = args[1]..args[2]..args[3]..args[4]..args[5]
        if not file.Exists('prisel_armeperm', 'DATA') then file.CreateDir('prisel_armeperm') end
        if not file.Exists('prisel_armeperm/' .. args[6] .. '.txt', 'DATA') then file.Write('prisel_armeperm/' .. args[6] .. '.txt', '') end

        file.Append('prisel_armeperm/' .. args[6] .. '.txt', stid..'\n')
    end)

    concommand.Add('prisel_hpperm', function(ply, cmd, args)
        if ply:IsPlayer() then return end
        if not sql.Query('SELECT * FROM prisel_permhp') then 
            sql.Query('CREATE TABLE prisel_permhp( id INT, steamid TEXT )')
            sql.Query('INSERT INTO prisel_permhp(steamid) VALUES("STEAM_0:0:000000000")') 
        end
    
        local stid = args[1]..args[2]..args[3]..args[4]..args[5]
        for k, v in ipairs(sql.Query('SELECT steamid FROM prisel_permhp')) do
            if v.steamid == stid then
                return
            end
        end
        
        sql.Query('INSERT INTO prisel_permhp(steamid) VALUES("' .. stid .. '")')
    end)


    hook.Add('PlayerSpawn', 'Prisel::HP::Permanent::NewBoutique', function(ply)
        if not IsValid(ply) then return end
        if not sql.Query('SELECT * FROM prisel_permhp') then 
            sql.Query('CREATE TABLE prisel_permhp( id INT, steamid TEXT )')
            sql.Query('INSERT INTO prisel_permhp(steamid) VALUES("STEAM_0:0:000000000")') 
        return end
    
        local playerTable = sql.QueryRow("SELECT * FROM prisel_permhp WHERE steamid = '" ..ply:SteamID().."'")
        
        if playerTable then
            
            timer.Simple(1, function()
                ply:SetHealth(200)
            end)

        end

    end)

    concommand.Add('prisel_permarm', function(ply, cmd, args)
        if ply:IsPlayer() then return end
        if not sql.Query('SELECT * FROM prisel_permarmor') then 
            sql.Query('CREATE TABLE prisel_permarmor( id INT, steamid TEXT )')
            sql.Query('INSERT INTO prisel_permarmor(steamid) VALUES("STEAM_0:0:000000000")') 
        end
    
        local stid = args[1]..args[2]..args[3]..args[4]..args[5]
        for k, v in ipairs(sql.Query('SELECT steamid FROM prisel_permarmor')) do
            if v.steamid == stid then
                return
            end
        end
        
        sql.Query('INSERT INTO prisel_permarmor(steamid) VALUES("' .. stid .. '")')
    end)


    hook.Add('PlayerSpawn', 'Prisel::ARMOR::Permanent::NewBoutique', function(ply)
        if not IsValid(ply) then return end
        if not sql.Query('SELECT * FROM prisel_permarmor') then 
            sql.Query('CREATE TABLE prisel_permarmor( id INT, steamid TEXT )')
            sql.Query('INSERT INTO prisel_permarmor(steamid) VALUES("STEAM_0:0:000000000")') 
        return end
    
        local playerTable = sql.QueryRow("SELECT * FROM prisel_permarmor WHERE steamid = '" ..ply:SteamID().."'")
        
        if playerTable then
            
            timer.Simple(1, function()
                ply:SetArmor(200)
            end)

        end

    end)

    -- Code OnSpawn
    hook.Add("PlayerSpawn", "Ekali:Prisel:PermanentWeapon:SpawnPlayer:ShowWeapon", function(ply)
        local files = file.Find('prisel_armeperm/*', 'DATA')
        local counttrue = 0
        local countfalse = 0
        local armed = {}
        for k, v in pairs(files) do
            local content = file.Read('prisel_armeperm/' .. v, 'DATA')
            local lines = string.Split(content, '\n')
            
            for a, b in pairs(lines) do
                if not lines[a] == ply:SteamID() then
                    countfalse = countfalse + 1
                elseif lines[a] == ply:SteamID() then
                    if table.HasValue(armed, string.Replace(v, '.txt', '')) then continue end

                    counttrue = counttrue + 1
    
                    table.insert(armed, counttrue, string.Replace(v, '.txt', ''))
                end
            end
        end

        if k == countfalse then
            net.Start("Ekali:Prisel:PermanentWeapon:PlayerSpawn")
                net.WriteTable({})
            net.Send(ply)
            ply:SetNWInt("Ekali::Prisel::ArmeP", 0)
        else
            net.Start("Ekali:Prisel:PermanentWeapon:PlayerSpawn")
                net.WriteTable(armed)
            net.Send(ply)

            ply:SetNWInt("Ekali::Prisel::ArmeP", counttrue)
        end
    end)

    net.Receive("Ekali:Prisel:OnRecup:PermanentWeapon:Net", function(_, ply)
        local files = file.Find('prisel_armeperm/*', 'DATA')
        local armed = {}
        local counttrue = 0
        for k, v in pairs(files) do
            local f = file.Read('prisel_armeperm/' .. v, 'DATA')
            for a, b in ipairs(string.Split(f, '\n')) do
                if b == ply:SteamID() then
                    if table.HasValue(armed, string.Replace(v, '.txt', '')) then break end

                    counttrue = counttrue + 1

                    table.insert(armed, counttrue, string.Replace(v, '.txt', ''))
                end
            end
        end

        local wep = net.ReadTable()
        if table.HasValue(armed, wep.wep) then
            ply:Give(wep.wep)

            return 
        end
    end)

    -- net.Receive("Ekali:Prisel:OnRecup:PermanentWeaponFav:Net", function(_, ply)
    --     local files = file.Find('prisel_armeperm/*', 'DATA')
    --     local armed = {}
    --     local counttrue = 0
    --     for k, v in pairs(files) do
    --         local f = file.Read('prisel_armeperm/' .. v, 'DATA')
    --         for a, b in ipairs(string.Split(f, '\n')) do
    --             if b == ply:SteamID() then
    --                 if table.HasValue(armed, string.Replace(v, '.txt', '')) then break end

    --                 counttrue = counttrue + 1

    --                 table.insert(armed, counttrue, string.Replace(v, '.txt', ''))
    --             end
    --         end
    --     end

    --     local wep = net.ReadTable()
    --     for k,v in pairs(wep) do 
    --         if table.HasValue(armed, v) then
    --             ply:Give(v)
    --         end
    --     end
    -- end)

    concommand.Add("prisel_addmoney", function(ply, cmd, args)
        local stid = args[1]..args[2]..args[3]..args[4]..args[5]
        local sti64 = util.SteamIDTo64(stid)
        local playerE = player.GetBySteamID(stid)

        if ply:IsPlayer() then return end

        if not playerE then
            if not file.Exists("prisel_money", "DATA") then file.CreateDir("prisel_money") end
            if not file.Exists("prisel_money/" .. sti64..".txt", "DATA") then file.Append("prisel_money/" .. sti64..".txt", args[6]) return end
            if file.Exists("prisel_money", "DATA") and file.Exists("prisel_money/" .. sti64..".txt", "DATA") then
                local openPri = file.Read("prisel_money/" .. sti64..".txt", "DATA")

                file.Write("prisel_money/" .. sti64..".txt", tonumber(openPri) + tonumber(args[6]))
            
            end
        return end
        
        playerE:addMoney(args[6])
        playerE:ChatPrint( "[Prisel-Boutique] Vos " ..args[6].. "€ de money vous ont été ajoutés !" )

    end)

    hook.Add("PlayerInitialSpawn", "Ekali::Boutique::MoneyAdd::OnOffline", function(ply)

        local sti64 = ply:SteamID64()

        if not file.Exists("prisel_money/" .. sti64..".txt", "DATA") then return end
        
        if file.Exists("prisel_money", "DATA") and file.Exists("prisel_money/" .. sti64..".txt", "DATA") then
            local openPri = file.Read("prisel_money/" .. sti64..".txt", "DATA")

            timer.Simple(10, function()
                ply:ChatPrint("[Prisel-Boutique] Vos " .. openPri.. "€ de money ont été acheté quand vous n'étiez pas en ligne ! Ils vous ont donc été ajouté !")
                ply:addMoney(openPri)
            end)

            file.Delete("prisel_money/" .. sti64..".txt")
        
        end

    end)

    concommand.Add("prisel_givejetons", function(ply, cmd, args)
        local stid = args[1]..args[2]..args[3]..args[4]..args[5]
        local sti64 = util.SteamIDTo64(stid)
        local playerE = player.GetBySteamID(stid)

        if ply:IsPlayer() then return end

        if not playerE then
            if not file.Exists("prisel_jetons", "DATA") then file.CreateDir("prisel_jetons") end
            if not file.Exists("prisel_jetons/" .. sti64..".txt", "DATA") then file.Append("prisel_jetons/" .. sti64..".txt", args[6]) return end
            if file.Exists("prisel_jetons", "DATA") and file.Exists("prisel_jetons/" .. sti64..".txt", "DATA") then
                local openPri = file.Read("prisel_jetons/" .. sti64..".txt", "DATA")

                file.Write("prisel_jetons/" .. sti64..".txt", tonumber(openPri) + tonumber(args[6]))
            
            end
        return end
        
        playerE:PS_GivePoints(args[6])
        playerE:ChatPrint( "[Prisel-Boutique] Vos " ..args[6].. " jetons vous ont été ajoutés !" )

    end)

    hook.Add("PlayerInitialSpawn", "Ekali::Boutique::Jetons::OnOffline", function(ply)

        local sti64 = ply:SteamID64()

        if not file.Exists("prisel_jetons/" .. sti64..".txt", "DATA") then return end
        
        if file.Exists("prisel_jetons", "DATA") and file.Exists("prisel_jetons/" .. sti64..".txt", "DATA") then
            local openPri = file.Read("prisel_jetons/" .. sti64..".txt", "DATA")

            ply:PS_GivePoints(tonumber(openPri))
            timer.Simple(10, function()
                ply:ChatPrint("[Prisel-Boutique] Vos " .. openPri.. " jetons ont été acheté quand vous n'étiez pas en ligne ! Ils vous ont donc été ajouté !")
            end)

            file.Delete("prisel_jetons/" .. sti64..".txt")
        
        end

    end)

    concommand.Add('prisel_munperm', function(ply, cmd, args)
        if ply:IsPlayer() then return end
        if not sql.Query('SELECT * FROM prisel_unlimited_ammo') then 
            sql.Query('CREATE TABLE prisel_unlimited_ammo( id INT, steamid TEXT )')
            sql.Query('INSERT INTO prisel_unlimited_ammo(steamid) VALUES("STEAM_0:0:000000000")') 
        end
    
        local stid = args[1]..args[2]..args[3]..args[4]..args[5]
        for k, v in ipairs(sql.Query('SELECT steamid FROM prisel_unlimited_ammo')) do
            if v.steamid == stid then
                return
            end
        end
        
        sql.Query('INSERT INTO prisel_unlimited_ammo(steamid) VALUES("' .. stid .. '")')
    end)

    local list_of_ammo = {
        'pistol',
        '357',
        'buckshot',
        'smg1',
        'ar2',
        'AirboatGun',
        'SniperPenetratedRound',
        'ammo_stungun'
    }
    hook.Add('PlayerSpawn', 'Prisel.Unlimited_Ammo.Hooks.PlayerSpawn', function(ply)
        if not IsValid(ply) then return end
        if not sql.Query('SELECT * FROM prisel_unlimited_ammo') then 
            sql.Query('CREATE TABLE prisel_unlimited_ammo( id INT, steamid TEXT )')
            sql.Query('INSERT INTO prisel_unlimited_ammo(steamid) VALUES("STEAM_0:0:000000000")') 
        return end
    
        local playerTable = sql.QueryRow("SELECT * FROM prisel_unlimited_ammo WHERE steamid = '" ..ply:SteamID().."'")
        
        if playerTable then
            
            timer.Simple(2, function()
              for k, v in ipairs(list_of_ammo) do
                 ply:SetAmmo(9999, v)
               end
             end)

        end
    
    end)

end

resource.AddSingleFile("materials/prisel_newboutiquematerials/knifes.png")
resource.AddSingleFile("materials/prisel_newboutiquematerials/unicorn.png")
resource.AddSingleFile("materials/prisel_newboutiquematerials/pistols.png")
resource.AddSingleFile("materials/prisel_newboutiquematerials/lourdes.png")
resource.AddSingleFile("materials/prisel_newboutiquematerials/shotgun.png")
resource.AddSingleFile("materials/prisel_newboutiquematerials/snipers.png")
resource.AddSingleFile("materials/prisel_newboutiquematerials/boutique.png")
resource.AddSingleFile("materials/prisel_newboutiquematerials/favorite.png")
resource.AddSingleFile("materials/prisel_newboutiquematerials/love.png")
resource.AddSingleFile("resource/fonts/prisel_newshop/right.ttf")
resource.AddFile("sound/prisel_sound/prisel_secret_sound.wav")
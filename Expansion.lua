--- by Xarinia

local NPC_ENTRY = 4800021
local CLASSIC_EXPANSION_ID = 0
local BURNING_CRUSADE_EXPANSION_ID = 1
local WRATH_EXPANSION_ID = 2

function OnHello(event, player, unit)
    local playerId = player:GetAccountId()
    local expansion = GetPlayerExpansion(playerId)

    if expansion == CLASSIC_EXPANSION_ID then
        player:SendBroadcastMessage("Du hast die Classic-Erweiterung.")
        ShowRelogPopup(player)
    elseif expansion == BURNING_CRUSADE_EXPANSION_ID then
        player:SendBroadcastMessage("Du hast die Burning Crusade-Erweiterung.")
        ShowRelogPopup(player)
    elseif expansion == WRATH_EXPANSION_ID then
        player:SendBroadcastMessage("Du hast die Wrath of the Lich King-Erweiterung.")
        ShowRelogPopup(player)
    else
        player:SendBroadcastMessage("Ungültige Expansion.")
    end

    player:GossipMenuAddItem(0, "Erweiterung auf Classic ändern", 0, 1)
    player:GossipMenuAddItem(0, "Erweiterung auf Burning Crusade ändern", 0, 2)
    player:GossipMenuAddItem(0, "Erweiterung auf Wrath of the Lich King ändern", 0, 3)
    player:GossipMenuAddItem(0, "Informationen anzeigen", 0, 4)  
    player:GossipSendMenu(1, unit)
end

function OnSelect(event, player, unit, sender, intid, code)
    if intid == 1 then
        SetPlayerExpansion(player, CLASSIC_EXPANSION_ID)
        player:SendBroadcastMessage("Erweiterung erfolgreich auf Classic geändert.")
        ShowRelogPopup(player)
        KickPlayer(player) 
        player:GossipComplete()
    elseif intid == 2 then
        SetPlayerExpansion(player, BURNING_CRUSADE_EXPANSION_ID)
        player:SendBroadcastMessage("Erweiterung erfolgreich auf Burning Crusade geändert.")
        ShowRelogPopup(player)
        KickPlayer(player)  
        player:GossipComplete()
    elseif intid == 3 then
        SetPlayerExpansion(player, WRATH_EXPANSION_ID)
        player:SendBroadcastMessage("Erweiterung erfolgreich auf Wrath of the Lich King geändert.")
        ShowRelogPopup(player)
        KickPlayer(player)  
        player:GossipComplete()
    elseif intid == 4 then
        ShowInformation(player)
        player:GossipComplete()
    end
end

function ShowInformation(player)
    player:SendBroadcastMessage("Du kannst hier die Erweiterungen jederzeit wechseln für deinen Account, beim Wechsel reloggst du automatisch. Die passenden XP-Stopp NPCs findest du  hier in der Nähe - Behsten+Slahtz).")
    
end

function ShowRelogPopup(player)
    player:SendAreaTriggerMessage("Relogge, um die Änderungen zu übernehmen.")
end

function GetPlayerExpansion(accountId)
    local query = CharDBQuery("SELECT expansion FROM acore_auth.account WHERE id = " .. accountId)
    
    if query then
        return tonumber(query:GetInt32(0))
    else
        return -1
    end
end

function SetPlayerExpansion(player, expansion)
    local accountId = player:GetAccountId()
    CharDBQuery("UPDATE acore_auth.account SET expansion = " .. expansion .. " WHERE id = " .. accountId)
end

function KickPlayer(player)
    player:KickPlayer()
end

RegisterCreatureGossipEvent(NPC_ENTRY, 1, OnHello)
RegisterCreatureGossipEvent(NPC_ENTRY, 2, OnSelect)

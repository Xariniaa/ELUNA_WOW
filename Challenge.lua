--- by Xarinia

local NPC_ENTRY = 4800033
local MAX_ALLOWED_LEVEL = 1
local MAX_GIFT_LEVEL = 75 
local CLASSIC_BUFF_ID = 40974
local GIFT_ITEM_ID = 13582

function OnHello(event, player, unit)
    local playerLevel = player:GetLevel()

    player:GossipClearMenu()

    if playerLevel > MAX_ALLOWED_LEVEL then
        player:GossipMenuAddItem(0, "Geschenk abholen", 0, 2)
        player:GossipMenuAddItem(0, "Buff entfernen", 0, 3)
    else
        player:GossipMenuAddItem(0, "No-Die Challenge starten", 0, 1)
        player:GossipMenuAddItem(0, "Informationen", 0, 2)
    end

    player:GossipSendMenu(1, unit)
end

function OnSelect(event, player, unit, sender, intid, code)
    local playerLevel = player:GetLevel()

    if intid == 1 then
        if playerLevel == 1 then
            player:SendBroadcastMessage("No-Die Challenge gestartet!")
            ApplyClassicBuff(player)
        else
            player:SendBroadcastMessage("Du kannst hier nur ab Stufe 1 die Challenge starten.")
        end
        player:GossipComplete()
    elseif intid == 2 then
        player:SendBroadcastMessage("Du erhältst einen Buff, sobald du diesen Buff verlierst (Tod), kannst du nicht mehr das Geschenk (Mount:Blizzardbär) erhalten. Wenn du Stufe 75 erreichst und den Buff noch hast, kannst du hier das Geschenk abholen. Die Challenge kannst du nur mit Stufe 1 starten.") -- Aktualisierte Stufeninformation
        player:GossipComplete()
    elseif intid == 3 then
        player:RemoveAura(CLASSIC_BUFF_ID)
        player:SendBroadcastMessage("Der Classic Buff wurde entfernt/sofern du ihn hattest.")
        player:GossipComplete()
    end

    if playerLevel >= MAX_GIFT_LEVEL and player:HasAura(CLASSIC_BUFF_ID) then
        player:AddItem(GIFT_ITEM_ID, 1)
        player:SendBroadcastMessage("Du hast ein Geschenk erhalten!")
    end
end

function ApplyClassicBuff(player)
    player:AddAura(CLASSIC_BUFF_ID, player)
    player:SendBroadcastMessage("Du hast den Classic Buff erhalten.")
end

local function OnGossipHello(event, player, unit)
    OnHello(event, player, unit)
end

local function OnGossipSelect(event, player, unit, sender, intid, code)
    OnSelect(event, player, unit, sender, intid, code)
end

RegisterCreatureGossipEvent(NPC_ENTRY, 1, OnGossipHello)
RegisterCreatureGossipEvent(NPC_ENTRY, 2, OnGossipSelect)

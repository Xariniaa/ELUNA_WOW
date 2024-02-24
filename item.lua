--- by Xarinia

local NPC_ID = 5368889

local function OnGossipHello(event, player, object)
    player:GossipMenuAddItem(0, "Ich habe den Hut der Tiefen für dich.", 0, 1)
    player:GossipSendMenu(1, object, 1000)
end

local function OnGossipSelect(event, player, object, sender, intid, code)
    if intid == 1 then
        local hatCount = player:GetItemCount(9429, false)
        local necklaceCount = player:GetItemCount(13583, false)

        if hatCount >= 1 and necklaceCount == 0 then
            player:GossipComplete()
            player:RemoveItem(9429, 1)  
            player:AddItem(13583, 1)    
            player:SendBroadcastMessage("Vielen Dank für den Hut der Tiefen! Hier ist dein Pandahalsband.")
        else
            player:GossipComplete()
            player:SendBroadcastMessage("Du hast nicht die erforderlichen Gegenstände oder hast das Pandahalsband bereits.")
        end
    end
end

RegisterCreatureGossipEvent(NPC_ID, 1, OnGossipHello)
RegisterCreatureGossipEvent(NPC_ID, 2, OnGossipSelect)

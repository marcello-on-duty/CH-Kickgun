RegisterServerEvent("ch_kickgun:checkRole")
AddEventHandler("ch_kickgun:checkRole", function()
    if IsPlayerAceAllowed(source, CH.AcePermsName) then
        TriggerClientEvent("ch_kickgun:returnCheck", source, true)
    else
        TriggerClientEvent("ch_kickgun:returnCheck", source, false)
    end
end)

RegisterServerEvent("ch_kickgun:kick")
AddEventHandler("ch_kickgun:kick", function(kickID, kickREDEN)
    if IsPlayerAceAllowed(source, CH.AcePermsName) then
        local tijd = os.date("%d/%m/%Y %X")
        DropPlayer(kickID, CH.KickMessage..' '.. CH.ServerName ..'\n'.. CH.AdminNameOnKick ..' '..GetPlayerName(source)..'\n '.. CH.KickReason ..' '..kickREDEN..'\n' .. CH.KickDate ..' '.. tijd)
    else
        print("[^1WARNING^0] "..GetPlayerName(source).." tried to trigger the kickgun but has no permissions.")
    end
end)

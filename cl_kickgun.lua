local chkickgun = false
local allowed = false
local passAce = false
local reden = ""

Citizen.CreateThread(function()
    TriggerServerEvent("ch_kickgun:checkRole")
end)

RegisterNetEvent("ch_kickgun:returnCheck")
AddEventHandler("ch_kickgun:returnCheck", function(check)
    passAce = check
end)

local function checkRole()
    if passAce == true then
        allowed = true
        return allowed
    end
end

local function getEntity(player)
	local _, entity = GetEntityPlayerIsFreeAimingAt(player)
	return entity
end

-- Infobox function
function InfoBox(str)
AddTextEntry('HelpMsg', str)
BeginTextCommandDisplayHelp('HelpMsg')
EndTextCommandDisplayHelp(0, false, false, -1)
end

-- Notification function
function sendM(text)
    SetNotificationTextEntry("STRING")
    AddTextComponentString(text)
    DrawNotification(false, false)
end

-- Countdown function
local CHDelay = 0
local CHrunning = false
function StartCountDown()
    CHrunning = true
    Citizen.CreateThread(function()
        Wait(1)
        while CHDelay > 0 do
            CHDelay = CHDelay - 1
            Citizen.Wait(1000)
        end
        CHrunning = false
    end)
end

RegisterCommand(CH.KickgunCommand, function(source, args, rawCommand)
    checkRole()
    if allowed then
        for i, theArg in pairs(args) do
            if i ~= 0 then
                reden = reden .. " " .. theArg
            end
        end
        chkickgun = not chkickgun
        sendM(chkickgun and CH.KickgunActiveMessage or CH.KickGunInactiveMessage)
        reden = not chkickgun and "" or reden
    else
        sendM(CH.NoAccesToKickgun)
    end
end, false)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if chkickgun then
            local message = CH.KickgunWarningMessage .. reden
            if CH.KickgunDelay then
                message = message .. "~n~" .. CH.KickGunDelayMessage
                if CHrunning then
                    message = message .. " " .. CHDelay
                else
                    message = message .. " " .. CH.KickgunDelayReady
                end
            end
            InfoBox(CH.KickGunInfoboxIcon .. "~s~ " .. message)
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1)
        if chkickgun and IsPlayerFreeAiming(PlayerId()) then
            local entity = getEntity(PlayerId())
            local entityowner = NetworkGetEntityOwner(entity)
            local ownerid = GetPlayerServerId(entityowner)
            local ownername = GetPlayerName(entityowner)
            local kickREDEN = reden
            if GetEntityType(entity) == 1 and IsPedShooting(PlayerPedId()) then
                if CH.KickgunDelay and CHDelay == 0 then
                    CHDelay = CH.KickgunDelaySeconds
                    StartCountDown()
                     TriggerServerEvent("ch_kickgun:kick", ownerid, kickREDEN)
                elseif not CH.KickgunDelay then
                     TriggerServerEvent("ch_kickgun:kick", ownerid, kickREDEN)
                else
                    sendM(CH.KickGunDelayCantKick1 .." "..CHDelay.." ".. CH.KickGunDelayCantKick2)
                end
            end
        elseif not chkickgun then
            Citizen.Wait(200)
        end
    end
end)
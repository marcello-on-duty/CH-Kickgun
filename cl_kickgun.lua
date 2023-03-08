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
    if allowed == true then

      for i,theArg in pairs(args) do
         if i ~= 0 then
            reden = reden.." "..theArg
        end
    end
    if chkickgun == false then
        chkickgun = true
        sendM(CH.KickgunActiveMessage)
        Citizen.Wait(1)
    else
        chkickgun = false
        sendM(CH.KickGunInactiveMessage)
        reden = ""
    end
else
    sendM(CH.NoAccesToKickgun)
end
end, false)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if chkickgun and not CH.KickgunDelay then
            InfoBox(CH.KickGunInfoboxIcon .."~s~ ".. CH.KickgunWarningMessage .."".. reden)
        elseif chkickgun and CH.KickgunDelay then
            if CHrunning then
                InfoBox(CH.KickGunInfoboxIcon .."~s~ ".. CH.KickgunWarningMessage .."".. reden .."~n~".. CH.KickGunDelayMessage .." ".. CHDelay) 
            else
                InfoBox(CH.KickGunInfoboxIcon .."~s~ ".. CH.KickgunWarningMessage .."".. reden .."~n~".. CH.KickGunDelayMessage .." ".. CH.KickgunDelayReady) 
            end
        elseif not chkickgun then
            Citizen.Wait(200)
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1)
        if chkickgun then
            if IsPlayerFreeAiming(PlayerId()) then
                local entity = getEntity(PlayerId())
                local entityowner = NetworkGetEntityOwner(entity)
                local ownerid = GetPlayerServerId(entityowner)
                local ownername = GetPlayerName(entityowner)
                local kickREDEN = reden
                if GetEntityType(entity) == 1 then
                 if IsPedShooting(PlayerPedId()) then
                   if CH.KickgunDelay and CHDelay == 0 then
                      TriggerServerEvent("ch_kickgun:kick", ownerid, kickREDEN)
                      CHDelay = CH.KickgunDelaySeconds
                      StartCountDown()
                  elseif not CH.KickgunDelay then
                   TriggerServerEvent("ch_kickgun:kick", ownerid, kickREDEN)
               else
                sendM(CH.KickGunDelayCantKick1 .." "..CHDelay.." ".. CH.KickGunDelayCantKick2)
            end
        end
    end
end
elseif not chkickgun then
 Citizen.Wait(200)
end
end
end)
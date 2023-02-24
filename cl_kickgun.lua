local chkickgun = false
local allowed = false
local passAce = false
local onAim = "false" -- Dont change, this wil kick the player on aiming!
local useAce = "true"
local reden = ""
local CHDelay = 0
local CHrunning = false
local playerPed = PlayerPedId()

Citizen.CreateThread(function()
    if useAce == "true" then
        TriggerServerEvent("ch_kickgun:checkRole")
    end
end)

RegisterNetEvent("ch_kickgun:returnCheck")
AddEventHandler("ch_kickgun:returnCheck", function(check)
    passAce = check
end)

local function checkRole()
    if useAce == "false" then
        allowed = true
        return allowed
    end
    if passAce == true then
        allowed = true
        return allowed
    end
end

local function getEntity(player)
	local _, entity = GetEntityPlayerIsFreeAimingAt(player)
	return entity
end

local function aimCheck(player)
    if onAim == "true" then
        return true
    else
        return IsPedShooting(player)
    end
end

-- This is your top-left infobox
function InfoBox(str)
	SetTextComponentFormat("STRING")
	AddTextComponentString(str)
	DisplayHelpTextFromStringLabel(0, 0, 0, -1)
end

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
    SetCanAttackFriendly(playerPed, true, true)
else
    chkickgun = false
    sendM(CH.KickGunInactiveMessage)
    reden = ""
    SetCanAttackFriendly(playerPed, false, false)
end
else
    sendM(CH.NoAccesToKickgun)
end
end, false)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if chkickgun and CH.KickgunDelay == false then
            InfoBox("~BLIP_INFO_ICON~~s~ ".. CH.KickgunWarningMessage .."".. reden)
        elseif chkickgun and CH.KickgunDelay == true then
            if CHrunning == true then
                InfoBox("~BLIP_INFO_ICON~~s~ ".. CH.KickgunWarningMessage .."".. reden .."~n~".. CH.KickGunDelayMessage .." ".. CHDelay) 
            else
                InfoBox("~BLIP_INFO_ICON~~s~ ".. CH.KickgunWarningMessage .."".. reden .."~n~".. CH.KickGunDelayMessage .." ".. CH.KickgunDelayReady) 
            end
        elseif chkickgun == false then
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
                   if aimCheck(GetPlayerPed(-1)) then
                     if CH.KickgunDelay == true and CHDelay == 0 then
                      TriggerServerEvent("ch_kickgun:kick", ownerid, kickREDEN)
                      CHDelay = CH.KickgunDelaySeconds
                      StartCountDown()
                  elseif CH.KickgunDelay == false then
                     TriggerServerEvent("ch_kickgun:kick", ownerid, kickREDEN)
                 else
                    sendM(CH.KickGunDelayCantKick1 .." "..CHDelay.." ".. CH.KickGunDelayCantKick2)
                end
            end
        end
    end
elseif chkickgun == false then
   Citizen.Wait(200)
end
end
end)
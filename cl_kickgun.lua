local chkickgun = false
local allowed = false
local passAce = false
local onAim = "false"
local useAce = "true"
local reden = ""

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

local function getEntity(player) -- function To Get Entity Player Is Aiming At
	local _, entity = GetEntityPlayerIsFreeAimingAt(player)
	return entity
end

local function aimCheck(player) -- function to check config value onAim. If it's off, then
    if onAim == "true" then
        return true
    else
        return IsPedShooting(player)
    end
end

function DisplayHelpText(str)
	SetTextComponentFormat("STRING")
	AddTextComponentString(str)
	DisplayHelpTextFromStringLabel(0, 0, 0, -1)
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
        local playerPed = PlayerPedId()
        SetCanAttackFriendly(playerPed, true, true)
    else
        chkickgun = false
        sendM(CH.KickGunInactiveMessage)
        reden = ""
        local playerPed = PlayerPedId()
        SetCanAttackFriendly(playerPed, false, false)
    end
else
    sendM(CH.NoAccesToKickgun)
end
end, false)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if chkickgun and CH.KickgunWarning == true then
            DisplayHelpText("~h~!~s~ ".. CH.KickgunWarningMessage .."".. reden)
        elseif chkickgun == false then
            Citizen.Wait(2500)
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
                      TriggerServerEvent("ch_kickgun:kick", ownerid, kickREDEN)
                  end
              end
          end
      elseif chkickgun == false then
       Citizen.Wait(600)
   end
end
end)
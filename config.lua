CH = {}

-- Will print in the console that CH-Kickgun is ready for use (standard true).
CH.ConsoleAnnoune = true

-- This will be the ACE Perms name for your group(s).
CH.AcePermsName = "CH.Kickgun"

-- This will be your in-game slash command
CH.KickgunCommand = "kickgun"

-- Language
CH.KickMessage = "⚪ You are kicked from"
CH.ServerName = "SERVERNAME"
CH.AdminNameOnKick = "⚪ Admin:"
CH.KickReason = "⚪ Reason:"
CH.KickDate = "⚪ Date:"
CH.NoAccesToKickgun = "You dont have permissions for this"
CH.KickgunActiveMessage = "Kickgun ~g~ON~s~!"
CH.KickGunInactiveMessage = "Kickgun ~b~OFF~s~!"

-- This wil show a warning top-left that the kickgun is active with the reason you entered. (This option will give 0.03 resmon more)
CH.KickgunWarning = true
CH.KickgunWarningMessage = "The Kickgun is ~g~active!~s~~n~Reason:"

-- This is your standard ESX.ShowNotification function, change this only if you know what you are doing!
-- Dont change the function name called "sendM(text)" else the notifications dont work.
function sendM(text) -- < Dont change
	SetNotificationTextEntry("STRING")
	AddTextComponentString(text)
	DrawNotification(false, false)
end
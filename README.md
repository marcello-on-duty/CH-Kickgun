![kickgunpreviewbig|690x388](https://cdn.discordapp.com/attachments/1078248796896641145/1078248930850119721/96b94b41b6d2c3c4e84645f77ec77392b082caa6.jpg)
# Kickgun for FiveM
### Video Showcase: [YouTube - Kickgun ](https://www.youtube.com/watch?v=aAeXMfHLKKg)

Want to kick players in style? now its possible with the kickgun!
Shoot at a player and it will kick them with the reason you entered.

* Easy configuration with instructions on how to change everything.
* Works with al shooting guns.
* This resource is working with ESX and Ace Perms.
* A lot of options in the config.lua
* Anti trigger (will print the modders name in the console when they dont have the right permissions).
* This resource is using the Asset Escrow system (only config.lua accessibility) .
* Resmon idle 0.0ms.
* Resmon with all the options turn on and /kickgun is active: 0.06ms.
* Resmon with top-left warning off and /kickgun is active: 0.03ms.

**Standard Command:**
/kickgun [reason]
*use /kickgun again to turn off kickgun.*
Example: 
```
/kickgun Using bad words! Read our server rules before you join us back!
```

**How to use:**
This Resource is using Ace perms, you can change the name in the config.
```lua
-- this is an example for permission setup
add_principal identifier.discord:YOURDISCORDID group.admin 
add_ace group.admin CH.Kickgun allow
```



![kickgunpreviewbig|690x388](https://media.discordapp.net/attachments/1115592251767271457/1115592507259109496/kickgun_banner.png?width=1193&height=671)


# Kickgun for FiveM [(Showcase on YouTube)](https://www.youtube.com/watch?v=aAeXMfHLKKg)


Want to kick players in style? now its possible with the kickgun!

Shoot at a player and it will kick them with the reason you entered.

* Easy configuration with instructions in config.lua
* Delay options
* Language options
* Works with al shooting guns.
* Anti server trigger (if a hacker triggers the server event).
* Client resmon idle: 0.0ms.
* Client resmon when /kickgun is active: 0.06ms.
* **This resource is working with ESX and Ace Perms.**

**Standard Command:**

/kickgun [reason]

*Use /kickgun again to turn off kickgun.*

Example:

```

/kickgun Using bad words! Please read our server rules before you join us back!

```

**What the player see when kicked:**
![kickmessage|690x388](https://media.discordapp.net/attachments/1115592251767271457/1115919689093226556/image.png)
**How to use:**

This Resource is using Ace Perms, you can change the name in the config.

```lua

-- this is an example for permission setup

add_principal identifier.discord:YOURDISCORDID group.admin

add_ace group.admin CH.Kickgun allow

```

*[The YouTube video](https://www.youtube.com/watch?v=aAeXMfHLKKg) does not show the new delay function, maybe i will upload a updated video soon.






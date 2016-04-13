# HideUI
A simple UI toggle hotkey with manual and automatic modes for Fallout 4

Like many, I dislike seeing the full HUD while I’m exploring. Fallout 4 Script Extender doesn't have any UI functions yet, so I dug in and started experimenting to see what I could do without it to hold me over.  This is the end result, and I’m very happy with it!  It isn't as flexible as something like iHUD for Skyrim, but not much can be done until F4SE is updated to give UI controls.  However, combined with other HUD/crosshair mods, and opacity tweaks, it'll definitely hold you over.  It’s extremely lightweight and highly functional and does NOT effect the Pip-Boy!

---------------------------------------------------
WHAT IT DOES / HOW IT WORKS
---------------------------------------------------
HideUI adds two aid items to your inventory automatically after installing: HideUI - Controller, and HideUI - Configuration.  HideUI Controller can simply be clicked from your inventory to toggle, but is made to be assigned to a favorites hotkey for use in real-time.  But it doesn't stop there!  HideUI has two modes, and two HUD styles, which can be configured in game by activating the HideUI Configuration aid:

HUD MODES

• MANUAL: Use a favorites hotkey to turn the HUD on and off whenever you want.

• AUTOMATIC: Automatically hides the HUD when you're not in combat, instantly turns it on when you are.

HUD STYLES

• BASIC (default): Hides health, compass, action points, enemy name/health, sneak meter.  Retains messages, crosshair, quick loot.

• HARDCORE: Hides EVERYTHING.  Great for exploring.  While hidden, quick-loot reverts back to requiring E to open containers.

MISC CONFIG

• Reset, and Uninstall options make removal mid-game completely safe and painless (see FAQ)

---------------------------------------------------
ADDITIONAL IMPORTANT INFORMATION
---------------------------------------------------
POWER ARMOR - This also works with Power Armor, but only Manual toggle mode.  In Auto Mode, the Power Armor HUD will stay on while you're using it, regardless if you're in combat or not.  I actually prefer this anyway, but this is due to the engine not handling conditions or script events properly when entering/exiting Power Armor, so I disabled Auto Mode while in PA.  It's easy enough to switch to Manual Mode anyway.

HUD WHEN AIMING - Using either Basic or Hardcore HUD styles, the HUD elements will show up while you're aiming down the sights with your weapon.  This is built into the engine and I can't do anything about this right now, but it's minor.  I like to see my HUD when I'm in combat anyhow.  It stops when you're not aiming.

"HARDCORE" HUD MODE and WORKSHOP CONTAINERS - If you're in "hardcore" HUD mode and use E to open a Workshop container directly, it will open the container AND activate the Workshop at the same time, and confuses the mouse (have to TAB out of the menu).  Toggling the UI on before interacting with the Workshop container has no problems, so it's best to do that.  Because I'm using engine functions I don't know that I can hook into these events to refine them, but rest assured I'm looking at it.  Minor annoyance, IMO because again, it's not Workshop mode (holding V) but looking into the Workshop storage container.

---------------------------------------------------
INSTALLATION
---------------------------------------------------

• BACKUP YOUR SAVE!  ALWAYS DO THIS!

• Do not install until after you've left Vault 111!  Items that are added to the inventory before the Sole Survivor gets their Pip-Boy and exits the vault are removed by the game.  This means you'll have to disable the mod when starting a new game until you leave the vault as well.  I'm looking at refining this so the items are added automatically as soon as you leave, stay tuned.

• MAKE SURE YOUR INI SETTINGS ARE CORRECT TO LOAD ALL FILES/FOLDERS!  I still see many users suffering from incorrect settings. Read this and follow it very closely!

• From there, simply install using NMM, or drag and drop the files into your /DATA/ folder and activate the ESP in the Fallout 4 Launcher.

• When you load your game after installing, the required items will be added to your inventory automatically.
UNINSTALL: Click HideUI - Configuration in your inventory, click Uninstall, click "Yes", save your game and quit.  Do not do this unless you are absolutely going to remove the mod.

---------------------------------------------------
F.A.Q. (Frequently Asked Questions) - Please Read!
---------------------------------------------------
Q: Is this safe to add mid-game?  What about removal?
A: Yes and yes!  Can be added at any time.  If you decide you do not like it, you can just revert your save OR use the Uninstall option from the Configuration.

Q: Can I customize exactly what gets turned off and on?
A: Unfortunately not yet.  This uses some rare engine code that has specific UI modes which cannot be fine-tuned just yet, and until F4SE is updated with UI controls, there's no way to access each UI element individually.

Q: Does this work with XYZ HUD mod?
A: Yes!  This does not edit any interface files / SWFs at all, so it is 100% compatible with every currently available HUD mod.

Q: How heavy are the scripts?
A: They're not at all, this mod is about as light as the code it takes to open a door.  The bulk of the mod is so tiny, it almost makes me blush.  Just a few lines of code in all.  The configuration code is the biggest part.  It uses pure engine conditions, effects, and standard OnActivate script events, so there are NO unsafe update loops, hacks, or weird workarounds.  No performance impact, safe to add/remove at any time.

Q: How did you do this without F4SE and the CK??
A: Determination will get you far!  I dug into the source code and found some very rare methods I could exploit to control some parts of the UI.  Praise the geniuses behind FO4Edit, Caprica, and Champollion.  When F4SE has UI functions, more detailed and configurable HUD mods will emerge.

ScriptName HideUIConfigScript extends ActiveMagicEffect
{HideUI In-Game Configuration Menus}
;fadingsignal 2016

;==========================================================================
;
; YOU SNEAKY SAUSAGE!  I SEE YOU!  That's OK, I learned a lot from reverse-engineering other's code :P
;
;==========================================================================

GlobalVariable Property CurrentHUDState Auto
GlobalVariable Property ConfigHUDMode Auto
GlobalVariable Property ConfigHUDStyle Auto

Message Property MESG_HUDConfiguration01 Auto
Message Property MESG_HUDConfigurationMode01 Auto
Message Property MESG_HUDConfigurationMode02 Auto
Message Property MESG_HUDConfigurationStyle01 Auto
Message Property MESG_HUDConfigurationStyle02 Auto
Message Property MESG_HUDConfigurationReset01 Auto
Message Property MESG_HUDConfigurationUninstall01 Auto

Form Property HideUIAidConfiguration Auto
Form Property HideUIAidController Auto
Spell Property HideUIAutomaticSpell Auto

Function OnEffectStart(Actor akTarget, Actor akCaster)
	;ToggleHUD()
	akTarget.AddItem(HideUIAidConfiguration, 1, True)
	ShowConfigMenuMain()
EndFunction

Function ShowConfigMenuMain(Int iButton = 0)

	iButton = MESG_HUDConfiguration01.Show(0, 0, 0, 0, 0, 0, 0, 0, 0)

	If iButton == 0 ;Select HUD Mode
		ShowModeMenu()
	ElseIf iButton == 1 ;Select HUD Style
		ShowStyleMenu()
	ElseIf iButton == 2 ;Reset HideUI
		ShowResetMenu()
	ElseIf iButton == 3 ;Uninstall
		ShowUninstallMenu()
	ElseIf iButton == 4 ;Do Nothing & Exit
		;Exit
	EndIf
	
EndFunction


Function ShowModeMenu(Int iButton = 0)

	Actor playerRef = Game.GetPlayer()

	;"Enum" Values: 
	;0 is Manual mode
	;1 is Automatic mode (shows HUD when in combat, hides when not)
	
	If (ConfigHUDMode.GetValue() as Int == 0)
		iButton = MESG_HUDConfigurationMode01.Show(0, 0, 0, 0, 0, 0, 0, 0, 0)
	ElseIf(ConfigHUDMode.GetValue() as Int ==1)
		iButton = MESG_HUDConfigurationMode02.Show(0, 0, 0, 0, 0, 0, 0, 0, 0)
	EndIf

	If iButton == 0 ;Manual
		ConfigHUDMode.SetValue(0)
		
		playerRef.RemoveSpell(HideUIAutomaticSpell)
		
		If(playerRef.GetItemCount(HideUIAidController))
			playerRef.RemoveItem(HideUIAidController, 999, True, None)
		EndIf
		playerRef.AddItem(HideUIAidController, 1, True)
		
		ResetHud()		
		ShowModeMenu()
		
	ElseIf iButton == 1 ;Automatic
		ConfigHUDMode.SetValue(1)
		
		ResetHud()
		AddRecycleSpell() ;also adds the spell if it doesn't exist
		
		If(playerRef.GetItemCount(HideUIAidController))
			playerRef.RemoveItem(HideUIAidController, 999, True, None)
		EndIf

		ShowModeMenu()
		
	ElseIf iButton == 2 ;Back to Main Menu
		ShowConfigMenuMain()
	EndIf
	
EndFunction

Function ShowStyleMenu(Int iButton = 0)

	;"Enum" Values: These are passed in as literal values into the UI functions so they're enumerated to match
	;0 vanilla
	;1 Basic (hides all but crosshair, quick loot, messages, hover / activate actions
	;3 Hardcore (hides ALL UI elements, including crosshair, messages, quick loot, hover)

	If (ConfigHUDStyle.GetValue() as Int == 1)
		iButton = MESG_HUDConfigurationStyle01.Show(0, 0, 0, 0, 0, 0, 0, 0, 0)
	ElseIf(ConfigHUDStyle.GetValue() as Int ==3)
		iButton = MESG_HUDConfigurationStyle02.Show(0, 0, 0, 0, 0, 0, 0, 0, 0)
	EndIf

	;BUG: AddRecycleSpell() fails because it removes/adds too fast.  If I put debug.notification between remove/add, it works!! I can't use Utility.Wait because it makes the menu disappear.  Fuck!
	
	If iButton == 0 ;Default / Basic
	
		ConfigHUDStyle.SetValue(1)
		
		;Recycle the spell if settings change to make sure the UI mode changes
		If(ConfigHUDMode.GetValue() As Int == 1)
			AddRecycleSpell()
		ElseIf(ConfigHUDMode.GetValue() As Int == 0)
			RecycleUIMode()
		EndIf
		
		ShowStyleMenu()
		
	ElseIf iButton == 1 ;Hardcore
	
		ConfigHUDStyle.SetValue(3)

		;Recycle the spell if settings change to make sure the UI mode changes
		If(ConfigHUDMode.GetValue() As Int == 1)
			AddRecycleSpell()
		ElseIf(ConfigHUDMode.GetValue() As Int == 0)
			RecycleUIMode()
		EndIf
		
		ShowStyleMenu()
		
	ElseIf iButton == 2 ;Back to Main Menu
		ShowConfigMenuMain()
	EndIf

EndFunction

Function ResetHUD()
	CurrentHUDState.SetValue(0)
	Game.SetCharGenHudMode(0)
EndFunction

Function RecycleUIMode()
	;debug.notification("cycling UI mode")
	CurrentHUDState.SetValue(0)
	Game.SetCharGenHudMode(0)
	
	CurrentHUDState.SetValue(ConfigHUDStyle.GetValue() as Int)
	Game.SetCharGenHudMode(ConfigHUDStyle.GetValue() as Int)
EndFunction

Function AddRecycleSpell()
	Actor playerRef = Game.GetPlayer()
	
	;debug.notification("removing spell")
	playerRef.RemoveSpell(HideUIAutomaticSpell)
	
	debug.notification("HideUI: Settings Updated")
	playerRef.AddSpell(HideUIAutomaticSpell, False)
EndFunction

Function ShowResetMenu(Int iButton = 0)

	Actor playerRef = Game.GetPlayer()

	iButton = MESG_HUDConfigurationReset01.Show(0, 0, 0, 0, 0, 0, 0, 0, 0)

	If iButton == 0 ;Reset
		playerRef.RemoveSpell(HideUIAutomaticSpell)
		debug.notification("HideUI: Resetting...")
		playerRef.RemoveItem(HideUIAidController, 999, True, None)		
		playerRef.RemoveItem(HideUIAidConfiguration, 999, True, None)		
		CurrentHUDState.SetValue(0)
		ConfigHUDMode.SetValue(0)
		ConfigHUDStyle.SetValue(1)	
		Game.SetCharGenHudMode(0)
		
		playerRef.AddItem(HideUIAidController, 1, True)
		playerRef.AddItem(HideUIAidConfiguration, 1, True)
		debug.notification("HideUI is fully reset to defaults.")
	Else
		ShowConfigMenuMain()
	EndIf
EndFunction

Function ShowUninstallMenu(Int iButton = 0)
	Actor playerRef = Game.GetPlayer()

	iButton = MESG_HUDConfigurationUninstall01.Show(0, 0, 0, 0, 0, 0, 0, 0, 0)
	
	If iButton == 0 ;Reset
		playerRef.RemoveSpell(HideUIAutomaticSpell)
		debug.notification("HideUI: Uninstalling...")
		playerRef.RemoveItem(HideUIAidController, 999, True, None)		
		playerRef.RemoveItem(HideUIAidConfiguration, 999, True, None)		
		CurrentHUDState.SetValue(0)
		ConfigHUDMode.SetValue(0)
		ConfigHUDStyle.SetValue(1)	
		Game.SetCharGenHudMode(0)
		debug.notification("HideUI: Uninstall complete.  You may save, quit, and remove HideUI.")
	Else
		ShowConfigMenuMain()
	EndIf
EndFunction

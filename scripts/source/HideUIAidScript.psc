ScriptName HideUIAidScript extends  ActiveMagicEffect
{Switches UI modes, showing only the crosshair.}
;fadingsignal 2016

;==========================================================================
;
; YOU SNEAKY SAUSAGE!  I SEE YOU!  That's OK, I learned a lot from reverse-engineering other's code :P
;
;==========================================================================

GlobalVariable Property CurrentHUDState Auto
GlobalVariable Property ConfigHUDMode Auto
GlobalVariable Property ConfigHUDStyle Auto
Bool Property ForceDisplayToggle Auto
Form Property HideUIAidController Auto

Function OnEffectStart(Actor akTarget, Actor akCaster)
	If(ConfigHUDMode.GetValue() as Int == 0) ;manual mode
		ToggleHUD()
		akTarget.AddItem(HideUIAidController, 1, True)		
	ElseIf(ConfigHUDMode.GetValue() as Int == 1) ;automatic mode
		SetHUD(ForceDisplayToggle)
	EndIf
EndFunction

Function ToggleHUD()
		If(CurrentHUDState.GetValue() as Int == 0)
			Game.SetCharGenHudMode(ConfigHUDStyle.GetValue() as Int)
			CurrentHUDState.SetValue(ConfigHUDStyle.GetValue() as Int)
		Else
			Game.SetCharGenHudMode(0)
			CurrentHUDState.SetValue(0)		
		EndIf
EndFunction

Function SetHUD(bool showHud)
	If(showHud)
		Game.SetCharGenHudMode(0)
		CurrentHUDState.SetValue(0)
	Else
		Game.SetCharGenHudMode(ConfigHUDStyle.GetValue() as Int)
		CurrentHUDState.SetValue(ConfigHUDStyle.GetValue() as Int)
	EndIf
EndFunction

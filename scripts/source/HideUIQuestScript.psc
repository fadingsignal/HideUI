ScriptName HideUIQuestScript extends Quest
{Simply used to add required items to player}

Form Property HideUIAidConfiguration Auto
Form Property HideUIAidController Auto

Function OnInit()
	;debug.notification("Hello")
EndFunction

Function OnQuestInit()
	Actor playerRef = Game.GetPlayer()
	debug.notification("HideUI: Initializing")
	
	playerRef.RemoveItem(HideUIAidController, 999, True, None)		
	playerRef.RemoveItem(HideUIAidConfiguration, 999, True, None)
	
	playerRef.AddItem(HideUIAidConfiguration, 1, False)
	playerRef.AddItem(HideUIAidController, 1, False)
	
	;Stop the quest, no need for it to continue
	Self.Stop()
EndFunction

Function OnQuestShutdown()
	;debug.notification("HideUI Quest Stopped")
EndFunction

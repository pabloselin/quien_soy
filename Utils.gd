extends Node

func updatePlayerObject(playerkey, property, value):
	GameVars.playerProps[keyToPlayer(playerkey)][property] =  value
	
func keyToPlayer(playerkey):
	return "player" + str(playerkey + 1)
	
func getActivePlayers():
	var activePlayers = []
	# Returns an array of active players
	for i in GameVars.playerProps.size():
		var curplayer = "player" + str(i+1)
		if GameVars.playerProps[curplayer]["active"] == true:
			activePlayers.push_back(curplayer)
	print(str(activePlayers))
	return activePlayers
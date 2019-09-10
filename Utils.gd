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
	return activePlayers
	
func randomizePlayersOrder():
	var activePlayers = getActivePlayers()
	randomize()
	var shuffledPlayers = activePlayers
	shuffledPlayers.shuffle()
	for i in shuffledPlayers.size():
		GameVars.playersOrder.push_back(shuffledPlayers[i])

func getPlayerTurn():
	if GameVars.playersOrder.size() > 0:
		GameVars.currentPlayer = GameVars.playersOrder.front()
		GameVars.playersOrder.pop_front()
	return GameVars.currentPlayer

func playerHasAvatar(player):
	if GameVars.playerProps[player].head != null:
		return true
	else:
		return false
		
func allPlayersHaveAvatars():
	var players = GameVars.playersOrder
	var allHaveAvatars = true
	for i in players.size():
		if !playerHasAvatar(players[i]):
			allHaveAvatars = false
	return allHaveAvatars
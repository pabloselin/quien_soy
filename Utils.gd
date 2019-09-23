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
	if allHaveAvatars == true:
		GameVars.transitionType = "minigame"
	return allHaveAvatars

func getPlayerScore(player):
	return GameVars.playerProps[player]["wins"]
	
func getPlayerLoses(player):
	return GameVars.playerProps[player]["loses"]
	
func getPlayerGamesPlayed(player):
	return getPlayerScore(player) + getPlayerLoses(player)

func getTotalGamesPlayed():
	var players = ["player1", "player2", "player3", "player4"]
	var total = 0
	for i in players.size():
		total += getPlayerScore(players[i]) + getPlayerLoses(players[i])
	return total
	
func getTotalGamesAllowed():
	return GameVars.activePlayers().size() * 5
	
func isGameFinished():
	var activePlayers = GameVars.activePlayers()
	var playersFinished = 0
	print("checkfinish")
	for i in activePlayers.size():
		print(str(getPlayerGamesPlayed(activePlayers[i])))
		if getPlayerGamesPlayed(activePlayers[i]) == GameVars.gamesPerPlayer:
			playersFinished += 1
	if playersFinished == activePlayers.size():
		return true
	else:
		return false
		
				
func buildName(player):
	randomize()
	var randKey = randi() % GameVars.nameList.size()
	var pickName = GameVars.nameList[randKey]
	GameVars.nameList.remove(randKey)
	var pickColor = GameVars.playerProps[player]["color"]["name"]
	
	return pickName + " " + pickColor
	
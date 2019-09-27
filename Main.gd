extends Node

onready var camara = $Camera2D
onready var tween = $CameraTween
var isPlaying = false
var playerNames = []
onready var gameprompt = $Container/GamePrompt

func _ready():
	#Shuffle again the players
	Utils.randomizePlayersOrder()
	Utils.allPlayersHaveAvatars()
	var player = Utils.getPlayerTurn()
	var playerTurns = preload("res://PlayerTurns.tscn").instance()
	var playerPrompt = preload("res://PlayerPrompt.tscn").instance()
	playerNames = [GameVars.playerProps["player1"]["name"], GameVars.playerProps["player2"]["name"] ,GameVars.playerProps["player3"]["name"], GameVars.playerProps["player4"]["name"]]
	putPlayerNames()
	
	if GameVars.transitionType == "avatar":
		$Sonidos/AvatarPrompt.play()
		gameprompt.text = "Crea tu avatar"
	elif GameVars.transitionType == "minigame":
		$Sonidos/Acelerate.play()
		gameprompt.text = "A jugar!"

	playerPrompt.init(player)
	#playerTurns.init(player)
	#var turns = add_child(playerTurns)
	var prompt = add_child(playerPrompt)
	
	playerPrompt.position = Vector2(1080, 400)
	#playerTurns.position = Vector2(1080, 700)
	$Fondo.modulate = GameVars.playerProps[player]["color"]["value"]
	zoomToMain()
	yield(get_tree().create_timer(2), "timeout")
	zoomToPlayer(player)
	
	
# Zooms to selected player position
func zoomToPlayer(player):
	tween.interpolate_property(camara, "zoom", GameVars.initialZoom, GameVars.activePlayerZoom, 0.7, Tween.TRANS_LINEAR, Tween.EASE_IN)
	tween.interpolate_property(camara, "position", camara.position, GameVars.playerPositions[player], 0.6, Tween.TRANS_LINEAR, Tween.EASE_IN)
	tween.start()
#	camara.position = GameVars.playerPositions[player]
#	camara.zoom = GameVars.activePlayerZoom
	
# Zooms back to main view	
func zoomToMain():
	tween.interpolate_property(camara, "zoom", camara.get_zoom(), GameVars.initialZoom, 1, Tween.TRANS_SINE, Tween.EASE_OUT)
	tween.interpolate_property(camara, "position", camara.position, GameVars.initialCameraPosition, 0.4, Tween.TRANS_LINEAR, Tween.EASE_IN) 
	tween.start()
#	camara.position = GameVars.initialCameraPosition
#	camara.zoom = GameVars.initialZoom

func _on_CameraTween_tween_all_completed():
	#yield(get_tree().create_timer(1.0), "timeout")
	# Check created avatars
	yield(get_tree().create_timer(2), "timeout")
	if Utils.allPlayersHaveAvatars():
		get_tree().change_scene("res://minigames/MiniGameBase.tscn")
	else:
		get_tree().change_scene("res://AvatarRoulette.tscn")

func putPlayerNames():
	var playerLabels = [$PlayerNames/Player1Container/PlayerName, $PlayerNames/Player2Container/PlayerName, $PlayerNames/Player3Container/PlayerName, $PlayerNames/Player4Container/PlayerName]
	
	for i in playerNames.size():
		playerLabels[i].visible = false
		if playerNames[i] != null:
			playerLabels[i].text = playerNames[i]
			playerLabels[i].visible = true

func _on_Timer_timeout():
	pass
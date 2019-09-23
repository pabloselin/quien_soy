extends Node

onready var camara = $Camera2D
onready var tween = $CameraTween
var isPlaying = false
var playerNames = []

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
		$GamePrompt.text = "Crea a tu jugador"
	elif GameVars.transitionType == "minigame":
		$Sonidos/Acelerate.play()
		$GamePrompt.text = "A jugar!"
	
	playerPrompt.init(player)
	playerTurns.init(player)
	add_child(playerTurns)
	add_child(playerPrompt)
	$Fondo.modulate = GameVars.playerProps[player]["color"]["value"]
	#zoomToMain()
	yield(get_tree().create_timer(2), "timeout")
	zoomToPlayer(player)
	
	
# Zooms to selected player position
func zoomToPlayer(player):
	#tween.interpolate_property(camara, "zoom", Vector2(1, 1), GameVars.activePlayerZoom, 0.7, Tween.TRANS_LINEAR, Tween.EASE_IN)
	tween.interpolate_property(camara, "position", camara.position, GameVars.playerPositions[player], 0.6, Tween.TRANS_LINEAR, Tween.EASE_IN)
	tween.start()
	
# Zooms back to main view	
func zoomToMain():
	tween.interpolate_property(camara, "zoom", camara.get_zoom(), GameVars.initialZoom, 1, Tween.TRANS_BACK, Tween.EASE_OUT)
	tween.interpolate_property(camara, "position", camara.position, GameVars.initialCameraPosition, 0.4, Tween.TRANS_LINEAR, Tween.EASE_OUT) 
	tween.start()

func _on_CameraTween_tween_all_completed():
	#yield(get_tree().create_timer(1.0), "timeout")
	# Check created avatars
	yield(get_tree().create_timer(2), "timeout")
	if Utils.allPlayersHaveAvatars():
		get_tree().change_scene("res://minigames/MiniGameBase.tscn")
	else:
		get_tree().change_scene("res://AvatarRoulette.tscn")

func putPlayerNames():
	var playerLabels = [$PlayerName, $PlayerName2, $PlayerName3, $PlayerName4]
	
	for i in playerNames.size():
		if playerNames[i] != null:
			playerLabels[i].text = playerNames[i]
			playerLabels[i].visible = true

func _on_Timer_timeout():
	pass
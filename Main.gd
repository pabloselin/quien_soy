extends Node

onready var camara = $Camera2D
onready var tween = $CameraTween
var players = ["player1", "player2", "player3", "player4"]
var currentPlayer = 0

func _ready():
	zoomToPlayer("player1")
	
# Zooms to selected player position
func zoomToPlayer(player):
	tween.interpolate_property(camara, "zoom", Vector2(1, 1), GameVars.activePlayerZoom, 0.7, Tween.TRANS_LINEAR, Tween.EASE_IN)
	tween.interpolate_property(camara, "position", camara.position, GameVars.playerPositions[player], 0.3, Tween.TRANS_LINEAR, Tween.EASE_IN)
	tween.start()
	
# Zooms back to main view	
func zoomToMain():
	tween.interpolate_property(camara, "zoom", camara.get_zoom(), GameVars.initialZoom, 1, Tween.TRANS_BACK, Tween.EASE_OUT)
	tween.interpolate_property(camara, "position", camara.position, GameVars.initialCameraPosition, 0.4, Tween.TRANS_LINEAR, Tween.EASE_OUT) 
	tween.start()

func _on_CameraTween_tween_all_completed():
	zoomToMain()
	
	yield(get_tree().create_timer(1.0), "timeout")
	
	if players.size() - 1 > currentPlayer:
		currentPlayer += 1
		print("zoom to player")
		zoomToPlayer(players[currentPlayer])
	else:
		currentPlayer = 0
		zoomToPlayer(players[currentPlayer])		
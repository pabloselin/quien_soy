extends Node

onready var camara = $Camera2D
onready var tween = $CameraTween

func _ready():
	pass
	
# Zooms to selected player position
func zoomToPlayer(player):
	tween.interpolate_property(camara, "zoom", Vector2(1, 1), GameVars.activePlayerZoom, 2, Tween.TRANS_ELASTIC, Tween.EASE_IN)
	tween.interpolate_property(camara, "position", camara.position, GameVars.playerPositions[player], 2, Tween.TRANS_ELASTIC, Tween.EASE_IN)
	tween.start()
	
# Zooms back to main view	
func zoomToMain():
	tween.interpolate_property(camara, "zoom", camara.get_zoom(), GameVars.initialZoom, 2, Tween.TRANS_BACK, Tween.EASE_OUT) 
	tween.start()
extends Node

var bodySeconds = 10

func _ready():
	print(str(GameVars.activePlayers))
	$Cabeza.play()
	$DebugTimer.start(5)

func _on_DebugTimer_timeout():
	get_tree().change_scene("res://PlayersStart.tscn")

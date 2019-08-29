extends Control
var playerObjects = {}

func _ready():
	Utils.getPlayerTurn()
	if GameVars.currentPlayer == null:
		get_tree().change_scene("res://Main.tscn")
	else:
		var curplayer = GameVars.playerProps[GameVars.currentPlayer]
		var curobject = curplayer["object"]
		$PlayerIndication.text = str(GameVars.currentPlayer)
		var order = curplayer["order"]
		if curobject:
			var item = load(curobject)
			$HBoxContainer/TurnObject.texture = item
			$HBoxContainer/TurnObject.modulate = curplayer["color"]
			$HBoxContainer/TurnObject.visible = true
		$Timer.start(4)

func _input(event):
	pass

func _on_Timer_timeout():
	get_tree().change_scene("res://AvatarRoulette.tscn")
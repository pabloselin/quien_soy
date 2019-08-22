extends Control


func _ready():
	var playerObjects = {
		"player1": $HBoxContainer/Player1,
		"player2": $HBoxContainer/Player2,
		"player3": $HBoxContainer/Player3,
		"player4": $HBoxContainer/Player4
	}
	
	var activePlayers = Utils.getActivePlayers()
	for i in activePlayers.size():
		var curobject = GameVars.playerProps[activePlayers[i]]["object"]
		if curobject:
			var item = load(curobject)
			playerObjects[activePlayers[i]].texture = item
			playerObjects[activePlayers[i]].modulate = GameVars.playerProps[activePlayers[i]]["color"]
	
	$Timer.start(4)

func _input(event):
	if event is InputEventScreenTouch:
		$DebugTowel.visible = true	
		_on_Timer_timeout()
		

func _on_Timer_timeout():
	get_tree().change_scene("res://AvatarRoulette.tscn")
extends Control
var playerObjects = {}

func init(thisplayer):
	var curplayer = GameVars.playerProps[thisplayer]
	var curobject = curplayer["object"]
	var order = curplayer["order"]
	if curobject:
		var item = load(curobject)
		$HBoxContainer/TurnObject.texture = item
		$HBoxContainer/TurnObject.modulate = curplayer["color"]["value"]
		$HBoxContainer/TurnObject.visible = true
extends Control
var playerObjects = {}

func init(thisplayer):
	var curplayer = GameVars.playerProps[thisplayer]
	var curobject = curplayer["object"]
	$PlayerIndication.text = str(thisplayer)
	var order = curplayer["order"]
	if curobject:
		var item = load(curobject)
		$HBoxContainer/TurnObject.texture = item
		$HBoxContainer/TurnObject.modulate = curplayer["color"]
		$HBoxContainer/TurnObject.visible = true
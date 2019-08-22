extends Control

func _ready():
	var hands = $GridContainer
	var rotation = GameVars.playerProps[GameVars.currentPlayer]["angle"]
	hands.set_rotation_degrees(rotation)
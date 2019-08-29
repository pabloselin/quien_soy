extends Control

func _ready():
	if GameVars.currentPlayer:
		var hands = $GridContainer
		var rotation = GameVars.playerProps[GameVars.currentPlayer]["angle"]
		hands.set_rotation_degrees(rotation)
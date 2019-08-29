extends Node2D

func _ready():
	buildCurrentAvatar()

func buildCurrentAvatar():
	var finalhead = GameVars.playerProps[GameVars.currentPlayer]["head"]
	var finaltorso = GameVars.playerProps[GameVars.currentPlayer]["torso"]
	var finalfeet = GameVars.playerProps[GameVars.currentPlayer]["feet"]
	
	var instanceHead =  GameVars.heads[finalhead].instance()
	var instanceTorso = GameVars.torsos[finaltorso].instance()
	var instanceFeet = GameVars.feet[finalfeet].instance()
		
	$CurrentHead.add_child(instanceHead)
	$CurrentTorso.add_child(instanceTorso)
	$CurrentFeet.add_child(instanceFeet)
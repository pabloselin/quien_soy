extends Node

var bodySeconds = 10
var parts = ["head", "torso", "feet"]
var currentpart = parts[0]
var isAvatarBuilt = false

func _ready():
	$PlayerLabel.text = str(GameVars.currentPlayer)

func _on_PartRotator_registeredPart():
	var head = GameVars.playerProps[GameVars.currentPlayer]["head"]
	var torso = GameVars.playerProps[GameVars.currentPlayer]["torso"]
	var feet = GameVars.playerProps[GameVars.currentPlayer]["feet"]
	$ResultZone/Label.text = str(head) + str(torso) + str(feet)

func _on_PartRotator_buildAvatar():
	if !isAvatarBuilt:
		var finalhead = GameVars.playerProps[GameVars.currentPlayer]["head"]
		var finaltorso = GameVars.playerProps[GameVars.currentPlayer]["torso"]
		var finalfeet = GameVars.playerProps[GameVars.currentPlayer]["feet"]
		
		if finalhead != null and finaltorso != null and finalfeet != null:
			var instanceHead =  GameVars.heads[finalhead].instance()
			var instanceTorso = GameVars.torsos[finaltorso].instance()
			var instanceFeet = GameVars.feet[finalfeet].instance()
			
			$ResultZone/FinalHead.add_child(instanceHead)
			$ResultZone/FinalTorso.add_child(instanceTorso)
			$ResultZone/FinalFeet.add_child(instanceFeet)
			isAvatarBuilt = true
			$FinalAvatarTimer.start(3)


func _on_FinalAvatarTimer_timeout():
	get_tree().change_scene("res://Main.tscn")
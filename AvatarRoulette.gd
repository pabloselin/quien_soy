extends Node

var bodySeconds = 15
var parts = ["head", "torso", "feet"]
var currentpart = parts[0]
var isAvatarBuilt = false

func _ready():
	$PlayerLabel.text = str(GameVars.currentPlayer)
	$ResultZone/ZoneFrame.visible = false
	$Fondo.modulate = GameVars.playerProps[GameVars.currentPlayer]["color"]

func _on_PartRotator_registeredPart():
	var head = GameVars.playerProps[GameVars.currentPlayer]["head"]
	var torso = GameVars.playerProps[GameVars.currentPlayer]["torso"]
	var feet = GameVars.playerProps[GameVars.currentPlayer]["feet"]
	
func _on_PartRotator_buildAvatar():
	if !isAvatarBuilt:
		var finalhead = GameVars.playerProps[GameVars.currentPlayer]["head"]
		var finaltorso = GameVars.playerProps[GameVars.currentPlayer]["torso"]
		var finalfeet = GameVars.playerProps[GameVars.currentPlayer]["feet"]
		
		if finalhead != null and finaltorso != null and finalfeet != null:
			var instanceHead =  GameVars.heads[finalhead].instance()
			var instanceTorso = GameVars.torsos[finaltorso].instance()
			var instanceFeet = GameVars.feet[finalfeet].instance()
			
			$paper_lines.visible = false
			$paper_lines2.visible = false
			$PickPart.play()
			yield($PickPart, "finished")
			$ResultZone/ZoneFrame.visible = true
			$ResultZone/ZoneFrame.play("appear")
			$Redoble.play()
			yield($Redoble, "finished")
			var readyHead = $ResultZone/FinalHead.add_child(instanceHead)
			var readyTorso = $ResultZone/FinalTorso.add_child(instanceTorso)
			var readyFeet = $ResultZone/FinalFeet.add_child(instanceFeet)
			
			isAvatarBuilt = true
			$FinalAvatarTimer.start(5)


func _on_FinalAvatarTimer_timeout():
	get_tree().change_scene("res://Main.tscn")
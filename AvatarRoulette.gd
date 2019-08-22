extends Node

var torsos = [preload("res://avatars/body/Body_01.tscn"),preload("res://avatars/body/Body_02.tscn"),preload("res://avatars/body/Body_03.tscn"),preload("res://avatars/body/Body_04.tscn"),preload("res://avatars/body/Body_05.tscn"),preload("res://avatars/body/Body_06.tscn")]
var feet = [preload("res://avatars/feet/Feet_01.tscn"),preload("res://avatars/feet/Feet_02.tscn"),preload("res://avatars/feet/Feet_03.tscn"),preload("res://avatars/feet/Feet_04.tscn"),preload("res://avatars/feet/Feet_05.tscn"),preload("res://avatars/feet/Feet_06.tscn")]
var heads = [preload("res://avatars/head/Head_01.tscn"),preload("res://avatars/head/Head_02.tscn"),preload("res://avatars/head/Head_03.tscn"),preload("res://avatars/head/Head_04.tscn"),preload("res://avatars/head/Head_05.tscn"),preload("res://avatars/head/Head_06.tscn")]

var bodySeconds = 10
var parts = ["head", "torso", "feet"]
var currentpart = parts[0]

func _ready():
	pass

func _on_DebugTimer_timeout():
	get_tree().change_scene("res://Main.tscn")



func _on_PartRotator_registeredPart():
	var head = GameVars.playerProps[GameVars.currentPlayer]["head"]
	var torso = GameVars.playerProps[GameVars.currentPlayer]["torso"]
	var feet = GameVars.playerProps[GameVars.currentPlayer]["feet"]
	$ResultZone/Label.text = str(head) + str(torso) + str(feet)

func _on_PartRotator_buildAvatar():
	var finalhead = GameVars.playerProps[GameVars.currentPlayer]["head"]
	var finaltorso = GameVars.playerProps[GameVars.currentPlayer]["torso"]
	var finalfeet = GameVars.playerProps[GameVars.currentPlayer]["feet"]
	
	if finalhead != null and finaltorso != null and finalfeet != null:
		var instanceHead =  heads[finalhead].instance()
		var instanceTorso = torsos[finaltorso].instance()
		var instanceFeet = feet[finalfeet].instance()
		
		$ResultZone/FinalHead.add_child(instanceHead)
		$ResultZone/FinalTorso.add_child(instanceTorso)
		$ResultZone/FinalFeet.add_child(instanceFeet)

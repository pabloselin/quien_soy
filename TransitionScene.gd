extends Control

export var sceneDuration = 20

func _ready():
	$SceneDuration.start(sceneDuration)

func _on_SceneDuration_timeout():
	get_tree().change_scene("res://PlayersStart.tscn")
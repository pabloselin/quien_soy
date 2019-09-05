extends Control

func _ready():
	$SceneDuration.start(20)

func _on_SceneDuration_timeout():
	get_tree().change_scene(GameVars.nextScene)
extends Control

func _ready():
	$TestPlayersBottom.text = GameVars.transitionMessage
	$TestPlayersTop.text = GameVars.transitionMessage
	$SceneDuration.start(3)

func _on_SceneDuration_timeout():
	get_tree().change_scene(GameVars.nextScene)
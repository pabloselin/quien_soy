extends Control

onready var screenButton =  $TouchScreenButton

func _ready():
	$AnimationPlayer.play("Tilt")

func _input(event):
	if event is InputEventScreenTouch:
		GameVars.transitionMessage = "Jugadores"
		GameVars.nextScene = "res://PlayersStart.tscn"
		get_tree().change_scene("res://TransitionScene.tscn")
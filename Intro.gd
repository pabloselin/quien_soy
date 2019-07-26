extends Control

onready var screenButton =  $TouchScreenButton

func _ready():
	$AnimationPlayer.play("Tilt")

func _input(event):
	if screenButton.is_pressed():
		get_tree().change_scene("res://PlayersStart.tscn")
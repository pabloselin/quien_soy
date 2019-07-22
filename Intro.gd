extends Control

onready var screenButton =  $TouchScreenButton

func _ready():
	pass

func _input(event):
	if screenButton.is_pressed():
		get_tree().change_scene("res://Main.tscn")
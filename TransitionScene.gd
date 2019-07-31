extends Control

func _ready():
	$AnimationPlayer.play("CamaraZoom")

func apply_text(text):
	$Texto.text = text
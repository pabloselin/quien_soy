extends Control

var charBgms = [preload("res://sfx/surf.ogg"), preload("res://sfx/skaty.ogg"), preload("res://sfx/malku.ogg"), preload("res://sfx/flecha.ogg")]
var chars = [preload("res://guias/Surf.tscn"), preload("res://guias/Skaty.tscn"), preload("res://guias/Malku.tscn"), preload("res://guias/Flecha.tscn")]

func _ready():
	$AnimationPlayer.play("Tilt")
	$VersionNumber.text = "Version " + GameVars.gameVersion
	pickChar()

func _input(event):
	if event is InputEventScreenTouch:
		GameVars.transitionMessage = "Jugadores"
		GameVars.nextScene = "res://PlayersStart.tscn"
		get_tree().change_scene("res://TransitionScene.tscn")
		
func pickChar():
	randomize()
	var randChar = randi() % chars.size()
	var charInstance = chars[randChar].instance()
	var charInstance2 = chars[randChar].instance()
	$Personaje.add_child(charInstance)
	$PersonajeInv.add_child(charInstance2)
	$Personaje/PersonajeBGM.stream = charBgms[randChar]
	$Personaje/PersonajeBGM.play()
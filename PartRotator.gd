extends Node2D

var bodys = [preload("res://avatars/body/Body_01.tscn"),preload("res://avatars/body/Body_02.tscn"),preload("res://avatars/body/Body_03.tscn"),preload("res://avatars/body/Body_04.tscn"),preload("res://avatars/body/Body_05.tscn"),preload("res://avatars/body/Body_06.tscn")]
var feet = [preload("res://avatars/feet/Feet_01.tscn"),preload("res://avatars/feet/Feet_02.tscn"),preload("res://avatars/feet/Feet_03.tscn"),preload("res://avatars/feet/Feet_04.tscn"),preload("res://avatars/feet/Feet_05.tscn"),preload("res://avatars/feet/Feet_06.tscn")]
var heads = [preload("res://avatars/head/Head_01.tscn"),preload("res://avatars/head/Head_02.tscn"),preload("res://avatars/head/Head_03.tscn"),preload("res://avatars/head/Head_04.tscn"),preload("res://avatars/head/Head_05.tscn"),preload("res://avatars/head/Head_06.tscn")]

var arrparts = [heads, bodys, feet]
var partLabels = ["CABEZA", "TORSO", "PIES"]
var changingPart = false
signal registeredPart
signal buildAvatar

var currentPart = 0
var currentIndex = 0
var currentInstance = null
export var curpart = "cabeza"
onready var timerSwitch = $Switch
onready var timerParts = $ChangePart
var switchTime = 0.6
var partChange = 5

func _ready():
	timerSwitch.start(switchTime)
	timerParts.start(partChange)
	updateLabelPart()
	
# Rotate and animate different parts depending current part

func _input(event):
	if event is InputEventScreenTouch:
		if !changingPart:
			registerChosenPart(currentIndex)

func selectPart(part):	
	if currentInstance != null: 
		currentInstance.queue_free()
	
	var scene = arrparts[part][currentIndex]
	currentInstance = scene.instance()
	add_child(currentInstance)
	$SoundChange.play()
	
	if currentIndex + 1 < arrparts[part].size():
		currentIndex += 1
	else:
		currentIndex = 0

func registerChosenPart(partIndex):
	var part2Index = ["head", "torso", "feet"]
	GameVars.playerProps[GameVars.currentPlayer][part2Index[currentPart]] = partIndex - 1
	emit_signal("registeredPart")
	nextPart()

func nextPart():
	changingPart = true
	if currentPart + 1 < arrparts.size():
		currentPart += 1
		updateLabelPart()
		yield(get_tree().create_timer(1), "timeout")
	else:
		buildAvatar()
	changingPart = false
		
func buildAvatar():
	emit_signal("buildAvatar")
	
func updateLabelPart():
	$CurrentPart.text = partLabels[currentPart]
			
func _on_Switch_timeout():
	selectPart(currentPart)

func _on_ChangePart_timeout():
	nextPart()
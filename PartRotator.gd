extends Node2D

var curPlayerProps = GameVars.playerProps[GameVars.currentPlayer]
var arrparts = [GameVars.heads, GameVars.torsos, GameVars.feet]
var partLabels = ["CABEZA", "TORSO", "PIES"]
var part2Index = ["head", "torso", "feet"]
var changingPart = false
signal registeredPart
signal buildAvatar

var currentPart = 0
var currentIndex = 0
var currentInstance = null
export var curpart = "cabeza"
onready var timerSwitch = $Switch
onready var timerParts = $ChangePart
var switchTime = 1
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

func switchPart(part):	
	if currentInstance != null: 
		currentInstance.queue_free()
	
	var scene = arrparts[part][currentIndex]
	currentInstance = scene.instance()
	add_child(currentInstance)
	$SoundChange.play()
	$curpart.text = str(currentIndex)
	if currentIndex + 1 < arrparts[part].size():
		currentIndex += 1
	else:
		currentIndex = 0

func registerChosenPart(partIndex):
	#$curpart.text = str(partIndex)
	curPlayerProps[part2Index[currentPart]] = partIndex - 1
	emit_signal("registeredPart")
	nextPartsGroup()

func nextPartsGroup():
	if currentPart + 1 < arrparts.size():
		changingPart = true
		currentPart += 1
		updateLabelPart()
		$SoundChange.pitch_scale += .2
		if curPlayerProps[part2Index[currentPart]] == null:
			curPlayerProps[part2Index[currentPart]] = currentIndex
			emit_signal("registeredPart")
			# print(str(curPlayerProps[part2Index[currentPart]]))
		yield(get_tree().create_timer(0.5), "timeout")
	else:
		buildAvatar()
	changingPart = false
		
func buildAvatar():
	emit_signal("buildAvatar")
	
func updateLabelPart():
	$CurrentPart.text = partLabels[currentPart]
			
func _on_Switch_timeout():
	switchPart(currentPart)

func _on_ChangePart_timeout():
	nextPartsGroup()
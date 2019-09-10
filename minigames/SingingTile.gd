extends Node2D

onready var singTile = $SingTile
var singtimes = 0
var singgoal = 2
signal minigamewin

func _ready():
	pass

func _process(delta):
	if singtimes > singgoal:
		emit_signal("minigamewin")

func sing():
	$Song.play()
	$Shake.play("ShakeTile")
	updateLabel()

func updateLabel():
	var singRest = singgoal - singtimes
	if singRest > 0:
		$SingPrompt.text = "¡HABLA OTRA VEZ!"

func stopSing():
	$Song.stop()
	$Shake.stop()

func _on_SingTile_pressed():
	sing()
	singtimes += 1
	
func _on_SingTile_released():
	stopSing()
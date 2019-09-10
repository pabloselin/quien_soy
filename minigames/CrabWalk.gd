extends Node2D

var arepaPosition
onready var arepa = $Arepa
signal minigamewin
var eaten = false

func _process(delta):
	if $Cangrejo.position.x > arepaPosition.x - 100:
		chomp() 

func _ready():
	if arepa != null:
		arepaPosition = arepa.position

func _input(event):
	if event is InputEventScreenTouch:
		moveCrab()
		
func moveCrab():
	$Caminando.play()
	$Cangrejo.position.x += 35
	$CrabWalk.play("Walk")
	
func chomp():
	if eaten == false:
		$Comiendo.play()
		eaten = true
		arepa.queue_free()
		emit_signal("minigamewin")
		
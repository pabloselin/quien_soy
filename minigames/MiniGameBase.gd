extends Node2D

var success = false
var timeout = 5
var rebootTime = 0.5

var turtleCrossing = preload("res://minigames/TurtleCrossing.tscn")
var turtleCrossingInstance = turtleCrossing.instance()

func _ready():
	startMiniGame()

func startMiniGame():
	$UnfoldBG.play("unfold")
	var turtlescene = add_child(turtleCrossingInstance)
	turtleCrossingInstance.connect("minigamewin", self, "_on_TurtleCrossing_minigamewin")
	$Timer.start(timeout)

func _process(delta):
	if success == true:
		$RebootTimer.start(rebootTime)
	
func _on_RebootTimer_timeout():
	$RebootTimer.stop()
	startMiniGame()

func _on_TurtleCrossing_minigamewin():
	success = true
	turtleCrossingInstance.queue_free()
	$Timer.stop()
	$UnfoldBG.play("unfold", true)
	yield(get_tree().create_timer(1), "timeout")
	get_tree().change_scene("res://Main.tscn")

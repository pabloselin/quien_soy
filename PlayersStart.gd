extends Node

var timeToStart = 5
var helpTime = 4
var curhand = 1
var timerScale = 1
var playerPressedStatus = [false, false, false, false]
var playerUnfoldedStatus = [false, false, false, false]
var playerReleasedStatus = [false, false, false, false]
var playerTimers = [0, 0, 0, 0]
var playerAnimations = []
var playerButtons = []

onready var seconds = $TimerUI/Seconds
onready var timerText = $TimerUI/TimerText
onready var ayudas = weakref($Ayudas)
onready var player1 = $Players/Player1
onready var player2 = $Players/Player2
onready var player3 = $Players/Player3
onready var player4 = $Players/Player4

signal player_unfolded
signal player_folded

func _ready():
	# Position and rotate the players
	player1.rotation_degrees = 180
	player2.rotation_degrees = 180
	
	player1.position = GameVars.playerPositions["player1"] + Vector2(GameVars.gameSize[0] / 2, GameVars.gameSize[1] / 2)
	player2.position = GameVars.playerPositions["player2"]	+ Vector2(GameVars.gameSize[0] / 2, GameVars.gameSize[1] / 2)
	
	player3.position = GameVars.playerPositions["player3"]
	player4.position = GameVars.playerPositions["player4"]
	
	playerAnimations = [$Players/PlayerAnimations/Player1Animation, $Players/PlayerAnimations/Player1Animation2, $Players/PlayerAnimations/Player1Animation3, $Players/PlayerAnimations/Player1Animation4]
	playerButtons = [player1, player2, player3, player4]
	
	
	$TimerUI/CountDown.start(helpTime)
		
	$TimerUI/CountDown.connect("timeout", self, "disableHelp")
	
	connect("player_folded", self, "playerFolded")
	connect("player_unfolded", self, "playerUnfolded")
	
	for i in playerButtons.size():
		playerButtons[i].connect("pressed", self, "playAnimationPlayer", [i])
		#playerButtons[i].connect("released", self, "playerRelease", [i])
		#playerAnimations[i].connect("frame_changed", self, "playerFinishUpdate", [i])
		playerAnimations[i].connect("animation_finished", self, "playerAssignTurn", [i])
		#playerAnimations[i].connect("player_unfolded", self, "playerUnfolded", [i])
		#playerAnimations[i].connect("player_folded", self, "playerFolded", [i])
		 
	
func _process(delta):
	pass
	
#func playerFinishUpdate(player):
#	var frame = playerAnimations[player].frame
#	var animationLength = playerAnimations[player].frames.get_frame_count("unfold")
#	if frame == animationLength - 1:
#		playerUnfoldedStatus[player] = true
#		emit_signal("player_unfolded", player)
#	elif frame == animationLength - 2:
#		emit_signal("player_folded", player)
#		playerUnfoldedStatus[player] = false

#func playerUnfolded(player):
#	print("player unfolded: ", player)
#
#func playerFolded(player):
#	print("player folded: ", player)

func playerAssignTurn(player):
	GameVars.activePlayers[player] = true

func disableHelp():
	if ayudas.get_ref():
		$Ayudas.queue_free()
	
func _input(event):
	if event is InputEventScreenTouch:
		checkPressed()
		var updatedPlayer = playerPressedStatus.find(true)
		if updatedPlayer != -1:
			if(seconds.is_stopped()):
				updateLabel(str(timeToStart))
				seconds.start(1)
		
func playAnimationPlayer(player):
	playerAnimations[player].play("unfold")

func animateTimer():
	var initialRotation = timerText.rect_rotation
	$TimerUI/TimerTween.interpolate_property(timerText, "rect_rotation", initialRotation, initialRotation + 180, 0.5, Tween.TRANS_CIRC, Tween.EASE_OUT_IN)
	$TimerUI/CircleTween.interpolate_property($TimerUI/TimerCircle, "scale", Vector2(0.5, 0.5), Vector2(0.6, 0.6), 1, Tween.TRANS_BOUNCE, Tween.EASE_IN_OUT)
	$TimerUI/CircleTween.start()
	$TimerUI/TimerTween.start()
	

func checkPressed():
	playerPressedStatus = [player1.is_pressed(), player2.is_pressed(), player3.is_pressed(), player4.is_pressed()]
	$DebugTimer.text = str(playerPressedStatus)

func updateLabel(text):
	timerText.rect_pivot_offset = timerText.rect_size / 2
	timerText.rect_scale += Vector2(0.1, 0.1)
	animateTimer()
	timerText.text = text

func _on_Seconds_timeout():
	if timeToStart < 1:
		#GameVars.activePlayers = checkPressed()
		get_tree().change_scene("res://PlayersAssigned.tscn")
	else:
		#$Sounds/CountDown.play()
		updateLabel(str(timeToStart))
		timeToStart -= 1
		
		
func playerRelease(player):
	playerAnimations[player].play("unfold", true)
	checkPressed()
	if(playerPressedStatus.find(true) == -1):
		seconds.stop()
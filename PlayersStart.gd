extends Node

var timeToStart = 5
var helpTime = 12
var timerScale = 1
var playerAnimations = []
var playerObjects = []
var playerButtons = []
var colorkeys = ["purple", "green", "lightblue", "red"]

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
	playerObjects = [$Players/PlayerObjects/ObjectPlayer1, $Players/PlayerObjects/ObjectPlayer2, $Players/PlayerObjects/ObjectPlayer3, $Players/PlayerObjects/ObjectPlayer4]
	playerButtons = [player1, player2, player3, player4]
	
	for i in playerObjects.size():
		Utils.updatePlayerObject(i, "object", playerObjects[i].texture.get_path())
	
	$Ayudas/MoveHand.play("moveAround")
	
	connect("player_folded", self, "playerFolded")
	connect("player_unfolded", self, "playerUnfolded")
	
	for i in playerButtons.size():
		playerButtons[i].connect("pressed", self, "playAnimationPlayer", [i])
		playerAnimations[i].connect("animation_finished", self, "playerAssignTurn", [i])

func showItemUnfolded(player):
	pass
	
func _process(delta):
	pass

func playerAssignTurn(playerkey):
	Utils.updatePlayerObject(playerkey, "active", true)
	playerObjects[playerkey].visible = true
	playerAssignColor(playerkey)

func disableHelp():
	if ayudas.get_ref():
		$Ayudas.queue_free()
	
func _input(event):
	if event is InputEventScreenTouch:
		disableHelp()
		if(seconds.is_stopped()):
			updateLabel(str(timeToStart))
			seconds.start(1)
		
func playAnimationPlayer(playerkey):
	playerAnimations[playerkey].play("unfold")
	
func playerAssignColor(playerkey):
	randomize()
	var randomColor = randi() % colorkeys.size()
	var playerColor = GameVars.colors[colorkeys[randomColor]]
	playerAnimations[playerkey].modulate = playerColor
	colorkeys.remove(randomColor)
	Utils.updatePlayerObject(playerkey, "color", playerColor)

func animateTimer():
	var initialRotation = timerText.rect_rotation
	$TimerUI/TimerTween.interpolate_property(timerText, "rect_rotation", initialRotation, initialRotation + 180, 0.5, Tween.TRANS_CIRC, Tween.EASE_OUT_IN)
	$TimerUI/CircleTween.interpolate_property($TimerUI/TimerCircle, "scale", Vector2(0.5, 0.5), Vector2(0.6, 0.6), 1, Tween.TRANS_BOUNCE, Tween.EASE_IN_OUT)
	$TimerUI/CircleTween.start()
	$TimerUI/TimerTween.start()
	$Sounds/CountDown.play()

func updateLabel(text):
	timerText.rect_pivot_offset = timerText.rect_size / 2
	timerText.rect_scale += Vector2(0.1, 0.1)
	animateTimer()
	timerText.text = text

func _on_Seconds_timeout():
	if timeToStart < 1:
		GameVars.playerItems = playerObjects
		get_tree().change_scene("res://PlayerTurns.tscn")
	else:
		updateLabel(str(timeToStart))
		timeToStart -= 1
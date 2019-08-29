extends Node

var timeToStart = 5
var helpTime = 12
var timerScale = 1
var playerOrder = 0
var playerAnimations = []
var playerObjects = []
var playerButtons = []
var colorkeys = ["purple", "green", "lightblue", "red"]

onready var seconds = $TimerUI/Seconds
onready var timerTexts = [$TimerUI/TimerText, $TimerUI/TimerText2, $TimerUI/TimerText3, $TimerUI/TimerText4]
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
	$TimerUI/TimerPez/AnimationPlayer.play("Shake")
	
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
	playerOrder += 1
	Utils.updatePlayerObject(playerkey, "active", true)
	Utils.updatePlayerObject(playerkey, "order", playerOrder)
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
	$TimerUI/CircleTween.start()
	$TimerUI/TimerPez/PezGlobo.play("countdown")
	$TimerUI/TimerPez/AnimationPlayer.play("FastShake")
	$Sounds/CountDown.play()

func updateLabel(text):
	for i in timerTexts.size():
		timerTexts[i].rect_pivot_offset = timerTexts[i].rect_size / 2
		timerTexts[i].rect_scale += Vector2(0.1, 0.1)
		timerTexts[i].text = text

	animateTimer()
	
func _on_Seconds_timeout():
	if timeToStart < 1:
		GameVars.playerItems = playerObjects
		Utils.randomizePlayersOrder()
		get_tree().change_scene("res://PlayerTurns.tscn")
	else:
		updateLabel(str(timeToStart))
		timeToStart -= 1
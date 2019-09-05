extends Node2D

# Ideas microjuegos

# - sacar un pajarito, un cangrejo o un chungungo en resto de red de pesca o en un plástico de cervezas (esos con 6 circulitos), animalito  escurridizo que se vuelve a enrollar
#
# - escobillar una mancha de fuel en un animalito, mancha animada (con carita) y escurridiza
#
# - insonorizar un ruido: capturar un ruido (un monstruito muy ruidoso) con un elemento de vidrio
#
# - con un detector de metal, detectar unos bichos mutantes que son mitad cangrejos (o pulgas de mar) mitad resortes que salen de la arena enojados y te persiguen
#
# - una nube de abejas mariadas y desorientas se vienen directo hacia ti, y tienes que dominarlos con poder mental, sacarlas de ese estado con hipnosis para liberarlas
#
# - recoger cacas de animales (perro, chungungos, cangrejos, pulgas de mar, focas, gaviotas, con una manito robot
#
# - invocar espíritus de la tierra, que hagan temblar y el cerro despierta y sopla la contaminación del aire
#
# - capturar nubecitas toxicas con una aspiradora de olores

var success = false
var timeout = 5
var rebootTime = 0.5

var turtleCrossing = preload("res://minigames/TurtleCrossing.tscn")
var tableDog = preload("res://minigames/TableDog.tscn")
var curMiniGame = null
export var debugMinigame = preload("res://minigames/TableDog.tscn")

func _ready():
	startMiniGame()
	
func chooseMiniGame():
	if !debugMinigame:
		var miniGames = [turtleCrossing, tableDog]
		randomize()
		var randGameSize = randi() % miniGames.size()
		var randGame = miniGames[randGameSize]
		print(str(randGame))
		return randGame
	else:
		return debugMinigame
		
func startMiniGame():
	$UnfoldBG.play("unfold")
	var curMiniGame = chooseMiniGame().instance()
	$MiniGameZone.add_child(curMiniGame)
	#print(str(gameInstance))
	curMiniGame.connect("minigamewin", self, "_on_minigamewin")
	curMiniGame.connect("minigamelose", self, "_on_minigamelose")
	$Timer.start(timeout)
	$GameTimeOut.play("countdown")

func endMiniGame():
	if curMiniGame:
		curMiniGame.queue_free()
	$Timer.stop()
	$UnfoldBG.play("unfold", true)
	yield(get_tree().create_timer(1), "timeout")
	get_tree().change_scene("res://Main.tscn")

func _process(delta):
	if success == true:
		$RebootTimer.start(rebootTime)
	
func _on_RebootTimer_timeout():
	$RebootTimer.stop()
	startMiniGame()

func _on_minigamewin():
	success = true
	endMiniGame()
	
func _on_minigamelose():
	endMiniGame()
	success = false

func _on_Timer_timeout():
	endMiniGame()
	success = false
extends Node
# Global game variables

var playerObjects = list_files_in_directory("res://gfx/player_objects")
# Phone Screen Size
var screenSize = OS.get_screen_size()
var gameSize = Vector2(ProjectSettings.get_setting("display/window/size/width"), ProjectSettings.get_setting("display/window/size/height"))
var activePlayerZoom = Vector2(0.5, 0.5)
var initialZoom = Vector2(1, 1)
var initialCameraPosition = Vector2(0, 0)

var nameList = ["suri", "wara", "kusi", "panqarita", "kurmi", "quantati", "nayra", "allin", "pawkar", "amaru"]

var torsos = [preload("res://avatars/body/Body_01.tscn"),preload("res://avatars/body/Body_02.tscn"),preload("res://avatars/body/Body_03.tscn"),preload("res://avatars/body/Body_04.tscn"),preload("res://avatars/body/Body_05.tscn"),preload("res://avatars/body/Body_06.tscn")]
var feet = [preload("res://avatars/feet/Feet_01.tscn"),preload("res://avatars/feet/Feet_02.tscn"),preload("res://avatars/feet/Feet_03.tscn"),preload("res://avatars/feet/Feet_04.tscn"),preload("res://avatars/feet/Feet_05.tscn"),preload("res://avatars/feet/Feet_06.tscn")]
var heads = [preload("res://avatars/head/Head_01.tscn"),preload("res://avatars/head/Head_02.tscn"),preload("res://avatars/head/Head_03.tscn"),preload("res://avatars/head/Head_04.tscn"),preload("res://avatars/head/Head_05.tscn"),preload("res://avatars/head/Head_06.tscn")]

# Player positions based on screen size

var playerPositions = {
	"player1": Vector2(0, 0),
	"player2": Vector2(gameSize[0] / 2, 0),
	"player3": Vector2(0, gameSize[1] / 2),
	"player4": Vector2(gameSize[0] / 2, gameSize[1] / 2)
}

var colors = {
	"green": Color(.93, .200, .70),
	"lightblue": Color(.77, .187, .247),
	"purple": Color(.193, .94, .229),
	"red": Color(.211, .74, .74)
}

var playerProps = {
	"player1": {
		"color": colors.green, 
		"texture": null,
		"head": null,
		"torso": null,
		"feet": null,
		"order": null,
		"screenPosition": null,
		"active": false,
		"games": null,
		"object": null,
		"name": null,
		"angle": -45,
		"wins": 0,
		"loses": 0
	},
	"player2": {
		"color": colors.lightblue, 
		"texture": null,
		"head": null,
		"torso": null,
		"feet": null,
		"order": null,
		"screenPosition": null,
		"active": false,
		"games": null,
		"object": null,
		"name": null,
		"angle": 45,
		"wins": 0,
		"loses": 0
	},
	"player3": {
		"color": colors.purple, 
		"texture": null,
		"head": null,
		"torso": null,
		"feet": null,
		"order": null,
		"screenPosition": null,
		"active": false,
		"games": null,
		"object": null,
		"name": null,
		"angle": 225,
		"wins": 0,
		"loses": 0
	},
	"player4": {
		"color": colors.red, 
		"texture": null,
		"head": null,
		"torso": null,
		"feet": null,
		"order": null,
		"screenPosition": null,
		"active": false,
		"games": null,
		"object": null,
		"name": null,
		"angle": 135,
		"wins": 0,
		"loses": 0
	}
}

var currentPlayer = "player4"
var playerItems = []
var playersOrder = []
var transitionMessage = "Put some text in the scene"
var nextScene = "res://Main.tscn"

func activePlayers():
	var activePlayers = []
	for player in playerProps:
		if player["active"] == true:
			activePlayers.push_back(player.key)
	return activePlayers

func nextScene(message, scene):
	transitionMessage = message
	nextScene = scene
	get_tree().change_scene("res://TransitionScene.gd")
	
func list_files_in_directory(path):
    var files = []
    var dir = Directory.new()
    dir.open(path)
    dir.list_dir_begin()

    while true:
        var file = dir.get_next()
        if file == "":
            break
        elif not file.begins_with(".") and file.ends_with(".png"):
            files.append(file)

    dir.list_dir_end()

    return files
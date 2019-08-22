extends Node
# Global game variables

var playerObjects = list_files_in_directory("res://gfx/player_objects")
# Phone Screen Size
var screenSize = OS.get_screen_size()
var gameSize = Vector2(ProjectSettings.get_setting("display/window/size/width"), ProjectSettings.get_setting("display/window/size/height"))
var activePlayerZoom = Vector2(0.5, 0.5)
var initialZoom = Vector2(1, 1)
var initialCameraPosition = Vector2(0, 0)
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
		"angle": -22.5
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
		"angle": 67.5
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
		"angle": -111.5
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
		"angle": 111.5
	}
}

var currentPlayer = "player1"

var playerItems = []

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
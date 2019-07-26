extends Node

var activePlayers = [false, false, false, false]

# Phone Screen Size
var screenSize = OS.get_screen_size()
var gameSize = Vector2(ProjectSettings.get_setting("display/window/size/width"), ProjectSettings.get_setting("display/window/size/height"))

var activePlayerZoom = Vector2(0.5, 0.5)
var initialZoom = Vector2(1, 1)

# Player positions based on screen size
var playerPositions = {
	"player1": Vector2(0, 0),
	"player2": Vector2(gameSize[0] / 2, 0),
	"player3": Vector2(0, gameSize[1] / 2),
	"player4": Vector2(gameSize[0] / 2, gameSize[1] / 2)
}
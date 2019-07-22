extends Node

var numberOfPlayers = 0

# Phone Screen Size
var screenSize = OS.get_screen_size()

var activePlayerZoom = Vector2(0.5, 0.5)
var initialZoom = Vector2(1, 1)

# Player positions based on screen size
var playerPositions = {
	"player1": Vector2(0, 0),
	"player2": Vector2(screenSize.x / 2, 0),
	"player3": Vector2(0, screenSize.y / 2),
	"player4": Vector2(screenSize.x / 2, screenSize.y / 2)
}
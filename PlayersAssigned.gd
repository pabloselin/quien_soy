extends Node

func _ready():
	print(str(GameVars.activePlayers))
	var playerAnimations = [$Players/PlayerAnimations/Player1Animation, $Players/PlayerAnimations/Player1Animation2, $Players/PlayerAnimations/Player1Animation3, $Players/PlayerAnimations/Player1Animation4]
	var objectPlayers = [$Players/Node/ObjectPlayer, $Players/Node/ObjectPlayer2, $Players/Node/ObjectPlayer3, $Players/Node/ObjectPlayer4]
	for i in GameVars.activePlayers.size():
		if GameVars.activePlayers[i] == true:
			playerAnimations[i].frame = 5
			objectPlayers[i].visible = true
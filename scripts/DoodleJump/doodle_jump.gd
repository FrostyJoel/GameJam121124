extends microgame_base
var state = false

func _ready() -> void:
#Needed to find and enableTimer
	var uiManager = get_tree().get_nodes_in_group("UiManager")
	for node in uiManager:
		# Check the node has a save function.
		if !node.has_method("Enabletimer"):
			print("persistent node '%s' is missing a Enabletimer() function, skipped" % node.name)
			continue

		node.call("Enabletimer",$GameTimer)
func _on_game_timer_timeout() -> void:
	$EndTimer.start()
	$Player.gameended = true

func _on_end_timer_timeout() -> void:
	microgameEnded.emit(state)
	print(state)

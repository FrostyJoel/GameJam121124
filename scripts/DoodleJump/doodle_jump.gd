extends microgame_base
var state = false

func _on_game_timer_timeout() -> void:
	$EndTimer.start()
	$Player.gameended = true

func _on_end_timer_timeout() -> void:
	microgameEnded.emit(state)
	print(state)

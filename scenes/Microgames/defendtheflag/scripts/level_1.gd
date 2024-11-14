extends microgame_base

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

	

func _on_game_timer_timeout() -> void:
	microgameEnded.emit(true)
	print_debug("Win")
	
func _on_hurtbox_area_entered(area: Area2D) -> void:
	$FailTimer.start()


func _on_fail_timer_timeout() -> void:
	microgameEnded.emit(false)

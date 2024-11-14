extends microgame_base




func _on_finish_body_entered(body: Node2D) -> void:
	$Timer.stop()
	microgameEnded.emit(true)


func _on_timer_timeout() -> void:
	microgameEnded.emit(false)
	print("timer ended")

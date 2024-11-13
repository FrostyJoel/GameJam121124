extends microgame_base

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$MicrogameTimer.start()
	
	randomize()
	var newPos = randf_range(200, 1700)
	$Sprite2D.transform.origin.x = newPos
	print("Ready m")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_microgame_timer_timeout() -> void:
	print("Microgame timeout!")
	microgameEnded.emit(false)

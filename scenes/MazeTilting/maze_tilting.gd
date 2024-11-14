extends Node2D

var rotation_speed = 1.5

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_pressed("NegativeHorizontal") || Input.is_action_pressed("DirLeft"):
		rotation += rotation_speed * delta * -1
		
	if Input.is_action_pressed("PositiveHorizontal") || Input.is_action_pressed("DirRight"):
		rotation += rotation_speed * delta

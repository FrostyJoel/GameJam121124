extends Node2D

var rotation_speed = 1.5

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_pressed("TiltLeft"):
		rotation += rotation_speed * delta * -1
		
	if Input.is_action_pressed("TiltRight"):
		rotation += rotation_speed * delta

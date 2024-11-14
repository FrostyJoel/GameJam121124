extends Node2D

var rotation_speed = 1.5

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_pressed("NegativeHorizontal") || Input.is_action_pressed("DirLeft"):
		rotation += rotation_speed * delta
		
	if Input.is_action_pressed("PostiveHorizontal") || Input.is_action_pressed("DirRight"):
		rotation += rotation_speed * delta * -1

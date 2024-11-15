extends Node2D

@export var flip_x : bool

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if (flip_x):
		$Sprite2D.flip_h = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
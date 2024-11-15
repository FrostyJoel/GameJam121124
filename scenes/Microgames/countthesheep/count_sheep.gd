extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$AnimatedSprite2D.play()
	if randi_range(0, 1) == 0:
		self.scale.x = -1
	self.scale = self.scale * randf_range(0.75, 1.25)
	self.rotate(deg_to_rad(randf_range(-45, 45)))

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$GPUParticles2D.emitting = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_gpu_particles_2d_finished() -> void:
	self.queue_free()
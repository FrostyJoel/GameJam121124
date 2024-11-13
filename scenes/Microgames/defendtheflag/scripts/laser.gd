extends CharacterBody2D

class_name Laser

@export var speed: int = 200

func _ready():
	$CollisionShape2D.disabled = true

func _physics_process(delta):
	velocity = Vector2()
	velocity = Vector2(speed, 0).rotated(rotation)
	set_velocity(velocity)
	
	move_and_slide()
	velocity = velocity


func _on_hurtbox_area_entered(area: Area2D) -> void:
	if area.is_in_group("Enemy"):
		queue_free()

extends CharacterBody2D
class_name Astroid_2

@export var speed: int = 300
var health : int = 3

func _ready():
	$Sprite2D.rotation -= rotation
	
func _physics_process(delta: float) -> void:
	velocity = Vector2()
	velocity = Vector2(speed, 0).rotated(rotation)
	set_velocity(velocity)
	
	move_and_slide()
	velocity = velocity


func _on_hurt_box_area_entered(area: Area2D) -> void:
	if area.is_in_group("Laser"):
		var _explosion = load("res://scenes/Microgames/defendtheflag/scenes/explosion_particles.tscn")
		var _explosion_instance = _explosion.instantiate()
		$"..".add_child(_explosion_instance)
		_explosion_instance.global_position = global_position
		if health <= 0:
			var _explosion_audio = load("res://scenes/Microgames/defendtheflag/scenes/explosion_audio_player.tscn")
			var _explosion_audio_instance = _explosion_audio.instantiate()
			$"..".add_child(_explosion_audio_instance)
			queue_free()
		else:
			health = health - 1

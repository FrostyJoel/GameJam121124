extends CharacterBody2D

var  rotation_dir = 0
var rotation_speed: float = 6
var laser_cooldown = false

signal player_death

func _physics_process(delta):
	var _input = Vector2.ZERO
	_input.x = Input.get_action_strength("DirLeft")-Input.get_action_strength("DirRight")
	
	get_input()
	
	if laser_cooldown == false:
		spawn_projectile()
	
	rotation += rotation_dir * rotation_speed * delta
	
	move_and_slide()
	
func get_input():
	rotation_dir = 0
	if Input.is_action_pressed("DirRight"):
		rotation_dir += 1
	if Input.is_action_pressed("DirLeft"):
		rotation_dir -= 1
		

func spawn_projectile():
	var _laser = load("res://scenes/Microgames/defendtheflag/scenes/laser.tscn")
	var _laser_instance = _laser.instantiate()
	$"..".add_child(_laser_instance)
	_laser_instance.global_position = global_position
	_laser_instance.rotation = self.rotation - PI / 4
	laser_cooldown = true
	$LaserCooldownTimer.start()


func _on_laser_cooldown_timer_timeout():
	laser_cooldown = false


func _on_hurtbox_area_entered(area: Area2D) -> void:
	if area.is_in_group("Enemy"):
		var _explosion = load("res://scenes/Microgames/defendtheflag/scenes/explosion_particles.tscn")
		var _explosion_instance = _explosion.instantiate()
		$"..".add_child(_explosion_instance)
		_explosion_instance.global_position = global_position
		emit_signal("player_death")
		queue_free()

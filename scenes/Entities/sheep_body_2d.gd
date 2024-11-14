extends CharacterBody2D


const SPEED = 50.0
const JUMP_VELOCITY = -275.0

			
func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("Action1") and is_on_floor():
		velocity.y = JUMP_VELOCITY 
		velocity.x = 100
		
	if velocity.y > -1:
		velocity.x = velocity.x/1.1
	
	position.x += SPEED * delta
	move_and_slide()

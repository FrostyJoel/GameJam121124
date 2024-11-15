extends CharacterBody2D

@onready var playerbase = position.y
@onready var camera_2d: Camera2D = $"../Camera2D"
@onready var camerabase = camera_2d.position.y
var maxheight = 0
var gameended = false
var screenend = false

const SPEED = 300.0
const JUMP_VELOCITY = -600.0

func _ready() -> void:
	$"../GameTimer".start()
	
func _process(delta: float) -> void:
	if not screenend:
		if (position.y - playerbase < maxheight):
			maxheight = position.y - playerbase
			camera_2d.position.y = camerabase + maxheight
	
func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if is_on_floor():
		if not gameended:
			velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("DirLeft", "DirRight")
	if direction:
		if not gameended:
			velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()


func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	gameended = true
	$"../EndTimer".start()
	

func _on_visible_on_screen_enabler_2d_screen_exited() -> void:
	screenend = true

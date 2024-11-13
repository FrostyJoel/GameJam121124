extends Node2D

const SHAPESIZE:float = 3
const DISTANCEOFFSET:float = 400
const CONTROLLERSPEED:float = 10

@onready var sprite_2d: Sprite2D = $Sprite2D

var originPos:Vector2
var pressed: bool = false
var velocity:Vector2

var new_color : Color

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	originPos = get_viewport_rect().get_center()
	sprite_2d.transform.origin = originPos
	sprite_2d.scale = Vector2(SHAPESIZE,SHAPESIZE)
	
	randomize_sprite_color()

func randomize_sprite_color() -> void:
	sprite_2d.modulate = (Color(randf(),randf(),randf(),1.0))
	randomize_new_color()

func randomize_new_color() -> void:
	randomize()
	new_color = (Color(randf(),randf(),randf(),1.0))

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if !pressed :
		sprite_2d.modulate = lerp(sprite_2d.modulate,new_color,0.01)
	
	if(!velocity.is_zero_approx()):
		sprite_2d.transform.origin += velocity * CONTROLLERSPEED

func _on_timer_timeout() -> void:
	randomize_new_color()

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("Action1"):
		print("Pressed " + event.as_text())
		sprite_2d.modulate = Color.GREEN
		pressed = true
	
	if event.is_action_pressed("Action2"):
		print("Pressed " + event.as_text())
		sprite_2d.modulate = Color.RED
		pressed = true
			
	if event.is_action_pressed("DirUp"):
		print("Pressed " + event.as_text())
		sprite_2d.transform.origin = originPos - Vector2(0,DISTANCEOFFSET)

	if event.is_action_pressed("DirDown"):
		print("Pressed " + event.as_text())
		sprite_2d.transform.origin += Vector2(0,DISTANCEOFFSET)

	if event.is_action_pressed("DirLeft"):
		print("Pressed " + event.as_text())
		sprite_2d.transform.origin -= Vector2(DISTANCEOFFSET,0)
	
	if event.is_action_pressed("DirRight"):
		print("Pressed " + event.as_text())
		sprite_2d.transform.origin += Vector2(DISTANCEOFFSET,0)

	if Input.get_axis("NegativeHorizontal","PostiveHorizontal") != 0:
		velocity.x = Input.get_axis("NegativeHorizontal","PostiveHorizontal")
	else:
		velocity.x = 0
	
	if Input.get_axis("NegativeVertical","PostiveVertical") != 0:
		velocity.y = Input.get_axis("NegativeVertical","PostiveVertical")
	else:
		velocity.y = 0

	if event.is_action_released("Action1"):
		pressed = false
	
	if event.is_action_released("Action2"):
		pressed = false

	if event.is_action_released("DirLeft"):
		sprite_2d.transform.origin = originPos

	if event.is_action_released("DirRight"):
		sprite_2d.transform.origin = originPos

	if event.is_action_released("DirUp"):
		sprite_2d.transform.origin = originPos

	if event.is_action_released("DirDown"):
		sprite_2d.transform.origin = originPos

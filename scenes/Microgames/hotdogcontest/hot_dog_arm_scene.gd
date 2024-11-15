extends Node2D

@onready var RotationSpeed = 0
@onready var CurrentRotation = -90
@onready var HoldingDog = true
@onready var CanEat = true
var RotationMultiplier = 3.5
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	rotation = -1.2

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if CanEat == true:
		var UpPressed = int(Input.is_action_pressed("DirUp")) + int(Input.is_action_just_pressed("PostiveHorizontal"))
		var X_value = ((UpPressed*2)-1)*4
		RotationSpeed = X_value * RotationMultiplier
	rotation += RotationSpeed * delta 
	rotation = clamp(rotation,-1.2,0)
	if rotation < -1.1:
		_GrabDog()

func _EatingTheDogs():
	HoldingDog = false
	$AnimationPlayer.play("DestroyHotDog")

func _DestroyDog():
		$AnimatedSprite2D.frame = 1

func _GrabDog():
	$AnimatedSprite2D.frame = 0
	HoldingDog = true

func _EndMinigame():
	if CanEat == false:
		$AnimationPlayer.play("HideArm")

func _HideArm():
	RotationSpeed = -4 * RotationMultiplier

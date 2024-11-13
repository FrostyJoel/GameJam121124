extends Node2D
var RandAmountOfSheep : int = randi_range(1,6)
var CurrentAmountOfSheep : int
@onready var UI : Label = $Control.get_child(0)
var counter : int = 0
var Game_Ongoing : bool = true
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	$Camera2D.make_current()
	
	CurrentAmountOfSheep = RandAmountOfSheep
	var _sheep = load("res://scenes/count_sheep.tscn")
	for n in CurrentAmountOfSheep:
		var _sheep_instance = _sheep.instantiate()
		get_tree().current_scene.add_child(_sheep_instance)
		_sheep_instance.global_position.x = randf_range(-500, 400)
		_sheep_instance.global_position.y = randf_range(-500, 500)
		_sheep_instance.rotation = randi_range(0, 359)
		var Sheep_Size_Set = randf_range(0.5, 2.5)
		_sheep_instance.scale.x = Sheep_Size_Set
		_sheep_instance.scale.y = Sheep_Size_Set
	$CooldownTimer.start()
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("Action1") && Game_Ongoing:
		BumpCounterUp()
	if Input.is_action_just_pressed("Action2") && Game_Ongoing:
		BumpCounterDown()

func BumpCounterUp():
	counter = counter + 1
	UI.text = str(counter)

func BumpCounterDown():
	if(counter > 0):
		counter = counter - 1
		UI.text = str(counter)

func _on_cooldown_timer_timeout() -> void:
	Game_Ongoing = false
	if(CurrentAmountOfSheep == counter):
		#return success here
		pass
		UI.text = ("Succeeded!")
	else:
		#return failure here
		pass
		UI.text = ("Failed!")

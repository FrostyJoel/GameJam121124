extends microgame_base
var RandAmountOfSheep : int = randi_range(1,6)
var CurrentAmountOfSheep : int
@onready var UI : Label = $Control.get_child(0).get_child(1)
var counter : int = 0
var Game_Ongoing : bool = true
var SheepsArray : Array

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	$Camera2D.make_current()
	
	CurrentAmountOfSheep = RandAmountOfSheep
	var _sheep = load("res://scenes/Microgames/countthesheep/count_sheep.tscn")
	for n in CurrentAmountOfSheep:
		var _sheep_instance = _sheep.instantiate()
		get_tree().current_scene.add_child(_sheep_instance)
		_sheep_instance.global_position.x = randf_range(-500, 400)
		_sheep_instance.global_position.y = randf_range(-500, 500)
		_sheep_instance.rotation = randi_range(0, 359)
		var Sheep_Size_Set = randf_range(1, 2.5)
		_sheep_instance.scale.x = Sheep_Size_Set
		_sheep_instance.scale.y = Sheep_Size_Set
		SheepsArray.append(_sheep_instance)
	$CooldownTimer.start()
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _input(event: InputEvent) -> void:
	if Input.is_action_pressed("DirUp") && Game_Ongoing:
		BumpCounterUp()
		print("up")
	if Input.is_action_pressed("DirDown") && Game_Ongoing:
		BumpCounterDown()
		print("down")
		
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
		microgameEnded.emit(true)
	else:
		#return failure here
		microgameEnded.emit(false)
	
	_delete_all_sheep()

func _delete_all_sheep():
	for _sheep_instance in SheepsArray:
		_sheep_instance.queue_free()
	

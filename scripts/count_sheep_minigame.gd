extends Node2D
var RandAmountOfSheep : int = randi_range(1,6)
var CurrentAmountOfSheep : int

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	$Camera2D.make_current()
	
	CurrentAmountOfSheep = RandAmountOfSheep
	var _sheep = load("res://scenes/count_sheep.tscn")
	for n in CurrentAmountOfSheep:
		var _sheep_instance = _sheep.instantiate()
		get_tree().current_scene.add_child(_sheep_instance)
		_sheep_instance.global_position.x = randf_range(-250, 250)
		_sheep_instance.global_position.y = randf_range(-250, 250)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

extends Node2D

@export var min_range: float = 0.0
@export var max_range: float = 4.0
var rng = RandomNumberGenerator.new()
@onready var player = get_parent().get_node("SpaceShip")

func _ready() -> void:
	var random_number = rng.randf_range(min_range, max_range)
	$Timer.wait_time = random_number
	$Timer.start()

func _on_timer_timeout() -> void:
	var _astroid = load("res://scenes/Microgames/defendtheflag/scenes/astroid_1.tscn")
	var _astroid_instance = _astroid.instantiate()
	$"..".add_child(_astroid_instance)
	_astroid_instance.global_position = global_position
	_astroid_instance.look_at(player.global_position)

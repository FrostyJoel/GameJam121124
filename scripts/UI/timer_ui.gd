extends Control

var currentTimer: Timer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	currentTimer.get_time_left()

func _init(timer: Timer) -> void:
	currentTimer = timer
	$PanelContainer/HBoxContainer/ProgressBar.max_value = currentTimer.

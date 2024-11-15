extends Node

@onready var progress_bar: ProgressBar = $Control/PanelContainer/HBoxContainer/ProgressBar
@onready var labeltext: Label = $Control/Label
var timerRef: Timer = null
var percentage_of_time

func Init(gameTimer : Timer) -> void:
	timerRef = gameTimer
	print(gameTimer.is_stopped())
	print(timerRef.is_stopped())

func EnableTimer() -> void:
	print("Enable Timer")
	$Control.visible = true

func DisableTimer() -> void:
	print("Disable Timer")
	$Control.visible = false

func _process(delta: float) -> void:
	if timerRef != null:
		#if timerRef.get_time_left() > 0:
			#percentage_of_time = (
				#(1-timerRef.get_time_left() / timerRef.get_wait_time()) * 100
			#)
			#progress_bar.value = percentage_of_time
		labeltext.text = str("%.0f" % timerRef.get_time_left())
		#print(timerRef.get_time_left())

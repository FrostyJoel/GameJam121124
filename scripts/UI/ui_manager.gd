extends Node

@export var healthContainer: HBoxContainer
@onready var health_amount: Label = $"Health Amount"
@onready var score_amount: Label = $"Score Amount"
@onready var you_lose: Label = $"You Lose"
@onready var final_score: Label = $"You Lose/FinalScore"
@onready var high_score: Label = $"You Lose/HighScore"

@export var healthIcon1 : TextureRect
@export var healthIcon2 : TextureRect
@export var healthIcon3 : TextureRect

signal restartGame

var highScore : int = -1

func UpdateHealthUI(newHealth:int) -> void:
	healthIcon1.visible = false
	healthIcon2.visible = false
	healthIcon3.visible = false
	
	if (newHealth == 3):
		healthIcon1.visible = true
		healthIcon2.visible = true
		healthIcon3.visible = true
	elif (newHealth == 2):
		healthIcon1.visible = true
		healthIcon2.visible = true
	elif (newHealth == 1):
		healthIcon1.visible = true
	
	health_amount.text = "Health Amount: " + str(newHealth) 


func UpdateScoreUI(newScore:int) -> void:
	score_amount.text = "Days Slept: " + str(newScore)
	
	if newScore > highScore:
		highScore = newScore


func EnableFinalScore(finalScore:int) -> void:
	DisableUI()
	you_lose.visible = true;
	final_score.text = "Final Score: \n" + str(finalScore)
	high_score.text = "High Score: \n" + str(highScore)

func DisableFinalScore() -> void:
	EnableUI()
	you_lose.visible = false;

func DisableUI() -> void:
	healthContainer.visible = false
	health_amount.visible = false
	score_amount.visible = false

func EnableUI() -> void:
	healthContainer.visible = true
	#health_amount.visible = true
	score_amount.visible = true
	DisableTimer()

func Enabletimer(gameTimer : Timer) -> void:
	$TimerUi.Init(gameTimer)
	$TimerUi.EnableTimer()

func DisableTimer() -> void:
	$TimerUi.DisableTimer()

func save() -> Dictionary:
	var save_dict = {
		"highscore" : highScore,
	}
	return save_dict

func loadData(data : Dictionary):
	for i in data.keys():
		if i == "highscore":
			highScore = data.get(i)
	print("Loaded Highscore: '%f' ",highScore)

func _on_microgame_manager_on_micro_game_loaded() -> void:
	print("Disable UI Cause Micro game Loaded")
	DisableUI()

func _on_node_2d_on_game_over(finalScore:int) -> void:
	DisableUI()
	$TimerUi.DisableTimer()
	EnableFinalScore(finalScore)


func _on_node_2d_on_health_update(newHealth: int) -> void:
	UpdateHealthUI(newHealth)


func _on_node_2d_on_score_update(newScore: int) -> void:
	UpdateScoreUI(newScore)


func _on_button_pressed() -> void:
	restartGame.emit()


func _on_restart_game() -> void:
	Engine.time_scale = 1
	EnableUI()
	DisableFinalScore()

func _spawn_timer(timer: Timer) -> void:
		$TimerUi.visible = true
		$TimerUi.init(timer)


func _on_button_2_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/UI/MainMenu.tscn")

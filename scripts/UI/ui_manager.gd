extends Node

@onready var health_amount: Label = $"Health Amount"
@onready var score_amount: Label = $"Score Amount"
@onready var you_lose: Label = $"You Lose"
@onready var final_score: Label = $"You Lose/FinalScore"
@onready var high_score: Label = $"You Lose/HighScore"

signal restartGame

var highScore : int = -1

func UpdateHealthUI(newHealth:int) -> void:
	health_amount.text = "Health Amount: " + str(newHealth) 


func UpdateScoreUI(newScore:int) -> void:
	score_amount.text = "Score Amount: " + str(newScore)
	
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
	health_amount.visible = false
	score_amount.visible = false


func EnableUI() -> void:
	health_amount.visible = true
	score_amount.visible = true


func _on_microgame_manager_on_micro_game_loaded() -> void:
	print("Disable UI Cause Micro game Loaded")
	DisableUI()

func _on_node_2d_on_game_over(finalScore:int) -> void:
	DisableUI()
	EnableFinalScore(finalScore)


func _on_node_2d_on_health_update(newHealth: int) -> void:
	UpdateHealthUI(newHealth)


func _on_node_2d_on_score_update(newScore: int) -> void:
	UpdateScoreUI(newScore)


func _on_button_pressed() -> void:
	restartGame.emit()


func _on_restart_game() -> void:
	EnableUI()
	DisableFinalScore()

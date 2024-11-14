extends Node2D

var currentScore : int
var currentHealth : int :
	set(value):
		currentHealth = clamp(value,0,maxHealth)

@export var maxHealth : int
@export var speedUpScoreThreshold : int = 6
@export var maxSpeedUpSteps : int = 8
@export var speedUpMultiplierStep : float = 0.2

signal onGameOver(finalScore:int)
signal onHealthUpdate(newHealth:int)
signal onScoreUpdate(newScore:int)

var timesSpedUp : int

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$MicrogameManager.microGameWin.connect(MicrogameWin) #Connect micro game outcome signals
	$MicrogameManager.microGameLose.connect(MicrogameLose)
	$SaveManager.load_game()
	init()

func init() -> void:
	StartGame()

# Tells the microgame manager to start spawning microgames
func StartGame():
	ResetValue()
	$MicrogameManager.init()

func ResetValue():
	currentScore = 0
	currentHealth = maxHealth
	$UiManager.UpdateHealthUI(currentHealth)
	$UiManager.UpdateScoreUI(currentScore)

func _on_ui_manager_restart_game() -> void:
	init()

# Tells the UI to show the current microgame timer
# TODO
func ShowTimer(time: float):
	pass


# Functions for winning and losing microgames, called from the microgame manager
func MicrogameLose():
	print("Microgame Loss...")
	LoseHealth()

func MicrogameWin():
	print("Microgame Won!")
	SpawnNextMicroGame()

func LoseHealth():
	if (currentHealth > 1):
		currentHealth -= 1
		SpawnNextMicroGame()
	else:
		GameOver()
	
	onHealthUpdate.emit(currentHealth)
	

func SpawnNextMicroGame():
	CheckScore()
	$UiManager.EnableUI()
	$MicrogameManager.StartSpawningTimer()

# Checks score for speed up & boss triggers
func CheckScore():
	currentScore += 1 # Add one to score
	onScoreUpdate.emit(currentScore)
	
	if (currentScore >= (speedUpScoreThreshold * (timesSpedUp + 1))):
		timesSpedUp += 1
		Engine.time_scale = 1 + (speedUpMultiplierStep) * timesSpedUp


# Called when the player loses all health
func GameOver():
	onGameOver.emit(currentScore)
	$SaveManager.save_game()
	Engine.time_scale = 1

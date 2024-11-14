extends Node2D

var currentScore : int

var currentHealth : int
var maxHealth : int

@export var speedUpScoreThreshold : int = 6
@export var maxSpeedUpSteps : int = 8
@export var speedUpMultiplierStep : float = 0.2
var timesSpedUp : int

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$MicrogameManager.microGameWin.connect(MicrogameWin) #Connect micro game outcome signals
	$MicrogameManager.microGameLose.connect(MicrogameLose)
	StartGame()


# Tells the microgame manager to start spawning microgames
func StartGame():
	$MicrogameManager.SpawnMicrogame()


# Tells the UI to show the current microgame timer
# TODO
func ShowTimer(time: float):
	pass


# Functions for winning and losing microgames, called from the microgame manager
func MicrogameLose():
	print("Microgame Loss...")
	CheckScore()

func MicrogameWin():
	print("Microgame Won!")
	CheckScore()

# Checks score for speed up & boss triggers
func CheckScore():
	currentScore += 1 # Add one to score
	
	if (currentScore >= (speedUpScoreThreshold * (timesSpedUp + 1))):
		timesSpedUp += 1
		Engine.time_scale = 1 + (speedUpMultiplierStep) * timesSpedUp


# Called when the player loses all health
func GameOver():
	Engine.time_scale = 1
	pass

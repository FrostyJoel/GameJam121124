extends Node2D

var currentScore : int

var currentHealth : int
var maxHealth : int

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$MicrogameManager.microGameWin.connect(MicrogameWin) #Connect micro game outcome signals
	$MicrogameManager.microGameLose.connect(MicrogameLose)
	StartGame()


# Tells the microgame manager to start spawning microgames
func StartGame():
	$MicrogameManager.SpawnMicrogame()


# Tells the UI to show the current microgame timer
func ShowTimer(time: float):
	pass


# Functions for winning and losing microgames, called from the microgame manager
func MicrogameLose():
	print("Microgame Loss...")

func MicrogameWin():
	print("Microgame Won!")


# Called when the player loses all health
func GameOver():
	pass

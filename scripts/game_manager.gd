extends Node2D

var currentScore : int

var currentHealth : int
var maxHealth : int

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	StartGame()


# Tells the microgame manager to start spawning microgames
func StartGame():
	print("Starting game")


# Tells the UI to show the current microgame timer
func ShowTimer(time: float):
	pass


func MicrogameLose():
	pass

func MicrogameWin():
	pass


# Called when the player loses all health
func GameOver():
	pass

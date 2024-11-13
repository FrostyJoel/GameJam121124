extends Node2D

var currentScore : int

var currentHealth : int
var maxHealth : int

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Tells the microgame manager to start spawning microgames
func StartGame():
	pass


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

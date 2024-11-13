extends Node2D

signal microGameWin
signal microGameLose

# Spawns a random microgame
func SpawnMicrogame():
	pass

# Call this function to end the current microgame in either a success or failure
func MicrogameOver(win: bool) -> void:
	if (win):
		microGameWin.emit()
	else:
		microGameLose.emit()

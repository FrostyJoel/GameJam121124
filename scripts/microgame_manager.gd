extends Node2D

@export var microgames : Array[MicrogameData]

var timesPicked : Array[int]
var lastPickedMicrogame : int = 999
var currentMicrogame : Node

signal microGameWin
signal microGameLose

func _ready() -> void:
	# Initialize picked array
	timesPicked.resize(microgames.size())
	timesPicked.fill(0)

# Spawns a random microgame
func SpawnMicrogame():
	var index = GetRandomIndex()
	var variationIndex = GetVariationIndex(index)
	var variationToSpawn = microgames[index].variations[variationIndex]
	print(variationIndex)
	currentMicrogame = variationToSpawn.instantiate()
	add_child(currentMicrogame)
	
	# Add one to times picked
	timesPicked[index] += 1
	
	# Connect to microgame ended signal
	currentMicrogame.microgameEnded.connect(MicrogameOver)

func GetRandomIndex() -> int:
	var randomIndex : int
	
	if microgames.size() == 1: # Don't do this if there is only 1 microgame
		randomIndex = 0
	else:
		randomIndex = randi_range(0, microgames.size() -1)
		while randomIndex == lastPickedMicrogame:
			randomIndex = randi_range(0, microgames.size() -1)
	
	lastPickedMicrogame = randomIndex # Set last picked index
	return randomIndex

func GetVariationIndex(microgameIndex : int) -> int:
	var index : int = timesPicked[microgameIndex]
	if index >= microgames[microgameIndex].variations.size():
		timesPicked[microgameIndex] = 0
		index = 0
	return index


# Call this function to end the current microgame in either a success or failure
func MicrogameOver(win: bool) -> void:
	if (win):
		microGameWin.emit()
	else:
		microGameLose.emit()
	
	# despawn old microgame and spawn another
	currentMicrogame.queue_free()
	$BetweenMicrogames.start()


func _on_between_microgames_timeout() -> void:
	SpawnMicrogame()

extends Node2D

@export var microgames : Array[MicrogameData]
@onready var ui_manager = $"../UiManager"

var timesPicked : Array[int]
var lastPickedMicrogame : int = 999
var currentMicrogame : Node
var index : int

signal microGameWin
signal microGameLose
signal onMicroGameUnloaded
signal onMicroGameLoaded

func init() -> void:
	# Initialize picked array
	if timesPicked.size() > 0:
		timesPicked.clear()
	
	timesPicked.resize(microgames.size())
	timesPicked.fill(0)
	StartSpawningTimer()

func StartSpawningTimer() -> void:
	$BetweenMicrogames.start()

func ShowHint() -> void:
	index = GetRandomIndex()
	ui_manager.ShowMicroGamePopUp()
	ui_manager.microgame_popup.text = microgames[index].instruction
	$AfterWordPopUp.start()

# Spawns a random microgame
func SpawnMicrogame():
	ui_manager.HideMicroGamePopUp()
	var variationIndex = GetVariationIndex(index)
	var variationToSpawn = microgames[index].variations[variationIndex]
	
	
	currentMicrogame = variationToSpawn.instantiate()

	
	
	add_child(currentMicrogame)
	
	# Add one to times picked
	timesPicked[index] += 1
	
	# Connect to microgame ended signal
	currentMicrogame.microgameEnded.connect(MicrogameOver)
	
	onMicroGameLoaded.emit()

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
	
	onMicroGameUnloaded.emit()

func _on_between_microgames_timeout() -> void:
	ShowHint()


func _on_after_word_pop_up_timeout() -> void:
	SpawnMicrogame()

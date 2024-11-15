extends microgame_base

var CurrentDogsEaten = 0
var HoldingDog = false
var GameWon = false
const DogEaterNumber = 3

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Timer.start()
	#Needed to find and enableTimer
	var uiManager = get_tree().get_nodes_in_group("UiManager")
	for node in uiManager:
		# Check the node has a save function.
		if !node.has_method("Enabletimer"):
			print("persistent node '%s' is missing a Enabletimer() function, skipped" % node.name)
			continue
		node.call("Enabletimer",7)
		$DogEaterNumber.text = str(DogEaterNumber)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	HoldingDog = $HotDogArmScene.HoldingDog
	if not(CurrentDogsEaten > DogEaterNumber):
		if (Input.is_action_just_pressed("Action1") || Input.is_action_just_pressed("Action2")):
			if HoldingDog == true && $HotDogArmScene.rotation == 0:
				$HotDogMan.play("default")
				$HotDogArmScene._EatingTheDogs()
				$AudioStreamPlayer2D.stream = load("res://audio/HotdogGame/EatingNoise" + str(randi_range(1,3)) + ".mp3")
				$AudioStreamPlayer2D.play()
				CurrentDogsEaten += 1
				$PlayerNumber.text = str(CurrentDogsEaten)
				if CurrentDogsEaten > DogEaterNumber:
					$PlayerNumber.add_theme_color_override("font_color", Color("GOLD"))
					$PlayerNumber.add_theme_color_override("font_outline_color", Color("GOLDENROD"))
					$HotDogArmScene.CanEat = false
					GameWon = true
					#$HotDogArmScene._EndMinigame()
					$Timer.stop()
					$WinGameTimer.start()


func _on_timer_timeout() -> void:
	if GameWon == false:
		microgameEnded.emit(false)

func _on_win_game_timer_timeout() -> void:
	microgameEnded.emit(true)

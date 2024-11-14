extends microgame_base

var CurrentDogsEaten = 0
var HoldingDog = false
var GameWon = false
const DogEaterNumber = 6

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Timer.start()
	$DogEaterNumber.text = str(DogEaterNumber)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	HoldingDog = $HotDogArmScene.HoldingDog
	if not(CurrentDogsEaten > DogEaterNumber):
		if (Input.is_action_just_pressed("Action1") || Input.is_action_just_pressed("Action2")):
			if HoldingDog == true && $HotDogArmScene.rotation == 0:
				$HotDogMan.play("default")
				$HotDogArmScene._EatingTheDogs()
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

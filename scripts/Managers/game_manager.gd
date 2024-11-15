extends Node2D

var currentScore : int
var currentHealth : int :
	set(value):
		currentHealth = clamp(value,0,maxHealth)

@export var maxHealth : int
@export var speedUpScoreThreshold : int = 8
@export var maxSpeedUpSteps : int = 10
@export var speedUpMultiplierStep : float = 0.1

signal onGameOver(finalScore:int)
signal onHealthUpdate(newHealth:int)
signal onScoreUpdate(newScore:int)

var timesSpedUp : int
var temp = null

@export var dreamBubbles : AnimatedSprite2D
@export var microgameCloud : Sprite2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$GameMusicAudioPlayer.play()
	$MicrogameManager.microGameWin.connect(MicrogameWin) #Connect micro game outcome signals
	$MicrogameManager.microGameLose.connect(MicrogameLose)
	$SaveManager.load_game()
	init()

func init() -> void:
	timesSpedUp = 0
	$GameManager/GameStartTimer.start()

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
func ShowTimer(time: float):
	pass


# Functions for winning and losing microgames, called from the microgame manager
func MicrogameLose():
	print("Microgame Loss...")
	$LoseAudioPlayer.play()
	AfterMicrogame()
	LoseHealth()

func MicrogameWin():
	print("Microgame Won!")
	$WinAudioPlayer.play()
	AfterMicrogame()
	$GameManager/TransitionTimer.start()

func AfterMicrogame():
	$GameMusicAudioPlayer.set_volume_db(10)
	DoDreamBubbleReverse()
	microgameCloud.visible = false

func LoseHealth():
	if (currentHealth > 1):
		currentHealth -= 1
		SpawnNextMicroGame()
	else:
		GameOver()
	
	onHealthUpdate.emit(currentHealth)

func SpawnNextMicroGame():
	CheckScore()
	$GameManager/TransitionTimer.start()

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


func DoDreamBubbles():
	dreamBubbles.visible = true
	dreamBubbles.play()

func DoDreamBubbleReverse():
	dreamBubbles.visible = true
	dreamBubbles.play_backwards()
	$GameManager/BubbleLeaveTimer.start()


# Initial timer when the player starts the game for the first time
func _on_game_start_timer_timeout() -> void:
	$GameManager/BubbleTimer.start()
	DoDreamBubbles()

# Timer for transitions between microgames
func _on_transition_timer_timeout() -> void:
	$GameManager/BubbleTimer.start()
	DoDreamBubbles()
	$GameMusicAudioPlayer.set_volume_db(18)
	print("AUDIO?")

# Small timer to wait for the dream bubbles
func _on_bubble_timer_timeout() -> void:
	microgameCloud.visible = true
	if (currentScore == 0):
		StartGame()
	else:
		$UiManager.EnableUI()
		$MicrogameManager.StartSpawningTimer()
	dreamBubbles.visible = false

# Small timer for when the bubble leaves
func _on_bubble_leave_timer_timeout() -> void:
	dreamBubbles.visible = false

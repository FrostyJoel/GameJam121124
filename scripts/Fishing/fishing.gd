extends microgame_base

enum FishingInputs {
	ACTION1,
	ACTION2,
	DIRUP,
	DIRLEFT,
	DIRRIGHT,
	DIRDOWN,
}

var inputImage: Dictionary = {
	FishingInputs.ACTION1 : "res://assets/images/controller/button_xbox_digital_a_5.png",
	FishingInputs.ACTION2 : "res://assets/images/controller/button_xbox_digital_b_5.png",
	FishingInputs.DIRUP : "res://assets/images/controller/button_xbox_dpad_dark_1.png",
	FishingInputs.DIRLEFT : "res://assets/images/controller/button_xbox_dpad_dark_4.png",
	FishingInputs.DIRRIGHT : "res://assets/images/controller/button_xbox_dpad_dark_2.png",
	FishingInputs.DIRDOWN : "res://assets/images/controller/button_xbox_dpad_dark_3.png",
}

@export var currentInput: FishingInputs = FishingInputs.ACTION1

@onready var bobber_timer: Timer = $BobberTimer
@onready var fish_get_away_timer: Timer = $FishGetAwayTimer
@onready var total_time: Timer = $TotalTime

@onready var input_button: Sprite2D = $InputButton
@export var debug_square: Sprite2D

var correctInput: bool = false;
var completedFishingBobbing : bool = false;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	currentInput = randi_range(0,FishingInputs.size()-1)
	
	bobber_timer.wait_time = randf_range(1,2)
	bobber_timer.start()
	
	fish_get_away_timer.wait_time = randf_range(2,3)
	var totalFishTime = bobber_timer.wait_time + fish_get_away_timer.wait_time
	
	total_time.wait_time = randf_range(totalFishTime+ 2,totalFishTime + 3)
	total_time.start();
	
	#Needed to find and enableTimer
	var uiManager = get_tree().get_nodes_in_group("Ui")
	for node in uiManager:
		# Check the node has a Enabletimer function.
		if !node.has_method("Enabletimer"):
			print("persistent node '%s' is missing a Enabletimer() function, skipped" % node.name)
			continue
		
		node.call("Enabletimer",total_time)
	
	debug_square.modulate = Color.FIREBRICK

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("Action1"):
		if currentInput == FishingInputs.ACTION1:
			correctInput = true
		ReelFishingRod()

	if event.is_action_pressed("Action2"):
		if currentInput == FishingInputs.ACTION2:
			correctInput = true
		ReelFishingRod()

	if event.is_action_pressed("DirUp"):
		if currentInput == FishingInputs.DIRUP:
			correctInput = true
		ReelFishingRod()

	if event.is_action_pressed("DirDown"):
		if currentInput == FishingInputs.DIRDOWN:
			correctInput = true
		ReelFishingRod()

	if event.is_action_pressed("DirLeft"):
		if currentInput == FishingInputs.DIRLEFT:
			correctInput = true
		ReelFishingRod()

	if event.is_action_pressed("DirRight"):
		if currentInput == FishingInputs.DIRRIGHT:
			correctInput = true
		ReelFishingRod()

func ReelFishingRod():
	bobber_timer.stop()
	fish_get_away_timer.stop()
	total_time.stop()
	if completedFishingBobbing && correctInput:
		print("CorrectlyFished")
		debug_square.modulate = Color.GREEN
		microgameEnded.emit(true)
	#Return Completed good
	else:
		print("Fished Wrong")
		debug_square.modulate = Color.WEB_GRAY
		microgameEnded.emit(false)
	#Return Completed False

func _on_bobber_timer_timeout() -> void:
	completedFishingBobbing = true;
	debug_square.modulate = Color.YELLOW
	
	input_button.texture = load(inputImage.get(currentInput))
	
	fish_get_away_timer.start()


func _on_fish_get_away_timer_timeout() -> void:
	print("Fished Wrong")
	debug_square.modulate = Color.RED


func _on_total_time_timeout() -> void:
	ReelFishingRod()

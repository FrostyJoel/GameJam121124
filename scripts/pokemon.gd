extends microgame_base

@onready var move_1: Label = $Move1
@onready var move_2: Label = $Move2
@onready var move_3: Label = $Move3
@onready var move_4: Label = $Move4
@onready var timer: Timer = $Timer
@onready var currentlabel = move_1
@onready var currentbutton = $ButtonTest1
@onready var UnselectedButton = load("res://assets/images/Pokemon/ButtonTest.png")
@onready var SelectedButton = load("res://assets/images/Pokemon/ButtonSelected.png")
var gameended = false
var CorrectMoveChosen = false


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var slots = [move_1, move_2, move_3, move_4]
	var movetypes = ["good", "bad", "bad", "bad"]
	var badmoves= ["Fluffy Slap", "Cute Dance", "Wink", "Cuddle Clap", "Huggy Dash", "Snuggle Slide"]
	var goodmoves = ["Hyper Shock", "Mega Blast", "Techtonic Shift", "Volcanic Beam", "Tsunami Terror", "Hurricane Rage"]
	
	
	# Assign moves to each slot
	for n in 4:
		var random = randi_range(0,3-n)
		var move = "null"
		if movetypes[random] == "bad":
			var randombad = randi_range(0, badmoves.size()-1)
			move = badmoves[randombad]
			badmoves.remove_at(randombad)
			slots[0].set_meta("Tag","bad")
		else:
			var randomgood = randi_range(0, goodmoves.size()-1)
			move = goodmoves[randomgood]
			goodmoves.remove_at(randomgood)
			slots[0].set_meta("Tag", "good")
		slots[0].text = move
		slots.remove_at(0)
		movetypes.remove_at(random)
		
	currentlabel.add_theme_color_override("font_color", Color(255,0,0))
	currentbutton.texture = SelectedButton
	
	timer.start()
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	#Player input
	if gameended == false:
		if Input.is_action_just_pressed("DirLeft") or Input.is_action_just_pressed("NegativeHorizontal"):
			if currentlabel == move_2:
				currentlabel.add_theme_color_override("font_color", Color(0,0,0))
				currentbutton.texture = UnselectedButton
				currentlabel = move_1
				currentbutton = $ButtonTest1
				currentlabel.add_theme_color_override("font_color", Color(255,0,0))
				currentbutton.texture = SelectedButton
			elif currentlabel == move_4:
				currentlabel.add_theme_color_override("font_color", Color(0,0,0))
				currentbutton.texture = UnselectedButton
				currentlabel = move_3
				currentbutton = $ButtonTest3
				currentlabel.add_theme_color_override("font_color", Color(255,0,0))
				currentbutton.texture = SelectedButton
				
		if Input.is_action_just_pressed("DirRight") or Input.is_action_just_pressed("PositiveHorizontal"):
			if currentlabel == move_1:
				currentlabel.add_theme_color_override("font_color", Color(0,0,0))
				currentbutton.texture = UnselectedButton
				currentlabel = move_2
				currentbutton = $ButtonTest2
				currentlabel.add_theme_color_override("font_color", Color(255,0,0))
				currentbutton.texture = SelectedButton
			elif currentlabel == move_3:
				currentlabel.add_theme_color_override("font_color", Color(0,0,0))
				currentbutton.texture = UnselectedButton
				currentlabel = move_4
				currentbutton = $ButtonTest4
				currentlabel.add_theme_color_override("font_color", Color(255,0,0))
				currentbutton.texture = SelectedButton
				
		if Input.is_action_just_pressed("DirUp") or Input.is_action_just_pressed("PostiveVertical"):
			if currentlabel == move_3:
				currentlabel.add_theme_color_override("font_color", Color(0,0,0))
				currentbutton.texture = UnselectedButton
				currentlabel = move_1
				currentbutton = $ButtonTest1
				currentlabel.add_theme_color_override("font_color", Color(255,0,0))
				currentbutton.texture = SelectedButton
			elif currentlabel == move_4:
				currentlabel.add_theme_color_override("font_color", Color(0,0,0))
				currentbutton.texture = UnselectedButton
				currentlabel = move_2
				currentbutton = $ButtonTest2
				currentlabel.add_theme_color_override("font_color", Color(255,0,0))
				currentbutton.texture = SelectedButton
				
		if Input.is_action_just_pressed("DirDown") or Input.is_action_just_pressed("NegativeVertical"):
			if currentlabel == move_1:
				currentlabel.add_theme_color_override("font_color", Color(0,0,0))
				currentbutton.texture = UnselectedButton
				currentlabel = move_3
				currentbutton = $ButtonTest3
				currentlabel.add_theme_color_override("font_color", Color(255,0,0))
				currentbutton.texture = SelectedButton
			elif currentlabel == move_2:
				currentlabel.add_theme_color_override("font_color", Color(0,0,0))
				currentbutton.texture = UnselectedButton
				currentlabel = move_4
				currentbutton = $ButtonTest4
				currentlabel.add_theme_color_override("font_color", Color(255,0,0))
				currentbutton.texture = SelectedButton
		
		if Input.is_action_just_pressed("Action1") or Input.is_action_just_pressed("Action2"):
			if currentlabel.get_meta("Tag") == "good":
				$WinAnimationPlayer.play("WinGame")
				CorrectMoveChosen = true
				#print("you win")
				#microgameEnded.emit(true)
				#timer.stop()
				#gameended = true
			else:
				$WinAnimationPlayer.play("LoseGame")
				#print("you lose")
				#microgameEnded.emit(false)
				#gameended = true
			

func _EndGame(win: bool) -> void:
				print(str(win))
				microgameEnded.emit(win)
				timer.stop()
				gameended = true

# Fail state when timer runs out
func _on_timer_timeout() -> void:
	if CorrectMoveChosen == false:
		print("YOU LOSE") # Replace with function body.
		microgameEnded.emit(false)
		gameended = true
	else:
		_EndGame(true)

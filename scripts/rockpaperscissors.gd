extends Node2D

@onready var opponent: Label = $Opponent
@onready var player: Label = $Player


func _ready() -> void:
	#Assign opponent's choice
	var randomint = randi_range(0,2)
	if randomint == 0:
		opponent.text = "ROCK"
	elif randomint == 1:
		opponent.text = "PAPER"
	elif randomint == 2:
		opponent.text = "SCISSORS"
		
	player.text = "ROCK"

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#Change answer with stick(left)
	if Input.is_action_just_pressed("DirLeft") or Input.is_action_just_pressed("NegativeHorizontal"):
		if player.text == "ROCK":
			player.text = "SCISSORS"
		elif player.text == "PAPER":
			player.text = "ROCK"
		elif player.text == "SCISSORS":
			player.text = "PAPER"
			
	#Change answer with stick(right)
	if Input.is_action_just_pressed("DirRight") or Input.is_action_just_pressed("PostiveHorizontal"):
		if player.text == "ROCK":
			player.text = "PAPER"
		elif player.text == "PAPER":
			player.text = "SCISSORS"
		elif player.text == "SCISSORS":
			player.text = "ROCK"
		
	#Enter answer
	if Input.is_action_just_pressed("Action1") or Input.is_action_just_pressed("Action2"):
		if opponent.text == "ROCK":
			if player.text == "PAPER":
				print("YOU WIN")
			else:
				print("YOU LOSE")
		if opponent.text == "PAPER":
			if player.text == "SCISSORS":
				print("YOU WIN")	
			else:
				print("YOU LOSE")
		if opponent.text == "SCISSORS":
			if player.text == "ROCK":
				print("YOU WIN")
			else:
				print("YOU LOSE")

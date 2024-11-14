extends microgame_base

@onready var opponent: Label = $Opponent
@onready var player: Label = $Player
@onready var timer: Timer = $Timer
@onready var playersprite: Sprite2D = $Player/PlayerSprite
@onready var opponent_sprite: Sprite2D = $Opponent/OpponentSprite

var rocktexture = preload("res://assets/images/Rock.png")
var rockflippedtexture = preload("res://assets/images/RockFlipped.png")
var papertexture = preload("res://assets/images/Paper.png")
var paperflippedtexture = preload("res://assets/images/PaperFlipped.png")
var scissortexture = preload("res://assets/images/Scissor.png")
var scissorflippedtexture = preload("res://assets/images/ScissorFlipped.png")
var currenttexture



func _ready() -> void:
	#Assign opponent's choice
	var randomint = randi_range(0,2)
	if randomint == 0:
		opponent.text = "ROCK"
		opponent_sprite.texture = rockflippedtexture
	elif randomint == 1:
		opponent.text = "PAPER"
		opponent_sprite.texture = paperflippedtexture
	elif randomint == 2:
		opponent.text = "SCISSORS"
		opponent_sprite.texture = scissorflippedtexture
		
	player.text = "ROCK"
	playersprite.texture = rocktexture
	currenttexture = rocktexture
	timer.start()
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	# Change answer with stick(left)
	if Input.is_action_just_pressed("DirLeft") or Input.is_action_just_pressed("NegativeHorizontal"):
		if player.text == "ROCK":
			player.text = "SCISSORS"
			playersprite.texture = scissortexture
		elif player.text == "PAPER":
			player.text = "ROCK"
			playersprite.texture = rocktexture
		elif player.text == "SCISSORS":
			player.text = "PAPER"
			playersprite.texture = papertexture
			
	# Change answer with stick(right)
	if Input.is_action_just_pressed("DirRight") or Input.is_action_just_pressed("PostiveHorizontal"):
		if player.text == "ROCK":
			player.text = "PAPER"
			playersprite.texture = papertexture
		elif player.text == "PAPER":
			player.text = "SCISSORS"
			playersprite.texture = scissortexture
		elif player.text == "SCISSORS":
			player.text = "ROCK"
			playersprite.texture = rocktexture
		
	# Enter answer
	if Input.is_action_just_pressed("Action1") or Input.is_action_just_pressed("Action2"):
		if opponent.text == "ROCK":
			if player.text == "PAPER":
				print("YOU WIN")
				microgameEnded.emit(true)
			else:
				print("YOU LOSE")
				microgameEnded.emit(false)
		if opponent.text == "PAPER":
			if player.text == "SCISSORS":
				print("YOU WIN")	
				microgameEnded.emit(true)
			else:
				print("YOU LOSE")
				microgameEnded.emit(false)
		if opponent.text == "SCISSORS":
			if player.text == "ROCK":
				print("YOU WIN")
				microgameEnded.emit(true)
			else:
				print("YOU LOSE")
				microgameEnded.emit(false)
				
# Fail state when timer runs out
func _on_timer_timeout() -> void:
	print("YOU LOSE") # Replace with function body.
	microgameEnded.emit(false)

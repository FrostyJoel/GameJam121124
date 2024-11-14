extends microgame_base

@onready var opponent: Label = $Opponent
@onready var player: Label = $Player
@onready var timer: Timer = $Timer
@onready var playersprite: Sprite2D = $Player/PlayerSprite
@onready var opponentsprite: Sprite2D = $Opponent/OpponentSprite

var rocktexture = preload("res://assets/images/Rock.png")
var rockflippedtexture = preload("res://assets/images/RockFlipped.png")
var papertexture = preload("res://assets/images/Paper.png")
var paperflippedtexture = preload("res://assets/images/PaperFlipped.png")
var scissortexture = preload("res://assets/images/Scissor.png")
var scissorflippedtexture = preload("res://assets/images/ScissorFlipped.png")
var gameended = false
var result


func _ready() -> void:
	#Assign opponent's choice
	var randomint = randi_range(0,2)
	if randomint == 0:
		opponentsprite.texture = rockflippedtexture
	elif randomint == 1:
		opponentsprite.texture = paperflippedtexture
	elif randomint == 2:
		opponentsprite.texture = scissorflippedtexture
		
	playersprite.texture = rocktexture
	timer.start()
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	# Change answer with stick(left)
	if gameended == false:
		if Input.is_action_just_pressed("DirLeft") or Input.is_action_just_pressed("NegativeHorizontal"):
			if playersprite.texture == rocktexture:	
				playersprite.texture = scissortexture
			elif playersprite.texture == papertexture:
				playersprite.texture = rocktexture
			elif playersprite.texture == scissortexture:
				playersprite.texture = papertexture
				
		# Change answer with stick(right)
		if Input.is_action_just_pressed("DirRight") or Input.is_action_just_pressed("PostiveHorizontal"):
			if playersprite.texture == rocktexture:
				playersprite.texture = papertexture
			elif playersprite.texture == papertexture:
				playersprite.texture = scissortexture
			elif playersprite.texture == scissortexture:
				playersprite.texture = rocktexture
			
		# Enter answer
		if Input.is_action_just_pressed("Action1") or Input.is_action_just_pressed("Action2"):
			if opponentsprite.texture == rockflippedtexture:
				if playersprite.texture == papertexture:
					print("YOU WIN")
					timer.stop()
					$Square.modulate = Color(0,255,0)
					$EndTimer.start()
					gameended = true
					result = true
				else:
					print("YOU LOSE")
					timer.stop()
					$Square.modulate = Color(255,0,0)
					$EndTimer.start()					
					gameended = true
					result = false
			if opponentsprite.texture == paperflippedtexture:
				if playersprite.texture == scissortexture:
					print("YOU WIN")	
					timer.stop()
					$Square.modulate = Color(0,255,0)
					$EndTimer.start()
					gameended = true
					result = true
				else:
					print("YOU LOSE")
					timer.stop()
					$Square.modulate = Color(255,0,0)
					$EndTimer.start()
					gameended = true
					result = false
			if opponentsprite.texture == scissorflippedtexture:
				if playersprite.texture == rocktexture:
					print("YOU WIN")
					timer.stop()
					$Square.modulate = Color(0,255,0)
					$EndTimer.start()
					gameended = true
					result = true
				else:
					print("YOU LOSE")
					timer.stop()
					$Square.modulate = Color(255,0,0)					
					$EndTimer.start()
					gameended = true
					result = false
				
# Fail state when timer runs out
func _on_timer_timeout() -> void:
	print("YOU LOSE") # Replace with function body.
	microgameEnded.emit(false)
	$Square.modulate = Color(255,0,0)
	$EndTimer.start()
	gameended = true


func _on_end_timer_timeout() -> void:
	microgameEnded.emit(result)

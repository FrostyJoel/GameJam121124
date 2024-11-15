extends CharacterBody2D

@export var amount_of_dirt_pieces = 25
var dirt_pieces : Array[Node2D]
var button_presses_pressed = 0
var block_input = false
var hide_cartridge_once = true
var win_condition_met = false

signal game_won
signal game_over

func _ready() -> void:
	$WindSprite.hide()
	$WorkingScreen.hide()
	$DustParticles.hide()
	$DustParticles2.hide()
	$BrokenScreen.hide()
	$DustParticles.emitting = false
	$DustParticles2.emitting = false
	$AnimationPlayer.play("WindBlowing")
	$GameTimer.start()
	
	print($CartridgeTopLeft.global_position)
	print($CartridgeBottomRight.global_position)	
	for dirt_piece in amount_of_dirt_pieces:
		var dirt_piece_to_spawn = preload("res://scenes/Microgames/blowthecartridge/scenes2/Dirt_For_Cartridge.tscn")
		var dirt_piece_instance : Node2D = dirt_piece_to_spawn.instantiate()
		dirt_piece_instance.position.x = $CartridgeTopLeft.position.x + randf_range(0, $CartridgeBottomRight.position.x - $CartridgeTopLeft.position.x)
		dirt_piece_instance.position.y = $CartridgeTopLeft.position.y + randf_range(0, $CartridgeBottomRight.position.y - $CartridgeTopLeft.position.y)
		dirt_pieces.append(dirt_piece_instance)
		add_child(dirt_piece_instance)
		print(dirt_piece_instance.position)

func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("Action2") || Input.is_action_just_pressed("Action1") and not block_input:
		button_presses_pressed += 1
		$WindSprite.show()
		$DustParticles.emitting = true
		$PressTimer.start()
		#blows away a piece of dirt if there is any left
		if dirt_pieces.size() > 0:
			var blown_dirt_piece : Node2D = dirt_pieces.pick_random()
			dirt_pieces.erase(blown_dirt_piece)
			blown_dirt_piece._get_blown()
			print(dirt_pieces.size())
	if button_presses_pressed >= amount_of_dirt_pieces / 5:
		$DustParticles.show()
	if button_presses_pressed >= amount_of_dirt_pieces / 2:
		$DustParticles2.show()
		
	if button_presses_pressed >= amount_of_dirt_pieces:
		block_input = true
		win_condition_met = true
		game_done()

func game_done():
	for dirt in dirt_pieces:
		dirt.queue_free()
	if hide_cartridge_once == true:
		hide_cartridge_once = false
		$AnimationPlayer.play("HideCartridge")

func _on_press_timer_timeout() -> void:
	$WindSprite.hide()
	$DustParticles.emitting = false
	$DustParticles2.emitting = false



func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "HideCartridge":
		$AnimationPlayer.play("ShowScreen")
	if anim_name == "ShowScreen":
		if win_condition_met == true:
			$WorkingScreen.show()
			$AnimationPlayer.play("WorkingScreen")
		elif win_condition_met == false:
			$BrokenScreen.show()
			$BrokenAudioPlayer.play()
			$EndOfGameTimer.start()
	if anim_name == "WorkingScreen":
		$DingAudioPlayer.play()
		$EndOfGameTimer.start()


func _on_game_timer_timeout() -> void:
	if win_condition_met == false:
		game_done()


func _on_end_of_game_timer_timeout() -> void:
	if win_condition_met == false:
		emit_signal("game_over")
	if win_condition_met == true:
		emit_signal("game_won")

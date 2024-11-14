extends CharacterBody2D

@export var required_button_presses = 25
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

func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("Action2") || Input.is_action_just_pressed("Action1") and not block_input:
		button_presses_pressed += 1
		$WindSprite.show()
		$DustParticles.emitting = true
		$PressTimer.start()
	
	if button_presses_pressed >= required_button_presses / 5:
		$DustParticles.show()
	if button_presses_pressed >= required_button_presses / 2:
		$DustParticles2.show()
		
	if button_presses_pressed >= required_button_presses:
		block_input = true
		win_condition_met = true
		game_done()

func game_done():
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
			$EndOfGameTimer.start()
	if anim_name == "WorkingScreen":
		$EndOfGameTimer.start()


func _on_game_timer_timeout() -> void:
	if win_condition_met == false:
		game_done()
		
		
		


func _on_end_of_game_timer_timeout() -> void:
	if win_condition_met == false:
		emit_signal("game_over")
	if win_condition_met == true:
		emit_signal("game_won")

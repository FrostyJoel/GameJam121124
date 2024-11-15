extends microgame_base

var can_move : bool = true

@export var spawn_locations : Array[Node2D]

func _ready() -> void:
	#set the ball at a random spawn location
	var ball_spawn_position : Node2D = spawn_locations.pick_random()
	$RigidBody2D.global_position = ball_spawn_position.global_position
	spawn_locations.erase(ball_spawn_position)
	#set the goal at a different random location
	var goal_spawn_position : Node2D = spawn_locations.pick_random()
	$TileMapLayer/Finish.global_position = goal_spawn_position.global_position
	
	#Needed to find and enableTimer
	var uiManager = get_tree().get_nodes_in_group("Ui")
	for node in uiManager:
		# Check the node has a save function.
		if !node.has_method("Enabletimer"):
			print("persistent node '%s' is missing a Enabletimer() function, skipped" % node.name)
			continue
			
		node.call("Enabletimer",$GameTimer)

func _on_finish_body_entered(body: Node2D) -> void:
	$GameTimer.stop()
	print("destination!")
	
	can_move = false # Disable moving the maze
	$BallTiltingUi.queue_free()

	# Change the ball
	$RigidBody2D.set_freeze_enabled(true)  # Freeze the body
	$RigidBody2D.set_freeze_mode(1) # Set the freeze mode to Static
	$RigidBody2D.global_position = $TileMapLayer/Finish.global_position # Place the ball on top of the hole
	$RigidBody2D.global_scale = Vector2(0.8,0.8) # Make the ball smaller
	
	$EndTimer.start()

func _physics_process(delta: float) -> void:
	if can_move == false:
		$RigidBody2D.global_scale = $RigidBody2D.global_scale * 0.95


func _on_end_timer_timeout() -> void:
	microgameEnded.emit(true)
	print("to next game!")

func _on_game_timer_timeout() -> void:
	microgameEnded.emit(false)
	print("timer ended")

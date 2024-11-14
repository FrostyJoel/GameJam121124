extends microgame_base

@export var spawn_locations : Array[Node2D]

func _ready() -> void:
	#set the ball at a random spawn location
	var ball_spawn_position : Node2D = spawn_locations.pick_random()
	$RigidBody2D.global_position = ball_spawn_position.global_position
	spawn_locations.erase(ball_spawn_position)
	#set the goal at a different random location
	var goal_spawn_position : Node2D = spawn_locations.pick_random()
	$TileMapLayer/Finish.global_position = goal_spawn_position.global_position

func _on_finish_body_entered(body: Node2D) -> void:
	$Timer.stop()
	microgameEnded.emit(true)
	print("destination!")


func _on_timer_timeout() -> void:
	microgameEnded.emit(false)
	print("timer ended")

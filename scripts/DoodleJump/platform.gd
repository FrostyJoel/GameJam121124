extends Node2D

func _process(delta: float) -> void:
	var player: CharacterBody2D = $"../../Player"
	var difference = position.y - player.position.y
	print(difference)
	if (difference > 500):
		print
		queue_free()

extends Area2D

@onready var player: CharacterBody2D = $"../Player"


func _on_body_entered(body) -> void:
	if (body.name == "Player"):
		player.gameended = true
		$"../EndTimer".start()
		$"..".state = true

extends Node2D

var speed : int = 60
var blown : bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if blown:
		self.position.y -= speed


func _get_blown() -> void:
	blown = true
	$Timer.start()

func _on_timer_timeout() -> void:
	self.queue_free()

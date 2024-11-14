extends microgame_base


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$GameBoy.game_won.connect(connected_signal)
	$GameBoy.game_over.connect(game_lost)

func connected_signal():
	print_debug("GAME WON")   
	microgameEnded.emit(true)

func game_lost():
	print_debug("GAME LOST")   
	microgameEnded.emit(false)

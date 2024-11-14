extends microgame_base

enum Input_Keys {
	A,
	B,
	Up,
	Down,
	Left,
	Right
} 

var Input_Options : Dictionary = {
	Input_Keys.A: "res://assets/images/controller/button_xbox_digital_a_5.png",
	Input_Keys.B: "res://assets/images/controller/button_xbox_digital_b_5.png",
	Input_Keys.Up: "res://assets/images/controller/button_xbox_dpad_dark_1.png",
	Input_Keys.Down: "res://assets/images/controller/button_xbox_dpad_dark_3.png",
	Input_Keys.Left: "res://assets/images/controller/button_xbox_dpad_dark_4.png",
	Input_Keys.Right: "res://assets/images/controller/button_xbox_dpad_dark_2.png"
}
var ActiveArraySelection : int = 0
var AmountOfInputs : int = 6
var Button_To_Press : Input_Keys
var Button_Array : Array
@onready var HorizontalBoxWithInputs : HBoxContainer = $BackgroundSquare/BombOrder

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.
	for n in AmountOfInputs:
		var ActiveButtonFromEnum = randi_range(0, Input_Keys.size()-1)
		Button_Array.append(ActiveButtonFromEnum)
		var ButtonToSpawn = Input_Options.get(ActiveButtonFromEnum) 
		var Image_To_Change : TextureRect = HorizontalBoxWithInputs.get_child(n)
		Image_To_Change.texture = load(ButtonToSpawn)
	
	_set_next_active_button()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("Action1"):
		if Button_To_Press == Input_Keys.A:
			_set_next_active_button()
		else:
			_bomb_exploded()
	if event.is_action_pressed("Action2"):
		if Button_To_Press == Input_Keys.B:
			_set_next_active_button()
		else:
			_bomb_exploded()
	if event.is_action_pressed("DirUp"):
		if Button_To_Press == Input_Keys.Up:
			_set_next_active_button()
		else:
			_bomb_exploded()
	if event.is_action_pressed("DirDown"):
		if Button_To_Press == Input_Keys.Down:
			_set_next_active_button()
		else:
			_bomb_exploded()
	if event.is_action_pressed("DirLeft"):
		if Button_To_Press == Input_Keys.Left:
			_set_next_active_button()
		else:
			_bomb_exploded()
	if event.is_action_pressed("DirRight"):
		if Button_To_Press == Input_Keys.Right:
			_set_next_active_button()
		else:
			_bomb_exploded()

func _set_next_active_button():
	if ActiveArraySelection != 0:
		var TurnImageToTick : TextureRect = HorizontalBoxWithInputs.get_child(ActiveArraySelection - 1)
		TurnImageToTick.texture = load("res://assets/Green-check-mark-on-transparent-background-PNG.png")
	if ActiveArraySelection < 6:
		Button_To_Press = Button_Array[ActiveArraySelection]
		ActiveArraySelection = ActiveArraySelection + 1
	else:
		microgameEnded.emit(true)
		print("you win")

func _bomb_exploded():
	microgameEnded.emit(false)
	print("you lose")

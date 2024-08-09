extends Button

@export var value: String 
var button:Button= self
signal ButtonClicked(ButtonVal:String)


func _button_pressed(value):
	ButtonClicked.emit(value)

# Called when the node enters the scene tree for the first time.
func _ready():
	button.connect("pressed", _button_pressed.bind(value))
	

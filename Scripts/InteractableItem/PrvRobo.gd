extends Node2D

@onready var interaction_area: InteractionArea = $InteractionScene
@onready var interaction_scene = $InteractionScene

signal on_Interact_PrevRover

func _ready():
	interaction_area.interact = Callable(self, "_interact_PrevRover")
func _interact_PrevRover():
	on_Interact_PrevRover.emit()
	

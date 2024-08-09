extends Node2D

@onready var interaction_area: InteractionArea = $InteractionScene
@onready var interaction_scene = $InteractionScene


signal got_MRR_Battery

func _ready():
	
	interaction_area.interact = Callable(self, "_get_MRR_Battery")
func _get_MRR_Battery():
	got_MRR_Battery.emit()
	queue_free()


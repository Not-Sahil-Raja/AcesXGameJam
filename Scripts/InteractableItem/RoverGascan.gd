extends Node2D

@onready var interaction_area: InteractionArea = $InteractionScene
@onready var interaction_scene = $InteractionScene

signal got_GasCan

func _ready():
	interaction_area.interact = Callable(self, "_get_gasCan")
func _get_gasCan():
	got_GasCan.emit()
	queue_free()


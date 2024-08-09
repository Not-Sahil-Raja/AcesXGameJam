extends Node2D

@onready var interaction_area: InteractionArea = $InteractionScene
@onready var interaction_scene = $InteractionScene

signal Prv_BaseCamp_inetracted

func _ready():
	interaction_area.interact = Callable(self, "_on_interact_with_prvBaseCamp")
func _on_interact_with_prvBaseCamp():
	Prv_BaseCamp_inetracted.emit()
	

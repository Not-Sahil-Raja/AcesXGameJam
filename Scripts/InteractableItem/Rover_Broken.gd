extends Node2D

@onready var interaction_area: InteractionArea = $InteractionScene
@onready var interaction_scene = $InteractionScene

signal fix_rover

func _ready():
	interaction_area.interact = Callable(self, "_fix_rover")

func _fix_rover():
	fix_rover.emit()

func remove_collision():
	interaction_scene.queue_free()

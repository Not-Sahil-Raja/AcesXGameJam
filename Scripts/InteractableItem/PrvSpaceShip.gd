extends Node2D

@onready var interaction_area: InteractionArea = $InteractionScene
@onready var interaction_scene = $InteractionScene



signal Prv_Spaceship_inetracted

func _ready():
	interaction_area.interact = Callable(self, "_on_interact_with_prvSpaceShip")
func _on_interact_with_prvSpaceShip():
	Prv_Spaceship_inetracted.emit()
	interaction_scene.queue_free()

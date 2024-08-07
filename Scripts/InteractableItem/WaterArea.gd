extends Node2D

@onready var interaction_area: InteractionArea = $InteractionScene
@export var itemRes: InventoryItem
@export var inventory :Inventory
@onready var interaction_scene = $InteractionScene

var interactable

func _ready():
	interaction_area.interact = Callable(self, "_get_WaterPacket")
func _get_WaterPacket():
	collect(inventory)
	interaction_scene.queue_free()


func collect(inventory: Inventory):
	inventory.insert(itemRes)
	

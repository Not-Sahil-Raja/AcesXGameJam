extends Node2D

@onready var interaction_area: InteractionArea = $InteractionScene
@export var itemRes: InventoryItem
@export var inventory :Inventory
@onready var interaction_scene = $InteractionScene

var battery:int = 1
var interactable

func _ready():
	interaction_area.interact = Callable(self, "_get_Battery")
func _get_Battery():
	collect(inventory)
	queue_free()


func collect(inventory: Inventory):
	inventory.insert(itemRes)
	

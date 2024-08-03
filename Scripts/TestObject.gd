extends Node2D

@onready var interaction_area: InteractionArea = $InteractionScene
@export var itemRes: InventoryItem
@export var inventory :Inventory
@onready var interaction_scene = $InteractionScene

var cabels:int =3
var interactable

func _ready():
	interaction_area.interact = Callable(self, "_get_cables")
func _get_cables():
	if cabels>0:
		print("Got Cable")
		collect(inventory)
		cabels-=1
		if cabels == 0:
			interaction_scene.queue_free()
	else:
		print("Nothing to interact")

func collect(inventory: Inventory):
	inventory.insert(itemRes)
	

extends CanvasLayer
@onready var inventory = $Inventory

func _input(event):
	if Input.is_action_pressed("inventory"):
		if inventory.is_inventory_opened:
			inventory.close()
		else:
			inventory.open()

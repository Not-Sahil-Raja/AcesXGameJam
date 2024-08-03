extends Panel

class_name ItemStackGui

@onready var itemSprite:Sprite2D = $item
@onready var amountlabel:Label = $Label

var inventorySlot:InventorySlot

func update():
	if !inventorySlot || !inventorySlot.item : return
	itemSprite.visible=true
	itemSprite.texture= inventorySlot.item.texture
	
	if inventorySlot.amount >1:
		amountlabel.visible= true
		amountlabel.text=str(inventorySlot.amount)
	else:
		amountlabel.visible= false

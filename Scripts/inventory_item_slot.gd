extends Button
@onready var backgroundSprite:Sprite2D = $Background
@onready var center_container:CenterContainer = $CenterContainer
@onready var inventory= preload("res://Inventory/playerInventory.tres")

var itemStackGui:ItemStackGui
var index:int


func insert(isg : ItemStackGui):
	itemStackGui = isg
	backgroundSprite.frame = 1
	center_container.add_child(itemStackGui)
	
	if !itemStackGui.inventorySlot || inventory.slots[index] == itemStackGui.inventorySlot:
		return
	
	inventory.insertSlot(index, itemStackGui.inventorySlot)

func takeItem():
	var item= itemStackGui
	inventory.removeSlot(itemStackGui.inventorySlot)
	
	
	
	return item
	
func isEmpty():
	return !itemStackGui
	
func clear():
	if itemStackGui:
		center_container.remove_child(itemStackGui)
		itemStackGui=null
	backgroundSprite.frame=0

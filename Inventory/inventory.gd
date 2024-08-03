extends Resource

class_name Inventory

signal updated

@export var slots :Array[InventorySlot]

func insert(item:InventoryItem):
	
	for slot in slots:
		if slot.item == item:
			if slot.amount < item.maxAmountPerStack:
				slot.amount+=1
				updated.emit()
				return
	
	for i in range(slots.size()):
		if !slots[i].item:
			slots[i].item= item
			slots[i].amount= 1
			updated.emit()
			return 
			

func removeSlot(inventorySlot:InventorySlot):
	var index = slots.find(inventorySlot)
	if index <0 : return 
	
	slots[index] = InventorySlot.new()

func insertSlot(index:int, inventorySlot: InventorySlot):
	#var oldIndex : int = slots.find(inventorySlot)
	#removeItemAtIndex(oldIndex)
	
	slots[index] = inventorySlot

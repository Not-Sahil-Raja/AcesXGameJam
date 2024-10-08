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
	
	remove_at_index(index)
	
func remove_at_index(index:int) ->void:
	slots[index] = InventorySlot.new()
	updated.emit()

func insertSlot(index:int, inventorySlot: InventorySlot):
	#var oldIndex : int = slots.find(inventorySlot)
	#removeItemAtIndex(oldIndex)
	slots[index] = inventorySlot
	updated.emit()

func use_item_at_index(index:int)->void:
	if index < 0 || index >= slots.size() || !slots[index].item : return
	
	var slot = slots[index]
	var Itemtype:String =  slot.item.Type
	var ItemValue:int= slot.item.value
	HudItems.recover(Itemtype, ItemValue)
	if slot.amount> 1:
		slot.amount -=1
		updated.emit()
		return
	remove_at_index(index)

extends Resource

class_name InventoryItem

@export var name: String = ""
@export var texture: Texture2D
@export var maxAmountPerStack:int

@export_enum("o2", "health", "hunger") var Type:String 
@export var value:int

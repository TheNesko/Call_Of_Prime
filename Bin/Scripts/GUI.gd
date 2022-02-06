extends Control


onready var Inventory = $Inventory
onready var InventorySlots = $Inventory/InventoryPanel/TextureRect/SlotsPanel.get_children()
onready var ItemBase = preload("res://Bin/Scenes/Items/ItemBase.tscn")
const SlotOffset = Vector2(20,35)

func _ready():
	_Updata_Slots()

func _input(event):
	var closest = null
	if Input.is_action_just_pressed("ui_home"):
		Inventory.visible = !Inventory.visible
	if event is InputEventMouseButton and Inventory.visible == true:
		for x in InventorySlots:
			if closest == null: 
				closest = x
				continue
			if (event.position.distance_to(x.get_global_transform_with_canvas().origin+SlotOffset) <
				event.position.distance_to(closest.get_global_transform_with_canvas().origin+SlotOffset)):
				closest = x
		if Input.is_action_just_pressed("MOUSE_RIGHT"):
			_remove_Item(closest)

func _Add_Item(data):
	for x in InventorySlots:
		if x.Occupied == false:
			x.ItemData = data
			x.Occupied = true
			break
	_Updata_Slots()

func _remove_Item(slot):
	if slot.ItemData == null: return
	var ItemCopy = ItemBase.instance()
	ItemCopy.ItemData = slot.ItemData
	get_parent().get_parent().add_child(ItemCopy)
	ItemCopy.position = get_parent().get_parent().find_node("Player").position
	slot.ItemData = null
	slot.Occupied = false
	_Updata_Slots()

func _Updata_Slots():
	for x in InventorySlots:
		x._Update()

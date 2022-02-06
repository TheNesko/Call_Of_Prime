extends Control


onready var Inventory = $Inventory
onready var InventorySlots = $Inventory/InventoryPanel/TextureRect/InventorySlots.get_children()
onready var Equipment = $Inventory/InventoryPanel/TextureRect/Equipment
onready var ItemBase = preload("res://Bin/Scenes/Items/ItemBase.tscn")
const SlotOffset = Vector2(20,35)

func _ready():
	_Update_Slots()

func _input(event):
	if Input.is_action_just_pressed("ui_home"):
		Inventory.visible = !Inventory.visible
	if event is InputEventMouseButton and Inventory.visible == true:
		if get_viewport().get_mouse_position().distance_to(
			_get_closest_slot().get_global_transform_with_canvas().origin+SlotOffset) > 30: return
		if Input.is_action_just_pressed("MOUSE_RIGHT"):
			_remove_Item(_get_closest_slot())
		if Input.is_action_just_pressed("MOUSE_LEFT"):
			match DragActive:
				true:
					_Drop(_get_closest_slot())
				false:
					_Drag(_get_closest_slot())

func _physics_process(delta):
	if Inventory.visible == false and DragActive == true:
		_Insert_Item(PreviousItemSlot,DragingItem)
		DragActive = false
		DragingItem = null
		PreviousItemSlot = null
	if Inventory.visible == false: return
	if get_viewport().get_mouse_position().distance_to(
		_get_closest_slot().get_global_transform_with_canvas().origin+SlotOffset) < 35:
			_Show_Description(_get_closest_slot())
	else:
		_reset_Description()

func _Add_Item(data):
	for x in InventorySlots:
		if x.Occupied == false:
			x.ItemData = data
			x.Occupied = true
			break
	_Update_Slots()

func _Insert_Item(slot,data):
	slot.Occupied = true
	slot.ItemData = data
	_Update_Slots()

func _remove_Item(slot):
	if slot.ItemData == null: return
	var ItemCopy = ItemBase.instance()
	ItemCopy.ItemData = slot.ItemData
	get_parent().get_parent().add_child(ItemCopy)
	ItemCopy.position = get_parent().get_parent().find_node("Player").position
	slot.ItemData = null
	slot.Occupied = false
	_Update_Slots()

func _Update_Slots():
	for x in InventorySlots:
		x._Update()
	for x in Equipment.get_children():
		x._Update()

var DragActive = false
var DragingItem = null
var PreviousItemSlot = null
func _Drag(slot):
	if slot.ItemData == null: return
	PreviousItemSlot = slot
	DragActive = true
	DragingItem = slot.ItemData
	slot.Occupied = false
	slot.ItemData = null
	_Update_Slots()

func _Drop(slot):
	if DragingItem == null: return
	if slot.Occupied == true:
		_Insert_Item(PreviousItemSlot,DragingItem)
	else:
		if slot.get_parent() == Equipment:
			if slot.name != (DragingItem.EquipmentSlot): return
		_Insert_Item(slot,DragingItem)
	DragActive = false
	DragingItem = null
	PreviousItemSlot = null
	_Update_Slots()

onready var ItemDescription = $Inventory/InventoryPanel/TextureRect/ItemDetail/ItemDescription
onready var ItemTexture = $Inventory/InventoryPanel/TextureRect/ItemDetail/ItemTexture
onready var ItemName = $Inventory/InventoryPanel/TextureRect/ItemDetail/ItemName
func _Show_Description(slot):
	if slot.ItemData == null:
		ItemDescription.text = ""
		ItemTexture.texture = null
		ItemName.text = ""
		return
	ItemDescription.text = slot.ItemData.ItemDescription
	ItemTexture.texture = slot.ItemData.texture
	ItemName.text = slot.ItemData.ItemName

func _reset_Description():
	ItemDescription.text = ""
	ItemTexture.texture = null
	ItemName.text = ""

func _get_closest_slot():
	var closest = null
	var MousePos = get_viewport().get_mouse_position()
	for x in InventorySlots:
		if closest == null: 
			closest = x
			continue
		if (MousePos.distance_to(x.get_global_transform_with_canvas().origin+SlotOffset) <
			MousePos.distance_to(closest.get_global_transform_with_canvas().origin+SlotOffset)):
			closest = x
	for x in Equipment.get_children():
		if closest == null: 
			closest = x
			continue
		if (MousePos.distance_to(x.get_global_transform_with_canvas().origin+SlotOffset) <
			MousePos.distance_to(closest.get_global_transform_with_canvas().origin+SlotOffset)):
			closest = x
	return closest

extends Control


onready var Inventory = $Inventory
onready var InventorySlots = $Inventory/InventoryPanel/TextureRect/SlotsPanel.get_children()
const SlotOffset = Vector2(20,35)
var closest = null

func _input(event):
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

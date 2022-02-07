extends Resource
class_name Item

export (int) var id = 0
export (String) var ItemName = 0
export (int) var price = 0
export (int) var AddedInventorySlots = 0
export (Texture) var texture = null
export (String,"Helmet","Chestplate","RightHand","LeftHand","Leggins","Backpack") var EquipmentSlot
export (String, MULTILINE) var ItemDescription = "null"

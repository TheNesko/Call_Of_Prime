extends Resource
class_name Item

export (String) var ItemName = "null"
export (String) var ConsoleName = "null"
export (String,"Helmet","Chestplate","RightHand","LeftHand","Boots","Backpack","null") var EquipmentSlot
export (int) var price = 0
export (int) var BonusInventorySlots = 0
export (int) var BonusDamage = 0
export (float) var BonusAtackSpeed = 0
export (int) var BonusBaseSpeed = 0
export (int) var BonusHealth = 0
export (int) var BonusMaxHealth = 0
export (Texture) var texture = null
export (String, MULTILINE) var ItemDescription = "null"

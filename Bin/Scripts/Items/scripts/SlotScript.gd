extends Panel

export (bool) var Occupied = false
export (Resource) var ItemData = null

func _Update():
	if ItemData != null:
		$Sprite.texture = ItemData.texture
	else:
		$Sprite.texture = null

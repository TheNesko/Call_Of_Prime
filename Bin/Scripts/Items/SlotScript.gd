extends Panel

export (bool) var Occupied = false
export (Resource) var ItemData = null

func _physics_process(delta):
	if ItemData == null: 
		Occupied = true 
		return
	if ItemData: Occupied = true
	$Sprite.texture = ItemData.texture

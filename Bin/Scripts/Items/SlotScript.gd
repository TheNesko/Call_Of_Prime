extends Panel

export (bool) var Occupied = false
export (Resource) var ItemData = null
var Unlocked = true

func _ready():
	yield(get_tree().create_timer(0.3),"timeout")
	_Update()

func _Update():
	if Unlocked == false:
		self_modulate.a = 0.3
	else:
		self_modulate.a = 0
	if ItemData != null:
		$Sprite.texture = ItemData.texture
	else:
		$Sprite.texture = null

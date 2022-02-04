extends AnimatedSprite


func _ready():
	var Player = get_parent().find_node("Player")
	if Player.PlayerTexture.flip_h == false:
		flip_h = true
	playing = true
	yield(get_tree().create_timer(0.3),"timeout")
	queue_free()

func _physics_process(delta):
	position += Vector2(0,-0.3).rotated(rotation)

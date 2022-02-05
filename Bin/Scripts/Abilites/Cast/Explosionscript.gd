extends AnimatedSprite

var EffectAnimation : SpriteFrames = null

func _ready():
	if EffectAnimation != null:
		frames = EffectAnimation
	playing = true
	yield(get_tree().create_timer(0.3),"timeout")
	queue_free()

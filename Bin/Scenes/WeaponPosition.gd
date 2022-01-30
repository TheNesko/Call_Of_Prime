extends Node2D

var Flipped = false
onready var MousePosition = get_viewport().get_mouse_position()
onready var Player = get_parent().get_parent()


func _process(delta):
	if Player.AttackTween.is_active(): return
	rotation = 0
	var PlayerPoz = Player.get_global_transform_with_canvas()
	MousePosition = get_viewport().get_mouse_position()
	var MouseToPlayer = MousePosition - PlayerPoz.get_origin()
	if MouseToPlayer.x < 0:
		position.x = -8
		scale.x = -1
		Flipped = true
	elif MouseToPlayer.x > 0:
		position.x = 8
		scale.x = 1
		Flipped = false

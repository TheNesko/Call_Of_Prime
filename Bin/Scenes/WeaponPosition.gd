extends Node2D

var Flipped = false
onready var MousePosition = get_viewport().get_mouse_position()
onready var Player = get_parent().get_parent()


func _physics_process(delta):
	#if Player.AttackTween.is_active(): return
	rotation = 0
	var PlayerPoz = Player.get_global_transform_with_canvas()
	MousePosition = get_viewport().get_mouse_position()
	var MouseToPlayer = MousePosition - PlayerPoz.get_origin()
	position = (MouseToPlayer.normalized()*10 - Vector2(0,15))
	rotate(MouseToPlayer.rotated(deg2rad(90)).angle())
	if MouseToPlayer.x < 0:
		scale.x = -1
		Flipped = true
	else:
		scale.x = 1
		Flipped = false

func _draw():
	draw_circle(Vector2.ZERO,5,Color.red)

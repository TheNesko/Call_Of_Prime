extends KinematicBody2D

onready var AnimPlayer = $Sprite

var Velocity = Vector2.ZERO
var Speed = 100

func _input(_event):
	if Input.is_key_pressed(KEY_SHIFT):
		Speed = 300
	else:
		Speed = 100

func _Move():
	move_and_slide(Velocity)

var LastDirection = "Down"
func _Check_Direction() -> String:
	if Input.is_action_pressed("Up"):
		LastDirection = "Up"
		return "Up"
	if Input.is_action_pressed("Down"):
		LastDirection = "Down"
		return "Down"
	if Input.is_action_pressed("Right"):
		LastDirection = "Right"
		return "Right"
	if Input.is_action_pressed("Left"):
		LastDirection = "Left"
		return "Left"
	return LastDirection

func _Play_Animation(State:String):
	var NextAnim = str(State)
	if AnimPlayer.animation == NextAnim: return
	AnimPlayer.animation = str(State)

func _Flip():
	if Input.is_action_just_pressed("Left"):
		$Sprite.flip_h = false
	if Input.is_action_just_pressed("Right"):
		$Sprite.flip_h = true

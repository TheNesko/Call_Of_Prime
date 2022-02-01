extends KinematicBody2D

onready var AnimPlayer = $YSort/SpriteHolder/Sprite

var Velocity = Vector2.ZERO
var Speed = 200

func _input(_event):
	if Input.is_key_pressed(KEY_SHIFT):
		Speed = 300
	else:
		Speed = 200

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
	var MousePosition = get_viewport().get_mouse_position()
	var PlayerPoz = self.get_global_transform_with_canvas()
	var MouseToPlayer = MousePosition - PlayerPoz.get_origin()
	if MouseToPlayer.x < 0:
		$YSort/SpriteHolder/Sprite.flip_h = false
	else:
		$YSort/SpriteHolder/Sprite.flip_h = true

onready var HurtBox = $YSort/WeaponPosition/RotationManager/HurtBox
onready var HurtBoxCollision = $YSort/WeaponPosition/RotationManager/HurtBox/Collision
onready var RotationManager = $YSort/WeaponPosition/RotationManager
onready var AttackRotation = $AttackRotation
onready var AttackPosition = $AttackPosition
func _Attack():
	HurtBoxCollision.disabled = false
	RotationManager.rotation = 0
	var FinalPoz = (RotationManager.position+Vector2(10,5)).rotated(RotationManager.rotation)
	var FinalRot = deg2rad(RotationManager.rotation_degrees+190)
	AttackPosition.interpolate_property(RotationManager,"position",RotationManager.position,
									FinalPoz,0.15,Tween.TRANS_LINEAR,Tween.EASE_OUT)
	AttackRotation.interpolate_property(RotationManager,"rotation",RotationManager.rotation_degrees,
									FinalRot,0.15,Tween.TRANS_LINEAR,Tween.EASE_OUT)
	AttackRotation.start()
	AttackPosition.start()
	yield(get_tree().create_timer(0.3),"timeout")
	HurtBoxCollision.disabled = true
	RotationManager.position = Vector2.ZERO
	RotationManager.rotation = 0


func _on_HurtBox(area):
	area.get_parent()._Take_Damage(10)

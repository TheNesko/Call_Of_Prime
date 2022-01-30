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
	if Input.is_action_just_pressed("Left"):
		$YSort/SpriteHolder/Sprite.flip_h = false
	if Input.is_action_just_pressed("Right"):
		$YSort/SpriteHolder/Sprite.flip_h = true

onready var HurtBox = $YSort/WeaponPosition/HurtBox
onready var HurtBoxCollision = $YSort/WeaponPosition/HurtBox/Collision
onready var AttackTween = $AttackTween
var isAttacking = false
func _Attack():
	var rotDir = 2
	if $YSort/WeaponPosition.Flipped == true: rotDir = -2
	if $YSort/WeaponPosition.Flipped == false: rotDir = 2
	isAttacking = true
	AttackTween.interpolate_property($YSort/WeaponPosition,"rotation",0,
									rotDir,0.2,Tween.TRANS_LINEAR,Tween.EASE_OUT)
	AttackTween.start()
	yield(get_tree().create_timer(0.05),"timeout")
	print(HurtBox.get_overlapping_areas())
	if HurtBox.get_overlapping_areas().size() > 0:
		for x in HurtBox.get_overlapping_areas():
			if x.is_in_group("EnemyHitBox"):
				x.get_parent()._Take_Damage(10)
	yield(get_tree().create_timer(0.3),"timeout")
	isAttacking = false

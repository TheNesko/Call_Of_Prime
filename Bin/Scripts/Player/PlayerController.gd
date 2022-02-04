extends KinematicBody2D

onready var root = get_parent().get_parent()
onready var AnimPlayer = $YSort/SpriteHolder/Sprite
onready var Stats = $Stats
export var Velocity = Vector2.ZERO


func _input(_event):
	if Input.is_key_pressed(KEY_Q):
		_Use_Ablility("Fireball")
	if Input.is_key_pressed(KEY_E):
		_Use_Ablility("Boulder")
	if Input.is_key_pressed(KEY_SHIFT):
		Stats.Speed = 300
	else:
		Stats.Speed = Stats.BaseSpeed
	
	if Input.is_key_pressed(KEY_F):
		_Pick_Up_Item()


func _Move_Input():
	Velocity.x = Input.get_axis("Left","Right")
	Velocity.y = Input.get_axis("Up","Down")
	Velocity = Velocity.normalized()*Stats.Speed


func _Apply_Movement():
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


onready var PlayerTexture = $YSort/SpriteHolder/Sprite
func _Flip():
	var MousePosition = get_viewport().get_mouse_position()
	var PlayerPoz = self.get_global_transform_with_canvas()
	var MouseToPlayer = MousePosition - PlayerPoz.get_origin()
	if MouseToPlayer.x < 0:
		PlayerTexture.flip_h = false
	else:
		PlayerTexture.flip_h = true


onready var Slash = preload("res://Bin/Scenes/Slash.tscn")
onready var WeaponPosition = $YSort/WeaponPosition
onready var HurtBox = $YSort/WeaponPosition/HurtBox
onready var HurtBoxCollision = $YSort/WeaponPosition/HurtBox/Collision
onready var RotationManager = $YSort/WeaponPosition/RotationManager
onready var AttackRotation = $AttackRotation
onready var AttackPosition = $AttackPosition
func _Attack():
	var AttackSpeed = (1.00/Stats.AttackSpeed)
	var SlashCopy = Slash.instance()
	var FinalPoz = (RotationManager.position+Vector2(10,8)).rotated(RotationManager.rotation)
	var FinalRot = deg2rad(RotationManager.rotation_degrees+270)
	#================================
	HurtBoxCollision.disabled = false
	RotationManager.rotation = 0
	#================================
	get_parent().add_child(SlashCopy)
	SlashCopy.global_position = RotationManager.global_position + Vector2(0,-10).rotated(
														 $YSort/WeaponPosition.rotation)
	SlashCopy.rotation = $YSort/WeaponPosition.rotation
	#================================
	AttackPosition.interpolate_property(RotationManager , "position" , RotationManager.position,
									FinalPoz , (AttackSpeed/2) , Tween.TRANS_LINEAR , Tween.EASE_OUT )
	AttackRotation.interpolate_property(RotationManager , "rotation" , RotationManager.rotation_degrees,
									FinalRot , (AttackSpeed/2) , Tween.TRANS_LINEAR , Tween.EASE_OUT )
	AttackRotation.start()
	AttackPosition.start()
	#================================
	yield(get_tree().create_timer(AttackSpeed),"timeout")
	HurtBoxCollision.disabled = true
	RotationManager.position = Vector2.ZERO
	RotationManager.rotation = 0


func _on_HurtBox(area):
	area.get_parent()._Take_Damage(Stats.Damage)

func _Use_Ablility(AbilityName:String):
	for x in $Abilities.get_children():
		if x.AbilityName == AbilityName:
			if x.CooldownTimer.is_stopped():
				x._Cast()


var ItemsNear = []
func _on_PickUpArea(body):
	ItemsNear.append(body)
	print(ItemsNear)

func _on_PickUpArea_exited(body):
	ItemsNear.erase(body)

func _Pick_Up_Item():
	if ItemsNear.size() <=0: return
	var closest = null
	for x in ItemsNear:
		if closest == null: closest = x
		if position.distance_to(x.position) < position.distance_to(closest.position):
			closest = x
	root.find_node("GUI")._Add_Item(closest.ItemData)
	print(root.find_node("GUI"))
	closest.queue_free()

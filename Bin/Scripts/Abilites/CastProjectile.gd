extends KinematicBody2D

var Speed = 100
var Damage = 0.00
var Velocity = Vector2.UP
var TravelTime = 1
onready var ExplosionEffect = preload("res://Bin/Scenes/Effects/ExplosionEffect.tscn")

func _ready():
	$Sprite.playing = true
	yield(get_tree().create_timer(TravelTime),"timeout")
	_Destroy()

func _physics_process(delta):
	move_and_slide(Velocity.rotated(rotation)*Speed)


func _on_HurtBox(area):
	if area.get_parent().has_method("_Take_Damage"):
		area.get_parent()._Take_Damage(Damage)
		#APPLY EFFECTS IF ABLE
		#====================
		_Destroy()

func _Destroy():
	var EffectCopy = ExplosionEffect.instance()
	get_parent().add_child(EffectCopy)
	EffectCopy.position = position
	queue_free()

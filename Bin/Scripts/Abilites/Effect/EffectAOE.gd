extends Area2D

var Radius = 10
var AOEtime = 1.00
var AbilityData = null
onready var EffectNode = preload("res://Bin/Scenes/Abilites/Effect.tscn")

func _ready():
	$Collision.shape.radius = Radius
	$Particles2D.process_material.set_shader_param('emission_sphere_radius',Radius)
	$Particles2D.amount = 20 * Radius
	yield(get_tree().create_timer(AOEtime),"timeout")
	queue_free()


func _on_body_entered(body):
	var BodyEffects = body.find_node("ActiveEffects")
	if BodyEffects == null: return
	for Effect in BodyEffects.get_children():
		if Effect.EffectData == AbilityData: return
	var EffectNodeCopy = EffectNode.instance()
	EffectNodeCopy.EffectData = AbilityData
	BodyEffects.add_child(EffectNodeCopy)
	

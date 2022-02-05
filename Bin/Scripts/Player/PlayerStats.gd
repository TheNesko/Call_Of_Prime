extends Node

export(String) var Name = "Player"
#=========Movement===========
export var Speed = 150
export var BaseSpeed = 150
export var RunSpeed = 300
#=========Health===========
export var Health = 100
export var MaxHealth = 100
#=========Attacks===========
export var Damage = 10
export(float) var AttackSpeed = 3


onready var ActiveEffects = get_parent().find_node("ActiveEffects")
func _Apply_Active_Effects():
	for Effect in ActiveEffects.get_children():
		if Effect.EffectData == null: return
		if !Effect.EffectTimer.is_stopped(): return
		Effect._Apply_Effect(get_parent())

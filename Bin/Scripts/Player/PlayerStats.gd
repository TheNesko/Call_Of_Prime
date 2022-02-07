extends Node

export(String) var Name = "Player"
#=========Movement===========
export var Speed = 150.00
export var BaseSpeed = 150.00
export var RunSpeed = 300.00
#=========Health===========
export var Health = 100.00
export var MaxHealth = 100.00
#=========Attacks===========
export var Damage = 10.00
export(float) var AttackSpeed = 3.00
#=========Others===========
export (int,0,35) var BaseInventorySlots = 15

func _ready():
	pass

onready var ActiveEffects = get_parent().find_node("ActiveEffects")
func _Apply_Active_Effects():
	for Effect in ActiveEffects.get_children():
		if Effect.EffectData == null: return
		if !Effect.EffectTimer.is_stopped(): return
		Effect._Apply_Effect(get_parent())


var BonusDamage = 0
var BonusAtackSpeed = 0
var BonusBaseSpeed = 0
var BonusHealth = 0
var BonusMaxHealth = 0
func _Apply_Equipment_Bonus():
	_Remove_Equipment_Bonus()
	var Inventory = get_parent().get_parent().get_parent().find_node("GUI")
	for EqSlot in Inventory.Equipment.get_children():
		if EqSlot.ItemData == null: continue
		print(EqSlot.ItemData.ItemName)
		BonusDamage += EqSlot.ItemData.BonusDamage
		BonusAtackSpeed += EqSlot.ItemData.BonusAtackSpeed
		BonusBaseSpeed += EqSlot.ItemData.BonusBaseSpeed
		BonusHealth += EqSlot.ItemData.BonusHealth
		BonusMaxHealth += EqSlot.ItemData.BonusMaxHealth
	Damage += BonusDamage
	AttackSpeed += BonusAtackSpeed
	Speed += BonusBaseSpeed
	Health += BonusHealth
	MaxHealth += BonusMaxHealth

func _Remove_Equipment_Bonus():
	Damage -= BonusDamage
	AttackSpeed -= BonusAtackSpeed
	Speed -= BonusBaseSpeed
	Health -= BonusHealth
	MaxHealth -= BonusMaxHealth
	BonusDamage = 0
	BonusAtackSpeed = 0
	BonusBaseSpeed = 0
	BonusHealth = 0
	BonusMaxHealth = 0

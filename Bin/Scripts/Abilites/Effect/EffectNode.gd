extends Node

#EFFECTS :
#	Damage boost/weeken
#	Health boost/life drain/bonus max health for X time/Poison
#	Speed boost/slow
var FirstValue = null
onready var EffectTimer = $EffectTimer
export (Resource) var EffectData = null
var Stats
var Started = false
var PoisionActive = false
func _Apply_Effect(body):
	Stats = body.find_node("Stats")
	if Stats == null: return
	if EffectData == null: return
	if !EffectTimer.is_stopped(): return
	if Started == true: return
	EffectTimer.start(EffectData.EffectLength)
	Started = true
	FirstValue = Stats.get(EffectData.StatEffect)
	match EffectData.EffectModifier:
		"Boost":
			var Stat = Stats.get(EffectData.StatEffect)
			Stats.set(EffectData.StatEffect,Stat + EffectData.EffectStrengh)
		"Weeken":
			var Stat = Stats.get(EffectData.StatEffect)
			Stats.set(EffectData.StatEffect,Stat - (Stat*(EffectData.EffectStrengh/100)))
		"Poison":
			PoisionActive = true
	prints(EffectData.StatEffect,"Set to",Stats.get(EffectData.StatEffect))
	


func _physics_process(delta):
	if EffectData.EffectModifier != "Poison": return
	if EffectTimer.is_stopped(): return
	if PoisionActive == false: return
	var Stat = Stats.get(EffectData.StatEffect)
	if Stat <= 0:
		Stat = 0
		return
	Stats.set(EffectData.StatEffect,Stat - (EffectData.EffectStrengh*delta))
	print(Stat)

func _on_EffectTimer_timeout():
	match EffectData.EffectModifier:
		"Boost":
			Stats.set(EffectData.StatEffect,FirstValue)
		"Weeken":
			Stats.set(EffectData.StatEffect,FirstValue)
		"Poison":
			PoisionActive = false
			Stats.set(EffectData.StatEffect,FirstValue)
	prints(EffectData.StatEffect,"Set to",FirstValue)
	queue_free()

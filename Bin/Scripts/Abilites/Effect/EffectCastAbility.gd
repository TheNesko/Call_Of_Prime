extends Node

var AbilityName = "null"
onready var root = get_parent().get_parent().get_parent().get_parent()
onready var Player = get_parent().get_parent()
export (Resource) var AbilityData = null
onready var EffectNode = preload("res://Bin/Scenes/Abilites/Effect.tscn")
onready var CooldownTimer = $CooldownTimer

func _ready():
	if AbilityData == null: return
	if AbilityData.AbilityName == "null": return
	else: AbilityName = AbilityData.AbilityName

func _Cast():
	if AbilityData == null: return
	match AbilityData.SelfEffect:
		true:
			# Apply Effect on caster
			var ActiveEffects = Player.find_node("ActiveEffects")
			var EffectNodeCopy = EffectNode.instance()
			EffectNodeCopy.EffectData = AbilityData
			ActiveEffects.add_child(EffectNodeCopy)
		false:
			# Cast an AOE which applies an Effect
			var MousePosition = Player.get_global_mouse_position()
			var AOE = load("res://Bin/Scenes/EffectAOE.tscn").instance()
			AOE.AbilityData = AbilityData
			AOE.AOEtime = AbilityData.EffectAOEtime
			AOE.Radius = AbilityData.EffectAOE
			root.add_child(AOE)
			AOE.global_position = MousePosition
	_Start_Cooldown(AbilityData.Cooldown)

func _Start_Cooldown(CooldownTime:float):
	if CooldownTimer.is_stopped():
		CooldownTimer.start(CooldownTime)

extends Node

var AbilityName = "null"
onready var root = get_parent().get_parent().get_parent()
onready var Player = get_parent().get_parent()
export (Resource) var AbilityData = null
onready var Projectile = load("res://Bin/Scenes/Abilites/CastProjectile.tscn")
onready var CooldownTimer = $CooldownTimer

func _ready():
	if AbilityData == null: return
	if AbilityData.AbilityName == "null": return
	else: AbilityName = AbilityData.AbilityName


func _Cast():
	if AbilityData == null: return
	if AbilityData.texture == null: return
	var ProjectileCopy = Projectile.instance()
	ProjectileCopy.Speed = AbilityData.ProjectileSpeed
	ProjectileCopy.Damage = AbilityData.Damage
	ProjectileCopy.TravelTime = AbilityData.TravelTime
	root.add_child(ProjectileCopy)
	ProjectileCopy.rotation = Player.WeaponPosition.rotation
	ProjectileCopy.position = Player.WeaponPosition.global_position
	ProjectileCopy.find_node("Sprite").frames = AbilityData.texture
	_Start_Cooldown(AbilityData.Cooldown)

func _Start_Cooldown(CooldownTime:float):
	if CooldownTimer.is_stopped():
		CooldownTimer.start(CooldownTime)

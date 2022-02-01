extends StaticBody2D

var DamagePerSecond = 0
var DamageDone = 0.00
var DPS_time = 0.00
var DamagedAmmount = 0

func _Take_Damage(damage):
	DamageDone += damage
	DamagedAmmount += 1
	$DPSTimer.start()
	if DPS_time == 0:
		yield(get_tree().create_timer(0.05),"timeout")
	if DamagedAmmount == 1:
		DamagePerSecond = DamageDone
	else:
		DamagePerSecond = DamageDone/DPS_time

func _physics_process(delta):
	if !$DPSTimer.is_stopped():
		$DPSlabel.text = "Damage per second: " + str(round(DamagePerSecond))\
					+ "   Damage dealt: " + str(DamageDone)
		$DPSlabel.visible = true
	else:
		$DPSlabel.visible = false
	if $DPSTimer.is_stopped():
		DPS_time = 0
		DamagedAmmount = 0
		return
	DPS_time += delta

func _DPSTimer_timeout():
	DamagePerSecond = 0.00
	DamageDone = 0.00

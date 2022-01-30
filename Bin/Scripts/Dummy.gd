extends StaticBody2D

var DamagePerSecond = 0
var DamageDone = 0.00
var DPS_time = 0.00

func _Take_Damage(damage):
	DamageDone += damage
	$DPSTimer.start()
	if DPS_time == 0:
		yield(get_tree().create_timer(0.05),"timeout")
	DamagePerSecond = DamageDone/DPS_time

func _process(delta):
	if !$DPSTimer.is_stopped():
		$DPSlabel.visible = true
		$DPSlabel.text = "Damage per second: " + str(round(DamagePerSecond))\
					+ "   Damage dealt: " + str(DamageDone)
	else:
		$DPSlabel.visible = false
	if $DPSTimer.is_stopped():
		DPS_time = 0
		return
	DPS_time += delta

func _input(event):
	if Input.is_key_pressed(KEY_SPACE):
		_Take_Damage(10)

func _DPSTimer_timeout():
	DamagePerSecond = 0.00
	DamageDone = 0.00

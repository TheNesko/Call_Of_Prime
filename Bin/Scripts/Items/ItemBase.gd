extends KinematicBody2D
tool

export (Resource) var ItemData = null
var Name = "null"

func _ready():
	if ItemData == null: return
	Name = ItemData.ItemName
	self.name = Name
	$Sprite.texture = ItemData.texture


var Time = 0.00
func _Sine_Wave_Movement(delta,Freq:int,Amplitude:int):
	Time += delta
	var V = Vector2.ZERO
	V.y = sin(PI/2 + Time*Freq)*Amplitude
	$Sprite.position = V
	#Velocity = V
	#Velocity = move_and_collide(Velocity * delta)

func _physics_process(delta):
	_Sine_Wave_Movement(delta,2,5)

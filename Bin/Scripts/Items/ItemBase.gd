extends KinematicBody2D

export (Resource) var ItemData = null
var id = 0 
var Name = "null"

func _ready():
	if ItemData == null: return
	id = ItemData.id
	Name = ItemData.ItemName
	self.name = Name
	$Sprite.texture = ItemData.texture

func _Use():
	pass



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

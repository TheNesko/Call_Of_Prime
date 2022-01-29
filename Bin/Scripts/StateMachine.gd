extends Node
onready var parent = get_parent()

enum States {
	Idle,
	Walk
}

var PreviousState = null
export (States) var State = States.Idle

func _process(_delta) -> void:
	_Update_State(_State_Checker())
	
	parent.Velocity.x = Input.get_axis("Left","Right")*parent.Speed
	parent.Velocity.y = Input.get_axis("Up","Down")*parent.Speed
	
	match State:
		States.Idle:
			parent._Play_Animation("Idle",parent._Check_Direction())
		States.Walk:
			parent._Play_Animation("Walk",parent._Check_Direction())


func _physics_process(_delta) -> void:
	parent._Move()

func _State_Checker():
	match State:
		States.Idle:
			if parent.Velocity != Vector2.ZERO:
				return States.Walk
		States.Walk:
			if parent.Velocity == Vector2.ZERO:
				return States.Idle
	return null

func _Update_State(NextState) -> void:
	if NextState == null: return
	if NextState == State: return
	PreviousState = State
	State = NextState
	if State != null:
		_Enter_State()
		_Exit_State()

func _Enter_State() -> void:
	match State:
		States.Idle:
			print("Idle")
		States.Walk:
			print("Walk")

func _Exit_State() -> void:
	match PreviousState:
		States.Idle:
			pass
		States.Walk:
			pass

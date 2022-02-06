extends Node
onready var parent = get_parent()

enum States {
	Idle,
	Walk,
	Attack
}

var PreviousState = null
export (States) var State = States.Idle

func _process(delta) -> void:
	_Update_State(_State_Checker())
	parent._Flip()
	parent._Move_Input()
	parent.find_node("Stats")._Apply_Active_Effects()
	
	if Input.is_key_pressed(KEY_Q):
		parent._Use_Ablility("Fireball")
	if Input.is_key_pressed(KEY_E):
		parent._Use_Ablility("Health Boost")
#	if Input.is_key_pressed(KEY_SHIFT):
#		parent.Stats.Speed = parent.Stats.RunSpeed
#	else:
#		parent.Stats.Speed = parent.Stats.BaseSpeed
	
	if Input.is_action_just_pressed("Interact"):
		parent._Pick_Up_Item()
	

func _physics_process(_delta) -> void:
	parent._Apply_Movement()

func _State_Checker():
	match State:
		States.Idle:
			if parent.Velocity != Vector2.ZERO:
				return States.Walk
			if Input.is_action_just_pressed("Attack"):
				return States.Attack
		States.Walk:
			if parent.Velocity == Vector2.ZERO:
				return States.Idle
			if Input.is_action_just_pressed("Attack"):
				return States.Attack
		States.Attack:
			if parent.HurtBoxCollision.disabled == true and parent.Velocity == Vector2.ZERO:
				return States.Idle
			if parent.HurtBoxCollision.disabled == true and parent.Velocity != Vector2.ZERO:
				return States.Walk
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
			parent.AnimPlayer.animation = "Idle"
		States.Walk:
			parent.AnimPlayer.animation = "Walk"
		States.Attack:
			parent._Attack()

func _Exit_State() -> void:
	match PreviousState:
		States.Idle:
			pass
		States.Walk:
			pass

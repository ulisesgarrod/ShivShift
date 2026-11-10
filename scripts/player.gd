extends CharacterBody2D


var speed : float = 170
var direction = Vector2.ZERO

var is_dashing = false
var dash_speed : float = 500
var dash_duration : float = 0.2
var dash_timer : float = 0.2

var is_charging = false
var charge_duration : float = 0.5
var charge_timer : float = 0.5


func _physics_process(_delta: float) -> void:
	if is_charging == true: #Charge state
		velocity = Vector2.ZERO
		direction = Input.get_vector("left", "right", "up", "down")
		charge_timer -= _delta
		if (charge_timer) <= 0:
				execute_dash()
	elif is_dashing == true: #Dash movement
		dash_timer -= _delta
		velocity = direction * dash_speed
		move_and_slide()
		if (dash_timer) <= 0:
				is_dashing = false
	else: #Normal state
		velocity = Input.get_vector("left", "right", "up", "down") * speed
		move_and_slide()
		if Input.is_action_just_pressed("attack"):
			charge()

func charge() -> void:
	if is_dashing == true || is_charging == true:
		return
	is_charging = true
	charge_timer = charge_duration

func execute_dash() -> void:
	is_charging = false
	is_dashing = true
	dash_timer = dash_duration

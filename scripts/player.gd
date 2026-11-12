extends CharacterBody2D


var speed : float = 170
var direction = Vector2.ZERO

var is_dashing = false
var dash_speed : float = 500
var dash_duration : float = 0.2
var dash_timer : float = 0.0
var dash_damage : float = 1

var is_charging = false
var charge_duration : float = 0.5
var charge_timer : float = 0.0

var hit_enemies : Array = [] #Enemies hit by the current dash

func _physics_process(_delta: float) -> void:
	if is_charging == true: #Charge state
		velocity = Vector2.ZERO
		direction = Input.get_vector("left", "right", "up", "down")
		charge_timer += _delta
		
		update_charge_bar()
		
		if Input.is_action_just_released("attack"):
			execute_dash(charge_timer)
		elif (charge_timer) >= charge_duration:
			execute_dash(charge_duration)
	elif is_dashing == true: #Dash movement
		dash_timer -= _delta
		velocity = direction * dash_speed
		move_and_slide()
		deal_dash_damage()
		if (dash_timer) <= 0:
			is_dashing = false
			hit_enemies.clear()
	else: #Normal state
		velocity = Input.get_vector("left", "right", "up", "down") * speed
		move_and_slide()
		if Input.is_action_just_pressed("attack"):
			charge()

func charge() -> void:
	if is_dashing == true || is_charging == true:
		return
	is_charging = true
	charge_timer = 0.0
	$ChargeBar.visible = true
	$ChargeBar.value = 0.0

func execute_dash(timer: float) -> void:
	is_charging = false
	is_dashing = true
	var charge_load = clampf(timer / charge_duration, 0.0, 1.0) #Turning the charged time into a value between 0 and 1
	dash_timer = dash_duration * maxf(charge_load, 0.3) #Max between charge_load and the minimun duration
	$ChargeBar.visible = false

func deal_dash_damage() -> void:
	for body in $DashHitbox.get_overlapping_bodies():
		if body.has_method("take_damage") and body not in hit_enemies:
			hit_enemies.append(body)
			body.take_damage(dash_damage)

func update_charge_bar() -> void:
	$ChargeBar.value = clampf(charge_timer / charge_duration, 0.0, 1.0)

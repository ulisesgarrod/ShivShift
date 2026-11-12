extends CharacterBody2D


@export var player_reference : CharacterBody2D
@export var type : Enemy
@export var health : float = 1
var direction : Vector2
var speed : float = 100


func _ready() -> void:
	# Si tiene un EnemyType asignado, la vida sale de ahí
	if type:
		health = type.health


func _physics_process(_delta: float) -> void:
	velocity = (player_reference.global_position - global_position).normalized() * speed
	move_and_slide()


func take_damage(amount : float) -> void:
	health -= amount
	if health <= 0:
		queue_free()
		return
	# Parpadeo blanco para que se note el golpe
	$Sprite2D.modulate = Color(3, 3, 3)
	create_tween().tween_property($Sprite2D, "modulate", Color.WHITE, 0.15)

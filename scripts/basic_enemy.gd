extends CharacterBody2D


@export var player_reference : CharacterBody2D
var direction : Vector2
var speed : float = 100


func _physics_process(_delta: float) -> void:
	velocity = (player_reference.global_position - global_position).normalized() * speed
	move_and_slide()

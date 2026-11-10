extends Node2D

@export var player : CharacterBody2D
@export var enemy : PackedScene

@export var distance : float = 550
@export var spawn_interval : int = 1

var minute : int:
	set(value):
		minute= value
		%Minute.text= str(value)
		
var second : int:
	set(value):
		second = value
		if second >= 60:
			second -= 60
			minute += 1
		%Second.text = str(second).lpad(2, '0')
			
func spawn(pos: Vector2):
	var enemy_instance = enemy.instantiate()
	
	enemy_instance.position = pos
	enemy_instance.player_reference = player
	
	get_tree().current_scene.add_child(enemy_instance)
	
func get_random_position() -> Vector2:
	return player.position + distance * Vector2.RIGHT.rotated(randf_range(0, 2 * PI ))
	
	
func amount(number : int = 1):
	for i in range(number):
		spawn(get_random_position())
	

func _on_timer_timeout() -> void:
	second += 1
	# Cada `spawn_interval` segundos sale 1 enemigo, más 1 extra por cada minuto jugado
	if second % spawn_interval == 0:
		amount(1 + minute)

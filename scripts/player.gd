extends CharacterBody2D


var speed : float = 170


func _physics_process(_delta: float) -> void:
	velocity = Input.get_vector("left", "right", "up", "down") * speed
	move_and_slide()

class_name Player
extends CharacterBody2D

var speed: float = 200.0

@onready var health_comp: HealthComponent = %HealthComponent


func _physics_process(_delta: float) -> void:
	if not is_multiplayer_authority():
		return
	velocity = get_movement_vector() * speed
	move_and_slide()


func get_movement_vector() -> Vector2:
	if GameState.mode != GameState.Mode.GAMEPLAY:
		return Vector2.ZERO
	return Input.get_vector("move_left", "move_right", "move_up", "move_down")

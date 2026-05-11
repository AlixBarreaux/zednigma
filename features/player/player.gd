class_name Player
extends CharacterBody2D

@export var data: PlayerData = null

@onready var _health_comp: HealthComponent = %HealthComponent


func get_movement_vector() -> Vector2:
	if GameState.mode != GameState.Mode.GAMEPLAY:
		return Vector2.ZERO
	return Input.get_vector("move_left", "move_right", "move_up", "move_down")


func take_damage(amount: int) -> void:
	if not is_multiplayer_authority():
		return
	_health_comp.decrease_health(amount)


#func _on_health_changed(value: int) -> void:
## TODO Sprint 2: update HUD health display
#pass


func _on_died() -> void:
	# TODO: trigger death state, restart level
	Events.player_died.emit(get_multiplayer_authority())
	queue_free()


func _ready() -> void:
	assert(data != null, "Player: data resource is not set")
	assert(_health_comp != null, "Player: HealthComponent unique name not found")

	_health_comp.initialize(data.max_health)
	#_health_comp.changed.connect(_on_health_changed)
	_health_comp.died.connect(_on_died)


func _physics_process(_delta: float) -> void:
	if not is_multiplayer_authority():
		return
	velocity = get_movement_vector() * data.move_speed
	move_and_slide()

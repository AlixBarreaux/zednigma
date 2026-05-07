class_name Zombie
extends CharacterBody2D

@export var data: ZombieData = null

var _ai: ZombieAIBase = null
var _player: Player = null

var _player_health_comp: HealthComponent = null

@onready var _nav_agent: NavigationAgent2D = %NavigationAgent2D
@onready var _health_comp: HealthComponent = %HealthComponent


func _ready() -> void:
	assert(data != null, "data is not set!")
	assert(data.max_health > 0, "max_health must be > 0 !")
	assert(data.move_speed > 0.0, "move_speed must be > 0.0 !")
	assert(data.detection_range > 0.0, "detection_range must be > 0.0 !")
	assert(data.attack_range > 0.0, "attack_range must be > 0.0 !")
	assert(data.attack_damage > 0, "attack_damage must be > 0 !")
	assert(data.attack_cooldown > 0.0, "attack_cooldown must be > 0.0 !")

	_health_comp.initialize(data.max_health)
	_health_comp.died.connect(_on_died)
	_ai = data.create_ai()


func set_player_target(player: Player) -> void:
	_player = player
	_player_health_comp = _player.health_comp


func _physics_process(delta: float) -> void:
	if not _player:
		return

	var can_see_player: bool = _can_see_player()
	_ai.tick(delta, global_position, _player.global_position, can_see_player)

	if _ai.wants_attack:
		_player_health_comp.decrease_health(data.attack_damage)

	_nav_agent.target_position = _player.global_position
	var next_pos: Vector2 = _nav_agent.get_next_path_position()

	if _ai.desired_direction != Vector2.ZERO:
		velocity = (next_pos - global_position).normalized() * data.move_speed
	else:
		velocity = Vector2.ZERO

	move_and_slide()


func _can_see_player() -> bool:
	## TODO: refactor line-of-sight into systems/vision/ if reused by other entities.
	var space_state: PhysicsDirectSpaceState2D = get_world_2d().get_direct_space_state()
	var query: PhysicsRayQueryParameters2D = PhysicsRayQueryParameters2D.create(
		self.global_position, _player.global_position
	)
	query.set_exclude([self])
	var result: Dictionary = space_state.intersect_ray(query)
	return result.is_empty() or result.collider == _player


func _on_died() -> void:
	queue_free()

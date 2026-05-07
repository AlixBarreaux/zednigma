class_name ZombieAIChaser
extends ZombieAIBase

enum State { IDLE, CHASE, ATTACK }

var _data: ZombieData = null
var _state: State = State.IDLE
var _attack_timer: float = 0.0


func _init(data: ZombieData) -> void:
	_data = data


## TODO: refactor line-of-sight into systems/vision/ if reused by other entities.
func tick(delta: float, self_pos: Vector2, player_pos: Vector2, can_see_player: bool) -> void:
	wants_attack = false
	_attack_timer = maxf(_attack_timer - delta, 0.0)

	var distance: float = self_pos.distance_to(player_pos)

	match _state:
		State.IDLE:
			desired_direction = Vector2.ZERO
			if can_see_player and distance <= _data.detection_range:
				_state = State.CHASE

		State.CHASE:
			if distance <= _data.attack_range:
				_state = State.ATTACK
			elif distance > _data.detection_range:
				_state = State.IDLE
			else:
				desired_direction = (player_pos - self_pos).normalized()

		State.ATTACK:
			desired_direction = Vector2.ZERO
			if distance > _data.attack_range:
				_state = State.CHASE
			elif _attack_timer <= 0.0:
				wants_attack = true
				_attack_timer = _data.attack_cooldown
		_:
			printerr("Unrecognized state!")

class_name ZombieAIBase

var desired_direction: Vector2 = Vector2.ZERO
var wants_attack: bool = false


func _init(_data: ZombieData) -> void:
	pass


## TODO: refactor line-of-sight into systems/vision/ if reused by other entities.
## Override in subclasses. Called every physics frame.
func tick(_delta: float, _self_pos: Vector2, _player_pos: Vector2, _can_see_player: bool) -> void:
	pass

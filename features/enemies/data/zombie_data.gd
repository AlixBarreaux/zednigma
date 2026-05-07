class_name ZombieData
extends Resource

@export var max_health: int = 1
@export var move_speed: float = 60.0
@export var detection_range: float = 250.0
@export var attack_range: float = 20.0
@export var attack_damage: int = 1
@export var attack_cooldown: float = 1.0


## Override in subclasses to return the matching AI.
## ZombieData itself returns the standard chaser — covers Basic, Runner, Tank.
func create_ai() -> ZombieAIBase:
	return ZombieAIChaser.new(self)

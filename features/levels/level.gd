class_name Level
extends Node

@onready var _player: Player = %Player
@onready var _zombie: Zombie = %Zombie


func _ready() -> void:
	_zombie.set_player_target(_player)

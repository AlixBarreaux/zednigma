class_name Level
extends Node

@onready var _player: Player = %Player
@onready var _zombies: Node2D = %Zombies


func _ready() -> void:
	for zombie in _zombies.get_children():
		zombie.set_player_target(_player)

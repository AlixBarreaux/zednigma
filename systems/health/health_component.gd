class_name HealthComponent
extends Node

signal changed(value: int)
signal decreased(value: int, current_hp: int)
signal increased(value: int, current_hp: int)
signal max_changed(value: int)
signal max_decreased(value: int, current_hp: int)
signal max_increased(value: int, current_hp: int)
signal died

var _max_health_cap: int = 0
var _max_health: int = 3
var _health: int
var _is_dead: bool = false


func _set_health(value: int) -> void:
	if _is_dead:
		return
	_health = clampi(value, 0, _max_health)
	changed.emit(_health)
	if _health <= 0:
		_is_dead = true
		died.emit()


func decrease_health(value: int) -> void:
	if _is_dead:
		return
	_set_health(_health - value)
	decreased.emit(value, _health)


func increase_health(value: int) -> void:
	if _is_dead:
		return
	_set_health(_health + value)
	increased.emit(value, _health)


func _set_max_health(value: int) -> void:
	_max_health = clampi(value, 0, _max_health_cap)
	max_changed.emit(_max_health)
	if _health > _max_health:
		_set_health(_max_health)


func decrease_max_health(value: int) -> void:
	if _is_dead:
		return
	_set_max_health(_max_health - value)
	max_decreased.emit(value, _health)


func increase_max_health(value: int) -> void:
	if _is_dead:
		return
	_set_max_health(_max_health + value)
	max_increased.emit(value, _health)


func deplete_all_health() -> void:
	_set_health(0)


func replenish_all_health() -> void:
	_set_health(_max_health)


func initialize(max_health_cap: int) -> void:
	_max_health_cap = max_health_cap
	_set_max_health(max_health_cap)
	replenish_all_health()

@tool
class_name PointLight2DBase
extends PointLight2D

@export var config: LightingConfig = null:
	set(value):
		config = value
		if config:
			if config.config_changed.is_connected(_apply):
				config.config_changed.disconnect(_apply)
			config.config_changed.connect(_apply)


func _ready() -> void:
	assert(config != null, "PointLight2DBase requires a LightingConfig resource.")
	_apply()


func _notification(what: int) -> void:
	if Engine.is_editor_hint() and what == NOTIFICATION_ENTER_TREE:
		_apply()


func _apply() -> void:
	color = config.color
	energy = config.energy
	shadow_enabled = config.shadow_enabled
	shadow_filter = config.shadow_filter
	shadow_filter_smooth = config.shadow_filter_smooth
	shadow_item_cull_mask = config.shadow_item_cull_mask

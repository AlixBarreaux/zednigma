class_name LightingConfig
extends Resource

signal config_changed

@export var color: Color = Color.WHITE:
	set(value):
		color = value
		config_changed.emit()

@export var energy: float = 1.0:
	set(value):
		energy = value
		config_changed.emit()

@export var shadow_enabled: bool = true:
	set(value):
		shadow_enabled = value
		config_changed.emit()

@export var shadow_filter: Light2D.ShadowFilter = Light2D.SHADOW_FILTER_PCF5:
	set(value):
		shadow_filter = value
		config_changed.emit()

@export var shadow_filter_smooth: float = 1.5:
	set(value):
		shadow_filter_smooth = value
		config_changed.emit()

@export var shadow_item_cull_mask: int = 0:
	set(value):
		shadow_item_cull_mask = value
		config_changed.emit()

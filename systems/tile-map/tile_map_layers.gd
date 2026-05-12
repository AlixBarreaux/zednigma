class_name GroundTileMapLayer
extends TileMapLayer

@onready var wall_layer: TileMapLayer = %Walls


func _ready() -> void:
	notify_runtime_tile_data_update()


func _use_tile_data_runtime_update(coords: Vector2i) -> bool:
	return wall_layer.get_cell_tile_data(coords) != null


func _tile_data_runtime_update(_coords: Vector2i, tile_data: TileData) -> void:
	tile_data.set_navigation_polygon(0, NavigationPolygon.new())

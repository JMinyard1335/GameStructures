extends Node3D
@export var gridmap: GridMap
@export var character: Mage

func _ready() -> void:
	TileManager.init(gridmap)

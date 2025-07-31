extends Node3D
@export var gridmap: GridMap
@export var character: Mage
@export var camera_rig: CameraRig

func _ready() -> void:
	assert(camera_rig != null, "camera must be set in the inspector")
	assert(character != null, "Character Must Be Set in inspector")
	TileManager.init(gridmap)
	if camera_rig:
		camera_rig.set_pivot(character.position)


func _process(delta: float) -> void:
	camera_rig.set_pivot(character.position)

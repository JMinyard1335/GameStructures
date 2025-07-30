class_name MoveToTile extends Command
## Moves a Character from one tile in a grid to another

var target_tile: Tile = null
var path: Array = []
var pathfinder: Pathfinder
var height_offest: Vector3 = Vector3(0,1,0)


## Overwrites the .new() call. to take parameters
## you do not have to do this as they default to null so they can be added later.
func _init(parent: Node3D = null, tile: Tile = null) -> void:
	command_name = "Move To Tile"
	pathfinder = Pathfinder.new()
	target_tile = tile
	target = parent
	

## Checks the target tile.
## Finds the best path from current position to the target
## if no path exist return
## move to the target tile by following the path overtime
## emit signal completed and return true
func execuate() -> bool:
	# error checking in development
	assert(target_tile != null, "Target_Tile is null.")
	assert(target != null, "Target is null.")

	# attempt to find a path
	path = pathfinder.find_path(target, target_tile.position)
	assert(path != [] or path != null, "Path was not set.")

	for tile in path:
		await get_tree().create_timer(0.5).timeout
		# added vector is for character offset
		target.global_transform.origin = TileManager.map_to_world(tile) + height_offest

	command_completed.emit(command_name, target)
	return true


func undo() -> bool:
	return true

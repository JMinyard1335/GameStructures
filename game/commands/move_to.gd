class_name MoveTo extends Command
## Moves a Character from one tile in a grid to another

var target_tile: Tile = null
var path: Array = []
var pathfinder: Pathfinder = Pathfinder.new()

func _ready() -> void:
	command_name = "Move To"


## Checks the target tile.
## Finds the best path from current position to the target
## if no path exist return
## move to the target tile by following the path overtime
## emit signal completed and return true
func execuate() -> bool:
	print("executing %s"%command_name)
	if not target_tile:
		push_error("Target tile is not set")
		return false

	path = pathfinder.find_path(target, target_tile.position)
	if path.is_empty():
		push_error("No valid path to the target tile.")

	for tile in path:
		await get_tree().create_timer(0.5).timeout
		# added vector is for character offset
		target.global_transform.origin = TileManager.map_to_world(tile) + Vector3(0,1,0)

	command_completed.emit(command_name, target)
	print("finished Executing %s"%command_name)
	return true


func undo() -> bool:
	return true
